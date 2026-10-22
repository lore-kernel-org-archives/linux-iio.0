Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691512;
	b=iDwigN6AmnvGmwYxE28SHXEk1a+P6e1AsvbHsXQapfpfcvCtlGUS5VomRJtknY4asgOg
	 /RBaCW2Rl2pi2hJBR2vu5S7tRJsA8xUx1s2qnD9eSqSCF0Q2FlBwWK3I6qlhiwtOKNeUU
	 dGRm/EL2BY/hUsPkuHqk7j3T6zFv2eNTaeGR+PRczOKx1SvcznwMU+VJncVQ8H3ZWX+7F
	 ZwL6uEYluN/Q1oOWMAS8BL1kjZqfDQGo0iIBe1pXYXplyp6Ds4WwEh1jz9Cu7Clknt7ZP
	 er1aK3cz3ooHKDVWegYcRaA3WZADtjMWRysBNArPJ4BSyHQ/+XTKWkvh29l/bw51xyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=r2q+iyvuVlDeIlWZJGrX+HSjqNXjGEe/i8h2neh/mWE=;
	b=TEhKAnmLh3XjTdBT3HWG0dp9a/U84BkwimBJRExgT/mZOAjrWLKTLWVngA5BDXuTxEy+
	 tZHxfaFrdU+r/mqqjFap183BQlLs4dmGnLmk7GcxKu93RK9o6fObw60Z/qsw5lVcV2FHV
	 WYLLIvifBsEEBfbZYErdjMr/jqL+jOLE10Ea2gAH0YyTf4bXDkeox7lrMyVEjabJP/uVz
	 i0hBgPbjHWcIeVR7xKzMIwSMkRA3L1EU2uwUfjKfuSRIer16sXlsrJqbW3BGdcyJBz+yy
	 IlanMFiwOsPMUFQc7Yj6wz8TnnFvST/JblVztM5v7oAe6PTztMGvWeoTRyyyPJ4g18w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Mpa/3iSh";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4B606A319
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 17:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26F4B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Mpa/3iSh
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3550c917fd3so124961eec.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792691506; x=1793296306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r2q+iyvuVlDeIlWZJGrX+HSjqNXjGEe/i8h2neh/mWE=;
        b=Mpa/3iShcpdplVyV4AD4tedhbLcu8Y/44+UFs5RAQEPeTPcdHzGpgxVv18u/t2KG0k
         Gf0lN3PdVbnKUaTU/Z4O5TdUtlDHJ8QEmhbsLGXYNQLMdOi3i2sPvBsPveMlI6ymkIsT
         lYQy7sfpWTPaE8CyKu8k0AJ9Lew3Zrv4KvxtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691506; x=1793296306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r2q+iyvuVlDeIlWZJGrX+HSjqNXjGEe/i8h2neh/mWE=;
        b=fXSdmFkFWE++CP1OuD16hRZbOiaBBiZEPJYxCrstqV8fLn/dRB02h3B3PoLQjfXjKj
         PDsXqurzEDcAPgGiJWgI0Xfby9HpgIFDA9aTZkIzikB+cc1ZA1mbAtmY0jQrQhafA+G8
         PnGc2E/QJjRKu1e7/jy92tIRFAWLfmLt+dnza7ddTkksKZ9igdgzRkz6N75Oee51ZGVO
         oQ6Ruqo3yHdkV9yrYed4OwOwP6O0RDtQNxnQETYZ6viLKS3Rw2AEcfhI7/4JEWKeIZs2
         4WOMPxQ0qLJ9B16M6a03KeDwb4D2kaTZcbu9BGWXMrn3MmSBrF95PP65EyqcLozxoBGT
         nr2Q==
X-Forwarded-Encrypted: i=1; AKwUvByhxegRXXznzFh9bJ8iz73hobDEWA2LhUUOWSiPzez09K9woQcIrCELjAT7ZLHnqPKO0rLNOuEQaTA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFJn3wgOEoimmAuGIr6A3th8CgRTBJL+e8+Hocrzn28HrNGKTu
	ZJQjvQQI30777G3BVZ6Y/2y+Ws2dH/nfrVX79W3L1sVP1bjCitiqjY2R9y5MMxKqfw==
X-Gm-Gg: AYBFou2nDVrGjMz43HTm+oFcseqJdnIjBv98jPXJzB5EAhkt5aTtUzoZpYlhUH1BMe0
	XeBP/H9QcQDu3VsK9QxcmIYiQvsawP022l7dyp5SKvNC7vuWz8CaNwxnUnq6oXxueQPBkRxr80+
	5Lyp4UQdCvfzvvqsD4eBOv/88FSWACcLSiJHRe1w3jDRhD6GvUmnU5iHz7NNNb9sbYc6fPYdaGJ
	JUHRKsVudAiaw772NlL85T2XqCZeIwHMJRBjuPKd67tU118UnUhzjdDuonk1WUjUM1Qe6rXgh6T
	d6MJ6LimG4CsBkpg7DgBu/vxMuvdCUat3a988gvLeCC3cr34ns0rj6QKALVcCRt1dMQeJ4zLxKO
	WXbl2sAfChCYKqAqzRsSGsRnS93nxxXWP9eBvqGDyFaAx8omC5jM7T06jsh+/uzdgTiKcz6fmfW
	0BOagyXXVrzAl0Qa0ip7w8KoEwRcpx05kfm4T/Hy9NmJCLK5LJpYJPjETsgaE2hrAZlpxk77LVd
	KzFdyRTOdCLFccLmWw9ZLwTc6aF8nX0NaJdw+RHTbHBhRbHKT+ReAA6GgDNDVJ+w2xPsp/rVuES
	PvXKDwt6KCYncsrKSA4=
X-Received: by 2002:a05:7300:fb83:b0:359:8492:2107 with SMTP id 5a478bee46e88-3674c43c286mr11658686eec.10.1792691506190;
        Thu, 22 Oct 2026 10:51:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4a1d:784c:3fc4:37a2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-367405ed295sm19625095eec.9.2026.10.22.10.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:51:45 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:51:43 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] iio: accel: fxls8962af: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <atpNLy6Tb46hroHf@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <20261021165858.v2.1.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
 <atmy2Db_DlLUuOeC@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atmy2Db_DlLUuOeC@ashevche-desk.local>

On Thu, Oct 22, 2026 at 09:53:12AM +0300, Andy Shevchenko wrote:
> On Wed, Oct 21, 2026 at 04:57:02PM -0700, Brian Norris wrote:
> > This driver propagates the return value of pm_runtime_put_autosuspend(),
> > which is not particularly useful.
> > 
> > Returning an error code from pm_runtime_put_autosuspend() merely means
> > that it has not queued up a timer or work item to check whether or not
> > the device can be suspended and there are many perfectly valid
> > situations in which that can happen, like after writing "on" to the
> > device's runtime PM "control" attribute in sysfs for one example.
> > 
> > For this reason, modify this driver to simply discard the
> > pm_runtime_put_autosuspend() return value, and inline the
> > fxls8962af_power_off/on() helpers to their callsites, as they're even
> > more trivial now.
> > 
> > This will facilitate a planned change of the
> > pm_runtime_put_autosuspend() return type to void in the future, similar
> > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> > type to void").
> 
> ...
> 
> > static int fxls8962af_get_out(struct fxls8962af_data *data,
> 
> >  
> >  	is_active = fxls8962af_is_active(data);
> 
> >  	if (!is_active) {
> 
> Why do we have this check at all?

Frankly, I don't know. It seems logically wrong; you shouldn't even be
reading device registers without first grabbing a runtime PM reference.

But I'm also loathe to go tweak a bunch of driver-specific details I'm
completely unfamiliar with, when my main purpose is extremely simple --
to stop checking one return code.

All in all, I think this is beside the point, and I'd rather not try to
address it in this series. For one, even if I try to address it, there's
more chance of regressions that will distract from my purpose.

> > -		ret = fxls8962af_power_on(data);
> > -		if (ret)
> > +		ret = pm_runtime_resume_and_get(dev);
> > +		if (ret) {
> > +			dev_err(dev, "failed to power on: %d\n", ret);
> >  			return ret;
> > +		}
> >  	}
> >  
> >  	ret = regmap_bulk_read(data->regmap, chan->address,
> >  			       &raw_val, sizeof(data->lower_thres));
> >  
> >  	if (!is_active)
> > -		fxls8962af_power_off(data);
> > +		pm_runtime_put_autosuspend(dev);
> 
> If it's active my understanding that runtime PM keeps device already resumed,
> so these two will be just a reference counting calls, no?

Right. I don't really see the point.

Brian
