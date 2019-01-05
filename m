Return-Path: <SRS0=5rro=PN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F3C43387
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C12087F
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546705898;
	bh=12mYR82gWme4k+PUd6x2UKQmksNp06Dq89rH2z2Ix3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fGQMmeW9Lg0d+c89tmUnoMsbjiHH9HurYljJy8YbCo8I6rV0oDYJyu3RrAfbnFfVX
	 U42O7ekvoR+2rUqGt1oVSzLv6mLOr61/aDYHIN9tUPexdiIPlLkWGwple87IbfQGhP
	 CMih+YvVxPpyxSP3EsFDKPludI7Ur9h0pKCJhnjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAEQbh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfAEQbh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Jan 2019 11:31:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC392085A;
        Sat,  5 Jan 2019 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546705896;
        bh=12mYR82gWme4k+PUd6x2UKQmksNp06Dq89rH2z2Ix3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NX/f6Mci19negpnuIweWtQsjFaKDcrWj0tcqUbE6MX8LgI4wvFd4ElP1sYaklykaT
         Oe68CUuTHrtURd0YDkjYfOA1OvPJBSADha8Wr9tRJqMyB9zDP4Mrf802LMNDIH+unP
         S2OqRa5VEDYt3S6L4QrsDIT8liMx6e42Z4TQaYWI=
Date:   Sat, 5 Jan 2019 16:31:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chen-Yu Tsai <wens@csie.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: axp288: Fix TS-pin handling
Message-ID: <20190105163131.56b49a33@archlinux>
In-Reply-To: <20190104221305.26314-1-hdegoede@redhat.com>
References: <20190104221305.26314-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  4 Jan 2019 23:13:05 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Prior to this commit there were 3 issues with our handling of the TS-pin:
>=20
> 1) There are 2 ways how the firmware can disable monitoring of the TS-pin
> for designs which do not have a temperature-sensor for the battery:
> a) Clearing bit 0 of the AXP20X_ADC_EN1 register
> b) Setting bit 2 of the AXP288_ADC_TS_PIN_CTRL monitoring
>=20
> Prior to this commit we were unconditionally setting both bits to the
> value used on devices with a TS. This causes the temperature protection to
> kick in on devices without a TS, such as the Jumper ezbook v2, causing
> them to not charge under Linux.
>=20
> This commit fixes this by using regmap_update_bits when updating these 2
> registers, leaving the 2 mentioned bits alone.
>=20
> The next 2 problems are related to our handling of the current-source
> for the TS-pin. The current-source used for the battery temp-sensor (TS)
> is shared with the GPADC. For proper fuel-gauge and charger operation the
> TS current-source needs to be permanently on. But to read the GPADC we
> need to temporary switch the TS current-source to ondemand, so that the
> GPADC can use it, otherwise we will always read an all 0 value.
>=20
> 2) Problem 2 is we were writing hardcoded values to the ADC TS pin-ctrl
> register, overwriting various other unrelated bits. Specifically we were
> overwriting the current-source setting for the TS and GPIO0 pins, forcing
> it to 80=C5=B3A independent of its original setting. On a Chuwi Vi10 tabl=
et
> this was causing us to get a too high adc value (due to a too high
> current-source) resulting in the following errors being logged:
>=20
> ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion]
> ACPI Error: Method parse/execution failed \_SB.SXP1._TMP, AE_ERROR
>=20
> This commit fixes this by using regmap_update_bits to change only the
> relevant bits.
>=20
> 3) After reading the GPADC channel we were unconditionally enabling the
> TS current-source even on devices where the TS-pin is not used and the
> current-source thus was off before axp288_adc_read_raw call.
>=20
> This commit fixes this by making axp288_adc_set_ts a nop on devices where
> the ADC is not enabled for the TS-pin.
>=20
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1610545
> Fixes: 3091141d7803 ("iio: adc: axp288: Fix the GPADC pin ...")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

To me this looks fine (really minor comment inline).

I'll just wait until rc1 is out so as to have a suitable base to gather
a few fixes on before applying this.

Give me a poke if I seem to have forgotten in a week or so!
Will mark it for stable when I apply.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/axp288_adc.c | 74 ++++++++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 031d568b4972..99a6b804fd49 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -27,9 +27,18 @@
>  #include <linux/iio/machine.h>
>  #include <linux/iio/driver.h>
> =20
> -#define AXP288_ADC_EN_MASK		0xF1
> -#define AXP288_ADC_TS_PIN_GPADC		0xF2
> -#define AXP288_ADC_TS_PIN_ON		0xF3
> +/*
> + * This mask enables all ADCs except for the battery temp-sensor (TS), t=
hat is
> + * left as-is to avoid breaking charging on devices without a temp-senso=
r.
> + */
> +#define AXP288_ADC_EN_MASK				0xF0
> +#define AXP288_ADC_TS_ENABLE				0x01
> +
> +#define AXP288_ADC_TS_CURRENT_ON_OFF_MASK		GENMASK(1, 0)
> +#define AXP288_ADC_TS_CURRENT_OFF			(0 << 0)
> +#define AXP288_ADC_TS_CURRENT_ON_WHEN_CHARGING		(1 << 0)
> +#define AXP288_ADC_TS_CURRENT_ON_ONDEMAND		(2 << 0)
> +#define AXP288_ADC_TS_CURRENT_ON			(3 << 0)
> =20
>  enum axp288_adc_id {
>  	AXP288_ADC_TS,
> @@ -44,6 +53,7 @@ enum axp288_adc_id {
>  struct axp288_adc_info {
>  	int irq;
>  	struct regmap *regmap;
> +	bool ts_enabled;
>  };
> =20
>  static const struct iio_chan_spec axp288_adc_channels[] =3D {
> @@ -115,21 +125,33 @@ static int axp288_adc_read_channel(int *val, unsign=
ed long address,
>  	return IIO_VAL_INT;
>  }
> =20
> -static int axp288_adc_set_ts(struct regmap *regmap, unsigned int mode,
> -				unsigned long address)
> +/*
> + * The current-source used for the battery temp-sensor (TS) is shared
> + * with the GPADC. For proper fuel-gauge and charger operation the TS
> + * current-source needs to be permanently on. But to read the GPADC we
> + * need to temporary switch the TS current-source to ondemand, so that
> + * the GPADC can use it, otherwise we will always read an all 0 value.
> + */
> +static int axp288_adc_set_ts(struct axp288_adc_info *info,
> +			     unsigned int mode, unsigned long address)
>  {
>  	int ret;
> =20
> -	/* channels other than GPADC do not need to switch TS pin */
> +	/* No need to switch the current-source if the TS pin is disabled */
> +	if (!info->ts_enabled)
> +		return 0;
> +
> +	/* Channels other than GPADC do not need the current source */
>  	if (address !=3D AXP288_GP_ADC_H)
>  		return 0;
> =20
> -	ret =3D regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, mode);
> +	ret =3D regmap_update_bits(info->regmap, AXP288_ADC_TS_PIN_CTRL,
> +				 AXP288_ADC_TS_CURRENT_ON_OFF_MASK, mode);
>  	if (ret)
>  		return ret;
> =20
>  	/* When switching to the GPADC pin give things some time to settle */
> -	if (mode =3D=3D AXP288_ADC_TS_PIN_GPADC)
> +	if (mode =3D=3D AXP288_ADC_TS_CURRENT_ON_ONDEMAND)
>  		usleep_range(6000, 10000);
> =20
>  	return 0;
> @@ -145,14 +167,14 @@ static int axp288_adc_read_raw(struct iio_dev *indi=
o_dev,
>  	mutex_lock(&indio_dev->mlock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_GPADC,
> +		if (axp288_adc_set_ts(info, AXP288_ADC_TS_CURRENT_ON_ONDEMAND,
>  					chan->address)) {
>  			dev_err(&indio_dev->dev, "GPADC mode\n");
>  			ret =3D -EINVAL;
>  			break;
>  		}
>  		ret =3D axp288_adc_read_channel(val, chan->address, info->regmap);
> -		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_ON,
> +		if (axp288_adc_set_ts(info, AXP288_ADC_TS_CURRENT_ON,
>  						chan->address))
>  			dev_err(&indio_dev->dev, "TS pin restore\n");
>  		break;
> @@ -164,13 +186,33 @@ static int axp288_adc_read_raw(struct iio_dev *indi=
o_dev,
>  	return ret;
>  }
> =20
> -static int axp288_adc_set_state(struct regmap *regmap)
> +static int axp288_adc_initialize(struct axp288_adc_info *info)
>  {
> -	/* ADC should be always enabled for internal FG to function */
> -	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, AXP288_ADC_TS_PIN_ON))
> -		return -EIO;
> +	int ret, adc_enable_val;
> +
> +	/*
> +	 * Determine if the TS pin is enabled and if it is not enabled,
> +	 * turn the TS current-source off, so that the shared current-source
> +	 * will be available for the GPADC.
> +	 */
> +	ret =3D regmap_read(info->regmap, AXP20X_ADC_EN1, &adc_enable_val);
> +	if (ret)
> +		return ret;
> +
> +	if (adc_enable_val & AXP288_ADC_TS_ENABLE) {
> +		info->ts_enabled =3D true;
> +	} else {
> +		info->ts_enabled =3D false;
Really minor but I'd have found this clearer as=20
	info->ts_enabled =3D adc_enable_val & AXP288_ADC_TS_ENABLE;
	if (info->ts_enabled) { ...

> +		ret =3D regmap_update_bits(info->regmap, AXP288_ADC_TS_PIN_CTRL,
> +					 AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
> +					 AXP288_ADC_TS_CURRENT_OFF);
> +		if (ret)
> +			return ret;
> +	}
> =20
> -	return regmap_write(regmap, AXP20X_ADC_EN1, AXP288_ADC_EN_MASK);
> +	/* Turn on the ADC for all channels except TS, leave TS as is */
> +	return regmap_update_bits(info->regmap, AXP20X_ADC_EN1,
> +				  AXP288_ADC_EN_MASK, AXP288_ADC_EN_MASK);
>  }
> =20
>  static const struct iio_info axp288_adc_iio_info =3D {
> @@ -200,7 +242,7 @@ static int axp288_adc_probe(struct platform_device *p=
dev)
>  	 * Set ADC to enabled state at all time, including system suspend.
>  	 * otherwise internal fuel gauge functionality may be affected.
>  	 */
> -	ret =3D axp288_adc_set_state(axp20x->regmap);
> +	ret =3D axp288_adc_initialize(info);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to enable ADC device\n");
>  		return ret;

