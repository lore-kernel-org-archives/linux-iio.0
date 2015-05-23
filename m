Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50275 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757439AbbEWLV7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 07:21:59 -0400
Message-ID: <556062D2.3070101@kernel.org>
Date: Sat, 23 May 2015 12:21:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: light: Updated Vishay Capella cm32181 ambient
 light sensor driver.
References: <1432268380-7302-1-git-send-email-ktsai@capellamicro.com> <1432268380-7302-6-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1432268380-7302-6-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/15 05:19, Kevin Tsai wrote:
> - Added Interrupt support.
> 
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
This needs a detailed description.  There is interaction in here I think
between auto set thresholds and IIO threshold events. Not entirely
obvious how this intended to work.

Particularly as it seems that any read of the als will result in the thresholds
moving whether or nor a limit has been reached.

Jonathan

> ---
>  drivers/iio/light/cm32181.c | 156 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 153 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b7abd46..1ae32a0 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -47,6 +47,10 @@
>  /* ALS_WL register */
>  #define CM32181_ALS_WL_DEFAULT		0x0000
>  
> +/* STATUS register */
> +#define CM32181_STATUS_ALS_IF_L		BIT(15)
> +#define CM32181_STATUS_ALS_IF_H		BIT(14)
> +
>  /* Software parameters */
>  #define CM32181_HW_ID			0x81
>  #define CM32181_MLUX_PER_BIT		5	/* ALS_SM=01 IT=800ms */
> @@ -122,7 +126,8 @@ void cm32181_parse_dt(struct cm32181_chip *chip)
>  	if (!of_property_read_u32(dn, "capella,mlux_per_bit", &temp_val))
>  		als_info->mlux_per_bit = (int)temp_val;
>  	if (!of_property_read_u32(dn, "capella,thd_percent", &temp_val))
> -		als_info->thd_percent = (int)temp_val;
> +		if (((int)temp_val >= 0) && ((int)temp_val < 100))
> +			als_info->thd_percent = (int)temp_val;
>  }
>  #endif
>  
> @@ -173,6 +178,63 @@ static int cm32181_reg_init(struct cm32181_chip *chip)
>  }
>  
>  /**
> + * cm32181_interrupt() - enable/disable interrupt
> + * @chip:       pointer of struct cm32181_chip
> + * @ int_en:	truen for enable; false for disable
> + *
> + * Enable/disable interrupt mode
> + *
> + * Return: 0 for success; otherwise for error code.
> + */
> +static int cm32181_interrupt(struct cm32181_chip *cm32181, bool int_en)
> +{
> +	int ret;
> +
> +	mutex_lock(&cm32181->lock);
> +	if (int_en)
> +		cm32181->conf_regs[CM32181_REG_ADDR_CMD] |=
> +			CM32181_CMD_ALS_INT_EN;
> +	else
> +		cm32181->conf_regs[CM32181_REG_ADDR_CMD] &=
> +			~CM32181_CMD_ALS_INT_EN;
> +
> +	ret = i2c_smbus_write_word_data(cm32181->client,
> +			CM32181_REG_ADDR_CMD,
> +			cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> +	mutex_unlock(&cm32181->lock);
> +	return ret;
> +}
> +
> +static irqreturn_t cm32181_irq_handler(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
> +	struct i2c_client *client = cm32181->client;
> +	int ret;
> +	u64 ev_code;
> +
> +	ret = i2c_smbus_read_word_data(cm32181->client,
> +			CM32181_REG_ADDR_STATUS);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"%s: Data read failed: %d\n", __func__, ret);
> +		return IRQ_NONE;
> +	}
> +
> +	if (!(ret & (CM32181_STATUS_ALS_IF_H | CM32181_STATUS_ALS_IF_L)))
> +		return IRQ_NONE;
> +
> +	ev_code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +				0,
> +				IIO_EV_TYPE_THRESH,
> +				IIO_EV_DIR_EITHER);
> +
> +	iio_push_event(indio_dev, ev_code, iio_get_time_ns());
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
>   * cm32181_read_als_it() - Get sensor integration time
>   * @chip:	pointer of struct cm32181_chip
>   * @val:	pointer of int to load the integration (sec)
> @@ -242,6 +304,51 @@ static int cm32181_write_als_it(struct cm32181_chip *chip, int val, int val2)
>  }
>  
>  /**
> + * cm32181_ials_read() - read ALS raw data
typo
> + * @chip:       pointer of struct cm32181_chip
> + *
> + * Read the ALS raw data and update the interrupt threshold windows.
> + *
> + * Return: Positive value is ALS raw data, otherwise is error code.
> + */
> +static int cm32181_als_read(struct cm32181_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct cm32181_als_info *als_info = chip->als_info;
> +	u16 als, wh, wl, delta;
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
> +	if (ret < 0)
> +		return ret;
> +
> +	als = (u16)ret;
> +
> +	if (als_info->thd_percent) {
> +		delta = als * als_info->thd_percent / 100;
> +		if (delta < 3)
> +			delta = 3;
> +		wh = (als + delta > 0xFFFF) ? 0xFFFF : (als + delta);
> +		wl = (als < delta) ? 0 : (als - delta);
> +
> +		ret = i2c_smbus_write_word_data(client,
> +			CM32181_REG_ADDR_ALS_WH, wh);
> +		if (ret < 0)
> +			return ret;
> +		chip->conf_regs[CM32181_REG_ADDR_ALS_WH] = wh;
> +
> +		ret = i2c_smbus_write_word_data(client,
> +			CM32181_REG_ADDR_ALS_WL, wl);
> +		if (ret < 0)
> +			return ret;
> +		chip->conf_regs[CM32181_REG_ADDR_ALS_WL] = wl;
> +		ret = als;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
>   * cm32181_get_lux() - report current lux value
>   * @chip:	pointer of struct cm32181_chip
>   *
> @@ -252,7 +359,6 @@ static int cm32181_write_als_it(struct cm32181_chip *chip, int val, int val2)
>   */
>  static int cm32181_get_lux(struct cm32181_chip *chip)
>  {
> -	struct i2c_client *client = chip->client;
>  	struct cm32181_als_info *als_info = chip->als_info;
>  	int ret;
>  	int val, val2;
> @@ -268,7 +374,7 @@ static int cm32181_get_lux(struct cm32181_chip *chip)
>  	lux *= als_info->mlux_per_bit_base_it;
>  	lux = div_u64(lux, als_it);
>  
> -	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
> +	ret = cm32181_als_read(chip);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -350,6 +456,15 @@ static ssize_t cm32181_get_it_available(struct device *dev,
>  	return len + scnprintf(buf + len, PAGE_SIZE - len, "\n");
>  }
>  
> +static const struct iio_event_spec cm32181_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				BIT(IIO_EV_INFO_ENABLE),
> +	}
> +};
> +
>  static const struct iio_chan_spec cm32181_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
> @@ -357,6 +472,8 @@ static const struct iio_chan_spec cm32181_channels[] = {
>  			BIT(IIO_CHAN_INFO_PROCESSED) |
>  			BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.event_spec = cm32181_event_spec,
> +		.num_event_specs = ARRAY_SIZE(cm32181_event_spec),
>  	}
>  };
>  
> @@ -383,6 +500,7 @@ static int cm32181_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct cm32181_chip *chip;
> +	struct cm32181_als_info *als_info;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> @@ -412,11 +530,35 @@ static int cm32181_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	als_info = chip->als_info;
> +	if (als_info->thd_percent && client->irq) {
> +		ret = request_threaded_irq(client->irq, NULL,
> +					cm32181_irq_handler,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "%s: request irq failed\n",
> +				__func__);
> +			return ret;
> +		}
> +
> +		ret = cm32181_interrupt(chip, true);
> +		if (ret) {
> +			als_info->thd_percent = 0;
> +			dev_err(&client->dev,
> +				"%s: failed to enable interrupt\n", __func__);
> +		}
> +	} else {
> +		als_info->thd_percent = 0;	/* Polling Mode */
> +	}
> +
>  	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret) {
>  		dev_err(&client->dev,
>  			"%s: regist device failed\n",
>  			__func__);
use goto and a combined exit path now we have this to unwind.
> +		if (als_info->thd_percent)
> +			free_irq(client->irq, indio_dev);
>  		return ret;
>  	}
>  
> @@ -425,9 +567,17 @@ static int cm32181_probe(struct i2c_client *client,
>  
>  static int cm32181_remove(struct i2c_client *client)
>  {
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct cm32181_chip *chip = iio_priv(indio_dev);
> +	struct cm32181_als_info *als_info = chip->als_info;
> +
> +	cm32181_interrupt(chip, false);
>  	i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  		CM32181_CMD_ALS_DISABLE);
>  
> +	if (als_info->thd_percent)
> +		free_irq(client->irq, indio_dev);
> +
>  	return 0;
>  }
>  
> 

