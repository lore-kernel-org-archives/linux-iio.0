Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50024 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbbITK6w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 06:58:52 -0400
Subject: Re: [RESEND PATCH 4/4] iio: st_common: use standard trigger suffix
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1442303385-11905-1-git-send-email-linus.walleij@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FE916B.30006@kernel.org>
Date: Sun, 20 Sep 2015 11:58:51 +0100
MIME-Version: 1.0
In-Reply-To: <1442303385-11905-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/09/15 08:49, Linus Walleij wrote:
> The triggers from ST sensors are named <iio_device_name>-trigger
> instead of the standard <iio_device_name>-dev<iio_dev_id> as
> used by most and also in the iio-tools. Change this to match
> the norm.
> 
> After this I can do tests with generic_buffer -n <dev_name>
> without having to manually specify the trigger with the -t
> option.
> 
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Sorry, I never replied to your last email about this one.  Have
done so now as better to keep discussion in that thread than
start a new one.

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 3e907040c2c7..3c0aa17d753f 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -24,7 +24,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	int err;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> -	sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
> +	sdata->trig = iio_trigger_alloc("%s-dev%d",
> +					indio_dev->name, indio_dev->id);
>  	if (sdata->trig == NULL) {
>  		err = -ENOMEM;
>  		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
> 

