Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58468 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759095Ab2JSRm6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 13:42:58 -0400
Message-ID: <5081759E.5040803@kernel.org>
Date: Fri, 19 Oct 2012 16:45:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Use strict_strtouint instead of kstrtoul
References: <1350568027-25101-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1350568027-25101-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2012 02:47 PM, Lars-Peter Clausen wrote:
> strict_strto* has been deprecated in favor of kstrto*. Use strict_strtouint
> respective strict_strtoint, since that is what the functions we pass the
> converted values to expect.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Yipped another tunnel, another exciting patch.
It's been a day of delphi, French fish and robots.

Actually this one is definitely worth the churn, thanks!

Added to togreg branch of iio.git
> ---
>  drivers/iio/industrialio-buffer.c |    6 +++---
>  drivers/iio/industrialio-event.c  |    4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index d4ad374..722a83f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -371,12 +371,12 @@ ssize_t iio_buffer_write_length(struct device *dev,
>  				const char *buf,
>  				size_t len)
>  {
> -	int ret;
> -	ulong val;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_buffer *buffer = indio_dev->buffer;
> +	unsigned int val;
> +	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtouint(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index fa6543b..857e630 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -239,13 +239,13 @@ static ssize_t iio_ev_value_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	unsigned long val;
> +	int val;
>  	int ret;
>  
>  	if (!indio_dev->info->write_event_value)
>  		return -EINVAL;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoint(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  
> 
