Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48702 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab2JaK6K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Oct 2012 06:58:10 -0400
Message-ID: <50910440.2060800@kernel.org>
Date: Wed, 31 Oct 2012 10:58:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Axel Lin <axel.lin@ingics.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] Revert "iio: at91_adc: Use devm_kcalloc to allocate arrays"
References: <1351499156.14725.1.camel@phoenix>
In-Reply-To: <1351499156.14725.1.camel@phoenix>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/2012 08:25 AM, Axel Lin wrote:
> This reverts commit 45259859492812c8b700ae1d157be01a8d2babfe.
> This fixes build error because devm_kcalloc does not exist in current tree.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Applied to togreg branch of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Thanks Axel and oops on my part as well - should probably
have caught this one.

Jonathan
> ---
>  drivers/iio/adc/at91_adc.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index a917672..2e2c9a8 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -123,8 +123,10 @@ static int at91_adc_channel_init(struct iio_dev *idev)
>  	idev->num_channels = bitmap_weight(&st->channels_mask,
>  					   st->num_channels) + 1;
>  
> -	chan_array = devm_kcalloc(&idev->dev, idev->num_channels + 1,
> -					sizeof(*chan_array), GFP_KERNEL);
> +	chan_array = devm_kzalloc(&idev->dev,
> +				  ((idev->num_channels + 1) *
> +					sizeof(struct iio_chan_spec)),
> +				  GFP_KERNEL);
>  
>  	if (!chan_array)
>  		return -ENOMEM;
> @@ -268,8 +270,9 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
>  	struct at91_adc_state *st = iio_priv(idev);
>  	int i, ret;
>  
> -	st->trig = devm_kcalloc(&idev->dev, st->trigger_number,
> -				sizeof(*st->trig), GFP_KERNEL);
> +	st->trig = devm_kzalloc(&idev->dev,
> +				st->trigger_number * sizeof(st->trig),
> +				GFP_KERNEL);
>  
>  	if (st->trig == NULL) {
>  		ret = -ENOMEM;
> @@ -451,8 +454,9 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>  	st->registers->trigger_register = prop;
>  
>  	st->trigger_number = of_get_child_count(node);
> -	st->trigger_list = devm_kcalloc(&idev->dev, st->trigger_number,
> -					sizeof(*st->trigger_list), GFP_KERNEL);
> +	st->trigger_list = devm_kzalloc(&idev->dev, st->trigger_number *
> +					sizeof(struct at91_adc_trigger),
> +					GFP_KERNEL);
>  	if (!st->trigger_list) {
>  		dev_err(&idev->dev, "Could not allocate trigger list memory.\n");
>  		ret = -ENOMEM;
> 
