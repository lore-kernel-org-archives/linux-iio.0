Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbbHOT7I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 15:59:08 -0400
Subject: Re: [PATCH 1/2] Staging: iio: trigger: Alignment should match open
 parenthesis
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <cover.1439286814.git.cristina.opriceana@gmail.com>
 <0146dc807925c66b3098993e4cc2f3a0a0a4f746.1439286814.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF9A0A.5020907@kernel.org>
Date: Sat, 15 Aug 2015 20:59:06 +0100
MIME-Version: 1.0
In-Reply-To: <0146dc807925c66b3098993e4cc2f3a0a0a4f746.1439286814.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/15 11:18, Cristina Opriceana wrote:
> Fix alignment for function parameters as suggested by checkpatch.pl.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Whilst I find it a little hard to care about tidying up in these two drivers,
we haven't explicitly noted they are both on their way out in the medium
term and it does no harm.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c   | 7 ++++---
>  drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 3c1c8c6..9fe48ef 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -79,7 +79,8 @@ static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
>  }
>  
>  static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t count)
>  {
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
> @@ -116,8 +117,8 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
>  }
>  
>  static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> +					   struct device_attribute *attr,
> +					   char *buf)
>  {
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> index 0c1976d..a2a42c2 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -37,7 +37,7 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
>  	if (trig_info->frequency == 0 && state)
>  		return -EINVAL;
>  	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %u\n",
> -			trig_info->frequency);
> +		trig_info->frequency);
>  	ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
>  	if (ret == 0)
>  		trig_info->state = state;
> 

