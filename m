Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Mon, 30 Jan 2012 19:33:50 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, greg@kroah.com, guenter.roeck@ericsson.com,
	khali@linux-fr.org, dmitry.torokhov@gmail.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 5/5] stargate2: example of map configuration for iio to
 hwmon example.
Message-ID: <20120130193350.GA9672@opensource.wolfsonmicro.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
 <1327837614-24176-6-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
In-Reply-To: <1327837614-24176-6-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 29, 2012 at 11:46:54AM +0000, Jonathan Cameron wrote:

> +static struct iio_map max1363_consumer_map[] = {
> +	{
> +		.adc_channel_label = "AIN1",
> +		.consumer_dev = &iio_hwmon_test.dev,
> +		.consumer_channel = "testchan1",

I do think it's better to use dev_name here rather than a struct device
pointer - for several of the buses it's not actually possible to get a
struct device until a device has been instantiated which isn't helpful
for setting up the mappings.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJvBvAAoJEBus8iNuMP3dkeAP/3TTbqSMzsNK9jDp0ZziM+Pg
XnOcVlrUD258u4K1n1gV+yLIKcPgEWc1lcPlR/gmdr3AEEumxb+aJuXmyHSqTOFM
Txhj+R1+GH02N/HhVOGwZnWQervdxTIwqNRGVahmaTzqsnPBLdD1P4gRUw73FtYV
xUCNnMFWOGWc8CPYMK448kNj1glz+zCUxv6SWAPPuiST3FsIRwGd4yEyeg24kVaZ
kLWn4vvTXWKX1HGGSEKiUoUNfcA+HG8p6XvBGKdhi7+rbZR9WIKfdHZ7h0VLmzKc
viWzBomDi/8AYhITV0z76ncDFzt13YXxGpegbzXB1D6CFTyS3kZZ+y1k67Q08Pxc
W1zomFL7VBcyssLOby7RiX94XL5F0KzRyQxeMaHVhevFW2bn03nS23kDM23h3TnN
4ZAatzv96kpvYm+PQR48tU/PvPtC8abJrNaEesPrx0evMWn9Hqx1sZ3UYHhaI+qB
Hf/8KG5YJjWqR4PwwMQj+gEtcjHgZ3q31Sp8NDjb5OmbSTDLQlTDwLgnGOSdye2V
ZV98HjyHWPOd6DlxAo7uXfevvR2qv3oCeke1zDxzAhmSIBYz572S0syEe3T4fZET
U3URH0xSCfwsVFJ38W9+IBxEs9r/dLqMRBQZlvEVg2Uhm4PtqLr5SsHUPV2Qi0Uo
/pw/khonxEJqba7/Oiun
=2p8S
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
