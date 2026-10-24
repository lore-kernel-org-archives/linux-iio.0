Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792864724;
	b=fH/XFKJTk7xshKxkXX1Y5PDBndJ7WRmplFqvHaW1zKWKIm5KmDBUcPvyp8IJzkVPSfzg
	 5iF8n88Ak5dAiao2t6mJ8cvtBTL+8Nrs0aVi/uUJhH7wDZ4Xm4NMuKmDO/F6o/Sg53Yrt
	 wKHbBOo8Unxf0P1nQWNyKRxWzXAXuSUmyUXosLA4I6wRmqOZPqdVQN9DXCnWv9XmHNFv3
	 7f1+SysqOZvEGnGl/WT71WCHj3mDohSt3uDPtnhhw8vilAifMJk5PbEM5GhrhRW1Ikyp3
	 olz58OBLmjilBjbGuCWZvgs3rAGHBoHkq5sbSl4BdyP5Sxh7xsfFAKQ3e5plrwmZXNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864724;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=7wJ+fdUzJ6BKbykwA05wTEBzGGdvOprfMeqQz7cgg/Y=;
	b=lkmEoCzCOntaJVsx0dAGgJbQHCwy2jWev3Wk0aceB/feJBwFeAlSvAeupaqJmcjEnx5j
	 OWjMNY3gk8nsA6+IaXS2tck8lAkpnIiXrKJ898OjQmOr+UvlKD71x/+KIkX5K+GPumnGS
	 wtljLA2DEjNYPAHl42YG2oW9w1AyMZeNwzloLSjhfXNbJcVEuXKAvsCkAQeWzeuIfHtM+
	 vxTNKamUp2DjM4p15fVS1Hp4AC/CiEz0D/YG9++zk8OpMgkoFU21c4iUe2yRVAtQ71xrv
	 en6hhPUIxdhCOtAsKElxtoH3alH2Xio/Syp8AeGBrbhcrVik/ymbeJRcfQJDLrf5Sfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UiF3immM;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=j8shSVVf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836F606A31A;
	Sat, 24 Oct 2026 17:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1836F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UiF3immM;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=j8shSVVf
ARC-Seal: i=1; a=rsa-sha256; t=1792864704; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CJr9GzzEipvpgrMsxve7zOL5zuzrue7Pj4XDypokweX05vRLicFty1mx0bbUREvPSo
    PMtL8YGKj046kKfQ7Y11KNajn9KyLF65vEPB6OUoFhSOGXK7VSI0fumflk0MrJCu8n9C
    a3jLcOtO46epCZBzsaCFfPv22eqLeU5lpxxKD6REsk8LLr3XAkKDyi7Z5jIqyNoBVO/x
    otXrg0hBsjmEX9XNvj8X0fj3qwulbKMxdD8TKosRqT1x1vjkJ2MdO0jLTtXslVGDL9qR
    QzzDILA4tVl8jW1Qma097iIqlTS1UB7m0yF4ofayFxI73Mp0WlCGvBjf3vBfhmln3059
    tReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792864704;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7wJ+fdUzJ6BKbykwA05wTEBzGGdvOprfMeqQz7cgg/Y=;
    b=HMtzvO4f2s1+BWo0nRD4P+mLhAN2iRF1I1fM6crCLSDidP2HAlYcoGrS7+9eICQz8i
    4eYngOelOKqWOkU95rzRmacgnFTXP8929pWT9YF9WVEl9bRXLgGNNykSMQ0a7bB3K/bg
    bv+OjLjbGZpntjOHvCfUJ51dyZnpX8fXfm/lZf2R6LFOfCF13y3tc9RrL6Z+T4oec8NF
    WULSbFWcQFTCihfMX5L5rWyWIJYF6fCfLiGnOYdNMy/F2K7OOUMdWmSS5ABYHHUM0Uof
    p+QXlwvJA6EInM/iE0S8ZEIO9DU/5yijtPOxoe+wY55BzL/r5T/k2WmfXxwjz1Cd70tv
    mq6A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792864704;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7wJ+fdUzJ6BKbykwA05wTEBzGGdvOprfMeqQz7cgg/Y=;
    b=UiF3immMLbxAHnkpskHrrOBn1ujlrz6AkRgtDfxstfzN6kXmCI0hDfN2f2/oCSagXh
    7iMLAkSxZmDEG2OpBn1btPskRNLGkpBlWu1lUQDn8EDs9iqpE025H3Rh++JB+6A3TwvE
    FJyuU5OwiZ6ZQvIhQf7Abk0ptxv9aAAm+ItYhzRJCKSIa8ABZDy9gzNwQmPlGdSadcrv
    KgO4pFGBxhrrhrkWe7HqVncJx6VYbTOM2+g1yt/bMV4ax27kkXQfWRYmstb5uR/mlkhp
    z0qAy+GdZMaiMVj5o36OiimIzYAfap2AjMZbyuUeLxK65xXvbjoS4hMzaLaFqL87szMm
    6aVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792864704;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7wJ+fdUzJ6BKbykwA05wTEBzGGdvOprfMeqQz7cgg/Y=;
    b=j8shSVVfi9TOltSQWy8RdMYL/k5j/do7qmbAlfBuP8nQbte81tGTeUlpBQaV+X6Z17
    mmbqo0B56xxfwXkfqwBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV2poKzsiNzptYNlV1C1yk7253raiyx+O3Hxli"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a229OHwOwu5
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 24 Oct 2026 19:58:24 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v2 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261024041357.34346-2-olivier@mgcrea.io>
Date: Sat, 24 Oct 2026 19:57:53 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Paul Boddie <paul@boddie.org.uk>,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C468594-DAC6-4DD7-8394-4516F9D43917@goldelico.com>
References: <20261024041357.34346-1-olivier@mgcrea.io>
 <20261024041357.34346-2-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi,

> Am 24.10.2026 um 06:13 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The X1600's SAR ADC has four auxiliary channels, each with its own =
start
> bit, interrupt flag and 12-bit result, and none of the touchscreen or
> battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a =
small

I have checked a little and
jz4780 has its unique SADC register set
x1000  has no SADC (just a note for a clock reserved)
x1600  has this register set for 4 channels
x1830  shares the same register set
       but has only 3 channels
x2000  has a register set similar to the x1600
       but has 5 channels
x2600  has a completely different register model (and 16 channels)

So the x1600, x1830, x2000 only differ in number of channels and the =
bits
in ADENA, ADCTRL, ADSTATE

> driver that exposes the four channels as voltages against the 3.3 V
> reference.
>=20
> There is no datasheet here: the register layout and the clock dividers
> come from the X1600 driver of the vendor's 4.4 kernel.

Or x2000... Since the x2000 is older, this IMHO should be an x2000 ADC
driver where the x1600 is also compatible to.

But I am not sure what the policy is here. If the sequence of =
publication of
some chips and derivatives should be used for the driver name and =
internal
constants. Or if it can be based on which chip is lucky to find someone
who writes a driver for that chip.

I think the x1830 was published after the x2000 but this would have to
be researched.

>=20
> Tested on a HiBy R1, whose play/pause and volume keys sit on channel 0
> behind adc-keys: all three read and report correctly.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> Changes in v2, after Jonathan Cameron's review (thanks):
> - Drop the comparison with the JZ47xx ADCs from the file header
> - Drop the mod_devicetable.h include
> - X1600_ADC_VREF_MV -> X1600_ADC_VREF_mV
> - Split the status declaration from its readl() in the interrupt =
handler
> - field_get() for the channel's result
> - fsleep(2000) instead of usleep_range()
>=20
> v1 was tested on a HiBy R1; v2 is build-tested with W=3D1 on iio =
togreg.
>=20
> MAINTAINERS                         |   7 +
> drivers/iio/adc/Kconfig             |  10 ++
> drivers/iio/adc/Makefile            |   1 +
> drivers/iio/adc/ingenic-x1600-adc.c | 226 ++++++++++++++++++++++++++++
> 4 files changed, 244 insertions(+)
> create mode 100644 drivers/iio/adc/ingenic-x1600-adc.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc22d1149d1..bbb63228e330 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12925,6 +12925,13 @@ F: include/linux/mfd/ingenic-tcu.h
> F: sound/soc/codecs/jz47*
> F: sound/soc/jz4740/
>=20
> +INGENIC X1600 ADC DRIVER
> +M: Olivier Louvignes <olivier@mgcrea.io>
> +L: linux-iio@vger.kernel.org
> +S: Maintained
> +F: Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> +F: drivers/iio/adc/ingenic-x1600-adc.c
> +
> INJOINIC IP5xxx POWER BANK IC DRIVER
> M: Samuel Holland <samuel@sholland.org>
> S: Maintained
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a802d8ee4dd9..7b5c3d3fcfdb 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -881,6 +881,16 @@ config INGENIC_ADC
>  This driver can also be built as a module. If so, the module will be
>  called ingenic_adc.
>=20
> +config INGENIC_X1600_ADC
> + tristate "Ingenic X1600 ADC driver"
> + depends on MIPS || COMPILE_TEST
> + help
> +  Say yes here to build support for the SAR ADC of the Ingenic X1600
> +  SoC and its four auxiliary channels.

X1830 and X2000 should be mentioned here.

> +
> +  This driver can also be built as a module. If so, the module will =
be
> +  called ingenic-x1600-adc.
> +
> config INTEL_DC_TI_ADC
> tristate "Intel Bay Trail / Cherry Trail Dollar Cove TI ADC driver"
> depends on INTEL_SOC_PMIC_CHTDC_TI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9e82c21dbd37..f76e62b0cd04 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_IMX8QXP_ADC) +=3D imx8qxp-adc.o
> obj-$(CONFIG_IMX93_ADC) +=3D imx93_adc.o
> obj-$(CONFIG_INA2XX_ADC) +=3D ina2xx-adc.o
> obj-$(CONFIG_INGENIC_ADC) +=3D ingenic-adc.o
> +obj-$(CONFIG_INGENIC_X1600_ADC) +=3D ingenic-x1600-adc.o
> obj-$(CONFIG_INTEL_DC_TI_ADC) +=3D intel_dc_ti_adc.o
> obj-$(CONFIG_INTEL_MRFLD_ADC) +=3D intel_mrfld_adc.o
> obj-$(CONFIG_LP8788_ADC) +=3D lp8788_adc.o
> diff --git a/drivers/iio/adc/ingenic-x1600-adc.c =
b/drivers/iio/adc/ingenic-x1600-adc.c
> new file mode 100644
> index 000000000000..60683f26c693
> --- /dev/null
> +++ b/drivers/iio/adc/ingenic-x1600-adc.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADC driver for the Ingenic X1600 SoC
> + *
> + * The X1600's SAR ADC has four auxiliary channels, each with its own =
start
> + * bit, interrupt and 12-bit result. The register layout and the =
clock set-up
> + * were read from the vendor 4.4 kernel's driver.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +
> +#define X1600_ADC_REG_ENABLE 0x00
> +#define X1600_ADC_REG_CTRL 0x08
> +#define X1600_ADC_REG_STATUS 0x0c
> +#define X1600_ADC_REG_DATA(ch) (0x10 + ((ch) / 2) * 4)
> +#define X1600_ADC_REG_CLKDIV 0x20
> +#define X1600_ADC_REG_STABLE 0x24
> +
> +/* ENABLE: bits 3..0 start a channel's conversion; bit 15 powers =
down. */
> +#define X1600_ADC_ENABLE_POWER_DOWN BIT(15)
> +/* CTRL: bits 3..0 mask the channels' interrupts. STATUS: write 1 to =
clear. */
> +#define X1600_ADC_CHANNELS_MASK GENMASK(3, 0)
> +#define X1600_ADC_DATA_MASK(ch) (GENMASK(11, 0) << ((ch) % 2 * 16))
> +#define X1600_ADC_CLKDIV_DIV0 GENMASK(7, 0)
> +#define X1600_ADC_CLKDIV_DIV1 GENMASK(15, 8)
> +#define X1600_ADC_CLKDIV_DIV2 GENMASK(31, 16)
> +#define X1600_ADC_STABLE_TIME GENMASK(15, 0)
> +
> +#define X1600_ADC_NUM_CHANNELS 4
> +#define X1600_ADC_VREF_mV 3300
> +#define X1600_ADC_BITS 12
> +/* The vendor kernel brings its 140 MHz APB clock down to about this. =
*/
> +#define X1600_ADC_CLK_RATE 1166667
> +#define X1600_ADC_TIMEOUT_MS 20
> +
> +struct x1600_adc {
> + void __iomem *base;
> + struct clk *clk;
> + struct completion done;
> + /* Serialises conversions: there is one completion for all channels. =
*/
> + struct mutex lock;
> +};
> +
> +static irqreturn_t x1600_adc_irq(int irq, void *data)
> +{
> + struct x1600_adc *adc =3D data;
> + u32 status;
> +
> + status =3D readl(adc->base + X1600_ADC_REG_STATUS) & =
X1600_ADC_CHANNELS_MASK;
> + if (!status)
> + return IRQ_NONE;
> +
> + writel(status, adc->base + X1600_ADC_REG_STATUS);
> + complete(&adc->done);
> + return IRQ_HANDLED;
> +}
> +
> +static int x1600_adc_read_raw_channel(struct x1600_adc *adc, unsigned =
int ch, int *val)
> +{
> + u32 data;
> + int ret =3D 0;
> +
> + guard(mutex)(&adc->lock);
> +
> + reinit_completion(&adc->done);
> + writel(BIT(ch), adc->base + X1600_ADC_REG_STATUS);
> + writel(readl(adc->base + X1600_ADC_REG_ENABLE) | BIT(ch),
> +       adc->base + X1600_ADC_REG_ENABLE);
> +
> + if (!wait_for_completion_timeout(&adc->done,
> + msecs_to_jiffies(X1600_ADC_TIMEOUT_MS)))
> + ret =3D -ETIMEDOUT;
> +
> + writel(readl(adc->base + X1600_ADC_REG_ENABLE) & ~BIT(ch),
> +       adc->base + X1600_ADC_REG_ENABLE);
> + if (ret)
> + return ret;
> +
> + data =3D readl(adc->base + X1600_ADC_REG_DATA(ch));
> + *val =3D field_get(X1600_ADC_DATA_MASK(ch), data);
> + return 0;
> +}
> +
> +static int x1600_adc_read_raw(struct iio_dev *iio_dev,
> +      struct iio_chan_spec const *chan,
> +      int *val, int *val2, long mask)
> +{
> + struct x1600_adc *adc =3D iio_priv(iio_dev);
> + int ret;
> +
> + switch (mask) {
> + case IIO_CHAN_INFO_RAW:
> + ret =3D x1600_adc_read_raw_channel(adc, chan->channel, val);
> + return ret ? ret : IIO_VAL_INT;
> + case IIO_CHAN_INFO_SCALE:
> + *val =3D X1600_ADC_VREF_mV;
> + *val2 =3D X1600_ADC_BITS;
> + return IIO_VAL_FRACTIONAL_LOG2;
> + default:
> + return -EINVAL;
> + }
> +}
> +
> +static const struct iio_info x1600_adc_info =3D {
> + .read_raw =3D x1600_adc_read_raw,
> +};
> +
> +#define X1600_ADC_CHANNEL(ch) { \
> + .type =3D IIO_VOLTAGE, \
> + .indexed =3D 1, \
> + .channel =3D (ch), \
> + .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> + .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> +}
> +
> +static const struct iio_chan_spec x1600_adc_channels[] =3D {
> + X1600_ADC_CHANNEL(0),
> + X1600_ADC_CHANNEL(1),
> + X1600_ADC_CHANNEL(2),
> + X1600_ADC_CHANNEL(3),

X21830 has no ADC_CHANNEL(3).
X2000 has an ADC_CHANNEL(4).

> +};
> +
> +static void x1600_adc_power_down(void *data)
> +{
> + struct x1600_adc *adc =3D data;
> +
> + writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_CTRL);
> + writel(X1600_ADC_ENABLE_POWER_DOWN, adc->base + =
X1600_ADC_REG_ENABLE);
> +}
> +
> +static int x1600_adc_probe(struct platform_device *pdev)
> +{
> + struct device *dev =3D &pdev->dev;
> + struct iio_dev *iio_dev;
> + struct x1600_adc *adc;
> + unsigned long rate;
> + u32 div0, reg;
> + int irq, ret;
> +
> + iio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
> + if (!iio_dev)
> + return -ENOMEM;
> +
> + adc =3D iio_priv(iio_dev);
> + init_completion(&adc->done);
> + ret =3D devm_mutex_init(dev, &adc->lock);
> + if (ret)
> + return ret;
> +
> + adc->base =3D devm_platform_ioremap_resource(pdev, 0);
> + if (IS_ERR(adc->base))
> + return PTR_ERR(adc->base);
> +
> + adc->clk =3D devm_clk_get_enabled(dev, "adc");
> + if (IS_ERR(adc->clk))
> + return dev_err_probe(dev, PTR_ERR(adc->clk), "Unable to get =
clock\n");
> +
> + /* Powered down, interrupts masked and cleared, as the vendor does. =
*/
> + writel(X1600_ADC_ENABLE_POWER_DOWN, adc->base + =
X1600_ADC_REG_ENABLE);
> + writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_CTRL);
> + writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_STATUS);
> +
> + rate =3D clk_get_rate(adc->clk);
> + div0 =3D clamp(DIV_ROUND_UP(rate, X1600_ADC_CLK_RATE), 1UL, 256UL) - =
1;
> + /* DIV1 and DIV2 as the vendor kernel sets them. */
> + writel(FIELD_PREP(X1600_ADC_CLKDIV_DIV0, div0) |
> +       FIELD_PREP(X1600_ADC_CLKDIV_DIV1, 1) |
> +       FIELD_PREP(X1600_ADC_CLKDIV_DIV2, 99),
> +       adc->base + X1600_ADC_REG_CLKDIV);
> + reg =3D readl(adc->base + X1600_ADC_REG_STABLE) & =
~X1600_ADC_STABLE_TIME;
> + writel(reg | FIELD_PREP(X1600_ADC_STABLE_TIME, 1),
> +       adc->base + X1600_ADC_REG_STABLE);
> +
> + irq =3D platform_get_irq(pdev, 0);
> + if (irq < 0)
> + return irq;
> +
> + ret =3D devm_request_irq(dev, irq, x1600_adc_irq, 0, dev_name(dev), =
adc);
> + if (ret)
> + return dev_err_probe(dev, ret, "Failed to request irq\n");
> +
> + /*
> + * Powered up for good: the keys poll it every few tens of =
milliseconds,
> + * and powering up takes 2 ms.
> + */
> + writel(0, adc->base + X1600_ADC_REG_ENABLE);
> + fsleep(2000);
> + writel(0, adc->base + X1600_ADC_REG_CTRL);
> + ret =3D devm_add_action_or_reset(dev, x1600_adc_power_down, adc);
> + if (ret)
> + return ret;
> +
> + iio_dev->name =3D "x1600-adc";
> + iio_dev->modes =3D INDIO_DIRECT_MODE;
> + iio_dev->channels =3D x1600_adc_channels;
> + iio_dev->num_channels =3D ARRAY_SIZE(x1600_adc_channels);
> + iio_dev->info =3D &x1600_adc_info;
> +
> + return devm_iio_device_register(dev, iio_dev);
> +}
> +
> +static const struct of_device_id x1600_adc_of_match[] =3D {
> + { .compatible =3D "ingenic,x1600-adc" },

There should be some mechanism to make this driver compatible to x1830
and x2000 as well and base the number of channels on this.

> + { }
> +};
> +MODULE_DEVICE_TABLE(of, x1600_adc_of_match);
> +
> +static struct platform_driver x1600_adc_driver =3D {
> + .driver =3D {
> + .name =3D "ingenic-x1600-adc",
> + .of_match_table =3D x1600_adc_of_match,
> + },
> + .probe =3D x1600_adc_probe,
> +};
> +module_platform_driver(x1600_adc_driver);
> +MODULE_DESCRIPTION("ADC driver for the Ingenic X1600 SoC");
> +MODULE_LICENSE("GPL");
> --=20
> 2.39.5
>=20
>=20

BR, H. Nikolaus Schaller <hns@goldelico.com>=
