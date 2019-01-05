Return-Path: <SRS0=5rro=PN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59B3C43387
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 18:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8463222300
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 18:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfAESeh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Jan 2019 13:34:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40209 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfAESeg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Jan 2019 13:34:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so34415943edr.7
        for <linux-iio@vger.kernel.org>; Sat, 05 Jan 2019 10:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jiw5uQZNuzI9eGvqfdvxQxJaWH0rVF7wa6QIoGUw9u8=;
        b=kxw+L5mpADIb1MIbTZ7my1sm5d4fBoKVRL6o6xNae4b6AQKzgQNCc8fzm4sd9/qm67
         AlZPA0GAi4O6a2JK8KWXvF1Ajvj0SStLLGzi/x+YaSb8J4asdH+e/DaEVmMzBX0B01YR
         CjKtmBNS3Irsqgh3mlzJC89ow8j+Gwa99tryNGbnY4d4KfMmJvfMCK7Oy9QSz816uvDm
         nryYQLIdoSYTn+WYxAVgNModFOc38O/IIKm3xT95tzwsAevsObAJ1p+W8nxWTN5xDN3a
         sK+U4xqQTphHeBoMceTB5hOOxiaWuJEMkRqzp1XLj4xJ96DfFCRyKlcytOYBoaorwayt
         zKYQ==
X-Gm-Message-State: AA+aEWZPWez5QeG1bpKr1bU9WXhalyaVfQpNckTrqVawjbQIDo6fH4xW
        aP5jdyPZzIDrHDvcCMJezusPl/w3tSc=
X-Google-Smtp-Source: AFSGD/XpbHoh3mtrpT7OYZySH1Y8eSdZOXm+Gw9KesYh8suRwVYG2wfCYc0Xury1wt54t/D7MaXs1Q==
X-Received: by 2002:a17:906:8242:: with SMTP id f2-v6mr42620044ejx.125.1546713273967;
        Sat, 05 Jan 2019 10:34:33 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x10sm26823197edb.58.2019.01.05.10.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 10:34:33 -0800 (PST)
Subject: Re: [PATCH] iio: adc: axp288: Fix TS-pin handling
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chen-Yu Tsai <wens@csie.org>, linux-iio@vger.kernel.org
References: <20190104221305.26314-1-hdegoede@redhat.com>
 <20190105163131.56b49a33@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7475c9c7-42ae-0c72-c6c0-596fee435735@redhat.com>
Date:   Sat, 5 Jan 2019 19:34:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190105163131.56b49a33@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 05-01-19 17:31, Jonathan Cameron wrote:
> On Fri,  4 Jan 2019 23:13:05 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Prior to this commit there were 3 issues with our handling of the TS-pin:
>>
>> 1) There are 2 ways how the firmware can disable monitoring of the TS-pin
>> for designs which do not have a temperature-sensor for the battery:
>> a) Clearing bit 0 of the AXP20X_ADC_EN1 register
>> b) Setting bit 2 of the AXP288_ADC_TS_PIN_CTRL monitoring
>>
>> Prior to this commit we were unconditionally setting both bits to the
>> value used on devices with a TS. This causes the temperature protection to
>> kick in on devices without a TS, such as the Jumper ezbook v2, causing
>> them to not charge under Linux.
>>
>> This commit fixes this by using regmap_update_bits when updating these 2
>> registers, leaving the 2 mentioned bits alone.
>>
>> The next 2 problems are related to our handling of the current-source
>> for the TS-pin. The current-source used for the battery temp-sensor (TS)
>> is shared with the GPADC. For proper fuel-gauge and charger operation the
>> TS current-source needs to be permanently on. But to read the GPADC we
>> need to temporary switch the TS current-source to ondemand, so that the
>> GPADC can use it, otherwise we will always read an all 0 value.
>>
>> 2) Problem 2 is we were writing hardcoded values to the ADC TS pin-ctrl
>> register, overwriting various other unrelated bits. Specifically we were
>> overwriting the current-source setting for the TS and GPIO0 pins, forcing
>> it to 80ųA independent of its original setting. On a Chuwi Vi10 tablet
>> this was causing us to get a too high adc value (due to a too high
>> current-source) resulting in the following errors being logged:
>>
>> ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion]
>> ACPI Error: Method parse/execution failed \_SB.SXP1._TMP, AE_ERROR
>>
>> This commit fixes this by using regmap_update_bits to change only the
>> relevant bits.
>>
>> 3) After reading the GPADC channel we were unconditionally enabling the
>> TS current-source even on devices where the TS-pin is not used and the
>> current-source thus was off before axp288_adc_read_raw call.
>>
>> This commit fixes this by making axp288_adc_set_ts a nop on devices where
>> the ADC is not enabled for the TS-pin.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1610545
>> Fixes: 3091141d7803 ("iio: adc: axp288: Fix the GPADC pin ...")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> To me this looks fine (really minor comment inline).
> 
> I'll just wait until rc1 is out so as to have a suitable base to gather
> a few fixes on before applying this.

Thank you for the review. Note I noticed one small oversight
this morning, we no longer set the TS current-source to on on probe when
the TS pin is enabled. In practice it seems the firmware always sets the
TS pin to on in this case, but better safe then sorry and we did explictly
set the TS current-source to on before this patch.

I've prepared a v2 fixing this.

Regards,

Hans

>> ---
>>   drivers/iio/adc/axp288_adc.c | 74 ++++++++++++++++++++++++++++--------
>>   1 file changed, 58 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
>> index 031d568b4972..99a6b804fd49 100644
>> --- a/drivers/iio/adc/axp288_adc.c
>> +++ b/drivers/iio/adc/axp288_adc.c
>> @@ -27,9 +27,18 @@
>>   #include <linux/iio/machine.h>
>>   #include <linux/iio/driver.h>
>>   
>> -#define AXP288_ADC_EN_MASK		0xF1
>> -#define AXP288_ADC_TS_PIN_GPADC		0xF2
>> -#define AXP288_ADC_TS_PIN_ON		0xF3
>> +/*
>> + * This mask enables all ADCs except for the battery temp-sensor (TS), that is
>> + * left as-is to avoid breaking charging on devices without a temp-sensor.
>> + */
>> +#define AXP288_ADC_EN_MASK				0xF0
>> +#define AXP288_ADC_TS_ENABLE				0x01
>> +
>> +#define AXP288_ADC_TS_CURRENT_ON_OFF_MASK		GENMASK(1, 0)
>> +#define AXP288_ADC_TS_CURRENT_OFF			(0 << 0)
>> +#define AXP288_ADC_TS_CURRENT_ON_WHEN_CHARGING		(1 << 0)
>> +#define AXP288_ADC_TS_CURRENT_ON_ONDEMAND		(2 << 0)
>> +#define AXP288_ADC_TS_CURRENT_ON			(3 << 0)
>>   
>>   enum axp288_adc_id {
>>   	AXP288_ADC_TS,
>> @@ -44,6 +53,7 @@ enum axp288_adc_id {
>>   struct axp288_adc_info {
>>   	int irq;
>>   	struct regmap *regmap;
>> +	bool ts_enabled;
>>   };
>>   
>>   static const struct iio_chan_spec axp288_adc_channels[] = {
>> @@ -115,21 +125,33 @@ static int axp288_adc_read_channel(int *val, unsigned long address,
>>   	return IIO_VAL_INT;
>>   }
>>   
>> -static int axp288_adc_set_ts(struct regmap *regmap, unsigned int mode,
>> -				unsigned long address)
>> +/*
>> + * The current-source used for the battery temp-sensor (TS) is shared
>> + * with the GPADC. For proper fuel-gauge and charger operation the TS
>> + * current-source needs to be permanently on. But to read the GPADC we
>> + * need to temporary switch the TS current-source to ondemand, so that
>> + * the GPADC can use it, otherwise we will always read an all 0 value.
>> + */
>> +static int axp288_adc_set_ts(struct axp288_adc_info *info,
>> +			     unsigned int mode, unsigned long address)
>>   {
>>   	int ret;
>>   
>> -	/* channels other than GPADC do not need to switch TS pin */
>> +	/* No need to switch the current-source if the TS pin is disabled */
>> +	if (!info->ts_enabled)
>> +		return 0;
>> +
>> +	/* Channels other than GPADC do not need the current source */
>>   	if (address != AXP288_GP_ADC_H)
>>   		return 0;
>>   
>> -	ret = regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, mode);
>> +	ret = regmap_update_bits(info->regmap, AXP288_ADC_TS_PIN_CTRL,
>> +				 AXP288_ADC_TS_CURRENT_ON_OFF_MASK, mode);
>>   	if (ret)
>>   		return ret;
>>   
>>   	/* When switching to the GPADC pin give things some time to settle */
>> -	if (mode == AXP288_ADC_TS_PIN_GPADC)
>> +	if (mode == AXP288_ADC_TS_CURRENT_ON_ONDEMAND)
>>   		usleep_range(6000, 10000);
>>   
>>   	return 0;
>> @@ -145,14 +167,14 @@ static int axp288_adc_read_raw(struct iio_dev *indio_dev,
>>   	mutex_lock(&indio_dev->mlock);
>>   	switch (mask) {
>>   	case IIO_CHAN_INFO_RAW:
>> -		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_GPADC,
>> +		if (axp288_adc_set_ts(info, AXP288_ADC_TS_CURRENT_ON_ONDEMAND,
>>   					chan->address)) {
>>   			dev_err(&indio_dev->dev, "GPADC mode\n");
>>   			ret = -EINVAL;
>>   			break;
>>   		}
>>   		ret = axp288_adc_read_channel(val, chan->address, info->regmap);
>> -		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_ON,
>> +		if (axp288_adc_set_ts(info, AXP288_ADC_TS_CURRENT_ON,
>>   						chan->address))
>>   			dev_err(&indio_dev->dev, "TS pin restore\n");
>>   		break;
>> @@ -164,13 +186,33 @@ static int axp288_adc_read_raw(struct iio_dev *indio_dev,
>>   	return ret;
>>   }
>>   
>> -static int axp288_adc_set_state(struct regmap *regmap)
>> +static int axp288_adc_initialize(struct axp288_adc_info *info)
>>   {
>> -	/* ADC should be always enabled for internal FG to function */
>> -	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, AXP288_ADC_TS_PIN_ON))
>> -		return -EIO;
>> +	int ret, adc_enable_val;
>> +
>> +	/*
>> +	 * Determine if the TS pin is enabled and if it is not enabled,
>> +	 * turn the TS current-source off, so that the shared current-source
>> +	 * will be available for the GPADC.
>> +	 */
>> +	ret = regmap_read(info->regmap, AXP20X_ADC_EN1, &adc_enable_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (adc_enable_val & AXP288_ADC_TS_ENABLE) {
>> +		info->ts_enabled = true;
>> +	} else {
>> +		info->ts_enabled = false;
> Really minor but I'd have found this clearer as
> 	info->ts_enabled = adc_enable_val & AXP288_ADC_TS_ENABLE;
> 	if (info->ts_enabled) { ...
> 
>> +		ret = regmap_update_bits(info->regmap, AXP288_ADC_TS_PIN_CTRL,
>> +					 AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
>> +					 AXP288_ADC_TS_CURRENT_OFF);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>> -	return regmap_write(regmap, AXP20X_ADC_EN1, AXP288_ADC_EN_MASK);
>> +	/* Turn on the ADC for all channels except TS, leave TS as is */
>> +	return regmap_update_bits(info->regmap, AXP20X_ADC_EN1,
>> +				  AXP288_ADC_EN_MASK, AXP288_ADC_EN_MASK);
>>   }
>>   
>>   static const struct iio_info axp288_adc_iio_info = {
>> @@ -200,7 +242,7 @@ static int axp288_adc_probe(struct platform_device *pdev)
>>   	 * Set ADC to enabled state at all time, including system suspend.
>>   	 * otherwise internal fuel gauge functionality may be affected.
>>   	 */
>> -	ret = axp288_adc_set_state(axp20x->regmap);
>> +	ret = axp288_adc_initialize(info);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "unable to enable ADC device\n");
>>   		return ret;
> 
