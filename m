Return-Path: <wsa@the-dreams.de>
Date: Wed, 2 Mar 2016 18:06:30 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-i2c@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ge Gao <ggao@invensense.com>, Adriana Reus <adi.reus@gmail.com>,
	Crt Mori <cmo@melexis.com>, Michael Welling <mwelling@ieee.org>
Subject: Re: [RFC PATCH 9/9] iio: imu: inv_mpu6050: Fix deadlock between i2c
 adapter lock and mpu lock
Message-ID: <20160302170630.GA5439@katana>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
 <1455810794-3188-10-git-send-email-daniel.baluta@intel.com>
 <20160301205052.GD1488@katana>
 <CAEnQRZAF-tAjDwJkUNEVQXYqWDt7RsH2bH81UBAMUhsoWEt73g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <CAEnQRZAF-tAjDwJkUNEVQXYqWDt7RsH2bH81UBAMUhsoWEt73g@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I looked into the I2C adapter / mux code but I got lost rapidly :). It
> feels like the natural solution would be for the I2C core to not hold
> the adapter lock while doing transactions on the muxed child adapter.

The patch series I mentioned to you does exactly that. It locks only the
mux side of the muxed bus, not the whole parent adapter. It didn't work
for you because the mux driver maybe needed some adaptions as well?

However, I am still undecided if that series should go upstream because
it makes the mux code another magnitude more complex. And while this
seems to be the second issue which could be fixed by that series, both
issues are corner cases, so I am not sure it is worth the complexity.


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1x2WAAoJEBQN5MwUoCm2SoYP+wZhCsIYf5HCUxo9YtA4sYB0
41UQd1yVEe16asuC6ChA3UDvjnDGLgy3FcDzwWjPEyJAt7kbP+HhOVjjDpkCe1ux
8C+lr274LITknO2rM+aU9hVFsUnDuMOukvELYxOGZXtQZkTnC/VwuZL4nSrD1CF6
YMCknen+/cluY2Klg+jadpE5uBhKtRdLGU2Nj1YN+o6lhjSsn4GnZSZLGOcjgoup
HGrprCIwU5e4rt+BVrRRCokkptQBJGOjaY6i58NARkJlJlMOXfVbruvNCU4/YLNh
2kMnW3R7aKv54X4KeYl/vaxWg7FBIwWiiVQVj7Sc9H1FE0P1N7S4fZoylmzRvoDe
eH9jH1SESQKqks1kWJ49q5i1e1RoGqwQXIrN49+Bc+BXEyqYOgTYbVpoeXdfhLOI
nCrKkZ4EHxOBO9YT0NPjPdBoyKXQtSpnSl9pAsQQSo2UjC/qxBwWYq49QXs44K15
tll9rrUeES/FUzDjVdacDgavu449MirvUJibKmbgBTib4w/YDeRYb7RPOe9yZ0VH
KOpVR5hqhBPB7tukKq8Mc47CmFdPedbGQnUAkDlP7cxcbOJEPqPJBf1MMa+ozD0y
jeEMGRql+UJsFFL3DiiLBQObAUid0HHjIldWp4jg4xgm7H4xvRTP37Q6uoThC8Lw
tvmxS7J0c2l7iEP3dGL3
=ex7G
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
