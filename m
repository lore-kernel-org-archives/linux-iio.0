Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50070 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbIOVNH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2015 17:13:07 -0400
Subject: Re: [RESEND PATCH 1/4] iio: st_accel: set up available scan masks
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1442303356-11764-1-git-send-email-linus.walleij@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55F889DA.9070504@kernel.org>
Date: Tue, 15 Sep 2015 22:12:58 +0100
MIME-Version: 1.0
In-Reply-To: <1442303356-11764-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/09/15 08:49, Linus Walleij wrote:
> In order to enable triggered buffered input, IIO needs to
> know what channels can be enabled for buffered input.
> Set up a scan mask for X/Y/Z.
This is only necessary if the device isn't capable of reading
any subset of channels (i.e. there are restrictions).
In this case reads seem to be accomplished on a channel by
channel basis with no significant additional cost so I would
not expect available_scan_masks to be specified.

Doing this restricts the driver to having to read all 3 channels
even if only one is desired.

Jonathan
> 
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/accel/st_accel_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index ff30f8806880..b9a7b5c7c5e7 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -630,6 +630,12 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>  
> +/* Bits 0,1,2, = channels 0,1,2 = x,y,z */
> +static const unsigned long st_sensors_scan_masks[] = {
> +	ST_SENSORS_ENABLE_ALL_AXIS,
> +	0, /* Sentinel */
> +};
> +
>  int st_accel_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
> @@ -652,6 +658,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
>  	indio_dev->channels = adata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
> +	indio_dev->available_scan_masks = st_sensors_scan_masks;
>  
>  	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
>  					&adata->sensor_settings->fs.fs_avl[0];
> 

