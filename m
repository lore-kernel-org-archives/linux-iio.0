Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143E33C502
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581203; cv=none; b=tB0tu4tXfGsha1PmoE3pvMhW6mP4eNhkOl+z7NJ9hz8ZgK8RfPZTRfjMPNuhG0cWEn3WHlzzZ17PYJeImT1poQ1yqnZS+Y0Q5u07xeHXZJoA9Hc5R0fHSYh8sZWzF6ZU6XXsYLFZ8BHBeHE+ritTS/qeGhy7cNqvZSUQUkSnL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581203; c=relaxed/simple;
	bh=4P+AxRu+aP0P/lZrxKgWWxmE5YAZHis7WqiS/V5axvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lW/41rmaBS+2egPAV6ckwilHjJyvKw+MhtjMFceLr68+XgDT6W0AX3UnhNVHw8/W7HZPhdq8w6+0mVLFvzS2CCo5cElEhfq+bS8aCoyjxobrtyvaNiwDDavQBLzfs6lLqBA1Ved91gXuAvLx4rFVV7Xxph8YtdVTL+rv1iW8Uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNflKD2c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNflKD2c"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4926fe5be4bso11899135e9.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581200; x=1783186000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDQP8mnP+Jn71ABEIP8xYOjy07PIL00ezJXXjBMJLS0=;
        b=nNflKD2cbAh8+nXjj8nFF5N7LBT8EL1im+xl2YmyrdJFtugAIy+fj9OVGZf1JROvQA
         q8kKMUBuaAZEaqKSlSsRZtUKMNz9qwFqP/tdtzl4T1qZ4ZLFd4+6cQaP6Sbr5XnGBx6N
         wYBJhK68ob5P3wuWW++AuJfG8WHnqvZyVXs+stbT+aoup7DO2ht6XyPy3NeepiQCTPbR
         KIAbamcdSGJd3k857v7rV0Vjr7uk1j/4DV0gX6ExjWqa7nIi8vnB7wQL+yQ6VjmqVka1
         /RJgs9Xv1z+0Ng+UIuDPoGU9a2BF3QP04stBq1qQsrVEYXDbxkR6vy/ACXOk1skBoTdD
         P5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581200; x=1783186000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDQP8mnP+Jn71ABEIP8xYOjy07PIL00ezJXXjBMJLS0=;
        b=Rnzo3vJi+ooJiYMZU647WwMXcd1QWPYtqGbW+fUXHE/epHm2SwTy5KPWpwiu5VR2Uj
         3zhubKMYuPTiYJB3N0qFqlyNbTtaxEaLULT4qdoPYCO/n0Lq+XleXI4joAPI9bzKaIT9
         YbX9tnf3AhMrlwWq6Z48PMO+YTq8LUEl897glmgBdfr+lThFeZFL9/fvXos4F8YmLKza
         orKZ54MkXrI9ZU7uEWQhWrv73tQYSF2ZBkZgn8Ci1ZOelKL866SIdOvc6EW+JzK/yaZX
         Ut8liai8BtUhsv29z8xumRLbncf3Pe5VH/0zuWZHafWm2rNtGOmaxESA0LSW2VIRHYj/
         Y7jA==
X-Forwarded-Encrypted: i=1; AFNElJ9Mrql9HVQs1hDcb/uTKB05dtNWoLoS7HxScvVvFLUNh57zWR5ggYqwktqdTL0e+ITIh/lLJBxX5Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ymaKG+ncF7Bbu2JNkXvHG5GiUGT6ervmLh9O9N2cuI6F7he9
	gx9lv/B4/j9u/h0D0gE2pNsANadi50RoCyoW61cyi1plabyJcP+v+N/E
X-Gm-Gg: AfdE7cnxkCQckznCuaOc01QqbswQS1dcrmPfycP8kb83a5yvDrpSSFs8R5jwc4CEkee
	Zot90pF0rXQb+kXA1iRTv5Hasj/7XtNQn+Vlcgpgbuie4Hjtbyoyh0Et19yz2iBCumzlbdLNpcv
	f5MPryfRHoTjFMH1jTFJ2jOjw8JIt+Cu27GXKYUCCp6XnLlgnpaykWFwzyd/eojNN5/3tILW8H9
	dcLUk7cnGmjDlX/D6HuBAMwDPSvMtr9IApQ0gVqOQU8FfeSZnMOWX7qlQwUorvo8YisMhUVfkig
	EpPDjPq31u1qA0n+m4bqkE3m1qQ56fx81zi0faAsMEaHnxoXiI945Ho8IRB4nbUtIznVVORTR/O
	8MqASlJStLcnZHYxc8tIPt90Qt0TbXSWfjcW25TWNr509p7k158WKSzs+2ZfttQ1FmwQ8Q756dL
	+W2fhljRh0/N01g0Yu/rnU/DhjM2mgUQNV+7N3d2IL9Z679jCUMRZZXgYWoZqOrnRc3CQ+y+msQ
	27qjxvFObAS3O2+IHyOuCktCZ5PaLnXoqR5NneHFW56QJTqKXFoib0Hy7QA6mzVEoiOEgiSvUeQ
	iEtyPjYyae1K4U5A
X-Received: by 2002:a05:600c:4e0b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4926fc78e30mr87904095e9.24.1782581200242;
        Sat, 27 Jun 2026 10:26:40 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269071c9esm170020025e9.9.2026.06.27.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:26:40 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:26:38 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] iio: adc: ad7779: Initialize completion before
 requesting IRQ
Message-ID: <20260627192638.5623df0e@systembl0wer>
In-Reply-To: <20260627112205.31409-1-mokshpanicker.7@gmail.com>
References: <20260627112205.31409-1-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 11:22:05 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> init_completion() is called after devm_request_irq() in
> ad7779_setup_trigger(). If the IRQ fires before init_completion()
> runs, the completion is in an undefined state.

This is probably impossible, as devm_request_irq() is called with
IRQF_NO_AUTOEN as a parameter, therefore IRQs are enabled manually
in the code.

> Move init_completion() before devm_request_irq() to ensure the
> completion is ready before the IRQ handler can signal it.
> 
> Fixes: c9a3f8c7bfcb ("drivers: iio: adc: add support for ad777x family")
> Cc: stable@vger.kernel.org
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---
>  drivers/iio/adc/ad7779.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index 695cc79e78da..db8f5f4c6d6a 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -838,6 +838,8 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
>  	st->trig->ops = &ad7779_trigger_ops;
>  
>  	iio_trigger_set_drvdata(st->trig, st);
> +	init_completion(&st->completion);

Is there really any point in having this when st->completion isn't
used anywhere in the driver? I'd rather be for removing this function
call and the struct completion from struct ad7779_state.

> +
>  
>  	ret = devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_poll,
>  			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,

Unrelated, however the dev_err_probe() call below this is unnecessary,
as devm_request_irq already returns a dev_err_probe on failure. Consider
sending a patch for this as well.

-- 
Kind regards

CJD
