Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54896 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3FDKXW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 06:23:22 -0400
Date: Tue, 4 Jun 2013 12:23:18 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub
 devices to regmap interface
Message-ID: <20130604102318.GC1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-13-git-send-email-bigeasy@linutronix.de>
 <51AB84F5.2030405@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51AB84F5.2030405@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:46:29 [+0100]:

>On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
>> From: Pantelis Antoniou <panto@antoniou-consulting.com>
>> 
>Some confusing splitting between this and the previous patch that definitely wants
>to be cleaned up.
>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index cceff09..72ffe89 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -76,22 +82,24 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
>>  	tiadc_writel(adc_dev, REG_SE, STPENB_STEPENB);
>>  }
>>  
>> -static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>> +static int tiadc_channel_init(struct iio_dev *indio_dev,
>> +		struct tiadc_device *adc_dev)
>>  {
>>  	struct iio_chan_spec *chan_array;
>>  	struct iio_chan_spec *chan;
>>  	char *s;
>>  	int i, len, size, ret;
>> +	int channels = adc_dev->channels;
>This is an unconnected bit of cleanup.  If you want it put it in the previous patch
>which only just introduced what you are changing.

It will be probably best.

>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>> index bd127bd..a27401a 100644
>> --- a/drivers/mfd/ti_am335x_tscadc.c
>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>> @@ -31,6 +31,7 @@ static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
>>  {
>>  	unsigned int val;
>>
>????  What is this doing here? It's not doing the move to regmap but rather setting a default value.

No lo sé :) I saw that and was wondering myself a little and planned the
romval of this default for later. Now I think I do this earlier.

>> +	val = (unsigned int)-1;
>>  	regmap_read(tsadc->regmap_tscadc, reg, &val);
>>  	return val;
>>  }

Sebastian
