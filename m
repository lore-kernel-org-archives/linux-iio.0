Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44993 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbcLIQ0f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2016 11:26:35 -0500
Subject: Re: [PATCH v8 3/3] iio: adc: add support for Allwinner SoCs ADC
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161209102236.17655-1-quentin.schulz@free-electrons.com>
 <20161209102236.17655-4-quentin.schulz@free-electrons.com>
 <alpine.DEB.2.02.1612091657540.16360@pmeerw.net>
Cc: linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        wens@csie.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <b985dc64-fa14-1930-e73d-1d197b29ba53@free-electrons.com>
Date: Fri, 9 Dec 2016 17:26:31 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1612091657540.16360@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

On 09/12/2016 17:04, Peter Meerwald-Stadler wrote:
[...]
>> +	case IIO_CHAN_INFO_SCALE:
>> +		if (chan->type == IIO_VOLTAGE) {
>> +			/* 3000mV / 4096 * raw */
>> +			*val = 0;
>> +			*val2 = 732421875;
> 
> this looks more like INT_PLUS_NANO, beyond range of micro?
> 
>> +			return IIO_VAL_INT_PLUS_MICRO;

No, this is rather a mistake.

The scale to convert to mV is 0.732421875 (3000mV / 4096). The scale to
convert to uV is thus 732.421875.

The above code better is:

*val = 732;
*val2 = 421875;
return IIO_VAL_INT_PLUS_MICRO;

Thanks!

Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
