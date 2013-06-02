Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49076 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab3FBQGC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 12:06:02 -0400
Message-ID: <51AB6D68.2080207@kernel.org>
Date: Sun, 02 Jun 2013 17:06:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: 'Jonathan Cameron' <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: replace strict_strtoul() with kstrtoul()
References: <000401ce5e97$2aa80490$7ff80db0$@samsung.com>
In-Reply-To: <000401ce5e97$2aa80490$7ff80db0$@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/01/2013 08:10 AM, Jingoo Han wrote:
> The usage of strict_strtoul() is not preferred, because
> strict_strtoul() is obsolete. Thus, kstrtoul() should be
> used.
> 
hmmm.  Normally I'd only take this sort of change
if it were part of a large scale cleanup of a driver, but
as those are both my drivers what the heck, I'll take it.

Applied to the togreg branch of iio.git.

> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/iio/adc/max1363.c            |    2 +-
>  drivers/iio/trigger/iio-trig-sysfs.c |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 9e6da72..f148d00 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -660,7 +660,7 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
>  	unsigned long val;
>  	bool found = false;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
>  		return -EINVAL;
>  	for (i = 0; i < ARRAY_SIZE(max1363_monitor_speeds); i++)
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index b727bde..effcd0a 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -34,7 +34,7 @@ static ssize_t iio_sysfs_trig_add(struct device *dev,
>  	int ret;
>  	unsigned long input;
>  
> -	ret = strict_strtoul(buf, 10, &input);
> +	ret = kstrtoul(buf, 10, &input);
>  	if (ret)
>  		return ret;
>  	ret = iio_sysfs_trigger_probe(input);
> @@ -53,7 +53,7 @@ static ssize_t iio_sysfs_trig_remove(struct device *dev,
>  	int ret;
>  	unsigned long input;
>  
> -	ret = strict_strtoul(buf, 10, &input);
> +	ret = kstrtoul(buf, 10, &input);
>  	if (ret)
>  		return ret;
>  	ret = iio_sysfs_trigger_remove(input);
> 
