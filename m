Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:39117 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914Ab2EOI3E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2012 04:29:04 -0400
Message-ID: <4FB213CE.3040202@cam.ac.uk>
Date: Tue, 15 May 2012 09:29:02 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
	marek.belisko@gmail.com, shubhrajyoti@ti.com
Subject: Re: [PATCH 1/9] iio: fix access to hmc5843 private data
References: <1337034454-29717-1-git-send-email-pmeerw@pmeerw.net> <1337034454-29717-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1337034454-29717-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/14/2012 11:27 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
> i2c_get_clientdata(client) points to iio_dev, not hmc5843_data; fixes
> issue similar to 62d2feb9803f18c4e3c8a1a2c7e30a54df8a1d72
>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
> Acked-by: Shubhrajyoti D<shubhrajyoti@ti.com>
I acked this last time as well... Though as you've made me look at it
again, trivial nitpick below ;)
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/magnetometer/hmc5843.c |   14 +++++++++-----
>   1 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 3ec6518..9725cf8 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -250,7 +250,8 @@ static IIO_DEVICE_ATTR(operating_mode,
>   static s32 hmc5843_set_meas_conf(struct i2c_client *client,
>   				      u8 meas_conf)
>   {
> -	struct hmc5843_data *data = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>   	u8 reg_val;
>   	reg_val = (meas_conf&  MEAS_CONF_MASK) |  (data->rate<<  RATE_OFFSET);
>   	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
> @@ -272,7 +273,7 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> -	struct hmc5843_data *data = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>   	unsigned long meas_conf = 0;
>   	int error = strict_strtoul(buf, 10,&meas_conf);
>   	if (error)
> @@ -314,7 +315,8 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 10 20 50");
>   static s32 hmc5843_set_rate(struct i2c_client *client,
>   				u8 rate)
>   {
> -	struct hmc5843_data *data = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>   	u8 reg_val;
>
>   	reg_val = (data->meas_conf) |  (rate<<  RATE_OFFSET);
> @@ -600,8 +602,10 @@ static int hmc5843_suspend(struct device *dev)
>
>   static int hmc5843_resume(struct device *dev)
>   {
> -	struct hmc5843_data *data = i2c_get_clientdata(to_i2c_client(dev));
> -	hmc5843_configure(to_i2c_client(dev), data->operating_mode);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
ideally blank line here.
> +	hmc5843_configure(client, data->operating_mode);
and here.
>   	return 0;
>   }
>

