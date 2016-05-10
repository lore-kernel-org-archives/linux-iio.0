Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35052 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbcEJHfD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2016 03:35:03 -0400
Received: by mail-lf0-f46.google.com with SMTP id j8so4964173lfd.2
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2016 00:35:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1462837324-5670-1-git-send-email-matt.ranostay@intel.com>
References: <1462837324-5670-1-git-send-email-matt.ranostay@intel.com>
Date: Tue, 10 May 2016 10:35:01 +0300
Message-ID: <CAEnQRZAskVKgusS8iYYtQFMLUoD1X7GLOLTYzd8thbaqCbbFdA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: add support for ADS1115 part
From: Daniel Baluta <daniel.baluta@intel.com>
To: Matt Ranostay <matt.ranostay@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 10, 2016 at 2:42 AM, Matt Ranostay <matt.ranostay@intel.com> wrote:
> TI ADS1115 is a 16-bit resolution ADC that is register map
> compatible with the ADS1015 device.
>
> Cc: daniel.baluta@intel.com
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 77 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 71 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 73cbf0b54e54..317325692cb3 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -55,6 +55,11 @@
>  #define ADS1015_DEFAULT_DATA_RATE      4
>  #define ADS1015_DEFAULT_CHAN           0
>
> +enum {
> +       ADS1015,
> +       ADS1115,
> +};
> +
>  enum ads1015_channels {
>         ADS1015_AIN0_AIN1 = 0,
>         ADS1015_AIN0_AIN3,
> @@ -123,6 +128,42 @@ static const struct {
>         },                                                      \
>  }
>
> +#define ADS1115_V_CHAN(_chan, _addr) {                         \
> +       .type = IIO_VOLTAGE,                                    \
> +       .indexed = 1,                                           \
> +       .address = _addr,                                       \
> +       .channel = _chan,                                       \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> +                               BIT(IIO_CHAN_INFO_SCALE) |      \
> +                               BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
> +       .scan_index = _addr,                                    \
> +       .scan_type = {                                          \
> +               .sign = 's',                                    \
> +               .realbits = 16,                                 \
> +               .storagebits = 16,                              \
> +               .endianness = IIO_CPU,                          \
> +       },                                                      \
> +}
> +
> +#define ADS1115_V_DIFF_CHAN(_chan, _chan2, _addr) {            \
> +       .type = IIO_VOLTAGE,                                    \
> +       .differential = 1,                                      \
> +       .indexed = 1,                                           \
> +       .address = _addr,                                       \
> +       .channel = _chan,                                       \
> +       .channel2 = _chan2,                                     \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> +                               BIT(IIO_CHAN_INFO_SCALE) |      \
> +                               BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
> +       .scan_index = _addr,                                    \
> +       .scan_type = {                                          \
> +               .sign = 's',                                    \
> +               .realbits = 16,                                 \
> +               .storagebits = 16,                              \
> +               .endianness = IIO_CPU,                          \
> +       },                                                      \
> +}
> +
>  struct ads1015_data {
>         struct regmap *regmap;
>         /*
> @@ -157,6 +198,19 @@ static const struct iio_chan_spec ads1015_channels[] = {
>         IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
>  };
>
> +static const struct iio_chan_spec ads1115_channels[] = {
> +       ADS1115_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1),
> +       ADS1115_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3),
> +       ADS1115_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3),
> +       ADS1115_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3),
> +       ADS1115_V_CHAN(0, ADS1015_AIN0),
> +       ADS1115_V_CHAN(1, ADS1015_AIN1),
> +       ADS1115_V_CHAN(2, ADS1015_AIN2),
> +       ADS1115_V_CHAN(3, ADS1015_AIN3),
> +       IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
> +};
> +
> +
>  static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  {
>         int ret;
> @@ -291,7 +345,9 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>         mutex_lock(&indio_dev->mlock);
>         mutex_lock(&data->lock);
>         switch (mask) {
> -       case IIO_CHAN_INFO_RAW:
> +       case IIO_CHAN_INFO_RAW: {
> +               int shift = chan->scan_type.shift;
> +
>                 if (iio_buffer_enabled(indio_dev)) {
>                         ret = -EBUSY;
>                         break;
> @@ -307,8 +363,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>                         break;
>                 }
>
> -               /* 12 bit res, D0 is bit 4 in conversion register */
> -               *val = sign_extend32(*val >> 4, 11);
> +               *val = sign_extend32(*val >> shift, 15 - shift);
>
>                 ret = ads1015_set_power_state(data, false);
>                 if (ret < 0)
> @@ -316,6 +371,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>
>                 ret = IIO_VAL_INT;
>                 break;
> +       }
>         case IIO_CHAN_INFO_SCALE:
>                 idx = data->channel_data[chan->address].pga;
>                 *val = ads1015_scale[idx].scale;
> @@ -502,8 +558,16 @@ static int ads1015_probe(struct i2c_client *client,
>         indio_dev->dev.parent = &client->dev;
>         indio_dev->info = &ads1015_info;
>         indio_dev->name = ADS1015_DRV_NAME;
> -       indio_dev->channels = ads1015_channels;
> -       indio_dev->num_channels = ARRAY_SIZE(ads1015_channels);
> +
> +       switch (id->driver_data) {
> +       case ADS1015:
> +               indio_dev->channels = ads1015_channels;
> +               break;
> +       case ADS1115:
> +               indio_dev->channels = ads1115_channels;
> +               break;
> +       }
> +       indio_dev->num_channels = 9;
I'm not comfortable with this magic number here.
