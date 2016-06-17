Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57163 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbcFQQWk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2016 12:22:40 -0400
In-Reply-To: <1466169744-23214-1-git-send-email-linus.walleij@linaro.org>
References: <1466169744-23214-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: accel: kxsd9: fix the usage of spi_w8r8()
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Fri, 17 Jun 2016 17:22:22 +0100
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Message-ID: <B676781F-1D3F-4C2D-A11E-EEC33F5BB34C@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 17 June 2016 14:22:24 BST, Linus Walleij <linus.walleij@linaro.org> wrote:
>These two spi_w8r8() calls return a value with is used by the code
>following the error check. The dubious use was caused by a cleanup
>patch.
>
>Fixes: d34dbee8ac8e ("staging:iio:accel:kxsd9 cleanup and conversion to
>iio_chan_spec.")
>Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>---
>Jonathan: I suspect the driver was never tested after the cleanup?
>I'm trying to use the driver to bolt on I2C support, but I'm a bit
>suspicious that it's not really working for SPI even.

Sadly it is more than possible. My test bodge rig for this one was down for a long time. (Hides guilty expression)
Most of it is back running now as I was looking at the sca3000 driver recently
 which used the same mashup (with another adapter cable).

Pretty simple device iirc so shouldn't be too hard to fix. Original driver got written
 in about a day long ago...

Where did you find one of these. I thought they were long obsoleted?

J
>---
> drivers/iio/accel/kxsd9.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>index 923f56598d4b..3a9f106787d2 100644
>--- a/drivers/iio/accel/kxsd9.c
>+++ b/drivers/iio/accel/kxsd9.c
>@@ -81,7 +81,7 @@ static int kxsd9_write_scale(struct iio_dev
>*indio_dev, int micro)
> 
> 	mutex_lock(&st->buf_lock);
> 	ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
>-	if (ret)
>+	if (ret < 0)
> 		goto error_ret;
> 	st->tx[0] = KXSD9_WRITE(KXSD9_REG_CTRL_C);
> 	st->tx[1] = (ret & ~KXSD9_FS_MASK) | i;
>@@ -163,7 +163,7 @@ static int kxsd9_read_raw(struct iio_dev
>*indio_dev,
> 		break;
> 	case IIO_CHAN_INFO_SCALE:
> 		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
>-		if (ret)
>+		if (ret < 0)
> 			goto error_ret;
> 		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
> 		ret = IIO_VAL_INT_PLUS_MICRO;

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
