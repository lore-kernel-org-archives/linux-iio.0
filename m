Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Mon, 30 Jan 2012 21:22:54 +0000
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
Message-ID: <20120130212253.GC9672@opensource.wolfsonmicro.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
 <1327837614-24176-6-git-send-email-jic23@kernel.org>
 <20120130193350.GA9672@opensource.wolfsonmicro.com>
 <4F26FCE2.1030705@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
In-Reply-To: <4F26FCE2.1030705@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2012 at 08:26:10PM +0000, Jonathan Cameron wrote:
> On 01/30/2012 07:33 PM, Mark Brown wrote:
> > On Sun, Jan 29, 2012 at 11:46:54AM +0000, Jonathan Cameron wrote:

> >> +static struct iio_map max1363_consumer_map[] = { +	{ +
> >> .adc_channel_label = "AIN1", +		.consumer_dev =
> >> &iio_hwmon_test.dev, +		.consumer_channel = "testchan1",

> > I do think it's better to use dev_name here rather than a struct
> > device pointer - for several of the buses it's not actually
> > possible to get a struct device until a device has been
> > instantiated which isn't helpful for setting up the mappings.

> We allow both.  In cases like this where the dev pointer is explicitly
> available what gain do we get from not using it?

You avoid user confusion from having two ways of doing the same thing
and you save a little complexity in the implementation.  The user
confusion does happen in practice.

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJwnUAAoJEBus8iNuMP3d8/4P+wZuQzWE0c/IILhiHbRGDmLo
uJ7dYHH/yaMeKUyd0eHGUtyE31LEBHphdStxKRyqNGx4XkiIWS79zAduRHlZYBJh
YyffDBDxCi7UGU8xjXDnRkhAKD4Z0BCsCqhz+aULc+Of5OIpUno//OlYT6iNbwDZ
sqR9RF5IdeFaES9URmv1qZ/t6aYKUuVRV1JF2qSvT85Y17HnNzrfYzBTQqNAWtr5
PBn5Wb2U4cdao+UVXCOrbf7oJ3IlFP0XRXtNPAkWp+eC9tZuZ+yIhihfqYbtDtax
NijDmmYau2f7YuVSwteaV6Lkws1JDiLnR9c6OaOmewTECTrKH5kqph5UdSiW9RqS
KK2oQFemRohoJChFSWLHAon3GpCpRqXNyyUHR4y621HjUz83yA6XP3L82JYZbnF8
UV1hNG6iDI1ICdvj6iT4rBlNtl4p91Wz+xQJfpGpTwF8pNNPs6X+klviowSAnkyI
42HUYswSTBGfFknGYtytpjIpumSBh/Lc6GbWcfN8hFJTveRfoSaipCYdoPvfFeJC
+SfAen/OeDVHRp/EQGZG+3EmRWShchclpeRSgBU6VnmYjBqUue42DKLMxH3WzQGw
QEK5Qf5BIMBrpmcxtgcftqbprudmano59yysaAimW3jGDdmOgePL4nEN+7eQQN3H
eDLLm+qbqV5HOpoA0mbp
=J6TK
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
