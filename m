Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AFA330D2A
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157793; cv=none; b=gC8g4jU4qY5sEb2PWYFXGsIwNSUqZf+DSpZaQ9syrg8OpMs6M7iz40QixPQuREdQkqdDistG/2FrCK/eHC9UqgiN8HnBc7yzTcQdYkvdHz66FIsYR2luHWk/OZ5iVOsbZsEQFLgBTJf3oWXRMksEftdDCDW8gIlCQnSgLP5mKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157793; c=relaxed/simple;
	bh=Emls409A2jlvbrIttKd0ti1ixHX+ZB3nQAqLj+A0iP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otFDiU/499Nh/GI0td9KJdYKWcuuvqx4zWNV6pA7EVJhVX6nReTnbbLJ811NBiVGLWQwxP3MSwQX1ERNlrQ08aRO7QZ4Kr1ngQc2v4VK9s4xVq+qHWMIXXtMHHS13AVx6/2V4/abov0ofPowG+ncNoIGEoYCHe+QA9IAr6jV7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYT45VkL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYT45VkL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7650202fso1606341f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157790; x=1776762590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HMdqevrwJfPuSs+DzIMhPZpbbW9c93ZND4jFizEAK08=;
        b=FYT45VkLDulUku9ad6UBXnJCQFiknKDtTsyVZi8Ru0zsbkCltRs/Q4IkYDXcdhrPBl
         QY6FQkwGGL/cO6Zpu2JiwIbKojdOOULkwpFNaGVlYwqv9Eojn2QHGVBtyAbTmXQ5XSSn
         5Jn2wOBD86MyOKugHMKoTHP2T0/lu7TWTkZec0h2x5+V917GNGKujea+rW2fG/koRNkJ
         Ug7UNSChCMNOxCwIQbSfmehY6qx1PKgW1Z6HX/tbtg4rMvzeLMsuRmqe9iq5K8q5dwnx
         /4zYZSBLjt3uXCxIinH6KZOvAtXyIVPsDFNj3lPsnWB/eQOSg3X51YjOYBhPYJuIK6AT
         zdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157790; x=1776762590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMdqevrwJfPuSs+DzIMhPZpbbW9c93ZND4jFizEAK08=;
        b=L8quazhM8P9j34T2v4ocJyWVi+QMWewtMlvuvzxUgjGJE3uxelUvvw54lhK45/riEA
         70oxH3NX4TnQt+bvhGQP02vHVAQUWGci6Vm7zDoGA4KxqbiY6znz/LIkUfV1GNYHLtqV
         4kB/dlZJpxbvm/jUiioEWbI4NyZenil3zlYp3fGV65NT1EyDZKCAVUxqiaIRKMhRuzJN
         uiWGKivgytosgOo0mkciFX3XcLZC5JGWcXK/AS5neCvmIyJIfcL5Dx/bvV7RwkfZCpa+
         NOmHpPZXJt+7jg7DVVMBOU0RhSPE92daocPdyPCUSFRqZEbUZH/i7kDPX4myoJP+Avde
         bfIA==
X-Forwarded-Encrypted: i=1; AFNElJ/N5wQuP7j0uDZXdvZUcWmRXUCVgBMdjLXDPsTkPW0VRQCm+T+DHPIPI257GrHwyj/xE+BxHkVPSCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lHwxsKpEbv2JMlegcQLppmUUDEy+hp2+zehzwz7XPPFO6BR/
	Kj8dmjKwJzqiM/ct9XKq2RclAFUCbOHayw1RDo2GKfC04c+3mE6OQBfX
X-Gm-Gg: AeBDievxL1jyK0iC8H1cvgGWwvQU0AeAVSzvoVfoME6hpufdgRQv/08RwFPW1cgwIdY
	0Nz/k0MNl1f7MWYbipDYS/LNjVQUq29bIMkfy7ZE/emd9g2HkhDyLG9oTmzC4UQcDn32W0PXd9i
	h8csURgVDpALIKQ5usPs7jmRtJr/96hErjk3KEedelvpEXFpyZczisGtichSZJo62IYcivSeJvJ
	u6S2jYeLXRVCv3vlc3jtJb8pmC4cTO1+YP74qwOra4FaAMQxCFipI8z1SOk90Y/R8YIhHZ0ae0x
	MHqwtwGq3Ui/ksBqsKL1E6GSLyrhetAkKQFZOhpJtWJf0h3cvBTj0KCZG7Nuc9O+TzbpSgvkJY3
	RU9JPkkIHPavMFrZ8QbJ69GC/kNdoyGD7h/PiyQH0xOrav4d2+0Qpnzd58I1p/d03/CeRO49Z4r
	T/oiwo267qsoKD6Q==
X-Received: by 2002:a05:6000:18a6:b0:43d:7af0:3a93 with SMTP id ffacd0b85a97d-43d7af03bf8mr9481282f8f.34.1776157790110;
        Tue, 14 Apr 2026 02:09:50 -0700 (PDT)
Received: from nsa ([45.94.208.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7d5812dcsm9405743f8f.32.2026.04.14.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:09:49 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:10:38 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific errors
 when parsing properties
Message-ID: <ad4Dd2hlVdw16xgg@nsa>
References: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
 <c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
 <CAHp75VcpuxP=3cGuVrJoSuirQ3vPNR9LLWkf5CyaGcghJ2hzag@mail.gmail.com>
 <abkv_76b1cue1bGK@ashevche-desk.local>
 <20260412153040.0e6f2d7f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412153040.0e6f2d7f@jic23-huawei>

On Sun, Apr 12, 2026 at 03:30:40PM +0100, Jonathan Cameron wrote:
> On Tue, 17 Mar 2026 12:42:07 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Fri, Feb 20, 2026 at 12:33:28PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 20, 2026 at 12:04 PM Nuno Sá <noname.nuno@gmail.com> wrote:  
> > > > On Thu, 2026-02-19 at 15:39 +0100, Andy Shevchenko wrote:  
> > > > > Instead of checking for the specific error codes (that can be considered
> > > > > a layering violation to some extent) check for the property existence first
> > > > > and then either parse it, or apply a default value.  
> > > >
> > > > Not really sure how I feel about this one. Checking for specific errors is a very common
> > > > pattern and this change just makes it we check for the property presence twice. That said,
> > > > this makes it more "future proof" (though I find it very unlikely for ret value o change).  
> > > 
> > > I already have an answer to this:
> > > https://lore.kernel.org/r/aZcenabXYsOdBu84@smile.fi.intel.com  
> > 
> > Does it help?
> > 
> > > > Anyways, even if we choose to go down this route, I don't see much benefit in starting
> > > > converting the drivers with the pattern below (which should be a considerable number).  
> > > 
> > > There is not a big number of them, so I prefer to have common patterns
> > > without exact error code checks.  
> > 
> 
> 
> I left this one for a while to see if the discussion would continue but seems not.
> I'm not sure it is always the case, but in this particular example I think the
> resulting code is a little nicer to read so applied.
> 
> So for me, case by case basis for this sort of change.

Yeah, I missed this one! Anyways seems the way will be to explicitly
use device_property_present() to check property presence. Still don't
love the dual call thing so I might just stop checking for -EINVAL (was
not doing it religiously anyways).

Maybe we could have a set of optional variants of the API like
device_property_read_*_optional() kind of thing where we just return 0
if the property is not present. But might also be too noisy...

- Nuno Sá

> 
> Thanks,
> 
> Jonathan
