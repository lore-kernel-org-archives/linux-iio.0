Return-Path: <sre@kernel.org>
Date: Sun, 12 Nov 2017 19:28:49 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Pan Bian <bianpan2016@163.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: cpcap: fix incorrect validation
Message-ID: <20171112182848.li5chdcsrhjv3du6@earth>
References: <1510502480-27117-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3vix3yowm4qyieo"
In-Reply-To: <1510502480-27117-1-git-send-email-bianpan2016@163.com>
List-ID: <linux-iio@vger.kernel.org>


--j3vix3yowm4qyieo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 13, 2017 at 12:01:20AM +0800, Pan Bian wrote:
> Function platform_get_irq_byname() returns a negative error code on
> failure, and a zero or positive number on success. However, in function
> cpcap_adc_probe(), positive IRQ numbers are also taken as error cases.
> Use "if (ddata->irq < 0)" instead of "if (!ddata->irq)" to validate the
> return value of platform_get_irq_byname().
>=20
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/iio/adc/cpcap-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> index 6e419d5..f153e026 100644
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -1012,7 +1012,7 @@ static int cpcap_adc_probe(struct platform_device *=
pdev)
>  	platform_set_drvdata(pdev, indio_dev);
> =20
>  	ddata->irq =3D platform_get_irq_byname(pdev, "adcdone");
> -	if (!ddata->irq)
> +	if (ddata->irq < 0)
>  		return -ENODEV;
> =20
>  	error =3D devm_request_threaded_irq(&pdev->dev, ddata->irq, NULL,
> --=20
> 1.9.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--j3vix3yowm4qyieo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloIkt0ACgkQ2O7X88g7
+pqOrA//U4yfTn8WJCYT8dUdjPoQxuPPYlXoq7TAO5oz64Y3IWGSGXDaPCfdPLHc
yKKZau99fWbYgnq4sl3AFzfuawZBn8y1Kc8lPu9+QqOIGJ/wXCzE8pPMymPcJAv8
dF8vHxmVt/0birOSV/vIWuS0kdmaH3z5NlCjeqwvgvJ+lZkW+WrJzXzVGjf3S+yG
vau0jRpE2GK9rJL6qHTPqO2jxACCLZmenBJbRN3rfT8maQvTPH8T/A0TaX/9SFV4
OQDiuIfapZY/IGs3riT3bzQeSm2nPg4VxH4g15o1ItDUegXvY5bV9Qayrc7iMWli
hbEDaoZHQLb7YBYWH7VLw7INceTjDHnrFu1FVRAStFfRVh+dpfk6sfrmSuC11v67
VxvnLyoTvYbZSh4QsdTSyfc2SbzxcOo9LAKkO3+6G+GL9aRr3WDNJiLGZdo7iTr9
DbugB60px7TMDjk2t5R1bgcDL8V8vUKdXjZRi44aeYBgbRosu/G5IinkA/NybXhg
ypczh/jMMzgUIWdXI4peEobQmBR1WvgGIgwwSmytmo7raf8LnOkjrf9fewAjPJ6T
CbJNjiwr0RmrYAI+NFrxLDBBq8UHRU2Whyl5fyJBn9kkvqaIVkqRbZ9ceF/aILya
mJtDsMCefbWElq+9ogd8k7VnjQ6jaJdIr5aNHwdBQjz/jcgtjgE=
=rIU0
-----END PGP SIGNATURE-----

--j3vix3yowm4qyieo--
