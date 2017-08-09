Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbdHIOLU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 10:11:20 -0400
Date: Wed, 9 Aug 2017 15:11:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>,
        Matt Ranostay <matt.ranostay@intel.com>
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1015: use dynamically generated
 attributes
Message-ID: <20170809151100.592dab5e@archlinux>
In-Reply-To: <20170801082646.yfkcdfrchsdagw4m@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch>
        <20170801082646.yfkcdfrchsdagw4m@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 1 Aug 2017 10:26:46 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> Generate attributes dynamically based on actual values used
> by driver - leads to slightly smaller code (on ARM and X64)
> Scale and sampling frequency definitions are at one place now.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Sorry, for the small gain I am unconvinced.  If this was a new
driver and it had been submitted this way I wouldn't be asking
for it to be changed, but I'm also not interested in the churn and
additional code for what must be a pretty small chance.

Also if you really want to do tinification patches, please post
the actual sizes of the various regions.  In particular you need
to generally have a fairly large saving to justify replacing
stuff that is constant with code.

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 105 ++++++++++++++++++++++++-------------------
>  1 file changed, 60 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 86fd2753869d..2795553d5340 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -73,28 +73,30 @@ enum ads1015_channels {
>  	ADS1015_TIMESTAMP,
>  };
>  
> -static const unsigned int ads1015_data_rate[] = {
> +static const unsigned short ads1015_data_rate[] = {
>  	128, 250, 490, 920, 1600, 2400, 3300, 3300
>  };
>  
> -static const unsigned int ads1115_data_rate[] = {
> +static const unsigned short ads1115_data_rate[] = {
>  	8, 16, 32, 64, 128, 250, 475, 860
>  };
>  
>  static const struct {
> -	int scale;
> -	int uscale;
> +	short scale;
> +	short mscale;
>  } ads1015_scale[] = {
> -	{3, 0},
> -	{2, 0},
> -	{1, 0},
> -	{0, 500000},
> -	{0, 250000},
> -	{0, 125000},
> -	{0, 125000},
> -	{0, 125000},
> +	{ 3, 0 },
> +	{ 2, 0 },
> +	{ 1, 0 },
> +	{ 0, 500 },
> +	{ 0, 250 },
> +	{ 0, 125 },
> +	{ 0, 125 },
> +	{ 0, 125 },
>  };
>  
> +#define ADS1015_SCALES_SIZE	(ARRAY_SIZE(ads1015_scale) - 2)
> +
>  #define ADS1015_V_CHAN(_chan, _addr) {				\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
> @@ -182,7 +184,8 @@ struct ads1015_data {
>  	struct mutex lock;
>  	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
>  
> -	unsigned int *data_rate;
> +	unsigned short *data_rate;
> +	unsigned char data_rate_size;
>  };
>  
>  static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
> @@ -303,9 +306,9 @@ static int ads1015_set_scale(struct ads1015_data *data, int chan,
>  {
>  	int i, ret, rindex = -1;
>  
> -	for (i = 0; i < ARRAY_SIZE(ads1015_scale); i++)
> +	for (i = 0; i < ADS1015_SCALES_SIZE; i++)
>  		if (ads1015_scale[i].scale == scale &&
> -		    ads1015_scale[i].uscale == uscale) {
> +		    ads1015_scale[i].mscale * 1000 == uscale) {
>  			rindex = i;
>  			break;
>  		}
> @@ -327,7 +330,7 @@ static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)
>  {
>  	int i, ret, rindex = -1;
>  
> -	for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++)
> +	for (i = 0; i < data->data_rate_size; i++)
>  		if (data->data_rate[i] == rate) {
>  			rindex = i;
>  			break;
> @@ -386,7 +389,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		idx = data->channel_data[chan->address].pga;
>  		*val = ads1015_scale[idx].scale;
> -		*val2 = ads1015_scale[idx].uscale;
> +		*val2 = ads1015_scale[idx].mscale * 1000;
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -446,16 +449,44 @@ static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
>  	.validate_scan_mask = &iio_validate_scan_mask_onehot,
>  };
>  
> -static IIO_CONST_ATTR(scale_available, "3 2 1 0.5 0.25 0.125");
> +static ssize_t ads1015_show_scales(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	int i;
> +	ssize_t l = 0;
> +
> +	for (i = 0; i < ADS1015_SCALES_SIZE; i++)
> +		l += sprintf(buf + l, "%u.%03u%c",
> +			ads1015_scale[i].scale, ads1015_scale[i].mscale,
> +			i == ADS1015_SCALES_SIZE - 1 ? '\n' : ' ');
> +
> +	return l;
> +}
> +
> +static ssize_t ads1015_show_sample_rates(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	int i;
> +	ssize_t l = 0;
> +	struct ads1015_data *data = iio_priv(dev_to_iio_dev(dev));
> +
> +	for (i = 0; i < data->data_rate_size; i++)
> +		l += sprintf(buf + l, "%u%c", data->data_rate[i],
> +			i == data->data_rate_size - 1 ? '\n' : ' ');
> +
> +	return l;
> +}
> +
> +static IIO_DEVICE_ATTR(scale_available, S_IRUGO,
> +		       ads1015_show_scales, NULL, 0);
> +static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
> +		       ads1015_show_sample_rates, NULL, 0);
>  
> -static IIO_CONST_ATTR_NAMED(ads1015_sampling_frequency_available,
> -	sampling_frequency_available, "128 250 490 920 1600 2400 3300");
> -static IIO_CONST_ATTR_NAMED(ads1115_sampling_frequency_available,
> -	sampling_frequency_available, "8 16 32 64 128 250 475 860");
>  
>  static struct attribute *ads1015_attributes[] = {
> -	&iio_const_attr_scale_available.dev_attr.attr,
> -	&iio_const_attr_ads1015_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_scale_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -463,16 +494,6 @@ static const struct attribute_group ads1015_attribute_group = {
>  	.attrs = ads1015_attributes,
>  };
>  
> -static struct attribute *ads1115_attributes[] = {
> -	&iio_const_attr_scale_available.dev_attr.attr,
> -	&iio_const_attr_ads1115_sampling_frequency_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ads1115_attribute_group = {
> -	.attrs = ads1115_attributes,
> -};
> -
>  static const struct iio_info ads1015_info = {
>  	.driver_module	= THIS_MODULE,
>  	.read_raw	= ads1015_read_raw,
> @@ -480,13 +501,6 @@ static const struct iio_info ads1015_info = {
>  	.attrs          = &ads1015_attribute_group,
>  };
>  
> -static const struct iio_info ads1115_info = {
> -	.driver_module	= THIS_MODULE,
> -	.read_raw	= ads1015_read_raw,
> -	.write_raw	= ads1015_write_raw,
> -	.attrs          = &ads1115_attribute_group,
> -};
> -
>  #ifdef CONFIG_OF
>  static int ads1015_get_channels_config_of(struct i2c_client *client)
>  {
> @@ -594,6 +608,7 @@ static int ads1015_probe(struct i2c_client *client,
>  	indio_dev->dev.of_node = client->dev.of_node;
>  	indio_dev->name = ADS1015_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads1015_info;
>  
>  	if (client->dev.of_node)
>  		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
> @@ -603,14 +618,14 @@ static int ads1015_probe(struct i2c_client *client,
>  	case ADS1015:
>  		indio_dev->channels = ads1015_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ads1015_channels);
> -		indio_dev->info = &ads1015_info;
> -		data->data_rate = (unsigned int *) &ads1015_data_rate;
> +		data->data_rate = (unsigned short *) &ads1015_data_rate;
> +		data->data_rate_size = ARRAY_SIZE(ads1015_data_rate) - 1;
>  		break;
>  	case ADS1115:
>  		indio_dev->channels = ads1115_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ads1115_channels);
> -		indio_dev->info = &ads1115_info;
> -		data->data_rate = (unsigned int *) &ads1115_data_rate;
> +		data->data_rate = (unsigned short *) &ads1115_data_rate;
> +		data->data_rate_size = ARRAY_SIZE(ads1115_data_rate);
>  		break;
>  	}
>  

