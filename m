Return-Path: <jic23@kernel.org>
Message-ID: <4ED7EB76.3040302@kernel.org>
Date: Thu, 01 Dec 2011 21:02:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH 10/10] staging:iio:adc:ad7298: Use new ringbuffer setup
 helper function
References: <1322749170-21407-1-git-send-email-lars@metafoo.de> <1322749170-21407-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1322749170-21407-11-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/01/2011 02:19 PM, Lars-Peter Clausen wrote:
> Use the new ringbuffer setup helper function to allocate and register buffer and
> pollfunc.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/adc/ad7298.h      |    6 ++-
>  drivers/staging/iio/adc/ad7298_core.c |   11 +----
>  drivers/staging/iio/adc/ad7298_ring.c |   69 +++++---------------------------
>  3 files changed, 18 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
> index a0e5dea..18f2787 100644
> --- a/drivers/staging/iio/adc/ad7298.h
> +++ b/drivers/staging/iio/adc/ad7298.h
> @@ -38,7 +38,6 @@ struct ad7298_platform_data {
>  struct ad7298_state {
>  	struct spi_device		*spi;
>  	struct regulator		*reg;
> -	size_t				d_size;
>  	u16				int_vref_mv;
>  	unsigned			ext_ref;
>  	struct spi_transfer		ring_xfer[10];
> @@ -56,6 +55,8 @@ struct ad7298_state {
>  #ifdef CONFIG_IIO_BUFFER
>  int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev);
>  void ad7298_ring_cleanup(struct iio_dev *indio_dev);
> +int ad7298_update_scan_mode(struct iio_dev *indio_dev,
> +	const unsigned long *active_scan_mask);
>  #else /* CONFIG_IIO_BUFFER */
>  
>  static inline int
> @@ -67,5 +68,8 @@ ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  static inline void ad7298_ring_cleanup(struct iio_dev *indio_dev)
>  {
>  }
> +
> +#define ad7298_update_scan_mode NULL
> +
>  #endif /* CONFIG_IIO_BUFFER */
>  #endif /* IIO_ADC_AD7298_H_ */
> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
> index 6e184ea..b9cb85d 100644
> --- a/drivers/staging/iio/adc/ad7298_core.c
> +++ b/drivers/staging/iio/adc/ad7298_core.c
> @@ -160,6 +160,7 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info ad7298_info = {
>  	.read_raw = &ad7298_read_raw,
> +	.update_scan_mode = ad7298_update_scan_mode,
>  	.driver_module = THIS_MODULE,
>  };
>  
> @@ -220,19 +221,12 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = iio_buffer_register(indio_dev,
> -				  &ad7298_channels[1], /* skip temp0 */
> -				  ARRAY_SIZE(ad7298_channels) - 1);
> -	if (ret)
> -		goto error_cleanup_ring;
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_unregister_ring;
> +		goto error_cleanup_ring;
>  
>  	return 0;
>  
> -error_unregister_ring:
> -	iio_buffer_unregister(indio_dev);
>  error_cleanup_ring:
>  	ad7298_ring_cleanup(indio_dev);
>  error_disable_reg:
> @@ -252,7 +246,6 @@ static int __devexit ad7298_remove(struct spi_device *spi)
>  	struct ad7298_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	iio_buffer_unregister(indio_dev);
>  	ad7298_ring_cleanup(indio_dev);
>  	if (!IS_ERR(st->reg)) {
>  		regulator_disable(st->reg);
> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
> index feeb0ee..baa8b39 100644
> --- a/drivers/staging/iio/adc/ad7298_ring.c
> +++ b/drivers/staging/iio/adc/ad7298_ring.c
> @@ -19,39 +19,21 @@
>  #include "ad7298.h"
>  
>  /**
> - * ad7298_ring_preenable() setup the parameters of the ring before enabling
> - *
> - * The complex nature of the setting of the number of bytes per datum is due
> - * to this driver currently ensuring that the timestamp is stored at an 8
> - * byte boundary.
> + * ad7298_update_scan_mode() setup the spi transfer buffer for the new scan mask
>   **/
> -static int ad7298_ring_preenable(struct iio_dev *indio_dev)
> +int ad7298_update_scan_mode(struct iio_dev *indio_dev,
> +	const unsigned long *active_scan_mask)
>  {
>  	struct ad7298_state *st = iio_priv(indio_dev);
> -	struct iio_buffer *ring = indio_dev->buffer;
> -	size_t d_size;
>  	int i, m;
>  	unsigned short command;
> -	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +	int scan_count = bitmap_weight(active_scan_mask,
>  				       indio_dev->masklength);
> -	d_size = scan_count * (AD7298_STORAGE_BITS / 8);
> -
> -	if (ring->scan_timestamp) {
> -		d_size += sizeof(s64);
> -
> -		if (d_size % sizeof(s64))
> -			d_size += sizeof(s64) - (d_size % sizeof(s64));
> -	}
> -
> -	if (ring->access->set_bytes_per_datum)
> -		ring->access->set_bytes_per_datum(ring, d_size);
> -
> -	st->d_size = d_size;
>  
>  	command = AD7298_WRITE | st->ext_ref;
>  
>  	for (i = 0, m = AD7298_CH(0); i < AD7298_MAX_CHAN; i++, m >>= 1)
> -		if (test_bit(i, indio_dev->active_scan_mask))
> +		if (test_bit(i, active_scan_mask))
>  			command |= m;
>  
>  	st->tx_buf[0] = cpu_to_be16(command);
> @@ -92,6 +74,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad7298_state *st = iio_priv(indio_dev);
>  	struct iio_buffer *ring = indio_dev->buffer;
> +	unsigned int bpd = buffer_get_bytes_per_datum(ring);
>  	s64 time_ns;
>  	__u16 buf[16];
>  	int b_sent, i;
> @@ -102,7 +85,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  
>  	if (ring->scan_timestamp) {
>  		time_ns = iio_get_time_ns();
> -		memcpy((u8 *)buf + st->d_size - sizeof(s64),
> +		memcpy((u8 *)buf + bpd - sizeof(s64),
>  			&time_ns, sizeof(time_ns));
>  	}
>  
> @@ -116,49 +99,19 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> -static const struct iio_buffer_setup_ops ad7298_ring_setup_ops = {
> -	.preenable = &ad7298_ring_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
> -};
> -
>  int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  {
>  	int ret;
>  
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> -	if (!indio_dev->buffer) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
> -						 &ad7298_trigger_handler,
> -						 IRQF_ONESHOT,
> -						 indio_dev,
> -						 "ad7298_consumer%d",
> -						 indio_dev->id);
> -
> -	if (indio_dev->pollfunc == NULL) {
> -		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> -	}
> +	ret = iio_sw_rb_simple_setup(indio_dev, NULL, &ad7298_trigger_handler);
> +	if (ret)
> +		return ret;
>  
> -	/* Ring buffer functions - here trigger setup related */
> -	indio_dev->setup_ops = &ad7298_ring_setup_ops;
>  	indio_dev->buffer->scan_timestamp = true;
> -
> -	/* Flag that polled ring buffering is possible */
> -	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>  	return 0;
> -
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> -error_ret:
> -	return ret;
>  }
>  
>  void ad7298_ring_cleanup(struct iio_dev *indio_dev)
>  {
> -	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_sw_rb_simple_cleanup(indio_dev);
>  }
