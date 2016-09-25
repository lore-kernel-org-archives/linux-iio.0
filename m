Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36276 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934881AbcIYOcc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 10:32:32 -0400
Subject: Re: [PATCH 3/3] staging: iio: isl29018: fix comparison between signed
 and unsigned integers
To: Brian Masney <masneyb@onstation.org>, gregkh@linuxfoundation.org
References: <1474803667-21776-1-git-send-email-masneyb@onstation.org>
 <1474803667-21776-3-git-send-email-masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0ec220ac-b1a8-b923-ec47-03329ef43dc7@kernel.org>
Date: Sun, 25 Sep 2016 15:32:29 +0100
MIME-Version: 1.0
In-Reply-To: <1474803667-21776-3-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/16 12:41, Brian Masney wrote:
> Fixes warning found by make W=2:
> warning: comparison between signed and unsigned integer expressions
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This one is pretty marginal on whether it is worth while given
it is easy to verify that it doesn't matter in any of these cases.

Anyhow, I suppose it does no harm and maybe is a really small
improvement in the code.

Applied to the togreg branch of iio.git etc.

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 0a35588..4e2ce74 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -104,7 +104,8 @@ struct isl29018_chip {
>  static int isl29018_set_integration_time(struct isl29018_chip *chip,
>  					 unsigned int utime)
>  {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
>  	unsigned int int_time, new_int_time;
>  
>  	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i) {
> @@ -139,7 +140,8 @@ static int isl29018_set_integration_time(struct isl29018_chip *chip,
>  
>  static int isl29018_set_scale(struct isl29018_chip *chip, int scale, int uscale)
>  {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
>  	struct isl29018_scale new_scale;
>  
>  	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i) {
> @@ -275,7 +277,8 @@ static ssize_t show_scale_available(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct isl29018_chip *chip = iio_priv(indio_dev);
> -	int i, len = 0;
> +	unsigned int i;
> +	int len = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i)
>  		len += sprintf(buf + len, "%d.%06d ",
> @@ -292,7 +295,8 @@ static ssize_t show_int_time_available(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct isl29018_chip *chip = iio_priv(indio_dev);
> -	int i, len = 0;
> +	unsigned int i;
> +	int len = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i)
>  		len += sprintf(buf + len, "0.%06d ",
> 

