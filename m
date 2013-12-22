Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46807 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab3LVQCq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Dec 2013 11:02:46 -0500
Message-ID: <52B70D25.9080007@kernel.org>
Date: Sun, 22 Dec 2013 16:02:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: cm36651: Remove redundant of_match_ptr helper
References: <1387620441-28694-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1387620441-28694-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/21/13 10:07, Sachin Kamat wrote:
> 'cm36651_of_match' is always compiled in. Hence the
> helper macro is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/light/cm36651.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 0922e39b0ea9..328ef3d760c3 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -693,7 +693,7 @@ static const struct of_device_id cm36651_of_match[] = {
>  static struct i2c_driver cm36651_driver = {
>  	.driver = {
>  		.name	= "cm36651",
> -		.of_match_table = of_match_ptr(cm36651_of_match),
> +		.of_match_table = cm36651_of_match,
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe		= cm36651_probe,
> 
