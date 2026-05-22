Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E11371053;
	Fri, 22 May 2026 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451346; cv=none; b=k0EdCf7pA7tlJnHfbw9NcDzzGsNvk2dIFairbhc/zi+097kXPp/9A/pFlCk9Yo16pz06OTODDyRd4lk1LGDpq/FQjQGxLoZLEUk3uoy6NNmqI3daU9LlHRBRutT7dZ+KrtT8XAzPQHiI8VyIvtpLvx3kaLJHd8VOhPaomA36E7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451346; c=relaxed/simple;
	bh=GB/iR5SZPcU8jIidnt2+DwYwlVvnaGjbgKLSfjdW5ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ2C1bVJVo7DAPHEYTAuOyoqxMfg+kfrYtzKStFVRlmgiMOgZ14dVtr4NbyVtewwf7xc3RVqd9TZfgbKz9gGvT9X6vkmu7wP58KIFmlx3GRbw6Ox789l0Hrx4QnLlLTjaOZqiDkeMcbA1Vbgpu+343JjRxbDQ9BpXPQj5xlDFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQOcGrZa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQOcGrZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B4E1F00A3D;
	Fri, 22 May 2026 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451345;
	bh=RuDz2lvNHrdPf9klrASZ06dyn42LN/h1CtpTT36GXQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CQOcGrZan5bMAlQOrgvLCAEWoEaCDspQYuhi5gd5EKFTtIivtnSERTTEVTFaeHuNB
	 GkJSJLvoXfO2XNLKnlEXliY0tzrqNqgrUOYbrWrpb8EgTXWYFmyXiddfOKabLa/F5p
	 HBBBSAsB4RkjRksKJvuaBXfGtwV4rfsztYlpGwF8vbz4YyuZfY3JE3vj+dYiRFA1wJ
	 szI8yCE+wf+LNbHqnN3h/lzcn1cGj8hOhPn6HLL/c03fv4kGriuAu0K8n6Y9u29t+5
	 Nqt00PBIHBOmaqEnMstIuCS/hl3Ho0tepuPJVbuMLcYvuGwjQIu0OME6l7DSI+Z/uE
	 eOZaaHqzp4xlw==
Date: Fri, 22 May 2026 13:02:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: "linux-iio" <linux-iio@vger.kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: trigger: fix memory leak in
 viio_trigger_alloc()
Message-ID: <20260522130218.4f34ff65@jic23-huawei>
In-Reply-To: <19e4f819ed9.2157dac799522.5155742748768717789@zohomail.in>
References: <19e4f819ed9.2157dac799522.5155742748768717789@zohomail.in>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 17:15:55 +0530
Ashwin Gundarapu <linuxuser509@zohomail.in> wrote:

> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Fri, 22 May 2026 17:11:00 +0530
> Subject: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()
> 
> Separate error paths for before/after device_initialize().
> 
> The free_trig label was used for both early errors (before
> device_initialize) and late errors (after device_initialize).
> 
> Replace the unified kfree() with:
> - kfree() for early errors (free_trig)
> - put_device() for late errors (free_descs)
> 
> This prevents put_device() on an uninitialized device and
> ensures proper reference counting cleanup.
> 
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
Even for a simple fix, wait longer between iterations.

As I just replied to v1, your tree is old. This won't even apply
and the bug has been correctly fixed in upstream.

> ---
>  drivers/iio/industrialio-trigger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 9c72e7ae996c..39208c65e6c1 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -597,9 +597,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  
>  free_descs:
>  	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> -free_trig:
>  	put_device(&trig->dev);
>  	return NULL;
> +free_trig:
> +	kfree(trig);
> +	return NULL;
>  }
>  
>  /**
> --
> 2.43.0
> 
> 
> 

