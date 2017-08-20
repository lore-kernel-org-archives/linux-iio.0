Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdHTKDD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 06:03:03 -0400
Date: Sun, 20 Aug 2017 10:52:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: accel: kxcjk1013: rename registers for KXTF9
 compatibility
Message-ID: <20170820105222.36dcaa38@archlinux>
In-Reply-To: <97ed7c895e7eec28b66d4e591c30d40b00322820.1502979014.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
        <97ed7c895e7eec28b66d4e591c30d40b00322820.1502979014.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 Aug 2017 16:21:36 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Rename some registers that are shared between KXTF9 and KXCJK.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Hi Michał,

I'm not keen on this change.   Going for generic names is always
fragile as all it takes is another part coming along which is almost
but not quite the same as you shared register set and we end up with
a mess.

General convention for both register values and driver naming is they
should be named after one supported part rather than trying to find
a generic name that covers all supported parts.

So please revert this change and resend the series.

Sorry to be a pain, but this has gone wrong quite a lot of times in
the past!

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 123 ++++++++++++++++++++++-------------------
>  1 file changed, 65 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 80a6508d6370..27147b687471 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -48,39 +48,48 @@
>  
>  #define KXCJK1013_REG_DCST_RESP		0x0C
>  #define KXCJK1013_REG_WHO_AM_I		0x0F
> -#define KXCJK1013_REG_INT_SRC1		0x16
> +#define KXREG_INT_SRC_DATA		0x16
>  #define KXCJK1013_REG_INT_SRC2		0x17
>  #define KXCJK1013_REG_STATUS_REG	0x18
>  #define KXCJK1013_REG_INT_REL		0x1A
> -#define KXCJK1013_REG_CTRL1		0x1B
> -#define KXCJK1013_REG_CTRL2		0x1D
> -#define KXCJK1013_REG_INT_CTRL1		0x1E
> -#define KXCJK1013_REG_INT_CTRL2		0x1F
> +#define KXREG_CTRL1			0x1B
> +#define KXREG_CTRL3			0x1D
> +#define KXREG_INT_CTRL1			0x1E
> +#define KXREG_INT_CTRL2			0x1F
>  #define KXCJK1013_REG_DATA_CTRL		0x21
>  #define KXCJK1013_REG_WAKE_TIMER	0x29
>  #define KXCJK1013_REG_SELF_TEST		0x3A
>  #define KXCJK1013_REG_WAKE_THRES	0x6A
>  
> -#define KXCJK1013_REG_CTRL1_BIT_PC1	BIT(7)
> -#define KXCJK1013_REG_CTRL1_BIT_RES	BIT(6)
> -#define KXCJK1013_REG_CTRL1_BIT_DRDY	BIT(5)
> -#define KXCJK1013_REG_CTRL1_BIT_GSEL1	BIT(4)
> -#define KXCJK1013_REG_CTRL1_BIT_GSEL0	BIT(3)
> -#define KXCJK1013_REG_CTRL1_BIT_WUFE	BIT(1)
> -#define KXCJK1013_REG_INT_REG1_BIT_IEA	BIT(4)
> -#define KXCJK1013_REG_INT_REG1_BIT_IEN	BIT(5)
> +#define KXREG_CTRL1_BIT_PC1	BIT(7)
> +#define KXREG_CTRL1_BIT_RES	BIT(6)
> +#define KXREG_CTRL1_BIT_DRDY	BIT(5)
> +#define KXREG_CTRL1_BIT_GSEL1	BIT(4)
> +#define KXREG_CTRL1_BIT_GSEL0	BIT(3)
> +#define KXREG_CTRL1_BIT_TDTE	BIT(2)
> +#define KXREG_CTRL1_BIT_WUFE	BIT(1)
> +#define KXREG_CTRL1_BIT_TPE	BIT(0)
> +
> +#define KXREG_INT_CTRL1_BIT_IEL	BIT(3)
> +#define KXREG_INT_CTRL1_BIT_IEA	BIT(4)
> +#define KXREG_INT_CTRL1_BIT_IEN	BIT(5)
>  
>  #define KXCJK1013_DATA_MASK_12_BIT	0x0FFF
>  #define KXCJK1013_MAX_STARTUP_TIME_US	100000
>  
>  #define KXCJK1013_SLEEP_DELAY_MS	2000
>  
> -#define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
> -#define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
> -#define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
> -#define KXCJK1013_REG_INT_SRC2_BIT_YN	BIT(3)
> -#define KXCJK1013_REG_INT_SRC2_BIT_XP	BIT(4)
> -#define KXCJK1013_REG_INT_SRC2_BIT_XN	BIT(5)
> +/* KXCJK: INT_SOURCE1 */
> +#define KXREG_INT_BIT_WUFS	BIT(1)
> +#define KXREG_INT_BIT_DRDY	BIT(4)
> +
> +/* KXCJK: INT_SOURCE2: motion detect */
> +#define KXREG_MOTION_INT_BIT_ZP	BIT(0)
> +#define KXREG_MOTION_INT_BIT_ZN	BIT(1)
> +#define KXREG_MOTION_INT_BIT_YP	BIT(2)
> +#define KXREG_MOTION_INT_BIT_YN	BIT(3)
> +#define KXREG_MOTION_INT_BIT_XP	BIT(4)
> +#define KXREG_MOTION_INT_BIT_XN	BIT(5)
>  
>  #define KXCJK1013_DEFAULT_WAKE_THRES	1
>  
> @@ -215,19 +224,19 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
>  {
>  	int ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
>  		return ret;
>  	}
>  
>  	if (mode == STANDBY)
> -		ret &= ~KXCJK1013_REG_CTRL1_BIT_PC1;
> +		ret &= ~KXREG_CTRL1_BIT_PC1;
>  	else
> -		ret |= KXCJK1013_REG_CTRL1_BIT_PC1;
> +		ret |= KXREG_CTRL1_BIT_PC1;
>  
>  	ret = i2c_smbus_write_byte_data(data->client,
> -					KXCJK1013_REG_CTRL1, ret);
> +					KXREG_CTRL1, ret);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
>  		return ret;
> @@ -241,13 +250,13 @@ static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
>  {
>  	int ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
>  		return ret;
>  	}
>  
> -	if (ret & KXCJK1013_REG_CTRL1_BIT_PC1)
> +	if (ret & KXREG_CTRL1_BIT_PC1)
>  		*mode = OPERATION;
>  	else
>  		*mode = STANDBY;
> @@ -259,19 +268,19 @@ static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
>  {
>  	int ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
>  		return ret;
>  	}
>  
> -	ret &= ~(KXCJK1013_REG_CTRL1_BIT_GSEL0 |
> -		 KXCJK1013_REG_CTRL1_BIT_GSEL1);
> +	ret &= ~(KXREG_CTRL1_BIT_GSEL0 |
> +		 KXREG_CTRL1_BIT_GSEL1);
>  	ret |= (KXCJK1013_scale_table[range_index].gsel_0 << 3);
>  	ret |= (KXCJK1013_scale_table[range_index].gsel_1 << 4);
>  
>  	ret = i2c_smbus_write_byte_data(data->client,
> -					KXCJK1013_REG_CTRL1,
> +					KXREG_CTRL1,
>  					ret);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
> @@ -299,16 +308,16 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
>  		return ret;
>  	}
>  
>  	/* Set 12 bit mode */
> -	ret |= KXCJK1013_REG_CTRL1_BIT_RES;
> +	ret |= KXREG_CTRL1_BIT_RES;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL1,
> +	ret = i2c_smbus_write_byte_data(data->client, KXREG_CTRL1,
>  					ret);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_ctrl\n");
> @@ -329,18 +338,18 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  	data->odr_bits = ret;
>  
>  	/* Set up INT polarity */
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_INT_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
>  		return ret;
>  	}
>  
>  	if (data->active_high_intr)
> -		ret |= KXCJK1013_REG_INT_REG1_BIT_IEA;
> +		ret |= KXREG_INT_CTRL1_BIT_IEA;
>  	else
> -		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEA;
> +		ret &= ~KXREG_INT_CTRL1_BIT_IEA;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
> +	ret = i2c_smbus_write_byte_data(data->client, KXREG_INT_CTRL1,
>  					ret);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
> @@ -437,37 +446,37 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_INT_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
>  		return ret;
>  	}
>  
>  	if (status)
> -		ret |= KXCJK1013_REG_INT_REG1_BIT_IEN;
> +		ret |= KXREG_INT_CTRL1_BIT_IEN;
>  	else
> -		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEN;
> +		ret &= ~KXREG_INT_CTRL1_BIT_IEN;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
> +	ret = i2c_smbus_write_byte_data(data->client, KXREG_INT_CTRL1,
>  					ret);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
>  		return ret;
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
>  		return ret;
>  	}
>  
>  	if (status)
> -		ret |= KXCJK1013_REG_CTRL1_BIT_WUFE;
> +		ret |= KXREG_CTRL1_BIT_WUFE;
>  	else
> -		ret &= ~KXCJK1013_REG_CTRL1_BIT_WUFE;
> +		ret &= ~KXREG_CTRL1_BIT_WUFE;
>  
>  	ret = i2c_smbus_write_byte_data(data->client,
> -					KXCJK1013_REG_CTRL1, ret);
> +					KXREG_CTRL1, ret);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
>  		return ret;
> @@ -497,37 +506,35 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_INT_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
>  		return ret;
>  	}
>  
>  	if (status)
> -		ret |= KXCJK1013_REG_INT_REG1_BIT_IEN;
> +		ret |= KXREG_INT_CTRL1_BIT_IEN;
>  	else
> -		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEN;
> +		ret &= ~KXREG_INT_CTRL1_BIT_IEN;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
> -					ret);
> +	ret = i2c_smbus_write_byte_data(data->client, KXREG_INT_CTRL1, ret);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
>  		return ret;
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_CTRL1);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
>  		return ret;
>  	}
>  
>  	if (status)
> -		ret |= KXCJK1013_REG_CTRL1_BIT_DRDY;
> +		ret |= KXREG_CTRL1_BIT_DRDY;
>  	else
> -		ret &= ~KXCJK1013_REG_CTRL1_BIT_DRDY;
> +		ret &= ~KXREG_CTRL1_BIT_DRDY;
>  
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					KXCJK1013_REG_CTRL1, ret);
> +	ret = i2c_smbus_write_byte_data(data->client, KXREG_CTRL1, ret);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
>  		return ret;
> @@ -603,10 +610,10 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>  
>  	data->odr_bits = odr_setting->odr_bits;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL2,
> +	ret = i2c_smbus_write_byte_data(data->client, KXREG_CTRL3,
>  					odr_setting->wuf_bits);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_ctrl2\n");
> +		dev_err(&data->client->dev, "Error writing reg_ctrl3\n");
>  		return ret;
>  	}
>  
> @@ -1097,13 +1104,13 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_SRC1);
> +	ret = i2c_smbus_read_byte_data(data->client, KXREG_INT_SRC_DATA);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_int_src1\n");
>  		goto ack_intr;
>  	}
>  
> -	if (ret & 0x02) {
> +	if (ret & KXREG_INT_BIT_WUFS) {
>  		kxcjk1013_report_motion_event(indio_dev);
>  	}
>  

