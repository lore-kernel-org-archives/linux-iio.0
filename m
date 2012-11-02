Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45108 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964939Ab2KBJom (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 05:44:42 -0400
Message-ID: <50939607.7090609@kernel.org>
Date: Fri, 02 Nov 2012 09:44:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: Do not accept multiple '.' in fixed point numbers
References: <1350904515-696-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1350904515-696-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/22/2012 12:15 PM, Lars-Peter Clausen wrote:
> Currently when parsing a fix-point number we silently skip any additional '.'
> found in the string.  E.g. '1.2.3.4' gets parsed as '1.234'. This patch
> disallows this and returns an error if more than one '.' is encountered.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Added to togreg branch of iio.git

> ---
>  drivers/iio/industrialio-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6eb24db..a2e9953 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -449,7 +449,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  				break;
>  			else
>  				return -EINVAL;
> -		} else if (*buf == '.') {
> +		} else if (*buf == '.' && integer_part) {
>  			integer_part = false;
>  		} else {
>  			return -EINVAL;
> 
