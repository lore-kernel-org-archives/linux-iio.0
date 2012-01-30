Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Mon, 30 Jan 2012 20:22:27 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, greg@kroah.com, guenter.roeck@ericsson.com,
	khali@linux-fr.org, dmitry.torokhov@gmail.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20120130202226.GB9672@opensource.wolfsonmicro.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
 <1327837614-24176-2-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
In-Reply-To: <1327837614-24176-2-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 29, 2012 at 11:46:50AM +0000, Jonathan Cameron wrote:

> -static struct device_type iio_dev_type = {
> +struct device_type iio_dev_type = {
>  	.name = "iio_device",
>  	.release = iio_dev_release,
>  };

Why is this exported?

> +	mutex_lock(&iio_map_list_lock);
> +	while ((maps[i].consumer_dev != NULL) ||
> +	       (maps[i].consumer_dev_name != NULL)) {

I'd suggest just dropping the struct device - the reason we support the
struct device directly in the regulator API is that we originally had
only a struct device and kept the code around as a transition measure
(though now it's so old we should be able to kill it off).  This would
simplify the code and the interface a bit.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJvv8AAoJEBus8iNuMP3d7bMP/1zXlYHxsWYdItuaxgS3GDrG
gaT/uCQcZSgfdKZ9J3UMfZfK30urTxstBltf6BZrtf4rvS+oPiI7FomzFycflZJV
FoJmw1dE+Zr/44Mj2Nsf/beJ0z2JlTSPFYBXHKxAAoEpZDk6bvJ+2zK+evi0GgJj
Ov7FcyPYcuQ+V3DpyAcKyI2hsl4aTu0bWDJ6d9bNycqmlku+gOMiugddY7TtMMum
UI8aIDlM1KrS+hRVcvfSVWKRB+/qvhpUKWBn/avXfFYIqLnu7GUVhuDqZNv9Lh4f
AyfOUDvgMSIEHCbaJgFEZ+Kvhrrd9L8mFrdSEolPk+brr0SrgHYnvGx3v3u0sQxN
b2sQjjHNVDyVsPm++ktlx+YVZ8R+j0i5H3K9OyZIVhwnmOHfwK9mNHDLg6Ij/LrQ
pa89fmviuwwOL2Cqs1phe4LrV99TqYg8D6goOIcgf9keOx7PJJrvyFM3CgdmxEjK
FOEpwYyY3vINQIBbEzURCcxTgml3RLgPSxBC2hQ9wEwi244feYon2Cx3bxcMl6b5
OO/zy9xEFD6T7usGNf17i58eRdPRQOG07R2IpyMkH4flYIycY/6FIUig50IPLEdB
dPLVcCgr9xHQuQL/sg3tHBbvBwq9KthCVJ3ctRSGYR0szYkSre+++25l46bTGl/U
cSS/a+if8VF9WkDhUB1G
=etCB
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
