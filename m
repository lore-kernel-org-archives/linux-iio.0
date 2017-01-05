Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34583 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbdAEQvp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 11:51:45 -0500
Date: Thu, 5 Jan 2017 17:51:42 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        lee.jones@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH 03/22] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
Message-ID: <20170105165141.yamr24tn5pcleyfa@lukather>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-4-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ubympmcbdleq2fod"
In-Reply-To: <20170102163723.7939-4-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ubympmcbdleq2fod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 05:37:03PM +0100, Quentin Schulz wrote:
> +	switch (axp20x_id) {
> +	case AXP209_ID:
> +		indio_dev->info =3D &axp20x_adc_iio_info;
> +		indio_dev->num_channels =3D ARRAY_SIZE(axp20x_adc_channels);
> +		indio_dev->channels =3D axp20x_adc_channels;
> +
> +		/* Enable the ADCs on IP */
> +		regmap_write(info->regmap, AXP20X_ADC_EN1, AXP20X_ADC_EN1_MASK);
> +
> +		/* Enable GPIO0/1 and internal temperature ADCs */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> +				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> +
> +		/* Configure ADCs rate */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> +				   AXP20X_ADC_RATE_MASK, AXP20X_ADC_RATE_50HZ);
> +		break;
> +
> +	case AXP221_ID:
> +		indio_dev->info =3D &axp22x_adc_iio_info;
> +		indio_dev->num_channels =3D ARRAY_SIZE(axp22x_adc_channels);
> +		indio_dev->channels =3D axp22x_adc_channels;
> +
> +		/* Enable the ADCs on IP */
> +		regmap_write(info->regmap, AXP20X_ADC_EN1, AXP22X_ADC_EN1_MASK);
> +
> +		/* Configure ADCs rate */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> +				   AXP20X_ADC_RATE_MASK, AXP22X_ADC_RATE_200HZ);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}

I'm not a big fan of those IDs. It always ends up with a ever
increasing list of cases without any consolidation.

In this case, the only thing you need is a list of pointers and values
that can definitely be stored in a structure.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ubympmcbdleq2fod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYbnmdAAoJEBx+YmzsjxAgJ4kP/37Es0ZWIlM6Wh58mgOZYT6X
6CDKZ+/1efFLTVgyjd+XpAty2H4VL4bu7NJ/x4kLobQop/R5f78yqoywXz6/jnyH
qotuDSo/RVuPM0c01dXcr1p/TiBpa+ZWQ5u9Q15ux4jnVt0majNzQUE+zPArcICC
B85bo9HavOPUK+oAcyZiTUwjyMqUlfAlm2Lfr97nrZacgG96mgRNEMOt9E8AbnaZ
mjBGFpy84lx0N6sg29ZpzFnXmutkoCcMBQR+A7OhY0nF5zjqeDOw/URhI3y4e3tK
6H5tRkjWhvszUzhmRdrUMdCzrG5ipJWCI2mZBVRYBynDK+2K19NKhe1ovOUhZ20p
oj8qxuphtQANI8ppskH/a0ynONrvpYTboErgZ/AqjdkP3c+3WBb9VnrHE1iV7tyY
bBLpiBVEjvYAQlnQTCnVDp1kBfIypg3DDKH4H0OQx0OIpjSe6JdwBGeBJn750K8v
NBQwYQAiGXX/+6xMdKz7Y25fBKQg40jRAlnXyM22ZAbz+6ZXsSHejFgssfRruCUp
Mj2kllAAoW6xl+OTcykEeTt2A1evNIZxWO7bbL55FlXBMK32a4PL2kQXdv687Dot
oiIagvfbqdBwTgM8SquJ4xHXVV/Ln8FkWT8Zt0FWbWPrPGIr1KIl7XGiQr2TG8Zn
GJrHs1j5gJReCJh6mg+v
=YjoP
-----END PGP SIGNATURE-----

--ubympmcbdleq2fod--
