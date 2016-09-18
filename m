Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49439 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755302AbcIRKdO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:33:14 -0400
Subject: Re: [PATCH 11/15 v2] iio: accel: kxsd9: Deploy proper register bit
 defines
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
 <1472723089-25113-11-git-send-email-linus.walleij@linaro.org>
 <96839657-7351-8580-fad9-672bfcb302d9@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <78af5237-7861-c0f5-6be3-0a49bbc3ec38@kernel.org>
Date: Sun, 18 Sep 2016 11:33:12 +0100
MIME-Version: 1.0
In-Reply-To: <96839657-7351-8580-fad9-672bfcb302d9@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/16 17:42, Jonathan Cameron wrote:
> On 01/09/16 10:44, Linus Walleij wrote:
>> There are some hardcoded register values etc in the code, define
>> proper bitfield definitions, and use them when getting and setting
>> the scale. Optimize a read/modify/write to use regmap_update_bits()
>> at the same time.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Jonathan Cameron <jic23@kernel.org>
Applied.
>> ---
>> ChangeLog v1->v2:
>> - Rebase on the rest of the series.
>> ---
>>  drivers/iio/accel/kxsd9.c | 36 +++++++++++++++++++++++++++---------
>>  1 file changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>> index d84413ae14b1..8c6a4559256e 100644
>> --- a/drivers/iio/accel/kxsd9.c
>> +++ b/drivers/iio/accel/kxsd9.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/module.h>
>>  #include <linux/regmap.h>
>> +#include <linux/bitops.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>>  #include <linux/iio/buffer.h>
>> @@ -35,9 +36,29 @@
>>  #define KXSD9_REG_RESET		0x0a
>>  #define KXSD9_REG_CTRL_C	0x0c
>>  
>> -#define KXSD9_FS_MASK		0x03
>> +#define KXSD9_CTRL_C_FS_MASK	0x03
>> +#define KXSD9_CTRL_C_FS_8G	0x00
>> +#define KXSD9_CTRL_C_FS_6G	0x01
>> +#define KXSD9_CTRL_C_FS_4G	0x02
>> +#define KXSD9_CTRL_C_FS_2G	0x03
>> +#define KXSD9_CTRL_C_MOT_LAT	BIT(3)
>> +#define KXSD9_CTRL_C_MOT_LEV	BIT(4)
>> +#define KXSD9_CTRL_C_LP_MASK	0xe0
>> +#define KXSD9_CTRL_C_LP_NONE	0x00
>> +#define KXSD9_CTRL_C_LP_2000HZC	BIT(5)
>> +#define KXSD9_CTRL_C_LP_2000HZB	BIT(6)
>> +#define KXSD9_CTRL_C_LP_2000HZA	(BIT(5)|BIT(6))
>> +#define KXSD9_CTRL_C_LP_1000HZ	BIT(7)
>> +#define KXSD9_CTRL_C_LP_500HZ	(BIT(7)|BIT(5))
>> +#define KXSD9_CTRL_C_LP_100HZ	(BIT(7)|BIT(6))
>> +#define KXSD9_CTRL_C_LP_50HZ	(BIT(7)|BIT(6)|BIT(5))
>>  
>>  #define KXSD9_REG_CTRL_B	0x0d
>> +
>> +#define KXSD9_CTRL_B_CLK_HLD	BIT(7)
>> +#define KXSD9_CTRL_B_ENABLE	BIT(6)
>> +#define KXSD9_CTRL_B_ST		BIT(5) /* Self-test */
>> +
>>  #define KXSD9_REG_CTRL_A	0x0e
>>  
>>  /**
>> @@ -65,7 +86,6 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
>>  	int ret, i;
>>  	struct kxsd9_state *st = iio_priv(indio_dev);
>>  	bool foundit = false;
>> -	unsigned int val;
>>  
>>  	for (i = 0; i < 4; i++)
>>  		if (micro == kxsd9_micro_scales[i]) {
>> @@ -75,14 +95,12 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
>>  	if (!foundit)
>>  		return -EINVAL;
>>  
>> -	ret = regmap_read(st->map,
>> -			  KXSD9_REG_CTRL_C,
>> -			  &val);
>> +	ret = regmap_update_bits(st->map,
>> +				 KXSD9_REG_CTRL_C,
>> +				 KXSD9_CTRL_C_FS_MASK,
>> +				 i);
>>  	if (ret < 0)
>>  		goto error_ret;
>> -	ret = regmap_write(st->map,
>> -			   KXSD9_REG_CTRL_C,
>> -			   (val & ~KXSD9_FS_MASK) | i);
>>  error_ret:
>>  	return ret;
>>  }
>> @@ -150,7 +168,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>>  		if (ret < 0)
>>  			goto error_ret;
>>  		*val = 0;
>> -		*val2 = kxsd9_micro_scales[regval & KXSD9_FS_MASK];
>> +		*val2 = kxsd9_micro_scales[regval & KXSD9_CTRL_C_FS_MASK];
>>  		ret = IIO_VAL_INT_PLUS_MICRO;
>>  		break;
>>  	}
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

