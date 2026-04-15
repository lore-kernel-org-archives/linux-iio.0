Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076639BFE8
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237497; cv=pass; b=FfXkBHOo5IEpc3k9IszxOzyneHoTA4ygyU9LhcO5gy9dOK805becujFJW9G7Gsv6j07agCG4WoXuKqdaG5/h0yKAuzR1T9SaYTt2ajBxUJQA0qlo70jPFJnFJnJ2tTDPsMjWu0221Ig9Gpwe3FaclTbn8uqSkrJFxC37Xs0qZrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237497; c=relaxed/simple;
	bh=h0rQ4cS9dWXY9la8FpZjuD/RIneVPSi9ZeQGJ/Hz3as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKvqhJUl3jAteyMrTtJaidLNNZpXsf2adWKsepRRb3yw9zcnLXsYGdukkycapw0piv0a7j//h9PjIOGvceINnefTRr42bJE0M8KLjHOUjt8E86mZDzEpIhyXwbhpsB317tCO1AWlxudOmiAxRYPX/1qR7dyclhqTDI+zTL2V9fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7F3wO8o; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7F3wO8o"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfd96354aso3849342f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 00:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776237494; cv=none;
        d=google.com; s=arc-20240605;
        b=b8TD02V1ZUF9rxfxj6TimJOE7rBlszAf7fVnQv0rosLenOkwUeJrrfEZh+QT0RMxha
         1PA1jhfKcfysLotOvH6zLcqR3yywC9e3FEmG9JoxDIB7/udETD6xayX9Clu5uTR9ZZz+
         Wj+E9x9um8Q8Yn/mDdPSBQOeP93tKjTGmUgg53aeTc76YEIErYPdOq1GKVja7K/BBo8B
         1zhw823wU2XYLqfsRNPH6GcT2fghIfnOT5E0SKgKBvBv/uh4Zx1UbWaa4TIdcOPIvJH2
         rlTm7S119dv6tyqJvpPrZS4Xayp3sjPZ2m8NBw4mxzZ5Y+w0CqHevxxUeKzF0caU4uqQ
         JGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2nuKBbGlq7w6y0tHaaXEOwvqGYtxbGC9tRxpbGm9Imo=;
        fh=LXglLoBjaDUjQbsSahulKOj1tLH0xLZoGhCyMyIwIMw=;
        b=Bk8lzRelgBArjwpJTSp+HV3TTFrtzE/JxRSQ7sa3KTo4ZnCRYfxZ+G5QKZ7emKBEXR
         iwWRgZQzs/aOyZ+DPYXAatmIr43kQVubDUDMek3Z+5W1P6eUNPSTTrntVj3eYZoDrsbF
         7Q7r6WZ+aWwzTSHnpZaJwpHWgJlgF760Eu5c7FNjVbBV3foTyLRPB3B+gJIYK00UQ97L
         qTGuBhYXkts37fQP0zK702sKArSfoplSsjHDHbaOdjc6B5wnXgpKfruWPGYlM9u/4v3d
         VsQov3SDzIQc7A1DFhAx/wUv4JCkp1z3SCrbrhU50AIYHxuy7yD+cwaNGngXrJu0i3tX
         AYAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776237494; x=1776842294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2nuKBbGlq7w6y0tHaaXEOwvqGYtxbGC9tRxpbGm9Imo=;
        b=e7F3wO8o3RJ1ckqHPU06zOWFt3FaHTI3wRV3GURsmRbtdQu5HrfwzGfLFsYKpch/+j
         8G3BO+pUX5Wf3yOF9S8Qml6JvGYKAdGlZ6RMRl+5uPorUnORpXbzvuarStvxB3zqy0im
         SHZZ7lSVrPsQ0jt23RVD1jQ18cZ5ZcltoVmi8iCL5NEEfSid3gI2rCfSEHo3ugoGZMaD
         HmXNeakInXSOZ3tD7k+4C5LsQrOg47otv4TqwLWkP0+3+21z+J4+zfUewJA08PKAmQS0
         JKr0W+bOyLXJo3eREt+oKoLDhcuvy7KYJpJlKX8teZd3Rzgid25ktLXDF4Q2R204wySD
         Yr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776237494; x=1776842294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nuKBbGlq7w6y0tHaaXEOwvqGYtxbGC9tRxpbGm9Imo=;
        b=qIBv50iVJpTOEh3vJPsHtcfTIuir9vQi6F3FbWEe30zzgBh7GQwlcFGiT7+/bz8KAs
         TEegWP5JTc3b8WdUVaOCjBpaZDEIFa9uirveNlSVSMxXZy5+OVvMFgk4dfihT1PBshK7
         KFb0BIsMjUPXsy5VOBgT//UGSi29aRYVYVe41yMktyFabVr02LDFahrOfuvgmGnsySSx
         ClfagO2jejgCo/MuhaVoq/ZCqOQtndplr63uqAM5rbMIwAO9PGMLDVtzAfJKcZAiCPe4
         sMf/Vqr4/3Lm66qpLVE+pYelF2N0ftXmxH7d9ckWryhIPwP7XrjfkVtWZ1AkH7gN/T2g
         7c/w==
X-Forwarded-Encrypted: i=1; AFNElJ9qPNLLAqRsorAF82qqyo4uUA27q+jFk78pOLFIRkyUv3HYvrl6UrIwrQOtAsNfVBXmh/BFnl9gPuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/c7EI7B2vpJk8R9GtrjyN0I1uXcJCoKDRLYO0D6cxlD1w23t
	dWhaoyKINUCq2mQwDQFzXeOHvgeV4Hb162B7nINZoB07v+PQA2GmOD9pxRdEb16ShxbZvKhYenn
	kjPxHGQ5zfAGIJxC+plOuiS2yPzD7Rc8=
X-Gm-Gg: AeBDievMTiCG0R5uCe+8FP6LvtRuv1KxCCHaTp5mBzFj6OEhpxvOh7GrP5pcHN/OJZJ
	Zzk3WJGDPm3YohOzOvDqSUT22rxzgjyrGvxHWoCtKbpBOnDWFZjsaHoB6ezWtYcRwF+xJYjvEe0
	CwbGAOdwsf13fJlxPXtpKfSoyG3GUiGNasoZ6Uj/Iu3yAtFXliOZNnzCT/hiKXp5w8i/ZYoLFH2
	pDjbGYyTsZ04K70HISmESkjp6KjKztbhdQLMUA2dyMKC0/bF0XqmqH0c3Y5qwV0dkvV+fHX7kst
	AGrgfL84pTDI2Y4cYzAgfVDFireVMkuEksNd5DFc2Z9vfGQ5jYx68p9/D4OU5cIfx7fssZHiXHs
	BG8gD4OYRNVrmGhsBnQdsgUr89I7c5pCXpcl3Ywht/dFWxfBPlaTiLCOqLy/sgqkoezfWu2Koxp
	BnRAvuKm6MAxgC3D/O
X-Received: by 2002:a05:6000:1ac9:b0:43d:7d24:b51e with SMTP id
 ffacd0b85a97d-43d7d24b893mr13620760f8f.14.1776237494064; Wed, 15 Apr 2026
 00:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-2-joshua.crofts1@gmail.com> <ad4K-K3MpwD3U4F-@ashevche-desk.local>
 <CALoEA-wikg1aDAfhgHYR10ep8a0Ab+hJ4mAUyAR4nuV4Uysj+g@mail.gmail.com>
 <ad4oX0Py3T8j9Y7h@ashevche-desk.local> <CALoEA-zbi1VOv86FrU2Skkuota0UGcMyHVJwffyEY7+ZsMSNcw@mail.gmail.com>
 <ad5zXNdMTxbt1GHS@ashevche-desk.local>
In-Reply-To: <ad5zXNdMTxbt1GHS@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 15 Apr 2026 09:18:13 +0200
X-Gm-Features: AQROBzB4RhFtUOA-KA34_X6NSkJKMmJIUrhiZ_fFhqXxMp5KZX-F5S4m5xUEeZo
Message-ID: <CALoEA-wKJsjyOuVMOAyOVetB=N_E_K8X+85Kg6JVEthX3JWVpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 19:03, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Up to you, but that would need to be a separate patch, because it does
> the opposite to what your patch is doing. And justification is most likely
> that it's preferred to use linux/ generic over asm/ in the drivers. Or
> something in those lines...

Okay, I'll send it once I get this patch series done.

-- 
Kind regards

CJD
