Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FD4749F0
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736226; cv=none; b=STIKYktqGmbJyv7F36VJ8LVJAzT4z8F1cRidhJ/9eUEgkS4feNtSC/Ej0WcMEUkyNs9swbDJSc34iEzv5uDgPwGoebd2XI/IsPgLNVkI1WHhVRJUa0PLuRD8wijMtSjsTfbx3KXQfn9pVcQXMeKO82xepYYI3iDDEgfREJygaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736226; c=relaxed/simple;
	bh=1otvit2ICqX01VZfuWeoTPRah7RXDLpRfiXbAwprmwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9ZKv5x8F4pbZyoZMOfIt2VjXM9ToU63rPNlaNNak31aopHE+vqIBNNk463upY1zgVW2REWrYn0IW8Rf/2FPfeU2cNOnFpNFjHu+OOLCRhz4frw7DYdew9ilefkVk8XBQ27UAjQkfcz5iZTADSl3Nxr7qSR44eHoI6/Zccy0HmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJZ7PWLi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJZ7PWLi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cca0c5799eso106580045ad.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784736224; x=1785341024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+nkpUqQJix6KKXMhqyzdYJniOtozme3lGhsWfFwbkPQ=;
        b=LJZ7PWLi29v0vI/XkIqoXIQOZ13tjJtF7EqCFKuRPxNWKLM95eH+EPR5qs/TzD0i3S
         UU+lcq6QBYoqoRHC417NKxjan18qgpweE55hMowUbVJ+f95vTE8zDHNDsz8akzVkG+bT
         ajGZDdy/7gUehd+0lWlvg6efVmxwC8bZGbWM9IOfB38yf4crljZ4SPuBHLRoMt+GVY+z
         WVITc9JHM12X0z1bqz7xlzAaMDDq94sxv534nJbo/D5aoOWdl3Fq0A31XsWylUDtb4Cs
         Xe5t19Jc0QgTjYc+5RJ5KBmNxeeLFXPSMsFY0lAdRQ3WS/7IEj0VLwmWtatV15+yL7GA
         BiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784736224; x=1785341024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+nkpUqQJix6KKXMhqyzdYJniOtozme3lGhsWfFwbkPQ=;
        b=cMLNdt/LJjKOVlspCdpdorN/I0/7ONvWGDQhVw7JTlk6pwz/3XEmH99J0zjza1vski
         PF4flsxHaCpTHqMUE8bfXF1jJa8JzG18aiRWGATpB6FX7jDu/yAkkU2kqSMFd3+/9DsZ
         HwRLz+iVeAiG8H18eEJmd9++/1MkCtlOkbx27fStoMctGaCtRcwL5hQ7CHr5WmFSaT7Y
         n3fims4+fQFe9U5wIMEGCcAy/BjZS/A38ml2F7jQb0oS6tCMgz4wV68VMI6EOw4zdERO
         a3+XKGXseklg6bFTs9kRKe+Atx7OqhDZZrIxQRmucwqmvgdLg+NXNaTdT7D3ovtP44oH
         gKaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDmGq4cfGL33HLsORctw1UDr0ExAPp8HlRstfQO5kI8xHBO+IvI8NzovzrbWjsadc5hGtpDiGzwhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0LtNu0RhV3sRUNtx+rpDegLzMgcR0wvwEcCBUppHxf3A0iqA
	+3vcjzPu2aA7g2f8xKFXorT6NKZs6Z+zEI2buLTInvO9A2ApZXV5A2xJ
X-Gm-Gg: AR+sD12WXqbOXWw6uc1j0s4MFBGHQ+K5meWvYE80mBChsRFw1uJQn5+nHS3cSKrxXsN
	yX7ylxfbzUmqYJQAVzqhaoAw39h8VHjSyjZmKNl2YIlWvJTVpAGi43S9Z/DNBo5ZF6XNJWR6mSi
	nx0ABGSWVC64a1QasEzaxdbsKrVXyVWnwhDxaVx0yhVzCtI3+G5V5Tb7e1eFAOQKtnD9PQ//LKj
	toeYtCbAEQQfizMu0Rmd4nxr7S41spUjoeiWwFv2/9ZQBhmzPYZ0PzYOp9jw82BRA8Yy/CJutUV
	+pTxG2nb+q6uG0/VUvG1+a6gkmUzQKy5popSGKu9HIgTYkqDCRC/6siHn3LOhnw1SOic9xgl8XC
	p6t82DcpDY5a7+9z5doi/jyqCli6uTiScKEnGWin0eepu0PqIzDHvYtQ3CdI2JcMoYYi2gue3kT
	qMKDKNW8jmbf7yn6Aftb9G9g==
X-Received: by 2002:a17:90b:568e:b0:38e:673:5d18 with SMTP id 98e67ed59e1d1-38e4b56a0c2mr21959475a91.36.1784736223565;
        Wed, 22 Jul 2026 09:03:43 -0700 (PDT)
Received: from kernel ([103.219.206.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130ce035sm7548395c88.13.2026.07.22.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:03:42 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:33:33 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	jkoolstra@xs4all.nl, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] staging: iio: frequency: ad9832/ad9834: add comment
 explaining do_div usage
Message-ID: <amDp1VPSMF0P6r8T@kernel>
References: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
 <20260722082227.18768-1-raizudeen.kerneldev@gmail.com>
 <20260722104617.000050fa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722104617.000050fa@gmail.com>

On Wed, Jul 22, 2026 at 10:46:17AM +0200, Joshua Crofts wrote:
> On Wed, 22 Jul 2026 13:52:27 +0530
> Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:
> > Previous attempts to change do_div() to div64_ul() were rejected because
> > mclk will always fit within 32 bits for this hardware, making do_div()
> > safe to use.
> > 
> > However, Coccinelle continues to flag this as a false positive. To
> > prevent future developers from submitting unnecessary fixes, add a
> > comment explaining why do_div() is intentionally kept.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > ---
> 
> Please don't send a new version as a reply to the previous version,
> as it can break tooling such as b4 for patch review.
> 
> As for the comment, I think it's good, however I'm not sure whether
> this should be split into two patches, given that this is a small
> change. Andy, what do you think?
> 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index 60c33e10c46f..6d046e9121e2 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -118,6 +118,13 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
> >  {
> >  	u64 freqreg = (u64)fout << AD9832_FREQ_BITS;
> >  
> > +       /*
> > +	* mclk is an unsigned long, which triggers a Coccinelle false positive
> > +	* warning about using do_div() for 64-by-32 division. However, mclk
> > +	* for this hardware will always fit within 32 bits, so do_div() is
> > +	* safe to use here.
> > +	*/
> > +
> 
> Unnecessary blank line here, you want to couple the comment with the
> line that it's describing.
> 
> >  	do_div(freqreg, mclk);
> >  	return freqreg;
> >  }
> > diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> > index 33dfd723923c..8722f3a01cde 100644
> > --- a/drivers/staging/iio/frequency/ad9834.c
> > +++ b/drivers/staging/iio/frequency/ad9834.c
> > @@ -103,6 +103,13 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
> >  {
> >  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
> >  
> > +       /*
> > +	* mclk is an unsigned long, which triggers a Coccinelle false positive
> > +	* warning about using do_div() for 64-by-32 division. However, mclk
> > +	* for this hardware will always fit within 32 bits, so do_div() is
> > +	* safe to use here.
> > +	*/
> > +
> 
> Ditto.
> 
> >  	do_div(freqreg, mclk);
> >  	return freqreg;
> >  }
> 
> 
> 
> -- 
> Kind regards,
> Joshua Crofts

Hi Joshua,
Thanks you for reviewing the patch and for the clarifications.

I understood and will make sure v3 is sent as a new and separate email
thread without in-reply-to header so i doesn't break b4.

Sure, I will remove the unnecessary blank line.

I will hold off sending v3 until I hear from Andy regarding whether this should be split
into two patches or kept as one.

Thanks & regards,
Mohamad Raizudeen
