Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47768 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcFZQdm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:33:42 -0400
Subject: Re: [PATCH] iio: accel: kxsd9: fix the usage of spi_w8r8()
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org
References: <1466169744-23214-1-git-send-email-linus.walleij@linaro.org>
 <B676781F-1D3F-4C2D-A11E-EEC33F5BB34C@jic23.retrosnub.co.uk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <279a6ec1-ddec-2de5-17d2-3fd7c6b89cf4@kernel.org>
Date: Sun, 26 Jun 2016 17:33:38 +0100
MIME-Version: 1.0
In-Reply-To: <B676781F-1D3F-4C2D-A11E-EEC33F5BB34C@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/16 17:22, Jonathan Cameron wrote:
> 
> 
> On 17 June 2016 14:22:24 BST, Linus Walleij <linus.walleij@linaro.org> wrote:
>> These two spi_w8r8() calls return a value with is used by the code
>> following the error check. The dubious use was caused by a cleanup
>> patch.
>>
>> Fixes: d34dbee8ac8e ("staging:iio:accel:kxsd9 cleanup and conversion to
>> iio_chan_spec.")
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
This patch is 'obviously' correct so applied and marked for stable.

Thanks,

Jonathan
>> ---
>> Jonathan: I suspect the driver was never tested after the cleanup?
>> I'm trying to use the driver to bolt on I2C support, but I'm a bit
>> suspicious that it's not really working for SPI even.
> 
> Sadly it is more than possible. My test bodge rig for this one was down for a long time. (Hides guilty expression)
> Most of it is back running now as I was looking at the sca3000 driver recently
>  which used the same mashup (with another adapter cable).
> 
> Pretty simple device iirc so shouldn't be too hard to fix. Original driver got written
>  in about a day long ago...
> 
> Where did you find one of these. I thought they were long obsoleted?
> 
> J
>> ---
>> drivers/iio/accel/kxsd9.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>> index 923f56598d4b..3a9f106787d2 100644
>> --- a/drivers/iio/accel/kxsd9.c
>> +++ b/drivers/iio/accel/kxsd9.c
>> @@ -81,7 +81,7 @@ static int kxsd9_write_scale(struct iio_dev
>> *indio_dev, int micro)
>>
>> 	mutex_lock(&st->buf_lock);
>> 	ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
>> -	if (ret)
>> +	if (ret < 0)
>> 		goto error_ret;
>> 	st->tx[0] = KXSD9_WRITE(KXSD9_REG_CTRL_C);
>> 	st->tx[1] = (ret & ~KXSD9_FS_MASK) | i;
>> @@ -163,7 +163,7 @@ static int kxsd9_read_raw(struct iio_dev
>> *indio_dev,
>> 		break;
>> 	case IIO_CHAN_INFO_SCALE:
>> 		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
>> -		if (ret)
>> +		if (ret < 0)
>> 			goto error_ret;
>> 		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
>> 		ret = IIO_VAL_INT_PLUS_MICRO;
> 

