Return-Path: <bigeasy@linutronix.de>
Message-ID: <51B6D7F0.8020906@linutronix.de>
Date: Tue, 11 Jun 2013 09:55:28 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 21/22] iio/ti_am335x_adc: Allow to specify input line
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-22-git-send-email-bigeasy@linutronix.de> <51B4B2CE.3020300@metafoo.de>
In-Reply-To: <51B4B2CE.3020300@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/09/2013 06:52 PM, Lars-Peter Clausen wrote:
>> @@ -199,8 +213,11 @@ static int tiadc_probe(struct platform_device *pdev)
>>  	struct tiadc_device	*adc_dev;
>>  	struct ti_tscadc_dev	*tscadc_dev = ti_tscadc_dev_get(pdev);
>>  	struct device_node	*node = tscadc_dev->dev->of_node;
>> +	struct property		*prop;
>> +	const __be32		*cur;
>>  	int			err;
>> -	u32			val32;
>> +	u32			val;
>> +	int channels		= 0;
> 
> The indention here looks a bit strange.
fixed

>>  
>>  	if (!node) {
>>  		dev_err(&pdev->dev, "Could not find valid DT data.\n");
>> @@ -222,11 +239,13 @@ static int tiadc_probe(struct platform_device *pdev)
>>  		err = -EINVAL;
>>  		goto err_free_device;
>>  	}
>> -	err = of_property_read_u32(node,
>> -			"ti,adc-channels", &val32);
>> -	if (err < 0)
>> -		goto err_free_device;
>> -	adc_dev->channels = val32;
>> +
>> +	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
>> +
> 
> No need for the extra new line
fixed

>> +		adc_dev->channel_line[channels] = val;
>> +		channels++;
> 
> You should make sure that channels is never >= 8

This is done in the mfd part where it is also checked for adc channels
+ touch channles not > 8.

Sebastian
