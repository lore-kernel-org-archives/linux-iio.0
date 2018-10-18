Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:56172 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeJRPkT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 11:40:19 -0400
Subject: Re: [PATCH v2] staging: iio: ad7816: Switch to the gpio descriptor
 interface
To: Phil Reid <preid@electromag.com.au>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <20181017144716.GA11485@nishad>
 <fdcb085c-cf34-3310-f5ab-5795d5997977@electromag.com.au>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e3d4308c-9608-db52-c51e-5bb5d126284a@metafoo.de>
Date: Thu, 18 Oct 2018 09:40:00 +0200
MIME-Version: 1.0
In-Reply-To: <fdcb085c-cf34-3310-f5ab-5795d5997977@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2018 09:28 AM, Phil Reid wrote:
[...]
>> +    chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
>> +    if (IS_ERR(chip->rdwr_pin)) {
>> +        ret = PTR_ERR(chip->rdwr_pin);
>> +        dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
>> +            ret);
>>           return ret;
>>       }
>> -    gpio_direction_input(chip->rdwr_pin);
> 
> The RD/WR pin is an input to the AD78xx. So this doesn't make sense being
> GPIOD_IN.

One thing at a time. This patch is a straight forward conversion to the GPIO
descriptor interface. It keeps the existing semantics of the driver as they are.

Now these semantics are obviously wrong and should be fixed but that should
be a separate patch from changing the interface.
