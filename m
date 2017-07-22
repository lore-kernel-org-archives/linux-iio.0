Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbdGVUWZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jul 2017 16:22:25 -0400
Date: Sat, 22 Jul 2017 21:22:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 06/10] iio: humidity: hts221: support active-low
 interrupts
Message-ID: <20170722212221.02d8a74b@kernel.org>
In-Reply-To: <20170717173905.8209-7-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-7-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 19:39:01 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add support for active low interrupts (IRQF_TRIGGER_LOW and
> IRQF_TRIGGER_FALLING). Configure the device as active high or low
> according to the requested irq line.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied
> ---
>  drivers/iio/humidity/hts221.h        |  1 +
>  drivers/iio/humidity/hts221_buffer.c | 11 +++++++++++
>  drivers/iio/humidity/hts221_core.c   |  3 +--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index 69dfa5c63ec2..c3de6e494f8c 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -61,6 +61,7 @@ struct hts221_hw {
>  extern const struct dev_pm_ops hts221_pm_ops;
>  
>  int hts221_config_drdy(struct hts221_hw *hw, bool enable);
> +int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val);
>  int hts221_probe(struct iio_dev *iio_dev);
>  int hts221_set_enable(struct hts221_hw *hw, bool enable);
>  int hts221_allocate_buffers(struct hts221_hw *hw);
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index c4ed153ad397..ad5222295b2c 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -22,6 +22,8 @@
>  
>  #include "hts221.h"
>  
> +#define HTS221_REG_DRDY_HL_ADDR		0x22
> +#define HTS221_REG_DRDY_HL_MASK		BIT(7)
>  #define HTS221_REG_STATUS_ADDR		0x27
>  #define HTS221_RH_DRDY_MASK		BIT(1)
>  #define HTS221_TEMP_DRDY_MASK		BIT(0)
> @@ -67,6 +69,7 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>  int hts221_allocate_trigger(struct hts221_hw *hw)
>  {
>  	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
> +	bool irq_active_low = false;
>  	unsigned long irq_type;
>  	int err;
>  
> @@ -76,6 +79,10 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  	case IRQF_TRIGGER_HIGH:
>  	case IRQF_TRIGGER_RISING:
>  		break;
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_FALLING:
> +		irq_active_low = true;
> +		break;
>  	default:
>  		dev_info(hw->dev,
>  			 "mode %lx unsupported, using IRQF_TRIGGER_RISING\n",
> @@ -84,6 +91,10 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  		break;
>  	}
>  
> +	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_HL_ADDR,
> +				     HTS221_REG_DRDY_HL_MASK, irq_active_low);
> +	if (err < 0)
> +		return err;
>  	err = devm_request_threaded_irq(hw->dev, hw->irq, NULL,
>  					hts221_trigger_handler_thread,
>  					irq_type | IRQF_ONESHOT,
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index dc55d9fbc702..25fcb9993998 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -135,8 +135,7 @@ static const struct iio_chan_spec hts221_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> -static int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask,
> -				  u8 val)
> +int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val)
>  {
>  	u8 data;
>  	int err;

