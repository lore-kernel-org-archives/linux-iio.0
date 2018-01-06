Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752847AbeAFM2A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:28:00 -0500
Date: Sat, 6 Jan 2018 12:27:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] staging: iio: trigger: replace device_attr with
 device_attr_rw
Message-ID: <20180106122755.62dae7f8@archlinux>
In-Reply-To: <20180104105851.GA10434@mordor.localdomain>
References: <20180104105851.GA10434@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 4 Jan 2018 16:28:51 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> This is a clean-up patch which replaces DEVICE_ATTR() macro with the
> file permission specific DEVICE_ATTR_RW() macro for compaction and
> readability. Done using coccinelle.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Whilst this driver is in theory going away (Lars, update on that?)
I guess this is a minor improvement.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Also, note I changed the title to include the driver name as 
just putting to a directory is not much use for people trying
to track down changes that matter to them.

Jonathan

> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index f389f5cca99d..71f11d7472c0 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -78,9 +78,9 @@ static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
>  	return 0;
>  }
>  
> -static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
> -					    struct device_attribute *attr,
> -					    const char *buf, size_t count)
> +static ssize_t frequency_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
>  {
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
> @@ -116,9 +116,9 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
>  	return count;
>  }
>  
> -static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
> -					   struct device_attribute *attr,
> -					   char *buf)
> +static ssize_t frequency_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
>  {
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
> @@ -133,8 +133,7 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
>  	return sprintf(buf, "%lu\n", val);
>  }
>  
> -static DEVICE_ATTR(frequency, 0644, iio_bfin_tmr_frequency_show,
> -		   iio_bfin_tmr_frequency_store);
> +static DEVICE_ATTR_RW(frequency);
>  
>  static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
>  	&dev_attr_frequency.attr,

