Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33419 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdEPSVN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 May 2017 14:21:13 -0400
Subject: Re: [PATCH v2 1/2] iio: accel: bma180: Add support for BMA250E
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20170516125159.25403-1-hdegoede@redhat.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d2cbc135-45b1-48e8-0552-8f0934c26417@kernel.org>
Date: Tue, 16 May 2017 19:21:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170516125159.25403-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/05/17 13:51, Hans de Goede wrote:
> The BMA250E adds a new fifo mode and is fully backwards compatible
> with the BMA250, but with a different chip-id.
> 
> This commit adds support for it by adjusting the chip-id check and
> otherwise treating it as a regular BMA250.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/iio/accel/bma180.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index efc67739c28f..3d6694821a96 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -36,6 +36,7 @@
>   enum chip_ids {
>   	BMA180,
>   	BMA250,
> +	BMA250E,
>   };
>   
>   struct bma180_data;
> @@ -55,6 +56,7 @@ struct bma180_part_info {
>   	u8 power_reg, power_mask, lowpower_val;
>   	u8 int_enable_reg, int_enable_mask;
>   	u8 softreset_reg;
> +	u8 chip_id;
>   
>   	int (*chip_config)(struct bma180_data *data);
>   	void (*chip_disable)(struct bma180_data *data);
> @@ -112,6 +114,8 @@ struct bma180_part_info {
>   #define BMA250_INT1_DATA_MASK	BIT(0)
>   #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
>   
> +#define BMA250E_CHIP_ID		0xf9
> +
>   struct bma180_data {
>   	struct i2c_client *client;
>   	struct iio_trigger *trig;
> @@ -309,7 +313,7 @@ static int bma180_chip_init(struct bma180_data *data)
>   
>   	if (ret < 0)
>   		return ret;
> -	if (ret != BMA180_ID_REG_VAL)
> +	if (ret != data->part_info->chip_id)
>   		return -ENODEV;
>   
>   	ret = bma180_soft_reset(data);
> @@ -632,6 +636,7 @@ static const struct bma180_part_info bma180_part_info[] = {
>   		BMA180_TCO_Z, BMA180_MODE_CONFIG, BMA180_LOW_POWER,
>   		BMA180_CTRL_REG3, BMA180_NEW_DATA_INT,
>   		BMA180_RESET,
> +		BMA180_CHIP_ID,
>   		bma180_chip_config,
>   		bma180_chip_disable,
>   	},
> @@ -646,6 +651,22 @@ static const struct bma180_part_info bma180_part_info[] = {
>   		BMA250_POWER_REG, BMA250_LOWPOWER_MASK, 1,
>   		BMA250_INT_ENABLE_REG, BMA250_DATA_INTEN_MASK,
>   		BMA250_RESET_REG,
> +		BMA180_CHIP_ID,
> +		bma250_chip_config,
> +		bma250_chip_disable,
> +	},
> +	[BMA250E] = {
> +		bma250_channels, ARRAY_SIZE(bma250_channels),
> +		bma250_scale_table, ARRAY_SIZE(bma250_scale_table),
> +		bma250_bw_table, ARRAY_SIZE(bma250_bw_table),
> +		BMA250_INT_RESET_REG, BMA250_INT_RESET_MASK,
> +		BMA250_POWER_REG, BMA250_SUSPEND_MASK,
> +		BMA250_BW_REG, BMA250_BW_MASK,
> +		BMA250_RANGE_REG, BMA250_RANGE_MASK,
> +		BMA250_POWER_REG, BMA250_LOWPOWER_MASK, 1,
> +		BMA250_INT_ENABLE_REG, BMA250_DATA_INTEN_MASK,
> +		BMA250_RESET_REG,
> +		BMA250E_CHIP_ID,
>   		bma250_chip_config,
>   		bma250_chip_disable,
>   	},
Yikes.  I never picked up on this being there before.
Assigning elements of such a large structure is always going to be fragile.

I'll probably take this patch as is, but we really ought to move over to
using named element assignment in here.  It'll be a little more verbose but
way less fragile!   Not to mention allows the possibly upcoming
structure random ordering to work (if that merges).
> @@ -845,6 +866,7 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
>   static struct i2c_device_id bma180_ids[] = {
>   	{ "bma180", BMA180 },
>   	{ "bma250", BMA250 },
> +	{ "bma250e", BMA250E },
>   	{ }
>   };
>   
> 

