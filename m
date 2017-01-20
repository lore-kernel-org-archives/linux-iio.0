Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58642 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdATReN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 12:34:13 -0500
Date: Fri, 20 Jan 2017 17:23:41 +0000
In-Reply-To: <20170120095952.GA9790@kroah.com>
References: <20170120094605.25602-1-linus.walleij@linaro.org> <20170120095952.GA9790@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] iio: accel: fix Kconfig warning
To: Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <9A1BDB61-A4A1-4891-A5BE-0A63FD69E919@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 20 January 2017 09:59:52 GMT+00:00, Greg KH <greg@kroah.com> wrote:
>On Fri, Jan 20, 2017 at 10:46:05AM +0100, Linus Walleij wrote:
>> commit 762227721fe6225be5b6d233ef681aea5871f5f3
>> "iio: accel: st_accel: handle deprecated bindings"
>> attempted to be smart and let users use the old I2C
>> driver and the new SPI driver, or the old SPI driver and
>> the new I2C driver in combination for the LIS3LV02,
>> and put the restrictions on the I2C and SPI subdrivers
>> not not be combined with the old subdrivers.
>> 
>> This doesn't work since the IIO ST accel top-level
>> component selects the I2C and SPI subdrivers, resulting
>> in the following Kconfig noise:
>> 
>> warning: (IIO_ST_ACCEL_3AXIS) selects IIO_ST_ACCEL_I2C_3AXIS
>> which has unmet direct dependencies (IIO && !SENSORS_LIS3_I2C
>> && IIO_ST_ACCEL_3AXIS && IIO_ST_SENSORS_I2C)
>> warning: (IIO_ST_ACCEL_3AXIS) selects IIO_ST_ACCEL_SPI_3AXIS
>> which has unmet direct dependencies (IIO && !SENSORS_LIS3_SPI
>> && IIO_ST_ACCEL_3AXIS && IIO_ST_SENSORS_SPI)
>> (...)
>> 
>> This fixes the issue by putting the dependencies directly
>> in the top-level component instead, so that it never gets
>> to select its unselectable subcomponent.
>> 
>> Cc: Greg KH <greg@kroah.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Fixes: 762227721fe6 ("iio: accel: st_accel: handle deprecated
>bindings")
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> I guess Greg can apply the patch directly to quickly get
>> rid of the Kconfig noise, else Jonathan can funnel it as
>> a fix.
>
>I'll be glad to take it if I can get an ack from Jonathan.
Acked-by: Jonathan Cameron <jic23@kernel.org>. Thanks
>
>thanks for the quick response,
>
>greg k-h

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
