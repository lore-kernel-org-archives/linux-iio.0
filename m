Return-Path: <bigeasy@linutronix.de>
Message-ID: <51B58108.3020800@linutronix.de>
Date: Mon, 10 Jun 2013 09:32:24 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 21/22] iio/ti_am335x_adc: Allow to specify input line
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-22-git-send-email-bigeasy@linutronix.de> <51B2F85E.2080805@kernel.org>
In-Reply-To: <51B2F85E.2080805@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 06/08/2013 11:24 AM, Jonathan Cameron wrote:
> On 06/05/2013 05:24 PM, Sebastian Andrzej Siewior wrote:
>> The TSC part allows to specify the input lines. The IIO part assumes
>> that it usues always the last few, that means if IIO has adc-channels
>> set to 2 it will use channel 6 and 7. However it might make sense to use
>> only 6.
>> This patch changes the device property (which was introduced recently
>> and was never in an official release) in a way that the user can specify
>> which of the AIN lines should be used. In Addition to this, the name is
>> now AINx where x is the channel number i.e. for AIN6 we would have 6.
>> Prior this, it always started counting at 0 which is confusing. In
>> addition to this, it also checks for correct step number during reading
>> and does not rely on proper FIFO depth.
>>
> Looks like a typo below... Also the change that is in doesn't directly seem
> to be described in this description.

You can use up to 8 channels and it was checked that the user does not
specify more. However, in case of the touch you can read a channel
multiple times. Each read process is programmed in the FSM and referred
as a step in the manual. You can have up to 15 steps. The additional
check ensures that the user does not try to more "steps" then available.

>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>> index 8bdab8d..acdb7b9 100644
>> --- a/drivers/mfd/ti_am335x_tscadc.c
>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>> @@ -91,10 +95,17 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>
>>  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
>>  	of_property_read_u32(node, "ti,wires", &tsc_wires);
>> +	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> Coordiante? I'm guessing coordinate

You guess correctly. It is a typo in multiple files, I fix it up…

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
>>  	if (total_channels > 8) {
>>  		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");

Sebastian
