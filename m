Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54982 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab3FDKjM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 06:39:12 -0400
Date: Tue, 4 Jun 2013 12:39:11 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com,
	balbi@ti.com
Subject: Re: [PATCH 4/5] iio/ti_am335x_adc: Allow to specify input line
Message-ID: <20130604103911.GH1151@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
 <1369847397-27451-5-git-send-email-bigeasy@linutronix.de>
 <51AB88BE.6040109@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51AB88BE.6040109@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Jonathan Cameron | 2013-06-02 19:02:38 [+0100]:

>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>> index 5e4076f..b228c41 100644
>> --- a/drivers/mfd/ti_am335x_tscadc.c
>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>> @@ -77,16 +81,26 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>
>>  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
>>  	of_property_read_u32(node, "ti,wires", &tsc_wires);
>> +	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
>>
>>  	node = of_get_child_by_name(pdev->dev.of_node, "adc");
>> -	of_property_read_u32(node, "ti,adc-channels", &adc_channels);
>> -
>> +	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
>> +		adc_channels++;
>> +		if (val > 7) {
>> +			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
>> +					val);
>> +			return -EINVAL;
>> +		}
>> +	}
>>  	total_channels = tsc_wires + adc_channels;
>> -
>Should not change this whitespace in this sort of patch.

Okay.

Sebastian
