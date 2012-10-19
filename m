Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58455 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759056Ab2JSRmz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 13:42:55 -0400
Message-ID: <50817288.1000903@kernel.org>
Date: Fri, 19 Oct 2012 16:32:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/4] iio: at91_adc: Use devm_kcalloc to allocate arrays
References: <1350571399-17723-1-git-send-email-lars@metafoo.de> <1350571399-17723-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1350571399-17723-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2012 03:43 PM, Lars-Peter Clausen wrote:
> Use dev_kcalloc instead of devm_kzalloc to allocate arrays since it is
> semantically more appropriate.
> 
> While we are at it the patch also fixes the following coccinelle warning:
> 	drivers/iio/adc/at91_adc.c:277:25-31: ERROR: application of sizeof to pointer
'interesting description'. Surely it means in assigment of memory to the same pointer.
Not the clearest description and here doesn't cause an actual bug, just a semantic
mess.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Applied to togreg branch of iio.git.  Hmm.. should have stayed under the sea.
It wasn't raining there.
> ---
>  drivers/iio/adc/at91_adc.c |   16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 3ed94bf..b81f93b 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -126,10 +126,8 @@ static int at91_adc_channel_init(struct iio_dev *idev)
>  	idev->num_channels = bitmap_weight(&st->channels_mask,
>  					   st->num_channels) + 1;
>  
> -	chan_array = devm_kzalloc(&idev->dev,
> -				  ((idev->num_channels + 1) *
> -					sizeof(struct iio_chan_spec)),
> -				  GFP_KERNEL);
> +	chan_array = devm_kcalloc(&idev->dev, idev->num_channels + 1,
> +					sizeof(*chan_array), GFP_KERNEL);
>  
>  	if (!chan_array)
>  		return -ENOMEM;
> @@ -273,9 +271,8 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
>  	struct at91_adc_state *st = iio_priv(idev);
>  	int i, ret;
>  
> -	st->trig = devm_kzalloc(&idev->dev,
> -				st->trigger_number * sizeof(st->trig),
> -				GFP_KERNEL);
> +	st->trig = devm_kcalloc(&idev->dev, st->trigger_number,
> +				sizeof(*st->trig), GFP_KERNEL);
>  
>  	if (st->trig == NULL) {
>  		ret = -ENOMEM;
> @@ -457,9 +454,8 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>  	st->registers->trigger_register = prop;
>  
>  	st->trigger_number = of_get_child_count(node);
> -	st->trigger_list = devm_kzalloc(&idev->dev, st->trigger_number *
> -					sizeof(struct at91_adc_trigger),
> -					GFP_KERNEL);
> +	st->trigger_list = devm_kcalloc(&idev->dev, st->trigger_number,
> +					sizeof(*st->trigger_list), GFP_KERNEL);
>  	if (!st->trigger_list) {
>  		dev_err(&idev->dev, "Could not allocate trigger list memory.\n");
>  		ret = -ENOMEM;
> 
