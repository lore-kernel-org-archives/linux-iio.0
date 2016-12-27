Return-Path: <SRS0=js8X=YK=ucw.cz=pavel@kernel.org>
Date: Tue, 27 Dec 2016 11:49:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Richard Purdie <rpurdie@rpsys.net>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v4 3/5] backlight: lm3533: Support initialization from
 Device Tree
Message-ID: <20161227104915.GC15452@amd>
References: <20161226181153.11271-1-bjorn.andersson@linaro.org>
 <20161226181153.11271-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
In-Reply-To: <20161226181153.11271-3-bjorn.andersson@linaro.org>
List-ID: <linux-iio@vger.kernel.org>


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-12-26 10:11:51, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>=20
> Implement support for initialization of the lm3533 backlight from Device
> Tree.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Bjorn, you may want to fix your email system:

<bjorn.andersson@sonymobile.com>: host
    seldsegrel01.sonyericsson.com[37.139.156.29] said: 550 Rule
    imposed mailbox
        access for this user is refused: user invalid (in reply to
    RCPT TO command)


									Pavel
> ---
>=20
> This patch only depends on the acceptance of the DT binding (doesn't have=
 to be
> merged together with the mfd patch).
>=20
> Changes since v3:
> - Moved backlight DT parsing from mfd driver
> - Gave driver its own compatible
>=20
>  drivers/video/backlight/lm3533_bl.c | 98 +++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 95 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
> index 0e2337f367b6..2f132199e604 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -22,6 +22,7 @@
> =20
> =20
>  #define LM3533_HVCTRLBANK_COUNT		2
> +#define LM3533_BL_DEFAULT_BRIGHTNESS	200
>  #define LM3533_BL_MAX_BRIGHTNESS	255
> =20
>  #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
> @@ -269,6 +270,86 @@ static int lm3533_bl_setup(struct lm3533_bl *bl,
>  	return lm3533_ctrlbank_set_pwm(&bl->cb, pdata->pwm);
>  }
> =20
> +static int lm3533_of_parse_pwm_zones(struct device_node *node)
> +{
> +	const char *propname =3D "ti,pwm-zones";
> +	u32 zones[5];
> +	int count;
> +	int ret;
> +	int i;
> +
> +	count =3D of_property_count_u32_elems(node, propname);
> +	if (count =3D=3D -EINVAL)
> +		return 0;
> +	if (count <=3D 0)
> +		return count;
> +	if (count >=3D ARRAY_SIZE(zones))
> +		return -EINVAL;
> +
> +	ret =3D of_property_read_u32_array(node, propname, zones, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable pwm input, and enable the selected zones */
> +	ret =3D BIT(0);
> +	for (i =3D 0; i < count; i++)
> +		ret |=3D BIT(zones[i] + 1);
> +
> +	return ret;
> +}
> +
> +static struct lm3533_bl_platform_data *lm3533_bl_of_parse(struct device =
*dev,
> +							  int *id)
> +{
> +	struct lm3533_bl_platform_data *bl_pdata;
> +	struct device_node *node =3D dev->of_node;
> +	int ret;
> +	u32 reg;
> +	u32 val;
> +
> +	bl_pdata =3D devm_kzalloc(dev, sizeof(*bl_pdata), GFP_KERNEL);
> +	if (!bl_pdata)
> +		return NULL;
> +
> +	ret =3D of_property_read_u32(node, "reg", &reg);
> +	if (ret < 0) {
> +		dev_err(dev, "invalid reg property\n");
> +		return NULL;
> +	}
> +	*id =3D reg;
> +
> +	ret =3D of_property_read_string(node, "label",
> +				      (const char **)&bl_pdata->name);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to parse label\n");
> +		return NULL;
> +	}
> +
> +	ret =3D of_property_read_u32(node, "led-max-microamp", &val);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to parse led-max-microamp\n");
> +		return NULL;
> +	}
> +	bl_pdata->max_current =3D val;
> +
> +	val =3D LM3533_BL_DEFAULT_BRIGHTNESS;
> +	ret =3D of_property_read_u32(node, "default-brightness", &val);
> +	if (ret < 0 && ret !=3D -EINVAL) {
> +		dev_err(dev, "unable to parse default-brightness\n");
> +		return NULL;
> +	}
> +	bl_pdata->default_brightness =3D val;
> +
> +	ret =3D lm3533_of_parse_pwm_zones(node);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to parse ti,pwm-zones\n");
> +		return NULL;
> +	}
> +	bl_pdata->pwm =3D ret;
> +
> +	return bl_pdata;
> +}
> +
>  static int lm3533_bl_probe(struct platform_device *pdev)
>  {
>  	struct lm3533 *lm3533;
> @@ -277,6 +358,7 @@ static int lm3533_bl_probe(struct platform_device *pd=
ev)
>  	struct backlight_device *bd;
>  	struct backlight_properties props;
>  	int ret;
> +	int id;
> =20
>  	dev_dbg(&pdev->dev, "%s\n", __func__);
> =20
> @@ -284,14 +366,17 @@ static int lm3533_bl_probe(struct platform_device *=
pdev)
>  	if (!lm3533)
>  		return -EINVAL;
> =20
> +	id =3D pdev->id;
>  	pdata =3D dev_get_platdata(&pdev->dev);
> +	if (!pdata)
> +		pdata =3D lm3533_bl_of_parse(&pdev->dev, &id);
>  	if (!pdata) {
>  		dev_err(&pdev->dev, "no platform data\n");
>  		return -EINVAL;
>  	}
> =20
> -	if (pdev->id < 0 || pdev->id >=3D LM3533_HVCTRLBANK_COUNT) {
> -		dev_err(&pdev->dev, "illegal backlight id %d\n", pdev->id);
> +	if (id < 0 || id >=3D LM3533_HVCTRLBANK_COUNT) {
> +		dev_err(&pdev->dev, "illegal backlight id %d\n", id);
>  		return -EINVAL;
>  	}
> =20
> @@ -300,7 +385,7 @@ static int lm3533_bl_probe(struct platform_device *pd=
ev)
>  		return -ENOMEM;
> =20
>  	bl->lm3533 =3D lm3533;
> -	bl->id =3D pdev->id;
> +	bl->id =3D id;
> =20
>  	bl->cb.lm3533 =3D lm3533;
>  	bl->cb.id =3D lm3533_bl_get_ctrlbank_id(bl);
> @@ -394,10 +479,17 @@ static void lm3533_bl_shutdown(struct platform_devi=
ce *pdev)
>  	lm3533_ctrlbank_disable(&bl->cb);
>  }
> =20
> +static const struct of_device_id lm3533_bl_of_match[] =3D {
> +	{ .compatible =3D "ti,lm3533-backlight", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_bl_of_match);
> +
>  static struct platform_driver lm3533_bl_driver =3D {
>  	.driver =3D {
>  		.name	=3D "lm3533-backlight",
>  		.pm	=3D &lm3533_bl_pm_ops,
> +		.of_match_table =3D lm3533_bl_of_match,
>  	},
>  	.probe		=3D lm3533_bl_probe,
>  	.remove		=3D lm3533_bl_remove,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhiRysACgkQMOfwapXb+vKY5QCfTmPOMU2S3c0CX5nFTQhrrB6m
+pgAnixUzjErGahgHRmQNmfB8TMPY6V8
=AFIe
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
