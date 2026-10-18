Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF239A7F6;
	Sun, 18 Oct 2026 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792367116; cv=none; b=XS/m93YMb/k2GVLK0J0kSZoZe1lKW1Tdd0ElP437K892MHz2dYjlagxJDF+jybLkns3wNeGZgMozJAQy29q06Nh961zZfl8B+imh98OlITaj++u05FiqZskMtRRUowPxp+oECDXSs46yDjX8FL3q2CvFXBwZRPdZMZNDFDMvfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792367116; c=relaxed/simple;
	bh=LM7c0H2c7tCQMEuCtzVlJKszmWyqyAaE77EzKZquQ04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWaDlwv9mi3Y4jiIDL3afKNOGd5/4G0iaJjbe4hDQNesmn9iP5FPxBa+ZPA9XpXcgg15AKGyLb1zkfJfXfHLe94Sekj++Oi0noGLt5PMyUBb2/pNdVNQrSqrkFGuc1GcRuA1tpoJAkGE1IzbZY6z7i4Wnv7BA3UgXrAzvo35+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRhYcRE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRhYcRE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4FD1F000C4;
	Sun, 18 Oct 2026 23:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792367115;
	bh=fXPvQXd0lkDK6wKKARZ/K9s2fytmVFJ734ryxD1PjQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LRhYcRE9QwXhqv9RXutoCMJ5WQi3lGLUsubqOJUe6bd2+lBX5ae207UeWMYmY4Elp
	 J6VYgendJmlmxjEGbKwNe7N3oblLvzOC7+Jm4BbVwIps2CUWHw/9NlhYQVc3d2jCKe
	 sDtYqHIatkjuZzYM93j418x/CgKhWUx39AkZnpVHyufvvD9fBAZ/NrQUwtik/Xz2Yz
	 +MecAjoV6FlQ5i3BpJx7P35VEvyztC11BSdclN6BJc7WQ/dtAzN0LKRhfbyxQUKWgd
	 0JK5LMBc9rHVderCXcD1wU/+MrbbaABXw70iPH3bocnosGPmlUcV1PYwj5Wvigm5QO
	 SWQb5pxHfeIYQ==
Date: Mon, 19 Oct 2026 00:45:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Marco Elver
 <elver@google.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on
 mutex helpers
Message-ID: <20261019004509.68409863@jic23-hlaptop>
In-Reply-To: <asIRkK-uUz4FKQBN@ashevche-desk.local>
References: <20261003214516.128573-1-zoone.rupert@gmail.com>
	<asIRkK-uUz4FKQBN@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Oct 2026 11:42:56 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Oct 04, 2026 at 12:45:16AM +0300, Rupesh Majhi wrote:
> > The __acquires() and __releases() on adc5_gen3_mutex_lock() and
> > adc5_gen3_mutex_unlock() name adc, a local declared in the body. With
> > context analysis enabled for this file, the build fails:
> > 
> >   error: use of undeclared identifier 'adc'
> > 
> > The lock and unlock are split across these two helpers for the ADC_TM
> > driver, so mark them __context_unsafe() instead.  
> 
> Doesn't sound right to me. The __acquires() and __releases() IIRC are sparse
> annotations. If clang has something special, it needs to be addressed in
> the compiler-clang.h, no?
> 
It's in compiler-context-analysis.h and for now I believe is clang
only.  Reuses the older sparse definitions. I think the intent is to avoid
churn.

I currently have no idea if this is the right fix. The only users
today are places where a lock is intentionally skipped.

+CC Marco and Bart and putting back the patch content for context.

> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index c68c6c5f6aca..6a3cabedf4e8 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -663,7 +663,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>  }
>  
>  void adc5_gen3_mutex_lock(struct device *dev)
> -	__acquires(&adc->lock)
> +	__context_unsafe(/* returns with adc->lock held */)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>  	struct adc5_chip *adc = iio_priv(indio_dev);
> @@ -673,7 +673,7 @@ void adc5_gen3_mutex_lock(struct device *dev)
>  EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
>  
>  void adc5_gen3_mutex_unlock(struct device *dev)
> -	__releases(&adc->lock)
> +	__context_unsafe(/* releases adc->lock */)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>  	struct adc5_chip *adc = iio_priv(indio_dev);
> 
> base-commit: 04434a1d0f311d76b1f15fa987918b471a0b8c6a
> -- 
> 2.43.0





