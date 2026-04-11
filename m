Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467832E6B8
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895683; cv=none; b=KaLT1uVOtdsBSvwKPRK+Rtgw5GvTM6p7p0tx9sEYWL11YaM2OmqeFtjREbKuWE/BPhOHRz+SMaeeVcmUUbRRgYcw6uHO6YriPvZU9e7x3mOWE9nS77fCgSRC+FH2Opj4o+iw2sGFs0BgoNDLw4+9qyBJjXLjVzN76maE1fKAvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895683; c=relaxed/simple;
	bh=vcBjvKGJQYEODT9LGC4wGmOBHIm2sXHhdRxekpKCYUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC/N5AkuALmHGfEH7O/bm9myJYWdZKgrCbOwz+FiaqijJ8xUrxQ8XRTLduZp+bERpe5eSnazaTEExEq2D+QwpQkH/fL+1WYY9t3Hx9zgWlwGvNGv3g2uBDAlOe4dBkCy1LXZQ7ryVqlGlDCWkmVBY3BnB+/5DC4XhHtdnIgHv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZBZIM5N; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZBZIM5N"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so157575e9.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775895681; x=1776500481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiA2W6ra0oBmucOD+pQuH4lyD1NksJUw1bImSOanyJE=;
        b=hZBZIM5NJOSF6X4LQZfSmPudh6ZP/NaUCYDgevsN/TPzKFfObKLie5ztgp9KTyZylJ
         Snl4wJ3BWuIlauD3PgoIXy7Pa3bEANsGDyNEXuTEnrMNkSfonRkHHBPG41iFl13RTyWh
         d2Im2A7P3y3FfrNsad4ai9PwSxjhDjv7DKXTwMdHu7hJs8LSFe5f1v8JegL8elFaQL1y
         Fu8qRvQC8xLGTbr/HQVuytJAIcTdjMFObKrC9qmlaRWuAFNQMNfMC1922PzfaKR+Ux4X
         Tu/0IdJYIj/4lU1jqovt4XjkiMYLdirV4CY8dFB5ePy6S8cBl1PaWVveQxVzqODu2U/3
         pgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775895681; x=1776500481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiA2W6ra0oBmucOD+pQuH4lyD1NksJUw1bImSOanyJE=;
        b=qA2A47DGo7oxO093qZmmOY2l+mMrVdCTBtX/AZ9xMiVOd71aU+k9OkPlRZ4d8Bshq9
         ih8DmkDKb/d6uz/MlcRfOdqtslDw6GxCdoK0DvPdpbopUHFqgF1j2hUMCsXgjQMxTjYM
         0qrxRhlNW86eRR1rmv/r+5XgpiGCxFaOuDE0wsqZGnNgGLLVYVJnEwcDmc1CQgGeb7mp
         N4RBdgW81kg1j8fFaMpHj6oWOnbXyQDQfy5AGFbigDmQPvZB544q6zlwGU59q7CaZr8c
         5GpXBWZSXYqdZq5hcWBAehQYmOb8Snu6z22LceGi1t/lYHkFuR63lIOSEhnh/lEHdNgB
         f6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXYhUHD35PJCiS68EQ43D/g3KW5r4sd2h4PORgxe3DF5zDucj8IYFW5bZQt0CEaXe+y80tZ21oMtjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcAqhsYBE6Vs6xdK7Hfg+F5vgkrmFPI9vnxy/4rSaFZ6OukvQZ
	Ca6k/IWwR3go4y8AaiPXob2p22uAlfVOWhFPMo6KSfAWGGYqiqy3rSn+
X-Gm-Gg: AeBDievTsQYr6MIykKZFmxyZ11BZ2Pdh1BI6RXtlk8oFo3lLV/4wYekEF9iJG/zk2Mt
	PVxKbyp6zE/f6T4c8FM3+d8i6khJLq3NyQm+/Qhjnnj+0LaBX9prsby60RzAxIVIgb1q8Hwq8TV
	Cu7IwCWX9+WRqgXc329bxqEU8S2QXOUosAX6hEihUq8ejUE/JC9tkXNt+/EXBO1aJACWqD2y7ZI
	wtzH09xxMI3ihxoFZixkrFLSnWPXFEBm2uNIwgqzCOmeZmTqlyJD7ixqWHzHwbrLNhMviG+Jcu/
	OUdlFJ02Fm8A12UOE3N5PugD77OueT9Zbz1b9vPXvNoXPUR2aVlMdco8HcSMwsVjoYe7uWYgBXN
	z8La4tEZf4eWdutSbTdMEpPNDQkmpm502/qtMLxXkOrFYwXbjdLR5xOzPsECSGR4wAyn6LtOv87
	HVj4f/Z8EHvG6x9lZREIPMAlXTzkbrVA==
X-Received: by 2002:a05:600c:64c4:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488d686c04fmr73932525e9.21.1775895680711;
        Sat, 11 Apr 2026 01:21:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ef00sm147467045e9.5.2026.04.11.01.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:21:19 -0700 (PDT)
Date: Sat, 11 Apr 2026 11:21:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix refcount leak in viio_trigger_alloc()
 error path
Message-ID: <adoEfbDRO_ZsIUx6@stanley.mountain>
References: <20260411080435.2125626-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411080435.2125626-1-lgs201920130244@gmail.com>

On Sat, Apr 11, 2026 at 04:04:35PM +0800, Guangshuo Li wrote:
> After device_initialize(), the lifetime of the embedded struct device
  ^^^^^
The commit message says after but you're changing the before.

> is expected to be managed through the device core reference counting.
> 
> In viio_trigger_alloc(), if irq_alloc_descs() or kvasprintf() fails,
> the error path frees trig directly with kfree() rather than releasing
> the device reference with put_device(). This bypasses the normal device
> lifetime rules and may leave the reference count of the embedded struct
> device unbalanced, resulting in a refcount leak and potentially leading
> to a use-after-free.
> 
> Fix this by using put_device(&trig->dev) in the failure path and let
> iio_trig_release() handle the final cleanup. Also update the subirq_base
> check in iio_trig_release() to test for >= 0, so that a negative error
> code from irq_alloc_descs() is not treated as a valid IRQ descriptor
> base during cleanup.
> 
> Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/industrialio-trigger.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..ab544976018f 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -509,7 +509,7 @@ static void iio_trig_release(struct device *device)
>  	struct iio_trigger *trig = to_iio_trigger(device);
>  	int i;
>  
> -	if (trig->subirq_base) {
> +	if (trig->subirq_base >= 0) {
>  		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>  			irq_modify_status(trig->subirq_base + i,
>  					  IRQ_NOAUTOEN,
> @@ -572,11 +572,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
>  					    0);
>  	if (trig->subirq_base < 0)
> -		goto free_trig;
> +		goto err_put;
>  
>  	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
>  	if (trig->name == NULL)
> -		goto free_descs;
> +		goto err_put;

At this point we haven't done:

	trig->dev.type = &iio_trig_type;
or
	device_initialize(&trig->dev);

So the original code is fine and the new code just introduces memory
leaks.

regards,
dan carpenter

>  
>  	INIT_LIST_HEAD(&trig->list);
>  
> @@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  
>  	return trig;
>  
> -free_descs:
> -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> -free_trig:
> -	kfree(trig);
> +err_put:
> +	put_device(&trig->dev);
>  	return NULL;
>  }
