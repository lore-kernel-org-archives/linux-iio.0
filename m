Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751724AbdHLMDS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:03:18 -0400
Date: Sat, 12 Aug 2017 12:50:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] iio: srf08: add sensor type srf10
Message-ID: <20170812125055.0415eaad@archlinux>
In-Reply-To: <20170802232356.GA15234@arbeit>
References: <20170802232356.GA15234@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 01:23:56 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Ultrasonic sensor srf10 is quite similar to srf08 and now also supported by
> the driver as device tree compatible string.
> 
> The most significiant difference is a different range and values of
> register gain (in the driver it's call sensitivity). Therefore the array of
> was extended.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Minor issue inline.  Otherwise looks fine.

Jonathan
> ---
>  drivers/iio/proximity/srf08.c | 59 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index 49316cbf7c60..350b5b0eb64e 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -30,14 +30,23 @@
>  
>  #define SRF08_CMD_RANGING_CM	0x51	/* Ranging Mode - Result in cm */
>  
> -#define SRF08_DEFAULT_GAIN	1025	/* default analogue value of Gain */
> +//#define SRF08_DEFAULT_GAIN	1025	/* default analogue value of Gain */
checkpatch.pl would have picked up on this.  Don't leave random dead code
in here...
>  #define SRF08_DEFAULT_RANGE	6020	/* default value of Range in mm */
>  
> +#define SRF08_MAX_SENSITIVITY	32	/* number of Gain Register values */
> +
> +enum srf08_sensor_type {
> +	SRF08,
> +	SRF10,
> +	SRF_MAX_TYPE
> +};
> +
>  struct srf08_data {
>  	struct i2c_client	*client;
>  	int			sensitivity;		/* Gain */
>  	int			range_mm;		/* max. Range in mm */
>  	struct mutex		lock;
> +	enum srf08_sensor_type	sensor_type;		/* Sensor-Type */
>  };
>  
>  /*
> @@ -47,11 +56,29 @@ struct srf08_data {
>   * But with ADC's this term is already used differently and that's why it
>   * is called "Sensitivity" here.
>   */
> -static const int srf08_sensitivity[] = {
> +static const int srf08_sensitivity[SRF_MAX_TYPE][SRF08_MAX_SENSITIVITY] = {
> +	/* SRF08 */
> +	{
>  	 94,  97, 100, 103, 107, 110, 114, 118,
>  	123, 128, 133, 139, 145, 152, 159, 168,
>  	177, 187, 199, 212, 227, 245, 265, 288,
> -	317, 352, 395, 450, 524, 626, 777, 1025 };
> +	317, 352, 395, 450, 524, 626, 777, 1025
> +	},
> +	/* SRF10 */
> +	{
> +	 40,  40,  50,  60,  70,  80, 100, 120,
> +	140, 200, 250, 300, 350, 400, 500, 600,
> +	700,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,
> +	},
> +};
> +
> +static const int srf08_default_sensitivity[SRF_MAX_TYPE] = {
> +	/* SRF08 */
> +	1025,
> +	/* SRF10 */
> +	700,
> +};
>  
>  static int srf08_read_ranging(struct srf08_data *data)
>  {
> @@ -225,9 +252,13 @@ static ssize_t srf08_show_sensitivity_available(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
>  	int i, len = 0;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct srf08_data *data = iio_priv(indio_dev);
>  
> -	for (i = 0; i < ARRAY_SIZE(srf08_sensitivity); i++)
> -		len += sprintf(buf + len, "%d ", srf08_sensitivity[i]);
> +	for (i = 0; i < SRF08_MAX_SENSITIVITY; i++)
> +		if (srf08_sensitivity[data->sensor_type][i])
> +			len += sprintf(buf + len, "%d ",
> +				srf08_sensitivity[data->sensor_type][i]);
>  
>  	len += sprintf(buf + len, "\n");
>  
> @@ -256,13 +287,16 @@ static ssize_t srf08_write_sensitivity(struct srf08_data *data,
>  	int ret, i;
>  	u8 regval;
>  
> -	for (i = 0; i < ARRAY_SIZE(srf08_sensitivity); i++)
> -		if (val == srf08_sensitivity[i]) {
> +	if (!val)
> +		return -EINVAL;
> +
> +	for (i = 0; i < SRF08_MAX_SENSITIVITY; i++)
> +		if (val == srf08_sensitivity[data->sensor_type][i]) {
>  			regval = i;
>  			break;
>  		}
>  
> -	if (i >= ARRAY_SIZE(srf08_sensitivity))
> +	if (i >= SRF08_MAX_SENSITIVITY)
>  		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
> @@ -352,8 +386,9 @@ static int srf08_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> +	data->sensor_type = (enum srf08_sensor_type)id->driver_data;
>  
> -	indio_dev->name = "srf08";
> +	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &srf08_info;
> @@ -371,7 +406,8 @@ static int srf08_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = srf08_write_sensitivity(data, SRF08_DEFAULT_GAIN);
> +	ret = srf08_write_sensitivity(data,
> +			srf08_default_sensitivity[id->driver_data]);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -379,7 +415,8 @@ static int srf08_probe(struct i2c_client *client,
>  }
>  
>  static const struct i2c_device_id srf08_id[] = {
> -	{ "srf08", 0 },
> +	{ "srf08", SRF08 },
> +	{ "srf10", SRF10 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, srf08_id);

