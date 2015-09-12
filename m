Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55928 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbbILKII (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2015 06:08:08 -0400
Subject: Re: [PATCH 3/6] iio: mma8452: add freefall / motion interrupt source
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
References: <1441107913-4112-1-git-send-email-martink@posteo.de>
 <1441107913-4112-4-git-send-email-martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55F3F985.7090300@kernel.org>
Date: Sat, 12 Sep 2015 11:08:05 +0100
MIME-Version: 1.0
In-Reply-To: <1441107913-4112-4-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/15 12:45, Martin Kepplinger wrote:
> This adds the freefall / motion interrupt source definitions to the driver.
> It is used in this series' next patch, for chips that don't support the
> transient interrupt source.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Applied.
> ---
>  drivers/iio/accel/mma8452.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7b2ab17..6b1a862 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -42,6 +42,16 @@
>  #define  MMA8452_DATA_CFG_HPF_MASK		BIT(4)
>  #define MMA8452_HP_FILTER_CUTOFF		0x0f
>  #define  MMA8452_HP_FILTER_CUTOFF_SEL_MASK	GENMASK(1, 0)
> +#define MMA8452_FF_MT_CFG			0x15
> +#define  MMA8452_FF_MT_CFG_OAE			BIT(6)
> +#define  MMA8452_FF_MT_CFG_ELE			BIT(7)
> +#define MMA8452_FF_MT_SRC			0x16
> +#define  MMA8452_FF_MT_SRC_XHE			BIT(1)
> +#define  MMA8452_FF_MT_SRC_YHE			BIT(3)
> +#define  MMA8452_FF_MT_SRC_ZHE			BIT(5)
> +#define MMA8452_FF_MT_THS			0x17
> +#define  MMA8452_FF_MT_THS_MASK			0x7f
> +#define MMA8452_FF_MT_COUNT			0x18
>  #define MMA8452_TRANSIENT_CFG			0x1d
>  #define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
>  #define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
> @@ -69,6 +79,7 @@
>  #define MMA8452_MAX_REG				0x31
>  
>  #define  MMA8452_INT_DRDY			BIT(0)
> +#define  MMA8452_INT_FF_MT			BIT(2)
>  #define  MMA8452_INT_TRANS			BIT(5)
>  
>  #define  MMA8452_DEVICE_ID			0x2a
> @@ -613,7 +624,8 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  	else
>  		val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
>  
> -	val |= MMA8452_TRANSIENT_CFG_ELE;
> +	val |= chip->ev_cfg_ele;
> +	val |= MMA8452_FF_MT_CFG_OAE;
>  
>  	return mma8452_change_config(data, chip->ev_cfg, val);
>  }
> @@ -654,6 +666,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  {
>  	struct iio_dev *indio_dev = p;
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	const struct mma_chip_info *chip = data->chip_info;
>  	int ret = IRQ_NONE;
>  	int src;
>  
> @@ -666,7 +679,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  		ret = IRQ_HANDLED;
>  	}
>  
> -	if (src & MMA8452_INT_TRANS) {
> +	if ((src & MMA8452_INT_TRANS &&
> +	     chip->ev_src == MMA8452_TRANSIENT_SRC) ||
> +	    (src & MMA8452_INT_FF_MT &&
> +	     chip->ev_src == MMA8452_FF_MT_SRC)) {
>  		mma8452_transient_interrupt(indio_dev);
>  		ret = IRQ_HANDLED;
>  	}
> @@ -728,6 +744,16 @@ static const struct iio_event_spec mma8452_transient_event[] = {
>  	},
>  };
>  
> +static const struct iio_event_spec mma8452_motion_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +					BIT(IIO_EV_INFO_PERIOD)
> +	},
> +};
> +
>  /*
>   * Threshold is configured in fixed 8G/127 steps regardless of
>   * currently selected scale for measurement.
> @@ -1013,13 +1039,15 @@ static int mma8452_probe(struct i2c_client *client,
>  
>  	if (client->irq) {
>  		/*
> -		 * Although we enable the transient interrupt source once and
> -		 * for all here the transient event detection itself is not
> -		 * enabled until userspace asks for it by
> -		 * mma8452_write_event_config()
> +		 * Although we enable the interrupt sources once and for
> +		 * all here the event detection itself is not enabled until
> +		 * userspace asks for it by mma8452_write_event_config()
>  		 */
> -		int supported_interrupts = MMA8452_INT_DRDY | MMA8452_INT_TRANS;
> -		int enabled_interrupts = MMA8452_INT_TRANS;
> +		int supported_interrupts = MMA8452_INT_DRDY |
> +					   MMA8452_INT_TRANS |
> +					   MMA8452_INT_FF_MT;
> +		int enabled_interrupts = MMA8452_INT_TRANS |
> +					 MMA8452_INT_FF_MT;
>  
>  		/* Assume wired to INT1 pin */
>  		ret = i2c_smbus_write_byte_data(client,
> 

