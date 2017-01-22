Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39970 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdAVM3M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 07:29:12 -0500
Subject: Re: [PATCH] iio: trigger: close race condition in acquiring trigger
 reference
To: Alison Schofield <amsfield22@gmail.com>
References: <20170122032844.GA6812@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b8956a7b-f50a-22e0-ea40-aa8afc2a8cf9@kernel.org>
Date: Sun, 22 Jan 2017 12:29:09 +0000
MIME-Version: 1.0
In-Reply-To: <20170122032844.GA6812@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/01/17 03:28, Alison Schofield wrote:
> In iio_trigger_write_current() we find the trigger we want while
> holding mutex on the list of triggers, but we don't actually do a
> get on it while holding mutex.  We wait until further validations
> are completed and we're sure it's the one we want.  Race condition
> is that it could be freed by the time we do the get.
> 
> Solution is to grab the trigger (iio_trigger_get) as soon as we
> find it while holding mutex on the list of triggers.  If later
> we decide it's not the right one, put it back. (iio_trigger_put).
> 
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
It's a race that's been there a long time so I'm going to take this
one the slow route rather than pushing it for stable etc.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> ---
> Not directly related to this patch, but wondering about the
> behavior when userspace tries to set an invalid current_trigger.
> 
> If the given trigger name is not found on the list, we don't
> simply quit, we proceed.  Net result is the old trigger is
> removed, the current trigger is set to NULL, and we return
> success to userspace.  This looks like desired behavior 
> since it is very intentionally coded.  Perhaps it is the
> method used to remove a trigger?
Yeah, it was intended.
> 
> Is that what we want?
Thinking more on it, we would have been better with an explicit
'flag' value - be that the empty string or NONE or similar.
Now we can't change it though as it's userspace ABI and
who knows what magic value people are using!  


  
> 
> 
>  drivers/iio/industrialio-trigger.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 978729f..d0d869e 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -147,8 +147,7 @@ static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
>  	return NULL;
>  }
>  
> -static struct iio_trigger *iio_trigger_find_by_name(const char *name,
> -						    size_t len)
> +static struct iio_trigger *iio_trigger_acquire_by_name(const char *name)
>  {
>  	struct iio_trigger *trig = NULL, *iter;
>  
> @@ -156,6 +155,7 @@ static struct iio_trigger *iio_trigger_find_by_name(const char *name,
>  	list_for_each_entry(iter, &iio_trigger_list, list)
>  		if (sysfs_streq(iter->name, name)) {
>  			trig = iter;
> +			iio_trigger_get(trig);
>  			break;
>  		}
>  	mutex_unlock(&iio_trigger_list_lock);
> @@ -416,20 +416,22 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  	}
>  	mutex_unlock(&indio_dev->mlock);
>  
> -	trig = iio_trigger_find_by_name(buf, len);
> -	if (oldtrig == trig)
> -		return len;
> +	trig = iio_trigger_acquire_by_name(buf);
> +	if (oldtrig == trig) {
> +		ret = len;
> +		goto out_trigger_put;
> +	}
>  
>  	if (trig && indio_dev->info->validate_trigger) {
>  		ret = indio_dev->info->validate_trigger(indio_dev, trig);
>  		if (ret)
> -			return ret;
> +			goto out_trigger_put;
>  	}
>  
>  	if (trig && trig->ops->validate_device) {
>  		ret = trig->ops->validate_device(trig, indio_dev);
>  		if (ret)
> -			return ret;
> +			goto out_trigger_put;
>  	}
>  
>  	indio_dev->trig = trig;
> @@ -441,13 +443,16 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  		iio_trigger_put(oldtrig);
>  	}
>  	if (indio_dev->trig) {
> -		iio_trigger_get(indio_dev->trig);
>  		if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
>  			iio_trigger_attach_poll_func(indio_dev->trig,
>  						     indio_dev->pollfunc_event);
>  	}
>  
>  	return len;
> +
> +out_trigger_put:
> +	iio_trigger_put(trig);
> +	return ret;
>  }
>  
>  static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
> 

