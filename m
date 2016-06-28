Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45302 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751419AbcF1Ia1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 04:30:27 -0400
Date: Tue, 28 Jun 2016 10:30:24 +0200
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
Message-ID: <20160628083024.GC4472@kwain>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
In-Reply-To: <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Quentin!

A few comments bellow:

On Tue, Jun 28, 2016 at 10:18:15AM +0200, Quentin Schulz wrote:
>
> diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
> new file mode 100644
> index 0000000..710e297
> --- /dev/null
> +++ b/drivers/mfd/sunxi-gpadc-mfd.c
> @@ -0,0 +1,188 @@

You should add a license statement here.

> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +#include <linux/mfd/core.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Headers are usually included in the alphabetical order.

[...]

> diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunx=
i-gpadc-mfd.h
> new file mode 100644
> index 0000000..341f8c3
> --- /dev/null
> +++ b/include/linux/mfd/sunxi-gpadc-mfd.h
> @@ -0,0 +1,14 @@

You should also add a license statement here.

> +#ifndef __SUNXI_GPADC_MFD__H__
> +#define __SUNXI_GPADC_MFD__H__
> +
> +#define TP_INT_FIFOC            0x10
> +#define TP_INT_FIFOS            0x14
> +
> +struct sunxi_gpadc_mfd_dev {
> +	void __iomem			*regs;
> +	struct device			*dev;
> +	struct regmap			*regmap;
> +	struct regmap_irq_chip_data	*regmap_irqc;
> +};
> +
> +#endif

Thanks!

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXcjWcAAoJEFxNi8it27zYGdwP/3n7k9aGefaXlSEpaHx4fMAL
wghEh136/jfAvW45e0fY4Casz+kmLNPcnYzoBugCNy1DV8ie19FWJY1b8MvuaBJn
F3A9R6DsW4PRALIst9eqPC9hUQgAxM70xMbMnTj3mJUDc6QM7zNA6Qr0LMIQVmMk
FH3etjTDGZSulvvNiA2PvOL9yAjsCUJTfAe3xSW3nWAbi1qms5lUO4qaADMFhFX8
qo+GRCwflPmyayvw/gWim/ltXFPTbDC85uFuRJQrZhkVrxM2qmHnmotR6pAqYupH
n9XBqr6b3ulf7XHFP85cADMLIaK8WQpOC7mqOfz6C9qUY1JLVhlE74y7hA/FejSf
WBqhcWwZyQKQWtXGfk8xy7xA7YglMkKXGfm/7RROB03DJSUX1ZJx437Pmw+IpSfJ
wxOd4yfdMGqDor7h9AasuFnzVl3FcXCDVWsyDBEMdoWhs7rnqVrxm88nYngf+IrP
xlGf4R4JrbFM457eMVuuFJDyvAH6QRkrVWCgIIR3648i84u88yydXfy2XGuYgxMG
JL5e99FKfLXfW8HCNvzUazhzm7+Yr07w3bjZj9RbZuBC/B+VZ8d51/dHLjsDhJLf
21d7IyZNdsZJZcbh6h+NpRn8aB5CyVpVwhemqol8vn+89R3mfJLkGdzVi+WM/7Jw
vDFFJLOEjsnieLHURWB8
=/n1O
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
