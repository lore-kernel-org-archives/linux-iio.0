Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A713E63AA
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171760; cv=none; b=LwLvUe8tX3RkOusnP/Z1Oq0j5YWx6/rARkvAyuZpPesU27GqoWNw+LrGUcABInALu5RuXHHyXJILwh8msX70RYHvrvTyzGo1srUrGSEvo96Cint4KH+RkhPNBh7l1GVD/lUG3KQil6Ilt1fBk33uwmD3bOuz2zS1z45QX4N2N2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171760; c=relaxed/simple;
	bh=T+bDo2QrsDmzyawj0e7e+J4d7pMFaswH7o6m8bbf4hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2f4hGdXLF9l7O144WD5v682745+FjVGflNiohA3pfrsHoWmBEDg9XiTD1sniiVQlXs0Rw+AcKyj7R+ElThEDH6xg8qDOBaH5gSxYYy0ZCtZXJjTghZPCvr8hEP7u97UVWQE4e2nnImnRQhwCrLMK22WYaTDzWPHelc+ObwPOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca5FJf3y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca5FJf3y"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488d2079582so50500815e9.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776171758; x=1776776558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/ThIx4+xtrxrBR4kGGwtQo3YXjegxw0z+ZYGF/h5Ro=;
        b=Ca5FJf3yB1+b7vJipBfKXZSqvd9GiI2xzCUoeW0pR2nU3YB3OJ7oTLLAc2fsHnAVbT
         DQxCmjdQpmSfeL937mSU7RerClLEoJIRjeo6QfPKX/j59l6MMYMI3KdXDIzFAReaFDND
         kSIQDrPAkxVtzVgS4J0OUOJdXYGt6S720Dp3MTvSQNIn0tdEETUbcQOFkmHEg7f5Cm1b
         2K1pyQiQhJF2XWfYzRwwz0oQHvl0kIW4PDrImeLFZd5LoSRnwwAiwwKS+TVU3x7CPAkS
         2MMfCfH2saR8K1sy2o6oFadvSorlVu/IB9JP0RHDzlckCr/vcSgg1ZX4OBy0PVbKOE3L
         ILaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171758; x=1776776558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/ThIx4+xtrxrBR4kGGwtQo3YXjegxw0z+ZYGF/h5Ro=;
        b=JxamdLUt6/iruTt1nAOtn8Pi7mcv8t8COJBexEFlyNWMI4SKcCEJOeo/NJ+slxbRwg
         YETg5UyMS44NXY94RxcwC3nPSXkG4/ejnXWa4Sg4Zw78WnHaIB5xUyRVdf8wk582Weoy
         eC9zpykTpfS6akFLSkW/ECJMSSYyA7mMIPSDPQDc/3/r6S4CZtXFxl1/DQHEmloLOoZz
         t7ayRFWgYIukYnXSP3Jx73kF11zHFw0vZMCkvoaAyWKCJKzBln9XigOi0EDd3tXx9WMy
         zSs4nEUz3w1/NdEjSXFzIFDGXV0P6KoRg+We1ahkXISxqInpT5rYpAUb/OnP/kuEBzWr
         ZtnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wFA4oC+2xDyW9RqNepHGwf/rlSXSL2+X1M0v91jhbqzpkswjQKGl/vIsf1TzEpuZL6uh1J1LW5XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFV8gWuQQaL2+qX5b2EZFLFYd0bJUFcnpUelEdM7PZAi1T96ec
	tjzOpywx0REiRisqrenE+c0U5Ur62aO8sYYVpqk2+0UoVpP8VjUigqsj
X-Gm-Gg: AeBDieuxcPQvSdxdmUG3iTXO0fBBl5sLaqwXTRYx0fmErdHqMmO6lEZvqRA6ffnyIMq
	N8trIqeSdBK7oBMxOhTQc/8j2eFs4gSddy2SYN9MOt4mKxgEzso9JbsdKXzQspsUiMETpW8NIde
	KFe8Z2BI/osTQm9RkSmixNTPhhYnxjoSVno3SHvKVKGFktFHVIzzXKo7fUGAQa7TPe9FJGl61yU
	/LMtnd/rKHYNbU48xsfRrvBH1+rydadPUeuUba8cl/b/oJXRcCMCC7v5VYmX1SCLxSO9b8WUYWz
	kCNvpjUc1HPnT+oF8NDKcp7k7YXHoVwwRdmzoj1nCoa8Swsneej0bhMCwZTmSsvLr52ifkSN95T
	MZP9TIDvda5LhftZ0EBMvw44L5GgKo28c1Ec6a+zCApuJB7JqfMkRm7IAczWPTdCxvjXjq4oXh5
	j6O3f+Ik7I1NLHEdb5Ectjr8iWbo25eStDQhsf
X-Received: by 2002:a05:600c:a311:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488d68607fbmr176523385e9.20.1776171757537;
        Tue, 14 Apr 2026 06:02:37 -0700 (PDT)
Received: from localhost (hf33.n1.ips.mtn.co.ug. [41.210.143.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d97c65sm122528565e9.6.2026.04.14.06.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:02:35 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:02:30 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: frequency: ad9832: simplify bitwise math
Message-ID: <ad465p5LVaSMlTUa@stanley.mountain>
References: <CALoEA-wfx3=eVq=omiNmDeSaZpNP85KZd32A=GBiU-DVZ6btAQ@mail.gmail.com>
 <ad40MI2oyvDeu4Gh@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad40MI2oyvDeu4Gh@ashevche-desk.local>

On Tue, Apr 14, 2026 at 03:33:52PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 14, 2026 at 12:45:31PM +0200, Joshua Crofts wrote:
> > On Tue, 14 Apr 2026 at 11:57, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > It's up to you. (u64) casting here is not bad per se. And it's more robust
> > > against changes in the second operand the type of which is hidden currently.
> > > (Reading again what I just wrote, it seems I objecting my own suggestion!)
> 
> > If I'm not mistaken, the compiler would always do a type promotion of the
> > "smaller" operand (in this case fout). By casting at this point we're just doing
> > the work for it, so I guess it doesn't matter.
> 
> Yes, and the problem here that BIT_ULL() is (semi)hidden on what it returns for
> smaller values.

There is no way we'd implement a BIT_ULL() that doesn't give you a ULL.

regards,
dan carpenter
