Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45418 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752051AbcF1Ic2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 04:32:28 -0400
Date: Tue, 28 Jun 2016 10:32:26 +0200
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
Subject: Re: [PATCH 2/3] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20160628083226.GD4472@kwain>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-3-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
In-Reply-To: <1467101897-15946-3-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Quentin!

On Tue, Jun 28, 2016 at 10:18:16AM +0200, Quentin Schulz wrote:
>
> diff --git a/drivers/iio/adc/sunxi-gpadc-iio.c b/drivers/iio/adc/sunxi-gp=
adc-iio.c
> new file mode 100644
> index 0000000..5840f43
> --- /dev/null
> +++ b/drivers/iio/adc/sunxi-gpadc-iio.c
> @@ -0,0 +1,371 @@

Same here, you can add a license statement :-)

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +#include <linux/regmap.h>

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXcjYZAAoJEFxNi8it27zYt98P/1c/XBHeDLNzZGGa4LbIxoqx
WtsC1ZgOrJVf+t772Qnw2htZ78CWB5R1xpO2sLUjkyY09WoMhskDifz+PiDfym2L
qz0DaL1kq+zK3uOr4Z6WXKEdeqfTDB/7KLq0ZpbASq3YmGSe8IBxLc0vU5Rhr6/U
DtfChTGGUfiCusotBJrWvgm4Sq+UlwYLSD463BuKGEwLe29rQCaWgtIxk/fpe1wL
Cy7NeBe5aPuTmm290liwqXmQX5R/w/VDhh7MqzXS19dJmkMg/P7SdPYFyI20HnsF
YvoFYD4OYtFSRK/4LJl51E61OXh03LiN5NfaSV1+0G8waDtPNWYHzA7QurH4iYGO
rvuhioNzoqOj0W2oDF85KZR4bKuw5FcVUoF8UTXsaFs3klV1LOABfAU18JpTce3K
Tr9WkGd4jY+P24majtrKOrdtG9JrzCQxjIuksTQR+UIADZ1CmsnG0DYmx9MZbW24
nKaNPeqfJjiycgPBxMWJEB1oX2XAsCC7S3g4AKqustK6H7sG5z5+xBN6n7XMpzr6
lGjXtynYvwGdcmflGWuci8akUrHRSnHLmmmy1w+58n7lg5gMahveWlRtnq9BbRUj
HyvOdIJ2mWT6+84ppQ2RgxHB3fg37welwNkmDtWMH3GKEL/9+7cU/rD48LdPNRQ6
MgO2rIre73/WqiopOfCq
=vZD8
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
