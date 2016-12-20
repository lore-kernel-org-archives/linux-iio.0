Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:57324 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934966AbcLTSzo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 13:55:44 -0500
Subject: Re: [PATCH v3 2/2] iio: adc: hx711: Add IIO driver for AVIA HX711
To: Andreas Klinger <ak@it-klinger.de>
References: <20161214161740.GA13896@andreas>
 <78dfc4c0-f792-12b4-ca07-0242e95f7ee5@metafoo.de>
 <20161220103346.GA1318@imap.1und1.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <603f00cf-2c96-53bc-8e5c-a8d881d08a2e@metafoo.de>
Date: Tue, 20 Dec 2016 19:55:39 +0100
MIME-Version: 1.0
In-Reply-To: <20161220103346.GA1318@imap.1und1.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/20/2016 11:33 AM, Andreas Klinger wrote:
>>> +static struct attribute *hx711_attributes[] = {
>>> +	&iio_dev_attr_gain.dev_attr.attr,
>>
>> For IIO devices the gain is typically expressed through the scale attribute.
>> Which is kind of the inverse of gain. It would be good if this driver
>> follows this standard notation. The scale is the value of 1LSB in mV. So
>> this includes the resolution of the ADC, the reference voltage and any gain
>> that is applied to the input signal.
>>
>> The possible values can be listed in the scale_available attribute.
>>
> 
> The reference voltage is in the hardware. 
> Should i use a DT entry for the reference voltage? 
> Or is it better to use a buildin scale and make it changeable?

Typically the reference voltage is specified through the devicetree using a
regulator. Have a look at e.g. ad7291.c.

> 
> 
>>> +	NULL,
>>> +};
>>> +
>>> +static struct attribute_group hx711_attribute_group = {
>>> +	.attrs = hx711_attributes,
>>> +};
>>> +
>>> +static const struct iio_info hx711_iio_info = {
>>> +	.driver_module		= THIS_MODULE,
>>> +	.read_raw		= hx711_read_raw,
>>> +	.attrs			= &hx711_attribute_group,
>>> +};
>>> +
>>> +static const struct iio_chan_spec hx711_chan_spec[] = {
>>> +	{ .type = IIO_VOLTAGE,
>>> +		.info_mask_separate =
>>> +			BIT(IIO_CHAN_INFO_RAW),
>>
>> Given that there are two separate physical input channels this should be
>> expressed here and there should be two IIO channels for the device.
>>
> 
> One who is toggling between channel A and B will cause a dummy read
> additional to every normal read. 
> 
> Should i offer a "toggling mode" which means that after reading
> channel A the channel B is selected for the next read and after
> reading channel B channel A is selected? Simply expecting the channel
> is toggled on every read. If it's not toggled there need to be a dummy 
> read, of course. This should be an attribute, right?

I don't think that is necessary. On one hand when doing these kind of single
shot conversions there is often not a predictable pattern on the other hand
such custom device specific attributes are difficult to handle in a generic
framework. We try to establish standard semantics so a generic application
is able to talk to a wide range of devices. When a device implements custom
attributes that becomes more difficult.

And there is also buffered mode. In buffered mode the application can select
the channels which the converter should cycle through and connect a trigger
like a timer to schedule the conversions. If switching between A and B in a
circular way is required I'd recommend to implement this by using buffered mode.

