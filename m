Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35217 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbBAKFp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Feb 2015 05:05:45 -0500
Message-ID: <54CDFA77.1060701@kernel.org>
Date: Sun, 01 Feb 2015 10:05:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: sanjeev sharma <sanjeevsharmaengg@gmail.com>,
	Devendra Naga <devendra.aaru@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel <devel@driverdev.osuosl.org>
Subject: Re: [PATCH V2 1/2] iio: meter: ade7754: add error handling in _reset
 and _stop_device
References: <1420189375-19854-1-git-send-email-devendra.aaru@gmail.com> <CAGUYZuTsV1x+tsQpm-yeuXfM9XVT7it9Nj8rzxqCaVOVmND7Jw@mail.gmail.com>
In-Reply-To: <CAGUYZuTsV1x+tsQpm-yeuXfM9XVT7it9Nj8rzxqCaVOVmND7Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/15 05:57, sanjeev sharma wrote:
> On Fri, Jan 2, 2015 at 2:32 PM, Devendra Naga <devendra.aaru@gmail.com> wrote:
>> This patch adds the error handling for the value returned from
>> ade7754_spi_read_reg_8. With this patch, the following randconfig
>> warnings get fixed automatically.
>>
>> drivers/staging/iio/meter/ade7754.c:222:6: warning: ‘val’ may be used
>> uninitialized in this function [-Wmaybe-uninitialized]
>> drivers/staging/iio/meter/ade7754.c:368:6: warning: ‘val’ may be used
>> uninitialized in this function [-Wmaybe-uninitialized]
>>
>> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
>> ---
>>
>>  Hello,
>>
>>  Please see if this is the error message you wanted.
>>
>>  Build tested on next-20141231 with randconfig sent to iio ml,
>>  and with allmodconfig.
>>
>>  drivers/staging/iio/meter/ade7754.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
>> index 81f6731..746b188 100644
>> --- a/drivers/staging/iio/meter/ade7754.c
>> +++ b/drivers/staging/iio/meter/ade7754.c
>> @@ -216,9 +216,13 @@ error_ret:
>>
>>  static int ade7754_reset(struct device *dev)
>>  {
>> +       int ret;
>>         u8 val;
>>
>> -       ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
>> +       ret = ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
>> +       if (ret < 0)
> 
> IMO,we should have consistent change throughout and here also we
> should use dev_err in failure scenario.
That would perhaps be an additional improvement, but the patch as it
stands is still a good thing so applied.  Feel free to follow up
with additional debugging information.

>> +               return ret;
>> +
>>         val |= 1 << 6; /* Software Chip Reset */
>>         return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
>>  }
>> @@ -362,9 +366,16 @@ error_ret:
>>  /* Power down the device */
>>  static int ade7754_stop_device(struct device *dev)
>>  {
>> +       int ret;
>>         u8 val;
>>
>> -       ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
>> +       ret = ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
>> +       if (ret < 0) {
>> +               dev_err(dev, "unable to power down the device, error: %d",
>> +                       ret);
>> +               return ret;
>> +       }
>> +
>>         val |= 7 << 3;  /* ADE7754 powered down */
>>         return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
>>  }
>> --
>> 1.9.3
>>
>> _______________________________________________
>> devel mailing list
>> devel@linuxdriverproject.org
>> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

