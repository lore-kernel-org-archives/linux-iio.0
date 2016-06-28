Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46105 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752062AbcF1Iv4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 04:51:56 -0400
Date: Tue, 28 Jun 2016 10:51:54 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH 1/3] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160628085154.GE4472@kwain>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
In-Reply-To: <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 28, 2016 at 10:18:15AM +0200, Quentin Schulz wrote:
> diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
> new file mode 100644
> index 0000000..710e297
> --- /dev/null
> +++ b/drivers/mfd/sunxi-gpadc-mfd.c
> @@ -0,0 +1,188 @@

[...]

> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "allwinner,sun4i-a10-ts"))
> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun4i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
> +				      0, NULL);
> +	else if (of_device_is_compatible(pdev->dev.of_node,
> +					 "allwinner,sun5i-a13-ts"))
> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun5i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
> +				      0, NULL);
> +	else if (of_device_is_compatible(pdev->dev.of_node,
> +					 "allwinner,sun6i-a31-ts"))
> +		ret =3D mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun6i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
> +				      0, NULL);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add MFD devices: %d\n", ret);
> +		regmap_del_irq_chip(irq, sunxi_gpadc_mfd_dev->regmap_irqc);
> +		mfd_remove_devices(&pdev->dev);

You don't need to explicitly call mfd_remove_devices() when
mfd_add_devices() fails. See:
http://lxr.free-electrons.com/source/drivers/mfd/mfd-core.c#L298

> +		return ret;
> +	}

Thanks,

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXcjqpAAoJEFxNi8it27zYyEQP/Rl2UMqt5jb23K8aVacQnYCv
VqeD6Ylky2+e/dBhf4+qWLHqG3nw1V3qVF0XlpzrDh/xLtYgmFq9Ox47b2JRN9It
MBb3GgmlYG2US5sYhhDiNQLnRmEwpuEZpI2nJpnQONGHVoq/2IkdrZy3o0WX1TiF
SVQlc2AssU9fxFnd0APhUMI5AJf0n75B7qPX110pyc/fAFVGJzRFESu2TRgn+C0i
hmudf86EN44zkI6K+CuydOUCCg1EQTRmuFMbdrfpxfnDopNQwatayylOKxagqTl0
Al/N3zyeEHZdQdgLEaRKTAk2DTthYF4HeL9wnTQxPKPbtq0athZKQBa8mu1CUH2O
xjXQ8Vj0zLPr/1iT9gOwMHkIhPqS3+lSufVDeRsQ1wrBpvKcn0HTbLMIIg6JEm0g
Dfw3OHvJ1nQNwoPo/Yw4CRKZuso5oExDQm8Fz0de67J6Exh6LjObdCeqdsFQD4AE
k4e2vnGR6zNFEXfeCycs6TZ4vTIRZMLLhr01hqGt2WZVyKru8MPDixNYEKJ8rqr0
VP5D6O9ETW2Z4kmrOlPb/KvmrOFhbBzBgdq4w1Vbp0RBevZrViqMaN97M+7aAE8G
q/1TtdJm02fEM8TxgC4zDpSl44hOHp3RF7BZylnJTs2nV7EjS/TS5YTKShCV7uA8
jZWe6G6i9Mtkff6S+hJr
=5x0R
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
