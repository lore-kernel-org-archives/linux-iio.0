Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752375AbeAFLrk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 06:47:40 -0500
Date: Sat, 6 Jan 2018 11:47:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: remove unnecessary
 get_unaligned_le16()
Message-ID: <20180106114735.34c3b198@archlinux>
In-Reply-To: <20180101141908.22531-1-lorenzo.bianconi@redhat.com>
References: <20180101141908.22531-1-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  1 Jan 2018 15:19:08 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Remove unnecessary unaligned access routine in hts221_read_oneshot() and
> the related include
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Whilst build testing this sparse came up with: 

  CHECK   drivers/iio/humidity/hts221_core.c
drivers/iio/humidity/hts221_core.c:278:19: warning: cast to restricted __le16
drivers/iio/humidity/hts221_core.c:289:18: warning: cast to restricted __le16
drivers/iio/humidity/hts221_core.c:295:18: warning: cast to restricted __le16
drivers/iio/humidity/hts221_core.c:327:18: warning: cast to restricted __le16
drivers/iio/humidity/hts221_core.c:333:18: warning: cast to restricted __le16

There are definitely some suspicious bits of code there.  Would you mind
cleaning this up? Looks to me like the regmap specification should
be handling the endianness.

Actually this is nasty enough that I'm going to back out the regmap conversion
for now.  Would you mind spinning a single patch doing the whole conversion
with this corrected.  Probably roll this patch into that series as well.

I've kept the common code patch though as that is fine on its own.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hts221_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 75d442e7b510..6df59e12c5e2 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -14,7 +14,6 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/delay.h>
>  #include <linux/pm.h>
> -#include <asm/unaligned.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
>  
> @@ -404,7 +403,7 @@ static int hts221_get_sensor_offset(struct hts221_hw *hw,
>  
>  static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>  {
> -	u8 data[HTS221_DATA_SIZE];
> +	__le16 data;
>  	int err;
>  
>  	err = hts221_set_enable(hw, true);
> @@ -413,13 +412,13 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>  
>  	msleep(50);
>  
> -	err = regmap_bulk_read(hw->regmap, addr, data, sizeof(data));
> +	err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
>  	if (err < 0)
>  		return err;
>  
>  	hts221_set_enable(hw, false);
>  
> -	*val = (s16)get_unaligned_le16(data);
> +	*val = (s16)le16_to_cpu(data);
>  
>  	return IIO_VAL_INT;
>  }

