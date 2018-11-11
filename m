Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbeKLCxz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:53:55 -0500
Date: Sun, 11 Nov 2018 17:04:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v6 2/2] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181111170446.6f35c64c@archlinux>
In-Reply-To: <20181111155911.3604-3-sst@poczta.fm>
References: <20181111155911.3604-1-sst@poczta.fm>
        <20181111155911.3604-3-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 16:59:11 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Hi Slawomir,

I made the minor mod below to align this with the change I made in patch 1.
It does close a very small window where you might unnecessary power down
if the first command in the chain_setup function resulted in an error
so the reset may never have been issued.  Of course you can't actually
tell where the error occurred in that spi write.  We'll just take
the view it's such a minor risk that we can assume the spi write has
no side effects on failure.

Thanks for persisting with this.  It looks like a good result to me.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 102 ++++++++++++------------------
>  1 file changed, 41 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 3ab06fd87675..327d3c96e83f 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -342,6 +342,14 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
>  	return sum;
>  }
>  
> +static void ad7280_sw_power_down(void *data)
> +{
> +	struct ad7280_state *st = data;
> +
> +	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
> +		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
> +}
> +
>  static int ad7280_chain_setup(struct ad7280_state *st)
>  {
>  	unsigned int val, n;
> @@ -492,8 +500,8 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  {
>  	int dev, ch, cnt;
>  
> -	st->channels = kcalloc((st->slave_num + 1) * 12 + 2,
> -			       sizeof(*st->channels), GFP_KERNEL);
> +	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 2,
> +				    sizeof(*st->channels), GFP_KERNEL);
>  	if (!st->channels)
>  		return -ENOMEM;
>  
> @@ -552,16 +560,18 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  static int ad7280_attr_init(struct ad7280_state *st)
>  {
>  	int dev, ch, cnt;
> +	unsigned int index;
>  
> -	st->iio_attr = kcalloc(2, sizeof(*st->iio_attr) *
> -			       (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
> -			       GFP_KERNEL);
> +	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
> +				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
> +				    GFP_KERNEL);
>  	if (!st->iio_attr)
>  		return -ENOMEM;
>  
>  	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
>  		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
>  			ch++, cnt++) {
> +			index = dev * AD7280A_CELLS_PER_DEV + ch;
>  			st->iio_attr[cnt].address =
>  				ad7280a_devaddr(dev) << 8 | ch;
>  			st->iio_attr[cnt].dev_attr.attr.mode =
> @@ -571,10 +581,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  			st->iio_attr[cnt].dev_attr.store =
>  				ad7280_store_balance_sw;
>  			st->iio_attr[cnt].dev_attr.attr.name =
> -				kasprintf(GFP_KERNEL,
> -					  "in%d-in%d_balance_switch_en",
> -					  dev * AD7280A_CELLS_PER_DEV + ch,
> -					  dev * AD7280A_CELLS_PER_DEV + ch + 1);
> +				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
> +					       "in%d-in%d_balance_switch_en",
> +					       index, index + 1);
>  			ad7280_attributes[cnt] =
>  				&st->iio_attr[cnt].dev_attr.attr;
>  			cnt++;
> @@ -588,10 +597,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  			st->iio_attr[cnt].dev_attr.store =
>  				ad7280_store_balance_timer;
>  			st->iio_attr[cnt].dev_attr.attr.name =
> -				kasprintf(GFP_KERNEL,
> -					  "in%d-in%d_balance_timer",
> -					  dev * AD7280A_CELLS_PER_DEV + ch,
> -					  dev * AD7280A_CELLS_PER_DEV + ch + 1);
> +				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
> +					       "in%d-in%d_balance_timer",
> +					       index, index + 1);
>  			ad7280_attributes[cnt] =
>  				&st->iio_attr[cnt].dev_attr.attr;
>  		}
> @@ -863,6 +871,10 @@ static int ad7280_probe(struct spi_device *spi)
>  	st->spi->mode = SPI_MODE_1;
>  	spi_setup(st->spi);
>  
> +	ret = devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
> +	if (ret)
> +		return ret;
> +
>  	st->ctrl_lb = AD7280A_CTRL_LB_ACQ_TIME(pdata->acquisition_time & 0x3);
>  	st->ctrl_hb = AD7280A_CTRL_HB_CONV_AVG(pdata->conversion_averaging
>  			& 0x3) | (pdata->thermistor_term_en ?
> @@ -870,7 +882,7 @@ static int ad7280_probe(struct spi_device *spi)
>  
>  	ret = ad7280_chain_setup(st);
>  	if (ret < 0)
> -		goto error_power_down;
> +		return ret;
>  
>  	st->slave_num = ret;
>  	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
> @@ -901,7 +913,7 @@ static int ad7280_probe(struct spi_device *spi)
>  
>  	ret = ad7280_channel_init(st);
>  	if (ret < 0)
> -		goto error_power_down;
> +		return ret;
>  
>  	indio_dev->num_channels = ret;
>  	indio_dev->channels = st->channels;
> @@ -909,68 +921,37 @@ static int ad7280_probe(struct spi_device *spi)
>  
>  	ret = ad7280_attr_init(st);
>  	if (ret < 0)
> -		goto error_free_channels;
> +		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
> -		goto error_free_attr;
> +		return ret;
>  
>  	if (spi->irq > 0) {
>  		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
>  				   AD7280A_ALERT, 1,
>  				   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN);
>  		if (ret)
> -			goto error_unregister;
> +			return ret;
>  
>  		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
>  				   AD7280A_ALERT, 0,
>  				   AD7280A_ALERT_GEN_STATIC_HIGH |
>  				   (pdata->chain_last_alert_ignore & 0xF));
>  		if (ret)
> -			goto error_unregister;
> -
> -		ret = request_threaded_irq(spi->irq,
> -					   NULL,
> -					   ad7280_event_handler,
> -					   IRQF_TRIGGER_FALLING |
> -					   IRQF_ONESHOT,
> -					   indio_dev->name,
> -					   indio_dev);
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> +						NULL,
> +						ad7280_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						indio_dev->name,
> +						indio_dev);
>  		if (ret)
> -			goto error_unregister;
> +			return ret;
>  	}
>  
> -	return 0;
> -error_unregister:
> -	iio_device_unregister(indio_dev);
> -
> -error_free_attr:
> -	kfree(st->iio_attr);
> -
> -error_free_channels:
> -	kfree(st->channels);
> -
> -error_power_down:
> -	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
> -		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
> -	return ret;
> -}
> -
> -static int ad7280_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -
> -	if (spi->irq > 0)
> -		free_irq(spi->irq, indio_dev);
> -	iio_device_unregister(indio_dev);
> -
> -	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
> -		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
> -
> -	kfree(st->channels);
> -	kfree(st->iio_attr);
> -
>  	return 0;
>  }
>  
> @@ -985,7 +966,6 @@ static struct spi_driver ad7280_driver = {
>  		.name	= "ad7280",
>  	},
>  	.probe		= ad7280_probe,
> -	.remove		= ad7280_remove,
>  	.id_table	= ad7280_id,
>  };
>  module_spi_driver(ad7280_driver);
