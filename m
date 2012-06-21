Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:40564 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab2FUOTi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jun 2012 10:19:38 -0400
Message-ID: <4FE32D78.9@cam.ac.uk>
Date: Thu, 21 Jun 2012 15:19:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:iio:trigger: Use to_iio_trigger() instead
 of dev_get_drvdata()
References: <1340037978-16915-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1340037978-16915-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/18/2012 5:46 PM, Lars-Peter Clausen wrote:
> Use to_iio_trigger(dev) instead of dev_get_drvdata(dev). Both will return the
> trigger which belongs to the device, but the the first on is a bit more
> lightweight. Also this will eventually free up the drvdata pointer of the device
> for driver specific data.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/trigger/iio-trig-bfin-timer.c   |    4 ++--
>   drivers/staging/iio/trigger/iio-trig-periodic-rtc.c |    4 ++--
>   drivers/staging/iio/trigger/iio-trig-sysfs.c        |    2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index f85734d..ce6a7b1 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -60,7 +60,7 @@ struct bfin_tmr_state {
>   static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> -	struct iio_trigger *trig = dev_get_drvdata(dev);
> +	struct iio_trigger *trig = to_iio_trigger(dev);
>   	struct bfin_tmr_state *st = trig->private_data;
>   	long val;
>   	int ret;
> @@ -97,7 +97,7 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
>   				 struct device_attribute *attr,
>   				 char *buf)
>   {
> -	struct iio_trigger *trig = dev_get_drvdata(dev);
> +	struct iio_trigger *trig = to_iio_trigger(dev);
>   	struct bfin_tmr_state *st = trig->private_data;
>
>   	return sprintf(buf, "%lu\n",
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> index 9f2d055..4ceaa18 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -41,7 +41,7 @@ static ssize_t iio_trig_periodic_read_freq(struct device *dev,
>   					   struct device_attribute *attr,
>   					   char *buf)
>   {
> -	struct iio_trigger *trig = dev_get_drvdata(dev);
> +	struct iio_trigger *trig = to_iio_trigger(dev);
>   	struct iio_prtc_trigger_info *trig_info = trig->private_data;
>   	return sprintf(buf, "%u\n", trig_info->frequency);
>   }
> @@ -51,7 +51,7 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
>   					    const char *buf,
>   					    size_t len)
>   {
> -	struct iio_trigger *trig = dev_get_drvdata(dev);
> +	struct iio_trigger *trig = to_iio_trigger(dev);
>   	struct iio_prtc_trigger_info *trig_info = trig->private_data;
>   	unsigned long val;
>   	int ret;
> diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
> index 552763b..fee4746 100644
> --- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
> @@ -92,7 +92,7 @@ static struct device iio_sysfs_trig_dev = {
>   static ssize_t iio_sysfs_trigger_poll(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> -	struct iio_trigger *trig = dev_get_drvdata(dev);
> +	struct iio_trigger *trig = to_iio_trigger(dev);
>   	iio_trigger_poll_chained(trig, 0);
>
>   	return count;
>


