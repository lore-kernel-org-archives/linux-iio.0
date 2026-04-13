Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203223C13F5
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083821; cv=none; b=g9jd6GN9EbnfW+3PUne2nq2Ho8tSp6gY4pi4bsyBNV35blZBYM/rKQz/cC/cCq0Q0l27MJT5doJ6uw0D2Lx+rYjfJQyKyaMUjdcMyU2WUwXrjdvbYTlHa+li6Wz7CLVdq6XjeEV3FDZYm0GWS3Dmw1bw49v4ipK75mtAWZaZNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083821; c=relaxed/simple;
	bh=mgeEoe6AtB49kywapoFP3GPBJeS2SOQhv89gRBsFD7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prd0ae8z7XSPrY2NsNHbr5l8pBCvGLDavKgGTgdVFap0sgvDfR2k6WparDomHrh8Wu/B7LpGnEFnr05dx11t5JUVhBtdcrB9PJ+wK27CdOnilUcdpwY+MOoJwSTygVPzr7T5sosV1q9nU8KoL7XzEymQpYB062LPhbyuYeUmR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfIQKpiA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfIQKpiA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so2956981f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083818; x=1776688618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+X/xGhJvuBPL4tYv8hEPxNZ5/GB2yObANZwMOQLBRg=;
        b=YfIQKpiAMYRpoekTXJOt6MGKYr2YUr8BP5kqJjhds1DM6/xAmWvcjj5kp4K/2X3pDM
         tBNy3nmdrjjf+Edt6IajkCEJONqaNA1fqfiLDugk57fRC9gxE+8zdqaW6KUzt9xAwESx
         bLH6kMTWKbDsQbT6+pY1HX64AEPzgKWolRfP9pZ0JyLCtlhZk7qzA72l3+RZLn0bpTc9
         yjGq3rqOyEPuEz2ewd+CoimMXjLGn5T/jFEQstwIePKLrYVDhLkX6C7/kXlGqyR8IzQb
         dh6Xy9qjFWqEzSiMjDOZ6tzh5Be3Z63+SoI0DiGiJNQMcC8ey7/Yh07sA9fRxuMjvwYK
         JrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083818; x=1776688618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+X/xGhJvuBPL4tYv8hEPxNZ5/GB2yObANZwMOQLBRg=;
        b=g1zzp/f8YOLdFAb7TFNwa0Kr2bEUKZtfrGpz7EUYfKig6FzYEt2zJNphJGNYTqEYxV
         dQm08a/3FKpVbr30SEXoq4jfNHoN6Tq3M5DicHf1JWGdfW+kA+D8dqqE8Ob9hLBqaZ9Y
         L6YML0L11RyC92OFYESjoYMa4zTF0Dbc1hma1QPhtsGJTxY9vu5xzHRbci5ruv8Ukptv
         4ZGlHIc3FV6Upm9FcpFPZoQEi7ge1HyRM3C+g6DRinDBj06VXsunj8jTYfgwvMJYhp9f
         EBgNmaB1Of8pCjyc7Ld+oc7DSS2a9yj/TVq0GEGBWNBUzZgCaSsGSej8AaCHUUwmGEMQ
         imPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uVtopmXNzNxaBQeV+Uz3iY7YsuqmukUzDjKRJFhyn+uglCjdh65uS1XSsy7IAZsXaJDj65FcZ4c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwNRQm8FfYvBpphIxvmLLiHPoxy2CXWMmDVFtTc/4ylhiuBgR
	5kROQkyFCzbLVwxoYvzocwaJwvdzbPdC3FvHyF/0lyMOGGlHNgYEMw2o
X-Gm-Gg: AeBDieslS2BumrwMVE0ZQ7E+1L9gK1Ced9m22FlimzdLUCeSWwP4t7/nI5qRMn6ld8D
	1majH6nrHG2R5TNGbBImKLr8+flymf8lJz7S9V9EBwFYjvi0tIkE/gAgudTN+JYSK9oYy7KB1xd
	QncBoBgYmxYwDSNdtrHND5baGhRzeOH7z82wD5s6x3QYAQf4ohxBf9Y4plghMCz8NgHY973EMoL
	W9g8NvbJvqBJ9R1qTjTCcedzuLqi6hWT813asVoGIOSJQ+KJOevrWRgClnbIbEpwyPI4L0VgYEZ
	2oEFSVTrcRY5fq5qpGV4mzO6G6ivNjk8VYPsvRFLgiMV/+nz6EbDGef454/E36NdPYTXiwW4FVR
	mr+8AuXQ7y+iYNxrUKnVBuQhjlAwosaWFi11MTbRHJqw2soKWi2tkKijw1laGKEHQcAaHnRX+kb
	AQ1FYSY1sKoq85hzIEYUg=
X-Received: by 2002:a5d:64e6:0:b0:43d:7887:9f36 with SMTP id ffacd0b85a97d-43d7887a15fmr5464550f8f.2.1776083818336;
        Mon, 13 Apr 2026 05:36:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6a1203b8sm28098391f8f.16.2026.04.13.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:36:57 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:36:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: Fix refcount leak in
 viio_trigger_alloc() error path
Message-ID: <adzjZvCm0enRw5cW@stanley.mountain>
References: <20260413115656.2789049-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413115656.2789049-1-lgs201920130244@gmail.com>

On Mon, Apr 13, 2026 at 07:56:56PM +0800, Guangshuo Li wrote:
> After device_initialize(), the lifetime of the embedded struct device
> is expected to be managed through the device core reference counting.
> 
> In viio_trigger_alloc(), if irq_alloc_descs() or kvasprintf() fails,
> the error path frees trig directly with kfree() rather than releasing
> the device reference with put_device(). This bypasses the normal device
> lifetime rules and may leave the reference count of the embedded struct
> device unbalanced, resulting in a refcount leak and potentially leading
> to a use-after-free.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
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
> v2:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review

No, the issue is that you are working against old code.  This bug
was already fixed a different way upstream.

regards,
dan carpenter

