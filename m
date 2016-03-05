Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55869 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbcCEOp3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 09:45:29 -0500
Subject: Re: [PATCH v4 3/3] iio:pressure:ms5611: oversampling rate support
To: Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1456828051.git.gregor.boirie@parrot.com>
 <968dd61e1b2cf2fa6ba936509594d71c799226c4.1456828051.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAF105.3010503@kernel.org>
Date: Sat, 5 Mar 2016 14:45:25 +0000
MIME-Version: 1.0
In-Reply-To: <968dd61e1b2cf2fa6ba936509594d71c799226c4.1456828051.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/16 10:31, Gregor Boirie wrote:
> Add support for setting and retrieving OverSampling Rate independently for
> each of the temperature and pressure channels. This allows userspace to
> fine tune hardware sampling process according to the following tradeoffs :
> * the higher the OSR, the finer the resolution ;
> * the higher the OSR, the lower the noise ;
> BUT:
> * the higher the OSR, the larger the drift ;
> * the higher the OSR, the longer the response time, i.e. less samples per
>   unit of time.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/ms5611.h      |  20 ++++---
>  drivers/iio/pressure/ms5611_core.c | 105 ++++++++++++++++++++++++++++++++++++-
>  drivers/iio/pressure/ms5611_i2c.c  |  12 ++---
>  drivers/iio/pressure/ms5611_spi.c  |  19 +++----
>  4 files changed, 133 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index 8b08e4b..d725a307 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -19,12 +19,6 @@
>  #define MS5611_RESET			0x1e
>  #define MS5611_READ_ADC			0x00
>  #define MS5611_READ_PROM_WORD		0xA0
> -#define MS5611_START_TEMP_CONV		0x58
> -#define MS5611_START_PRESSURE_CONV	0x48
> -
> -#define MS5611_CONV_TIME_MIN		9040
> -#define MS5611_CONV_TIME_MAX		10000
> -
>  #define MS5611_PROM_WORDS_NB		8
>  
>  enum {
> @@ -39,10 +33,24 @@ struct ms5611_chip_info {
>  					    s32 *temp, s32 *pressure);
>  };
>  
> +/*
> + * OverSampling Rate descriptor.
> + * Warning: cmd MUST be kept aligned on a word boundary (see
> + * m5611_spi_read_adc_temp_and_pressure in ms5611_spi.c).
> + */
> +struct ms5611_osr {
> +	unsigned long conv_usec;
> +	u8 cmd;
> +	unsigned short rate;
> +};
> +
>  struct ms5611_state {
>  	void *client;
>  	struct mutex lock;
>  
> +	const struct ms5611_osr *pressure_osr;
> +	const struct ms5611_osr *temp_osr;
> +
>  	int (*reset)(struct device *dev);
>  	int (*read_prom_word)(struct device *dev, int index, u16 *word);
>  	int (*read_adc_temp_and_pressure)(struct device *dev,
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index a9c4d49..a2a871b 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -18,11 +18,44 @@
>  #include <linux/delay.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include "ms5611.h"
>  
> +#define MS5611_INIT_OSR(_cmd, _conv_usec, _rate) \
> +	{ .cmd = _cmd, .conv_usec = _conv_usec, .rate = _rate }
> +
> +static const struct ms5611_osr ms5611_avail_pressure_osr[] = {
> +	MS5611_INIT_OSR(0x40, 600,  256),
> +	MS5611_INIT_OSR(0x42, 1170, 512),
> +	MS5611_INIT_OSR(0x44, 2280, 1024),
> +	MS5611_INIT_OSR(0x46, 4540, 2048),
> +	MS5611_INIT_OSR(0x48, 9040, 4096)
> +};
> +
> +static const struct ms5611_osr ms5611_avail_temp_osr[] = {
> +	MS5611_INIT_OSR(0x50, 600,  256),
> +	MS5611_INIT_OSR(0x52, 1170, 512),
> +	MS5611_INIT_OSR(0x54, 2280, 1024),
> +	MS5611_INIT_OSR(0x56, 4540, 2048),
> +	MS5611_INIT_OSR(0x58, 9040, 4096)
> +};
> +
> +static const char ms5611_show_osr[] = "256 512 1024 2048 4096";
> +
> +static IIO_CONST_ATTR(oversampling_ratio_available, ms5611_show_osr);
> +
> +static struct attribute *ms5611_attributes[] = {
> +	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ms5611_attribute_group = {
> +	.attrs = ms5611_attributes,
> +};
> +
>  static bool ms5611_prom_is_valid(u16 *prom, size_t len)
>  {
>  	int i, j;
> @@ -239,11 +272,70 @@ static int ms5611_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (chan->type != IIO_TEMP && chan->type != IIO_PRESSURE)
> +			break;
> +		mutex_lock(&st->lock);
> +		if (chan->type == IIO_TEMP)
> +			*val = (int)st->temp_osr->rate;
> +		else
> +			*val = (int)st->pressure_osr->rate;
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
>  }
>  
> +static const struct ms5611_osr *ms5611_find_osr(int rate,
> +						const struct ms5611_osr *osr,
> +						size_t count)
> +{
> +	unsigned int r;
> +
> +	for (r = 0; r < count; r++)
> +		if ((unsigned short)rate == osr[r].rate)
> +			break;
> +	if (r >= count)
> +		return NULL;
> +	return &osr[r];
> +}
> +
> +static int ms5611_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ms5611_state *st = iio_priv(indio_dev);
> +	const struct ms5611_osr *osr = NULL;
> +
> +	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
> +		return -EINVAL;
> +
> +	if (chan->type == IIO_TEMP)
> +		osr = ms5611_find_osr(val, ms5611_avail_temp_osr,
> +				      ARRAY_SIZE(ms5611_avail_temp_osr));
> +	else if (chan->type == IIO_PRESSURE)
> +		osr = ms5611_find_osr(val, ms5611_avail_pressure_osr,
> +				      ARRAY_SIZE(ms5611_avail_pressure_osr));
> +	if (!osr)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +
> +	if (iio_buffer_enabled(indio_dev)) {
> +		mutex_unlock(&st->lock);
> +		return -EBUSY;
> +	}
> +
> +	if (chan->type == IIO_TEMP)
> +		st->temp_osr = osr;
> +	else
> +		st->pressure_osr = osr;
> +
> +	mutex_unlock(&st->lock);
> +	return 0;
> +}
> +
>  static const unsigned long ms5611_scan_masks[] = {0x3, 0};
>  
>  static struct ms5611_chip_info chip_info_tbl[] = {
> @@ -259,7 +351,8 @@ static const struct iio_chan_spec ms5611_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 's',
> @@ -271,7 +364,8 @@ static const struct iio_chan_spec ms5611_channels[] = {
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 's',
> @@ -285,6 +379,8 @@ static const struct iio_chan_spec ms5611_channels[] = {
>  
>  static const struct iio_info ms5611_info = {
>  	.read_raw = &ms5611_read_raw,
> +	.write_raw = &ms5611_write_raw,
> +	.attrs = &ms5611_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
>  
> @@ -323,6 +419,11 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
>  
>  	mutex_init(&st->lock);
>  	st->chip_info = &chip_info_tbl[type];
> +	st->temp_osr =
> +		&ms5611_avail_temp_osr[ARRAY_SIZE(ms5611_avail_temp_osr) - 1];
> +	st->pressure_osr =
> +		&ms5611_avail_pressure_osr[ARRAY_SIZE(ms5611_avail_pressure_osr)
> +					   - 1];
>  	indio_dev->dev.parent = dev;
>  	indio_dev->name = name;
>  	indio_dev->info = &ms5611_info;
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 57a8f2c..55fb5fc 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -63,23 +63,23 @@ static int ms5611_i2c_read_adc_temp_and_pressure(struct device *dev,
>  {
>  	int ret;
>  	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +	const struct ms5611_osr *osr = st->temp_osr;
>  
> -	ret = i2c_smbus_write_byte(st->client, MS5611_START_TEMP_CONV);
> +	ret = i2c_smbus_write_byte(st->client, osr->cmd);
>  	if (ret < 0)
>  		return ret;
>  
> -	usleep_range(MS5611_CONV_TIME_MIN, MS5611_CONV_TIME_MAX);
> -
> +	usleep_range(osr->conv_usec, osr->conv_usec + (osr->conv_usec / 10UL));
>  	ret = ms5611_i2c_read_adc(st, temp);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = i2c_smbus_write_byte(st->client, MS5611_START_PRESSURE_CONV);
> +	osr = st->pressure_osr;
> +	ret = i2c_smbus_write_byte(st->client, osr->cmd);
>  	if (ret < 0)
>  		return ret;
>  
> -	usleep_range(MS5611_CONV_TIME_MIN, MS5611_CONV_TIME_MAX);
> -
> +	usleep_range(osr->conv_usec, osr->conv_usec + (osr->conv_usec / 10UL));
>  	return ms5611_i2c_read_adc(st, pressure);
>  }
>  
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index 7ec0c64..7600483 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -56,28 +56,29 @@ static int ms5611_spi_read_adc(struct device *dev, s32 *val)
>  static int ms5611_spi_read_adc_temp_and_pressure(struct device *dev,
>  						 s32 *temp, s32 *pressure)
>  {
> -	u8 cmd;
>  	int ret;
>  	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +	const struct ms5611_osr *osr = st->temp_osr;
>  
> -	cmd = MS5611_START_TEMP_CONV;
> -	ret = spi_write_then_read(st->client, &cmd, 1, NULL, 0);
> +	/*
> +	 * Warning: &osr->cmd MUST be aligned on a word boundary since used as
> +	 * 2nd argument (void*) of spi_write_then_read.
> +	 */
> +	ret = spi_write_then_read(st->client, &osr->cmd, 1, NULL, 0);
>  	if (ret < 0)
>  		return ret;
>  
> -	usleep_range(MS5611_CONV_TIME_MIN, MS5611_CONV_TIME_MAX);
> -
> +	usleep_range(osr->conv_usec, osr->conv_usec + (osr->conv_usec / 10UL));
>  	ret = ms5611_spi_read_adc(dev, temp);
>  	if (ret < 0)
>  		return ret;
>  
> -	cmd = MS5611_START_PRESSURE_CONV;
> -	ret = spi_write_then_read(st->client, &cmd, 1, NULL, 0);
> +	osr = st->pressure_osr;
> +	ret = spi_write_then_read(st->client, &osr->cmd, 1, NULL, 0);
>  	if (ret < 0)
>  		return ret;
>  
> -	usleep_range(MS5611_CONV_TIME_MIN, MS5611_CONV_TIME_MAX);
> -
> +	usleep_range(osr->conv_usec, osr->conv_usec + (osr->conv_usec / 10UL));
>  	return ms5611_spi_read_adc(dev, pressure);
>  }
>  
> 

