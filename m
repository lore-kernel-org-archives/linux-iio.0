Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40748 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbcK0KCA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 05:02:00 -0500
Subject: Re: [PATCH] Staging: iio: adc: fix macro and sysfs files modes in
 ad7280a.c
To: Boyan Vladinov <nayobix@nayobix.org>, gregkh@linuxfoundation.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de
References: <1480235877-26883-1-git-send-email-nayobix@nayobix.org>
From: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <600ecfb4-1172-cb8f-f276-5793c7e3e085@kernel.org>
Date: Sun, 27 Nov 2016 09:53:34 +0000
MIME-Version: 1.0
In-Reply-To: <1480235877-26883-1-git-send-email-nayobix@nayobix.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/11/16 08:37, Boyan Vladinov wrote:
> Fixes warnings found by checkpatch.pl:
> - AD7280A_DEVADDR macro to use typeof, because of possible side effects
Such as?  I can't tell from this description whether this is a bug, or just
some good coding practice stuff.
> - sysfs entries user/group modes to use their octal representation
> - coding style (open parenthesis alignment, CamelCase...)
> 
> Signed-off-by: Boyan Vladinov <nayobix@nayobix.org>
There are several unrelated changes here.  One patch for each unrelated
change please.

Various comments inline.

The content is mostly fine. You just need to work on how it is presented
for review.

Looking forward to the updated series!

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7280a.c | 141 +++++++++++++++++++++++++-------------
>  drivers/staging/iio/adc/ad7280a.h |   6 ++
>  2 files changed, 101 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index ee679ac0368f..5f687c6aaaeb 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -99,9 +99,11 @@
>  #define AD7280A_DEVADDR_MASTER		0
>  #define AD7280A_DEVADDR_ALL		0x1F
>  /* 5-bit device address is sent LSB first */
> -#define AD7280A_DEVADDR(addr)	(((addr & 0x1) << 4) | ((addr & 0x2) << 3) | \
> -				(addr & 0x4) | ((addr & 0x8) >> 3) | \
> -				((addr & 0x10) >> 4))
> +#define AD7280A_DEVADDR(addr)				\
> +	({ typeof(addr) _addr = (addr);			\
> +	((_addr & 0x1) << 4) | ((_addr & 0x2) << 3) |	\
> +	(_addr & 0x4) | ((_addr & 0x8) >> 3) |		\
> +	((_addr & 0x10) >> 4); })
I'd like an explanation of why this is necessary.  Are we looking at an
actual bug, or is this about prevenint plausible issues if this macro is
used with a different data type for address in the future?

Also if this is an actual bug please make it the first patch in the broken
out series of patches.  That way we have the option to route it to mainline
faster and it can be applied to stable kernels more easily.
>  
>  /* During a read a valid write is mandatory.
>   * So writing to the highest available address (Address 0x1F)
> @@ -159,8 +161,8 @@ static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
>  {
>  	unsigned char crc;
>  
> -	crc = crc_tab[val >> 16 & 0xFF];
> -	crc = crc_tab[crc ^ (val >> 8 & 0xFF)];
> +	crc = crc_tab[val >> 16 & 0xff];
Why?  This is not hurting readability.  It's also not camel case if that is
what you meant by camel case in the introduction.

If it is about consistency within the driver then fine, but please state this.
As it's within this large multi part patch it's not obvious how it relates
to the description.
> +	crc = crc_tab[crc ^ (val >> 8 & 0xff)];
>  
>  	return  crc ^ (val & 0xFF);
>  }
> @@ -559,7 +561,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  			st->iio_attr[cnt].address =
>  				AD7280A_DEVADDR(dev) << 8 | ch;
>  			st->iio_attr[cnt].dev_attr.attr.mode =
> -				S_IWUSR | S_IRUGO;
> +				0644;
hmm.  I must admit I'm really disliking the noise that came from a fairly
throwaway comment from Linus intended to stop people patching it the other
way.

I'll probably take these patches but most as a way to stop recieving the same
one every few days/weeks as checkpatch is now highlighting it.

>  			st->iio_attr[cnt].dev_attr.show =
>  				ad7280_show_balance_sw;
>  			st->iio_attr[cnt].dev_attr.store =
> @@ -576,7 +578,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  				AD7280A_DEVADDR(dev) << 8 |
>  				(AD7280A_CB1_TIMER + ch);
>  			st->iio_attr[cnt].dev_attr.attr.mode =
> -				S_IWUSR | S_IRUGO;
> +				0644;
>  			st->iio_attr[cnt].dev_attr.show =
>  				ad7280_show_balance_timer;
>  			st->iio_attr[cnt].dev_attr.store =
> @@ -679,6 +681,51 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
>  	return ret ? ret : len;
>  }
>
This bit of refactoring is reasonable to reduced excessive indentation, but
it should be in a patch on it's own with a description of why you are making
the change.

Actually scratch that, it's not actually making the code any clear at all
looking inline.
> +static void ad7280a_push_event(struct iio_dev *indio_dev,
> +			       enum event_code_type event_code_t,
> +			       enum iio_chan_type iio_chan_t,
> +			       int diff,
> +			       int modifier,
> +			       enum iio_event_direction iio_event_dir,
> +			       enum iio_event_type iio_event_t,
> +			       int chan,
> +			       int chan1,
> +			       int chan2,
> +			       int number)
> +{
> +	switch (event_code_t) {
> +	case AD7280A_IIO_EVENT_CODE:
> +		iio_push_event(indio_dev,
> +			       IIO_EVENT_CODE(iio_chan_t,
> +					      diff,
No need to wrap this quite so extensively.  You can have a few parameters
on each line now there is space.
> +					      modifier,
> +					      iio_event_dir,
> +					      iio_event_t,
> +					      chan,
> +					      chan1,
> +					      chan2),
> +			       iio_get_time_ns(indio_dev));
> +		break;
> +	case AD7280A_IIO_MOD_EVENT_CODE:
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(iio_chan_t,
> +						  number,
> +						  modifier,
> +						  iio_event_t,
> +						  iio_event_dir),
> +			       iio_get_time_ns(indio_dev));
> +		break;
> +	case AD7280A_IIO_UNMOD_EVENT_CODE:
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(iio_chan_t,
> +						    number,
> +						    iio_event_t,
> +						    iio_event_dir),
> +			       iio_get_time_ns(indio_dev));
> +		break;
> +	}
> +}
> +
>  static irqreturn_t ad7280_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -698,42 +745,44 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
>  			if (((channels[i] >> 11) & 0xFFF) >=
>  				st->cell_threshhigh)
> -				iio_push_event(indio_dev,
> -					       IIO_EVENT_CODE(IIO_VOLTAGE,
> -							1,
> -							0,
> -							IIO_EV_DIR_RISING,
> -							IIO_EV_TYPE_THRESH,
> -							0, 0, 0),
> -					       iio_get_time_ns(indio_dev));
> +				ad7280a_push_event(indio_dev,
> +						   AD7280A_IIO_EVENT_CODE,
> +						   IIO_VOLTAGE,
> +						   1,
> +						   0,
> +						   IIO_EV_DIR_RISING,
> +						   IIO_EV_TYPE_THRESH,
> +						   0, 0, 0, 0);
Where is the benefit in this?  Replace some code with more code.

I guess the plan was to avoid the indentation being 'wrong'.  Classic case
of where checkpatch warnings should be taken as a 'hint'not the rule.

If you want to avoid it, just use a local variable for the timestamp.
>  			else if (((channels[i] >> 11) & 0xFFF) <=
>  				st->cell_threshlow)
> -				iio_push_event(indio_dev,
> -					       IIO_EVENT_CODE(IIO_VOLTAGE,
> -							1,
> -							0,
> -							IIO_EV_DIR_FALLING,
> -							IIO_EV_TYPE_THRESH,
> -							0, 0, 0),
> -					       iio_get_time_ns(indio_dev));
> +				ad7280a_push_event(indio_dev,
> +						   AD7280A_IIO_EVENT_CODE,
> +						   IIO_VOLTAGE,
> +						   1,
> +						   0,
> +						   IIO_EV_DIR_FALLING,
> +						   IIO_EV_TYPE_THRESH,
> +						   0, 0, 0, 0);
>  		} else {
>  			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
> -				iio_push_event(indio_dev,
> -					       IIO_UNMOD_EVENT_CODE(
> -							IIO_TEMP,
> -							0,
> -							IIO_EV_TYPE_THRESH,
> -							IIO_EV_DIR_RISING),
> -					       iio_get_time_ns(indio_dev));
> +				ad7280a_push_event(indio_dev,
> +						   AD7280A_IIO_UNMOD_EVENT_CODE,
> +						   IIO_TEMP,
> +						   0,
> +						   0,
> +						   IIO_EV_DIR_RISING,
> +						   IIO_EV_TYPE_THRESH,
> +						   0, 0, 0, 0);
>  			else if (((channels[i] >> 11) & 0xFFF) <=
>  				st->aux_threshlow)
> -				iio_push_event(indio_dev,
> -					       IIO_UNMOD_EVENT_CODE(
> -							IIO_TEMP,
> -							0,
> -							IIO_EV_TYPE_THRESH,
> -							IIO_EV_DIR_FALLING),
> -					       iio_get_time_ns(indio_dev));
> +				ad7280a_push_event(indio_dev,
> +						   AD7280A_IIO_UNMOD_EVENT_CODE,
> +						   IIO_TEMP,
> +						   0,
> +						   0,
> +						   IIO_EV_DIR_FALLING,
> +						   IIO_EV_TYPE_THRESH,
> +						   0, 0, 0, 0);
>  		}
>  	}
>  
> @@ -745,26 +794,26 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
>  		in_voltage-voltage_thresh_low_value,
> -		S_IRUGO | S_IWUSR,
> +		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
>  		in_voltage-voltage_thresh_high_value,
> -		S_IRUGO | S_IWUSR,
> +		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_CELL_OVERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
> -		S_IRUGO | S_IWUSR,
> +		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_AUX_ADC_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
> -		S_IRUGO | S_IWUSR,
> +		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_AUX_ADC_OVERVOLTAGE);
> @@ -836,8 +885,8 @@ static int ad7280_probe(struct spi_device *spi)
>  	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad7280_state *st;
>  	int ret;
> -	const unsigned short tACQ_ns[4] = {465, 1010, 1460, 1890};
> -	const unsigned short nAVG[4] = {1, 2, 4, 8};
Again, not actually camel case.  These will be to align with naming on the
datasheet.  Not that important so worth tidying up perhaps.
> +	const unsigned short t_acq_ns[4] = {465, 1010, 1460, 1890};
> +	const unsigned short n_avg[4] = {1, 2, 4, 8};
>  	struct iio_dev *indio_dev;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -880,9 +929,9 @@ static int ad7280_probe(struct spi_device *spi)
>  	 */
>  
>  	st->readback_delay_us =
> -		((tACQ_ns[pdata->acquisition_time & 0x3] + 695) *
> -		(AD7280A_NUM_CH * nAVG[pdata->conversion_averaging & 0x3]))
> -		- tACQ_ns[pdata->acquisition_time & 0x3] +
> +		((t_acq_ns[pdata->acquisition_time & 0x3] + 695) *
> +		(AD7280A_NUM_CH * n_avg[pdata->conversion_averaging & 0x3]))
> +		- t_acq_ns[pdata->acquisition_time & 0x3] +
>  		st->slave_num * 250;
>  
>  	/* Convert to usecs */
> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> index ccfb90d20e71..157c33e0e128 100644
> --- a/drivers/staging/iio/adc/ad7280a.h
> +++ b/drivers/staging/iio/adc/ad7280a.h
> @@ -35,4 +35,10 @@ struct ad7280_platform_data {
>  	bool			thermistor_term_en;
>  };
>  
> +enum event_code_type {
> +	AD7280A_IIO_EVENT_CODE,
> +	AD7280A_IIO_MOD_EVENT_CODE,
> +	AD7280A_IIO_UNMOD_EVENT_CODE,
> +};
> +
>  #endif /* IIO_ADC_AD7280_H_ */
> 

