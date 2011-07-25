Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E2D898A.1040907@cam.ac.uk>
Date: Mon, 25 Jul 2011 16:19:38 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:iio: ABI rework - add in_ or out_ prefix
 to channnels
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <1311600234-16128-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311600234-16128-2-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/25/11 14:23, Jonathan Cameron wrote:
> Also involves changing current inX outX to in_voltageX and out_voltageX

oops. Didn't handle the read / write selection of attributes.  Fix is obvious
so I'll roll it into next version. (just check chan->output instead of matching
on IIO_OUT).
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/ad5686.c        |   24 ++++++++++++------------
>  drivers/staging/iio/iio.h               |   31 +++++++++++++++++++++++++++----
>  drivers/staging/iio/industrialio-core.c |   28 +++++++++++++++++-----------
>  3 files changed, 56 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
> index fd67cfa..b7f62d1 100644
> --- a/drivers/staging/iio/dac/ad5686.c
> +++ b/drivers/staging/iio/dac/ad5686.c
> @@ -99,57 +99,57 @@ enum ad5686_supported_device_ids {
>  
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  	[ID_AD5684] = {
> -		.channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
> +		.channel[0] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 0, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC0,
>  				    0, IIO_ST('u', 12, 16, 4), 0),
> -		.channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
> +		.channel[1] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 1, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC1,
>  				    1, IIO_ST('u', 12, 16, 4), 0),
> -		.channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
> +		.channel[2] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 2, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC2,
>  				    2, IIO_ST('u', 12, 16, 4), 0),
> -		.channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
> +		.channel[3] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 3, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC3,
>  				    3, IIO_ST('u', 12, 16, 4), 0),
>  		.int_vref_mv = 2500,
>  	},
>  	[ID_AD5685] = {
> -		.channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
> +		.channel[0] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 0, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC0,
>  				    0, IIO_ST('u', 14, 16, 2), 0),
> -		.channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
> +		.channel[1] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 1, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC1,
>  				    1, IIO_ST('u', 14, 16, 2), 0),
> -		.channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
> +		.channel[2] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 2, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC2,
>  				    2, IIO_ST('u', 14, 16, 2), 0),
> -		.channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
> +		.channel[3] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 3, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC3,
>  				    3, IIO_ST('u', 14, 16, 2), 0),
>  		.int_vref_mv = 2500,
>  	},
>  	[ID_AD5686] = {
> -		.channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
> +		.channel[0] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 0, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC0,
>  				    0, IIO_ST('u', 16, 16, 0), 0),
> -		.channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
> +		.channel[1] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 1, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC1,
>  				    1, IIO_ST('u', 16, 16, 0), 0),
> -		.channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
> +		.channel[2] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 2, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC2,
>  				    2, IIO_ST('u', 16, 16, 0), 0),
> -		.channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
> +		.channel[3] = IIO_CHAN_OUT(IIO_OUT, 0, 1, 0, NULL, 3, 0,
>  				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  				    AD5686_ADDR_DAC3,
>  				    3, IIO_ST('u', 16, 16, 0), 0),
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 74d427a..4311a36 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -24,12 +24,11 @@
>  
>  enum iio_chan_type {
>  	/* real channel types */
> -	IIO_IN,
> -	IIO_OUT,
> +	IIO_VOLTAGE,
>  	IIO_CURRENT,
>  	IIO_POWER,
>  	IIO_ACCEL,
> -	IIO_IN_DIFF,
> +	IIO_VOLTAGE_DIFF,
>  	IIO_GYRO,
>  	IIO_MAGN,
>  	IIO_LIGHT,
> @@ -42,6 +41,11 @@ enum iio_chan_type {
>  	IIO_TIMESTAMP,
>  };
>  
> +/* Nasty hack to avoid massive churn */
> +#define	IIO_IN IIO_VOLTAGE
> +#define	IIO_OUT IIO_VOLTAGE
> +#define	IIO_IN_DIFF IIO_VOLTAGE_DIFF
> +
>  #define IIO_MOD_X			0
>  #define IIO_MOD_LIGHT_BOTH		0
>  #define IIO_MOD_Y			1
> @@ -124,14 +128,33 @@ struct iio_chan_spec {
>  	unsigned		processed_val:1;
>  	unsigned		modified:1;
>  	unsigned		indexed:1;
> +	unsigned		output:1;
>  };
>  
>  #define IIO_ST(si, rb, sb, sh)						\
>  	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
>  
> -#define IIO_CHAN(_type, _mod, _indexed, _proc, _name, _chan, _chan2,	\
> +/* Macro assumes input channels */
> +#define IIO_CHAN(_type, _mod, _indexed, _proc, _name, _chan, _chan2, \
> +		 _inf_mask, _address, _si, _stype, _event_mask)		\
> +	{ .type = _type,						\
> +	  .output = 0,							\
> +	  .modified = _mod,						\
> +	  .indexed = _indexed,						\
> +	  .processed_val = _proc,					\
> +	  .extend_name = _name,						\
> +	  .channel = _chan,						\
> +	  .channel2 = _chan2,						\
> +	  .info_mask = _inf_mask,					\
> +	  .address = _address,						\
> +	  .scan_index = _si,						\
> +	  .scan_type = _stype,						\
> +	  .event_mask = _event_mask }
> +/* Output channels */
> +#define IIO_CHAN_OUT(_type, _mod, _indexed, _proc, _name, _chan, _chan2, \
>  		 _inf_mask, _address, _si, _stype, _event_mask)		\
>  	{ .type = _type,						\
> +	  .output = 1,							\
>  	  .modified = _mod,						\
>  	  .indexed = _indexed,						\
>  	  .processed_val = _proc,					\
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index 195808c..06ffc48 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -42,13 +42,17 @@ struct bus_type iio_bus_type = {
>  };
>  EXPORT_SYMBOL(iio_bus_type);
>  
> +static const char * const iio_direction[] = {
> +	[0] = "in",
> +	[1] = "out",
> +};
> +
>  static const char * const iio_chan_type_name_spec_shared[] = {
> -	[IIO_IN] = "in",
> -	[IIO_OUT] = "out",
> +	[IIO_VOLTAGE] = "voltage",
>  	[IIO_CURRENT] = "current",
>  	[IIO_POWER] = "power",
>  	[IIO_ACCEL] = "accel",
> -	[IIO_IN_DIFF] = "in-in",
> +	[IIO_VOLTAGE_DIFF] = "voltage-voltage",
>  	[IIO_GYRO] = "gyro",
>  	[IIO_MAGN] = "magn",
>  	[IIO_LIGHT] = "illuminance",
> @@ -62,7 +66,7 @@ static const char * const iio_chan_type_name_spec_shared[] = {
>  };
>  
>  static const char * const iio_chan_type_name_spec_complex[] = {
> -	[IIO_IN_DIFF] = "in%d-in%d",
> +	[IIO_VOLTAGE_DIFF] = "voltage%d-voltage%d",
>  };
>  
>  static const char * const iio_modifier_names_light[] = {
> @@ -518,19 +522,22 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>  		goto error_ret;
>  
>  	/* Special case for types that uses both channel numbers in naming */
> -	if (chan->type == IIO_IN_DIFF && !generic)
> +	if (chan->type == IIO_VOLTAGE_DIFF && !generic)
>  		name_format
> -			= kasprintf(GFP_KERNEL, "%s_%s",
> +			= kasprintf(GFP_KERNEL, "%s_%s_%s",
> +				    iio_direction[chan->output],
>  				    iio_chan_type_name_spec_complex[chan->type],
>  				    full_postfix);
>  	else if (generic || !chan->indexed)
>  		name_format
> -			= kasprintf(GFP_KERNEL, "%s_%s",
> +			= kasprintf(GFP_KERNEL, "%s_%s_%s",
> +				    iio_direction[chan->output],
>  				    iio_chan_type_name_spec_shared[chan->type],
>  				    full_postfix);
>  	else
>  		name_format
> -			= kasprintf(GFP_KERNEL, "%s%d_%s",
> +			= kasprintf(GFP_KERNEL, "%s_%s%d_%s",
> +				    iio_direction[chan->output],
>  				    iio_chan_type_name_spec_shared[chan->type],
>  				    chan->channel,
>  				    full_postfix);
> @@ -637,7 +644,6 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
>  {
>  	int ret, i;
>  
> -
>  	if (chan->channel < 0)
>  		return 0;
>  	if (chan->processed_val)
> @@ -870,7 +876,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
>  		}
>  		switch (chan->type) {
>  			/* Switch this to a table at some point */
> -		case IIO_IN:
> +		case IIO_VOLTAGE:
>  			mask = IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
>  						    i/IIO_EV_TYPE_MAX,
>  						    i%IIO_EV_TYPE_MAX);
> @@ -880,7 +886,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
>  						  i/IIO_EV_TYPE_MAX,
>  						  i%IIO_EV_TYPE_MAX);
>  			break;
> -		case IIO_IN_DIFF:
> +		case IIO_VOLTAGE_DIFF:
>  			mask = IIO_MOD_EVENT_CODE(chan->type, chan->channel,
>  						  chan->channel2,
>  						  i/IIO_EV_TYPE_MAX,
