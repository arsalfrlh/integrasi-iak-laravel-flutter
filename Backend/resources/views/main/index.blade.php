<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Pilih Type dan Provider</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/css/bootstrap.min.css">
  <style>
    body {
      background-color: #f8f9fa;
      font-family: Arial, sans-serif;
    }

    .card-title {
      font-size: 1.2rem;
      font-weight: bold;
    }

    .card h1, .card h5 {
      color: #343a40;
    }

    .card-custom {
      box-shadow: 0 4px 20px rgba(0,0,0,0.2);
      border-radius: 15px;
      transition: transform 0.2s;
    }

    .card-custom:hover {
      transform: scale(1.02);
    }

    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
    }

    .btn-primary:hover {
      background-color: #0056b3;
      border-color: #0056b3;
    }

    h1, h3 {
      font-weight: bold;
    }

    .form-control {
      border-radius: 0.25rem;
    }

    .mt-5 {
      margin-top: 3rem !important;
    }

    .list-group-item {
      border: none;
    }

    .card-body {
      padding: 1.5rem;
    }

    .no-products {
      text-align: center;
      margin-top: 2rem;
      color: #6c757d;
    }
  </style>
</head>
<body>
  <div class="container mt-5">
    <div class="d-flex justify-content-center">
      <div class="card card-custom w-100" style="max-width: 600px;">
        <div class="card-body">
          <h3 class="mb-4 text-center">Pilih Type dan Provider</h3>
          <form action="/pricelist" method="POST">
            @csrf
            <div class="form-group">
              <label for="typeSelect">Type</label>
              <select id="typeSelect" class="form-control" name="type">
                <option value="">Pilih Type</option>
                <option value="pulsa">Pulsa</option>
                <option value="data">Data</option>
                <option value="etoll">e-Money</option>
                <option value="voucher">Voucher</option>
                <option value="game">Game</option>
                <option value="pln">PLN</option>
              </select>
            </div>

            <div class="form-group">
              <label for="providerSelect">Provider</label>
              <select id="providerSelect" class="form-control" name="operator">
                <option value="">Pilih Provider</option>
              </select>
            </div>

            <button type="submit" class="btn btn-primary btn-block">Cari</button>
          </form>
        </div>
      </div>
    </div>

    @if ($pricelist = Session::get('pricelist'))
      <div class="mt-5">
        <h3 class="text-center mb-4">Daftar Produk</h3>
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 justify-content-center">
          @foreach ($pricelist['data']['pricelist'] as $item)
            <div class="col mb-4">
              <div class="card h-100 card-custom">
                <div class="card-body">
                  <h5 class="card-title">{{ $item['product_description'] }}</h5>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">Deskripsi: {{ $item['product_details'] }}</li>
                    <li class="list-group-item">{{ $item['product_nominal'] }}</li>
                    <li class="list-group-item">Harga: {{ $item['product_price'] }}</li>
                </ul>
                <div class="card-body text-center">
                  <a href="#" class="btn btn-warning w-100 btn-beli" data-code="{{ $item['product_code'] }}" data-product="{{ $item['product_description'] }}" data-price="{{ $item['product_price'] }}">Beli</a>
                </div>
              </div>
            </div>
          @endforeach
        </div>
      </div>
    @else
      <div class="no-products">Tidak ada produk tersedia.</div>
    @endif
  </div>

  <script>
    const providerData = {
      pulsa: ["axis", "indosat", "smart", "telkomsel", "three", "xixi_games", "xl", "by.U"],
      data: ["axis_paket_internet", "telkomsel", "indosat_paket_internet", "smartfren_paket_internet",
             "tri_paket_internet", "telkomsel_paket_internet", "xl_paket_internet"],
      etoll: ["dana", "mandiri_e-toll", "indomaret_card_e-money", "gopay_e-money", "linkaja", "ovo", "shopee_pay", "tix_id"],
      voucher: ["alfamart", "carrefour", "indomaret", "map", "tokopedia", "traveloka", "udemy"],
      game: [
        "arena_of_valor", "battlenet_sea", "bleach_mobile_3d", "call_of_duty_mobile", "dragon_nest_m_-_sea",
        "era_of_celestials", "free_fire", "garena", "gemscool", "genshin_impact", "google_play_us_region",
        "google_play_indonesia", "itunes_us_region", "lyto", "joox", "megaxus", "mobile_legend", "razer_pin",
        "playstation", "steam_sea", "wave_game", "league_of_legends_wild_rift", "lifeafter",
        "light_of_thel:_glory_of_cepheus", "lords_mobile", "marvel_super_war", "minecraft", "netflix",
        "nintendo_eshop", "point_blank", "pubg_mobile", "pubg_pc", "ragnarok_m", "skyegrid", "speed_drifters",
        "vidio", "viu", "wifi_id"
      ],
      pln: ["pln"]
    };

    document.getElementById('typeSelect').addEventListener('change', function () {
      const type = this.value;
      const providerSelect = document.getElementById('providerSelect');

      providerSelect.innerHTML = '<option value="">Pilih Provider</option>';

      if (providerData[type]) {
        providerData[type].forEach(provider => {
          const option = document.createElement('option');
          option.value = provider;
          option.textContent = provider.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
          providerSelect.appendChild(option);
        });
      }
    });
  </script>

  <!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  document.querySelectorAll('.btn-beli').forEach(button => {
    button.addEventListener('click', function (e) {
      e.preventDefault();

      const product = this.dataset.product;
      const price = this.dataset.price;
      const code = this.dataset.code;

      Swal.fire({
        title: 'Masukkan Customer ID',
        input: 'text',
        inputLabel: `Produk: ${product}\nHarga: Rp ${price}`,
        inputPlaceholder: 'Contoh: 08123456789',
        showCancelButton: true,
        confirmButtonText: 'Lanjutkan',
        cancelButtonText: 'Batal',
        inputValidator: (value) => {
          if (!value) {
            return 'Customer ID wajib diisi!';
          }
        }
      }).then(result => {
        if (result.isConfirmed) {
            Swal.fire("Berhasil!", "Pembelian sukses!", "success");

            // Kirim data ke server dengan fetch
            fetch("{{ url('/buy') }}", {
                method: "POST",
                headers: {
                "Content-Type": "application/json",
                "X-CSRF-TOKEN": "{{ csrf_token() }}" // penting untuk Laravel
                },
                body: JSON.stringify({
                        costumer_id: result.value,
                        code: code
                    })
            })
            // .then(data => {
            // window.location.href = "{{ url('/index') }}";
            // })
            .catch(error => {
            console.error("Error mengirim data ke server:", error); 
            });
        }
      });
    });
  });
</script>

</body>
</html>
