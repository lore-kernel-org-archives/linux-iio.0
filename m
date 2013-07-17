Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:51516 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab3GQPkP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 11:40:15 -0400
Date: Wed, 17 Jul 2013 17:40:10 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Josh Wu <josh.wu@atmel.com>, jic23@cam.ac.uk,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	plagnioj@jcrosoft.com
Subject: Re: [PATCH 2/5] iio: at91: Use different prescal, startup mask in MR
 for different IP
Message-ID: <20130717154010.GB21549@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-3-git-send-email-josh.wu@atmel.com>
 <20130715125815.GC2962@lukather>
 <51E651D5.7050906@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
In-Reply-To: <51E651D5.7050906@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Wed, Jul 17, 2013 at 10:12:05AM +0200, Nicolas Ferre wrote:
> On 15/07/2013 14:58, Maxime Ripard :
> >On Sun, Jul 14, 2013 at 04:04:26PM +0800, Josh Wu wrote:
> >>+/*
> >>+ * Since atmel adc support different ip for touchscreen mode. Through =
the
> >>+ * IP check, we will know the touchscreen capbilities.
> >>+ */
> >>+static void atmel_adc_get_cap(struct at91_adc_state *st)
> >>+{
> >>+	unsigned int version;
> >>+	struct iio_dev *idev =3D iio_priv_to_dev(st);
> >>+
> >>+	version =3D at91_adc_readl(st, AT91_ADC_VERSION);
> >>+	dev_dbg(&idev->dev, "version: 0x%x\n", version);
> >>+
> >>+	st->caps.mr_prescal_mask =3D AT91_ADC_PRESCAL_9260;
> >>+	st->caps.mr_startup_mask =3D AT91_ADC_STARTUP_9260;
> >>+
> >>+	/* keep only major version number */
> >>+	switch (version & 0xf00) {
> >>+	case 0x500:	/* SAMA5D3 */
> >>+	case 0x400:	/* AT91SAM9X5/9N12 */
> >>+		st->caps.has_tsmr =3D 1;
> >>+		st->caps.mr_startup_mask =3D AT91_ADC_STARTUP;
> >>+	case 0x200:	/* AT91SAM9M10/9G45 */
> >>+		st->caps.mr_prescal_mask =3D AT91_ADC_PRESCAL;
> >>+
> >>+		if ((version & 0xf00) =3D=3D 0x200)
> >>+			st->caps.mr_startup_mask =3D AT91_ADC_STARTUP_9G45;
> >>+	case 0x100:	/* AT91SAM9260/9G20 */
> >>+		break;
> >>+	default:
> >>+		dev_warn(&idev->dev,
> >>+				"Unmanaged adc version, use minimal capabilities\n");
> >>+		break;
> >>+	};
> >>+}
> >
> >Why don't you use different compatible names and derive your
> >capabilities from which compatible is declared.
>=20
> Do not forget that we still have a handful of platforms that do not
> support DT (and never will).

You can do pretty much the same thing with board-file-probed device
drivers, using the id_table field of the platform_driver structure and
use the driver_data field of the associated platform_device_id array to
store the needed values.

(see for example drivers/gpio/gpio-mxs.c)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5rraAAoJEBx+YmzsjxAgVnEQALRYEuorEuLTntJNSkAArD9b
whhYkv/47LXLMfR7j8U7WsW1pMooRYdJp3ifyGb0uWrFHmJV3h0nPLsLBbQ15Pqw
VS6QabRSxzYkfFGgONVejM+sI7Ltx+haafAY8K5gLJFhW9QAVOZs1blpjZwCRTyQ
UowHmx3dd5yp/n6n4JEwREaPWDkSWbzBXe7Y+L73hPUsD1XYEmmeAMJwvx6r4mni
mpQoe3mg0M+z/yp98IFwVt1+k79GC/LL5r58Gkgn5aT96r88db0uIH7+0hCAv209
5ewBJ25tSkkmoQW2rZE2OQZROIZa7prOzLSjCE5st+2SqfxK3bgce8V4mX25bH9D
wk/9e4HO/SR29HhBmSMNxD/XvyLAvPqAraW65chBXviqyNcGZkfd2AU/6HdcLMBt
9QeqN/CnFh9S3rm1F7cmpAPFyFSno3sc1xZVtaniuHgG9ar0gIBvj7jkkLOayAgP
F/qtturH0mpGPf9AAPNvN98tn22NmBTQu0IoXg0nWAnaktApjFGrHiEr+C6RXmRf
iSD9/k152hlmXosDtN81vcpScnUBzhI+YIy3XgKjKKZN0kZj3VrgQBG5v63m3XKb
GU7dC8uxbhjmhxlvqe8dv+TaRImLQ1xQKLHcmjYjlbPkJzTd5D2EwSuKbdWsGpGE
wxgkb14rxxJZJqW2CpKG
=tHRN
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
