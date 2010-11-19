Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:52545 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab0KSRms (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2010 12:42:48 -0500
Message-ID: <4CE6B89E.6080008@cam.ac.uk>
Date: Fri, 19 Nov 2010 17:49:18 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] staging: iio: adc: Enable driver support for ad7887 AD
 converter
References: <1290097328-6236-1-git-send-email-michael.hennerich@analog.com> <4CE68D1F.3050200@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771312EE154B7@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771312EE154B7@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

...
>>> +
>>> +#define RES_MASK(bits)      ((1 << (bits)) - 1)
>> It feels like this ought to be a standard macro, but I can't find it in
>> any of the obvious headers...
> 
> I thought so too.
> But I also can't find it - maybe add to one of the iio common headers?
Or propose it for inclusion in bitops.h itself?


...
>>> +
>> Use one of the endian macros for this perhaps?
> 
> Can do but need to make data 16-bit aligned.
Ah I'd missed that it wasn't. My mistake. Leave this as it is.
> 
>>> +    return (st->data[(ch * 2)] << 8) | st->data[(ch * 2) + 1]; }
>>> +
...
> ok
> 
>>> +                    mode = 0;
>>> +
>>> +    return mode;
>>> +}
>>> +
>>> +static const struct attribute_group ad7887_attribute_group = {
>>> +    .attrs = ad7887_attributes,
>>> +    .is_visible = ad7887_attr_is_visible, };
>>> +
>>
>> So is there a plan to add more parts to this driver?  Usually one
>> doesn't put this code in until at's needed, but if more are following
>> shortly then it's fine with me. Perhaps add something to the commit
>> message to indicate that this is going to be needed by future device
>> support?
> 
> Plan is to add more drivers - indeed I already have added one.
> But I need to wait for test hardware to arrive.
Cool.
> 
>>
>>> +static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
>>> +    [ID_AD7887] = {
>>> +            .bits = 12,
>>> +            .storagebits = 16,
>>> +            .res_shift = 0,
>>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>> +            .int_vref_mv = 2500,
>>> +    },
>>> +};
>>> +
>>> +static int __devinit ad7887_probe(struct spi_device *spi) {
>>> +    struct ad7887_platform_data *pdata = spi->dev.platform_data;
>>> +    struct ad7887_state *st;
>>> +    int ret, voltage_uv = 0;
>>> +
>>> +    st = kzalloc(sizeof(*st), GFP_KERNEL);
>>> +    if (st == NULL) {
>>> +            ret = -ENOMEM;
>>> +            goto error_ret;
>>> +    }
>>> +
>>> +    st->reg = regulator_get(&spi->dev, "vcc");
>>> +    if (!IS_ERR(st->reg)) {
>>> +            ret = regulator_enable(st->reg);
>>> +            if (ret)
>>> +                    goto error_put_reg;
>>> +
>>> +            voltage_uv = regulator_get_voltage(st->reg);
>> Technically you might want to register for the voltage change
>> notification from the regulator.  Some other driver might request a
>> different voltage and I don't think you have prevented it from changing.
> 
> I'm not quite sure what you mean. I don't think someone wants to change this voltage on the fly.
It would be a little odd, but you never know... Agreed, it probably isn't worth handling
in here.  If someone actually does do this, then we can add support.
...
>>> +    /* Ensure the timestamp is 8 byte aligned */
>>> +    d_size = bytes + sizeof(s64);
>>> +    if (d_size % sizeof(s64))
>> Spacing looks dubious round that minus sign. Would have thought
>> checkpatch would have moaned about that.
> 
> Actually checkpatch complained about having the spacing.
> I removed it to make checkpatch happy.
> Must be a bug in checkpatch, I'll revert.
Might be worth sending that example on as a bug report for checkpatch
Very strange response...
...

> Thanks for reviewing!
You are welcome.

Jonathan
