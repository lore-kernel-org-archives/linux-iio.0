Return-Path: <SRS0=+Vkw=3G=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Wed, 29 Mar 2017 17:27:43 +0100
In-Reply-To: <20170329160551.GA7230@arushi-HP-Pavilion-Notebook>
References: <20170329160551.GA7230@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2] staging: iio: Remove unneeded parentheses.
To: Arushi Singhal <arushisinghal19971997@gmail.com>,lars@metafoo.de
CC: outreachy-kernel@googlegroups.com,Michael Hennerich <Michael.Hennerich@analog.com>,Jonathan Cameron <jic23@kernel.org>,Hartmut Knaack <knaack.h@gmx.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-iio@vger.kernel.org,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <6ACE88E5-E497-420B-B7EB-4830F129B394@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 29 March 2017 17:05:51 BST, Arushi Singhal <arushisinghal19971997@gmail=
=2Ecom> wrote:
>Remove the extra parenthesis remove the checkpatch issue=2E
>
>Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail=2Ecom>

Patch doesn't need resending as already applied=2E
If it did the description is now incorrect!
>---
>changes in v2
> -done the changes according to the current tree
>
> drivers/staging/iio/cdc/ad7746=2Ec | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/staging/iio/cdc/ad7746=2Ec
>b/drivers/staging/iio/cdc/ad7746=2Ec
>index c2c8aa5585e4=2E=2E7fa9913386f5 100644
>--- a/drivers/staging/iio/cdc/ad7746=2Ec
>+++ b/drivers/staging/iio/cdc/ad7746=2Ec
>@@ -45,10 +45,10 @@
> #define AD7746_STATUS_RDYCAP		BIT(0)
>=20
>/* Capacitive Channel Setup Register Bit Designations
>(AD7746_REG_CAP_SETUP) */
>-#define AD7746_CAPSETUP_CAPEN		(1 << 7)
>-#define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
>-#define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
>-#define AD7746_CAPSETUP_CACHOP		(1 << 0)
>+#define AD7746_CAPSETUP_CAPEN		BIT(7)
>+#define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
>+#define AD7746_CAPSETUP_CAPDIFF		BIT(5)
>+#define AD7746_CAPSETUP_CACHOP		BIT(0)
>=20
>/* Voltage/Temperature Setup Register Bit Designations
>(AD7746_REG_VT_SETUP) */
> #define AD7746_VTSETUP_VTEN		(1 << 7)
>@@ -56,9 +56,9 @@
> #define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
> #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
> #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
>-#define AD7746_VTSETUP_EXTREF		(1 << 4)
>-#define AD7746_VTSETUP_VTSHORT		(1 << 1)
>-#define AD7746_VTSETUP_VTCHOP		(1 << 0)
>+#define AD7746_VTSETUP_EXTREF		BIT(4)
>+#define AD7746_VTSETUP_VTSHORT		BIT(1)
>+#define AD7746_VTSETUP_VTCHOP		BIT(0)
>=20
>/* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
> #define AD7746_EXCSETUP_CLKCTRL		BIT(7)
>@@ -82,7 +82,7 @@
> #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
>=20
> /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
>-#define AD7746_CAPDAC_DACEN		(1 << 7)
>+#define AD7746_CAPDAC_DACEN		BIT(7)
> #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>=20
> /*

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
