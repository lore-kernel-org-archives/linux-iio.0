Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.195]:29229 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752374Ab3GHI12 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jul 2013 04:27:28 -0400
Message-ID: <51DA77E8.3020803@digi.com>
Date: Mon, 8 Jul 2013 10:27:20 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"marex@denx.de" <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH 3/4] iio: mxs-lradc: add scale_available file to channels
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-4-git-send-email-hector.palacios@digi.com> <51D6A282.4040506@metafoo.de>
In-Reply-To: <51D6A282.4040506@metafoo.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Lars,

On 07/05/2013 12:40 PM, Lars-Peter Clausen wrote:
> On 07/05/2013 10:30 AM, Hector Palacios wrote:
> [...]
>> +#define SHOW_SCALE_AVAILABLE_FUNC(ch) 					\
>> +static ssize_t mxs_lradc_show_scale_available##ch(struct device *dev,	\
>> +		struct device_attribute *attr, 				\
>> +		char *buf)						\
>> +{ 									\
>> +	return c ch);	\
>> +}
>
> No need for a separate function for each channel. Use the address attribute
> of the iio_dev_attr. E.g.
>
> struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
>
> return mxs_lradc_show_scale_available_ch(dev, attr, buf, iio_attr->address);
>
> The last parameter to IIO_DEVICE_ATTR initializes this field.

Nice, I knew there had to be a better way.

> But I think you can need less boilerplate code if you use the
> iio_chan_spec_ext_info feature. Take a look at IIO_ENUM_AVAILABLE and
> friends to see how it is done.

I just took a look but don't know how I can use this framework with scales, as a scale 
is an array composed of two numbers (integer and fractional parts), not simple strings 
which is what iio_enum.items expects.

Best regards,
--
Hector Palacios
