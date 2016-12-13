Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60061 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbcLMPmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2016 10:42:13 -0500
Date: Tue, 13 Dec 2016 16:42:10 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux@armlinux.org.uk, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v9 3/3] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20161213154210.qg5udk6shzj6zyph@lukather>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-4-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xludzv4ljavjandr"
In-Reply-To: <20161213143332.24988-4-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--xludzv4ljavjandr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 03:33:32PM +0100, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. This patch adds the ADC driver which is
> based on the MFD for the same SoCs ADC.
>=20
> This also registers the thermal adc channel in the iio map array so
> iio_hwmon could use it without modifying the Device Tree. This registers
> the driver in the thermal framework.
>=20
> The thermal sensor requires the IP to be in touchscreen mode to return
> correct values. Therefore, if the user is continuously reading the ADC
> channel(s), the thermal framework in which the thermal sensor is
> registered will switch the IP in touchscreen mode to get a temperature
> value and requires a delay of 100ms (because of the mode switching),
> then the ADC will switch back to ADC mode and requires also a delay of
> 100ms. If the ADC readings are critical to user and the SoC temperature
> is not, this driver is capable of not registering the thermal sensor in
> the thermal framework and thus, "quicken" the ADC readings.
>=20
> This driver probes on three different platform_device_id to take into
> account slight differences (registers bit and temperature computation)
> between Allwinner SoCs ADCs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I already gave my Acked-by apparently, but I'll say it again :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--xludzv4ljavjandr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYUBbSAAoJEBx+YmzsjxAgSnYP/jNCKT266lmERYoa/pqSbodI
OUmKXy/5BebfPEpmbzt8lNGTwXs/2eFRO1ORjEToFnWL3Pl91qjO+JrxDXenxjTF
/mhIhAJmUN5UiorylHm9V1R02qcYkM8oq0vwAPHqGnmy3+eInIgXki4XVOlMI+wz
DDuBZZfXbTaLGtp74UQ/8lFmtlnR/rWU9SA+WS5TdamTF4jDouvN5A7OMdGwS3Pv
Jhyu8ISWSQyDVQNaQfti86uJBMmEiX339qh4BZrJN9PfCGRldA5JSAL63deAJrYd
FaLRObgx5kp4qtMoYTbCQ/oPwhvocqD8x+4zweGrL4RT+9SbQBQMQmzMG4CXA1xK
6evWC/TEq1Rm8/+t4OVDN4sFCf8IqVmzVXXskzV6N+jRlZqlgcv9XfZN8KiJoyoW
KnfaNKKTVoYI+cceKr+P7JNrf2rBnpw9JtIjrJ+oIfP7ZKbRPt96TBHG+p4OVO5y
MIDjqG1aUO4iVRXGR/nr8coXJD4XeyV7z2eIFL+7ZRlSjJte8MgVyuUi4iuKGhwM
BsI8ItPpsmeVQXbwMM9cBdnQqzoLDtzOM8kn+6c2yQyVczI6PHG0Mhecguz3oorc
HvlENwrWMmZ8dxT/vLQ5vo+bnJfkf+czmOabmQqrDgrimfIZ4HvihgxY9+ARUJly
vsyNeoMsZeKVEAjHrYjq
=vg7y
-----END PGP SIGNATURE-----

--xludzv4ljavjandr--
