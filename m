Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:52012 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbbJ1TQ5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2015 15:16:57 -0400
From: Eric Anholt <eric@anholt.net>
To: Nicola Corna <nicola@corna.info>, Wolfram Sang <wsa@the-dreams.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Nicola Corna <nicola@corna.info>,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] i2c: added I2C_AQ_NO_CLK_STRETCH to i2c-bcm2835.c
In-Reply-To: <1445976718-7449-3-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info> <1445976718-7449-3-git-send-email-nicola@corna.info>
Date: Wed, 28 Oct 2015 12:16:51 -0700
Message-ID: <8737wu9524.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nicola Corna <nicola@corna.info> writes:
> As reported here
> http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
> the BCM2835 has a bug in its i2c implementation which prevents a correct
> clock stretching.
>
> Signed-off-by: Nicola Corna <nicola@corna.info>
> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bc=
m2835.c
> index 3032b89..38d7102 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -222,6 +222,10 @@ static const struct i2c_algorithm bcm2835_i2c_algo =
=3D {
>  	.functionality	=3D bcm2835_i2c_func,
>  };
>=20=20
> +static const struct i2c_adapter_quirks bcm2835_i2c_quirks =3D {
> +	.flags =3D I2C_AQ_NO_CLK_STRETCH,
> +};
> +
>  static int bcm2835_i2c_probe(struct platform_device *pdev)
>  {
>  	struct bcm2835_i2c_dev *i2c_dev;
> @@ -293,6 +297,7 @@ static int bcm2835_i2c_probe(struct platform_device *=
pdev)
>  	adap->algo =3D &bcm2835_i2c_algo;
>  	adap->dev.parent =3D &pdev->dev;
>  	adap->dev.of_node =3D pdev->dev.of_node;
> +	adap->quirks =3D &bcm2835_i2c_quirks;
>=20=20
>  	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);

Looking at the driver, we're not setting the REDL/FEDL fields, which are
involved in the delays following clock stretching.  Looks like I2C_DEL's
low 16 bits (rising edge delay) should be I2C_DIV / 4 (wait half the
period for the slave to update its data before we sample it), and the
high 16 bits (falling edge delay) should be I2C_DIV / 16 (put our data
out before we expet the slave to sample the value).

Note: this is not a detailed analysis, nor am I asserting that this is
the bug, just something that we seem to be missing in the Linux driver.

(Added cc to linux-rpi-kernel, in case anyone on that list is interested
in I2C issues on the platform)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWMR8kAAoJELXWKTbR/J7oeHEP/1Arwiu8x21hRZ3oaiD+6FgX
zZM5LSypH3TFbje8iFUfZGre0Rejg8ERtQ28TiQFk8UFhxl7h1Yic5Bz92rgQkeT
zIsg2wZ6QOMZ9PtIsLyTaySSNxsthbxQoLIECPVwAt9/m9RuducsGyA+SKiGSKJW
jJDulznCWY/wIrqakb2USPShIDRapGueiffqrwRnXdK6eVEnimrBGVtoDXv9xX+2
zd3+1bTi1M7x7G/3UBbqnX2X3y5E1gQhrxTVvV64KtJz8dPGdh6rcUHfMMq5p329
PfgRIiJIr84xJBt+16Z8Kb34gIin3+O5w9PloZcIMzQxyhUNknkfZp440cVJU76k
It+EqNSUs/umEvzl3C99d+mwoF78Sb41rvyWkLNn7WTLi2BlE4SNvOCI+Zc0PIUw
OxLkG/eZ0W0xaQXSMiArLitTyh/9PzFy4Sx0eVUCWEBR33OSiBDJ7WuAmAKCMCqX
/MlH2YI64S6fE92gryUvUdUx2hJmBY0FnjoJES4s9tP7OtZpa2LRnL92bAARqy5X
PeV/0OS0xs7NcoZjwgByw7W0T4uOV0x+yNSo7hchgAostMMS/SXeLSNWdU5iDFfJ
ytHIUpHpwcHE9smVlEgGdExR/ZtyJNKsmxlJJi+euURP8+QoVa8D5QdmhFFZ7Qtr
IHkais9R5jM3eWwB5PT7
=iG/+
-----END PGP SIGNATURE-----
--=-=-=--
