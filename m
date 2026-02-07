Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02828151C;
	Sat,  7 Feb 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770478554; cv=none; b=IgjG8wzJqGYFsP29j73EjZg6fc0BxpDvv8wksAII0VQA7PHLyCzaAeeujHNd/H3V2ENCSu0WzzmU1YaUJGFmb9G09jtXRLdCBfbtk3zqAzW0Xohwd1zEpeUlRMlppi7ioXUkIiqyYSr/qUj3O0S1OrSf8Xbj6mvXU3zDiiGtQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770478554; c=relaxed/simple;
	bh=uYClm7tfTj3uxocphJ88Nm26+MA8c5utf/G6jxmsuyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8JnDt2oFhPI+NocZr69D2HWouqBp1UHU1/PRQs1vBU3PlIqP++C9Cy7GkVeb/Huyem3lNSc6yOuMijojZJ/D0+kaZ2LpwqDcwny7XZmjjnS5QumP/jogHUcqPR+zjoWU5t7EfncDaxGI0u2IoOystviS/MF/SCkqPm/CagIU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVH2FRle; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVH2FRle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCCEC116D0;
	Sat,  7 Feb 2026 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770478553;
	bh=uYClm7tfTj3uxocphJ88Nm26+MA8c5utf/G6jxmsuyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XVH2FRlehVC1rpG2ml3m+1VbuOqLAwQw97k3hcjo06XuTOawR5C3TvFPi1EmOUaFA
	 7cMoFwWaGH/OU+DaERhzxj/EfDi/+3JQAhS5gkjEKYsZJ7fYHF/kTwbwKJH0jhPamm
	 HSjVyvAu34wS1ZZUDGUMWTr+tmZNQOhiXzHuldyaVzOUTxmyFKidKMZrHzwmiPyt3F
	 BSn5TFFDbIxlizOIRwl1OONDnNyu07w97uWfPBV3ipGLRRCkwJYRm5v3SI3T3eAW1s
	 UcZpJXcycMppItzrTFpXVghRPO4KkVO5BPTJDtsVE8/T7OpQLtxUy4cW2YJE8fZcO4
	 aBI37QT6SQXtg==
Date: Sat, 7 Feb 2026 15:35:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: fix use-after-free in
 viio_trigger_alloc()
Message-ID: <20260207153546.74d4fc2b@jic23-huawei>
In-Reply-To: <20260204203414.89333-1-salah.triki@gmail.com>
References: <20260204203414.89333-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Feb 2026 21:34:13 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> Once `device_initialize()` is called, the reference count of the device is
> set to 1. The memory associated with the device must then be managed by
> the kobject reference counting via `put_device()`.
Hi Salah,

This explanation has become a little unnecessarily long and unclear.
I think it needs a rewrite.

> 
> Currently, if `irq_alloc_descs()` or `kvasprintf()` fails, the code
> manually calls `irq_free_descs()` and `kfree()`. This is problematic for
> two reasons:
> 
> 1. Calling `kfree()` directly bypasses the device's release callback
>    (`iio_trig_release()`), which could lead to resource leaks or
>    inconsistencies within the driver core.

Does it?  A could doesn't provide information on whether to back port or
not.  If you are going to make this statement, make it clear what
leak or meaningful inconsistency occurs.

I would instead pitch this as following a standard design pattern and
reducing the duplication of code for the cleanup path.

> 
> 2. If we simply replace `kfree()` with `put_device()`, a double free
>    occurs because `iio_trig_release()` already calls `irq_free_descs()`.
I don't thing this needs calling out explicitly as it's kind
of more about what was wrong in previous version than something
that needs stating here.


> 
> Fix this by:
> - Using `put_device()` to handle memory tearing down.
> - Removing the manual call to `irq_free_descs()` in the error path, as
>   it is already handled by the trigger's release function.
Simplify this to something like:

Use put_device() which removes the need to cal irq_free_descs()
explicitly in the error path as that is also also part of the
release function.


> 
> Path to the issue:
> viio_trigger_alloc()
>   -> device_initialize() (refcount = 1)
>   -> kvasprintf() fails
>   -> goto free_descs
>   -> irq_free_descs() (first manual free)
>   -> kfree(trig) (refcount is still 1, release never called)  
This bit is unnecessary detail.

> 
> Fixes: 2c99f1a09da3d ("iio: trigger: clean up viio_trigger_alloc()")
Without a clear statement of the bug (and refcount == 1 on something
we kfree is inelegant but not a bug) then a fixes tag is not appropriate.
It triggers backports, which may or may not make sense for this.

I'll note the minimal fix (which is less good for other reasons) is
simply do the device_initialize() later after we are sure we won't get
a failure.

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v2:
> - Remove the manual call to irq_free_descs() in the error path to avoid 
>   a double free, as this is already handled by iio_trig_release().
> - Clarify the error path and the potential for memory corruption in 
>   the commit description.
> - Remove the blank line in the tag block to comply with kernel script 
>   requirements.
> 
>  drivers/iio/industrialio-trigger.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..7f53e2a5a101 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -576,7 +576,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  
>  	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
>  	if (trig->name == NULL)
> -		goto free_descs;
> +		goto free_trig;
>  
>  	INIT_LIST_HEAD(&trig->list);
>  
> @@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  
>  	return trig;
>  
> -free_descs:
> -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  free_trig:
> -	kfree(trig);
> +	put_device(&trig->dev);
>  	return NULL;
>  }
>  

