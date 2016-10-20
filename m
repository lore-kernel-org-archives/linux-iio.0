Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0092.outbound.protection.outlook.com ([104.47.0.92]:14205
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752359AbcJUDXT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Oct 2016 23:23:19 -0400
Subject: Re: [PATCH 2/4] iio: dpot-dac: DAC driver based on a digital
 potentiometer
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
 <1476955562-13673-3-git-send-email-peda@axentia.se>
 <alpine.DEB.2.02.1610201254370.19919@pmeerw.net>
 <22d07498-860d-29f8-07ef-ae2f5df6ab25@axentia.se>
 <alpine.DEB.2.02.1610201604280.22512@pmeerw.net>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <430867e6-478d-420a-f2ae-5474a4ebfa0d@axentia.se>
Date: Thu, 20 Oct 2016 16:51:23 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1610201604280.22512@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-10-20 16:08, Peter Meerwald-Stadler wrote:
>>>> +	u32 max_ohms;
>>>> +};
>>>> +
>>>> +static const struct iio_chan_spec dpot_dac_iio_channel = {
>>>> +	.type = IIO_VOLTAGE,
>>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
>>>> +			    | BIT(IIO_CHAN_INFO_SCALE),
>>>> +	.output = 1,
>>>> +};
>>>> +
>>>> +static int dpot_dac_read_raw(struct iio_dev *indio_dev,
>>>> +			     struct iio_chan_spec const *chan,
>>>> +			     int *val, int *val2, long mask)
>>>> +{
>>>> +	struct dpot_dac *dac = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +	unsigned long long tmp;
>>>
>>> s64 (which is used to cast below)
>>
>> I assume that what you really want is to get rid of the cast, and
>> that you aren't really bothered if tmp is ull or s32, right? Given
>> that assumption, I'm just dropping the cast instead. The LL specifier
>> on the constant should promote *val anyway.
> 
> what I meant to pick upon was mixing
> s64 with unsigned long long with LL in the code that follows
> 
> anything simpler and more consistent would be good

Right, I should however note that I copied the pattern from the
industrialio-core.c:iio_format_value function. So, in my defense
I was consistent with that...

Cheers,
Peter

