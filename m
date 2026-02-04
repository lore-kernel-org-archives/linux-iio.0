Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47337F728
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235437; cv=none; b=RN+GKPdB8fzNWv7nj/VzIWJpJWYFvkbjUhki0J4To2OKb1cLcQhhbGrGAcxqw4PzabALQDm+12A4Nt2DQN5ilDmpOlfOA7icfzFCsNTWsiSIiQ2PPfFJ0TN3qo7wmsb9orssKdiBE/A69YcYy+NGn87Go49QfTICoMPTnA1i3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235437; c=relaxed/simple;
	bh=ZbjPQZxsawcIi9AE00bUE4mWPx5PaLFX85JY52XvYgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6ZJ1Rm4C+MY9pPYMtS4iBpquA+LmpiKL35W658f04XnNUQUknSSW4Nks7vQtABEZ+T43r2O6okTtVmvzdojrQqexfZn8Fn0m5O58hHilCv/aSDur3GwUtySgJn89jUjnbuZ2WEUr93nmOqRaNnC2lNYT8ixT1YAb0T6OwUWOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFojOTMz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFojOTMz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so1527645e9.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770235435; x=1770840235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o8jsa6rujwI1MDFtP7TZjZaBsvWUke/k2PYQ64bRKwo=;
        b=EFojOTMzKPvqIAMBE+ITxRp2uQu+mu/7w4lPlJAWfvMgOi/RfTa5X+lbZt9dD6Nt7k
         UZsvdHRnzWkqG6GJ6l2ymzrZ/LrB4CStt1DAuGwcFcuCFubUyFjn5OO7jjjCAnwHcFqq
         TyhXAxc12Y0Op9SVduET0cwU96sE48za2BTZ4ViVrZRXdlTSX3HK3bW9TXM9Z1bMS/ty
         QsNDxAFmElGSh1wphfOCCaeWA4tCQeBiRrb2mLlPAbLZZOmr6nEjsFYYIHtGH0EaSSkw
         OQAI5hOKb//oRtEiPsbL5FLHyrJU9k6+ICSKnq6n/E3IPYxmnGM31eu8aDkzn1d/zttn
         OS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770235435; x=1770840235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8jsa6rujwI1MDFtP7TZjZaBsvWUke/k2PYQ64bRKwo=;
        b=XVzqvjtxYT20r/k5S1J8WpNEABlVFzWbwntyGXsxj39ud9z+tqYzI4iG4oztkaqe0z
         ZDim/IZk36GrAFluQ2M15VVmrY5KNoE0Ig1d9dC2SrEvBjjvYiVLs3gLIblJ7WWzdi1X
         7HNT2L41gQjertGp01nagRAI0w52JW68igcy6xPwfyCX6a44RBUNWCgwc4YHJ7qfbcH8
         Yiyf4vJ/BQBq/aC0jmFZ35gW8n2h+Dlchs3eXeod/zWt0K7dS3jsG7TOWuoWaJNA86Lj
         anMtR9s1zlFcveKDsUxla3Z4O9lctkWPpznvUv4ZvZ9h5KuHNl23fKkXcbg7G8C1Me8C
         GXOA==
X-Forwarded-Encrypted: i=1; AJvYcCWaGY/qxl1xsvx6taROX4XOAf1n5Fmdo+eK74QCHS+qKbnqnl1oCPjisbRtB4m3NPs7pKe2SfwJIdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+vjgIeO+TokVU7jCCqwFfT9bgoIEjmsYGff+tvfkXAGrPl7e
	d4jTEZk5AAFL6c1fIUZaJXhvlst4Sa4F4KDMkJ9/VJfVQE6m5pu+v4As0iZBIQ==
X-Gm-Gg: AZuq6aIbJgOsfsLFxbx7EJ3Ve2cbCmAn3vZ3KzQLVbtbWIh2GRq/O3Ja6NxihbZl/5X
	8dr9edQkMeBtvSd8a4LSmeVA17asuDpt+WaxfjBkAmg9zhkzmnOoekPHZOcyzKoYY/R+cAFGTcQ
	6RshHkKS1sffVIdymqljXNVpDFGGx7S4lZGpRklB4jNxfH8nEgpGvWhK1AOGi5se+yliFGsp1Yx
	hyjBda+i8qcnIHQKf7NFPMTFtKhntrUj3DuiPZJ/oMUE2VCK9zpyCOjeFtmyJrN/gsLmQoqeZEv
	P7OQAgrTICejgsNqMBEH9w2ASPsXBvKK50UJuuO9MEF3H+tRv5xx9UHOp2fGRn8oMZN3nw1k6EN
	SLXkRaGBTwggprqgNrJCnxL2CgrPLd2mT/fBosuVD/VsG3pCZ2UO78f7RHx36xZuqybKkqzZhic
	QQBQ==
X-Received: by 2002:a05:6000:60f:b0:429:c851:69ab with SMTP id ffacd0b85a97d-43618061b83mr5243446f8f.55.1770235434995;
        Wed, 04 Feb 2026 12:03:54 -0800 (PST)
Received: from pc ([196.235.235.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f93sm8303745f8f.24.2026.02.04.12.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 12:03:54 -0800 (PST)
Date: Wed, 4 Feb 2026 21:03:49 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: fix use-after-free in viio_trigger_alloc()
Message-ID: <aYOmJeR3x0Mg4GLf@pc>
References: <20260131092333.247931-1-salah.triki@gmail.com>
 <20260131124416.19576731@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260131124416.19576731@jic23-huawei>

On Sat, Jan 31, 2026 at 12:44:16PM +0000, Jonathan Cameron wrote:
> On Sat, 31 Jan 2026 10:23:33 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> 
> Hi Salah,
> 
> This is a definitely case of the fix not being anywhere as simple
> as it might look at first glance.
> 
> > Once `device_initialize()` is called, the reference count of the device
> > is set to 1. The memory associated with the device must then be
> > managed by the kobject reference counting.
> > 
> > In `viio_trigger_alloc()`, if `irq_alloc_descs()` or `kvasprintf()` fails,
> > the code currently calls `kfree()`. Using `kfree()` in this case bypasses
> > the device's release callback and can lead to a use-after-free or memory
> > corruption.
> 
> In some cases yes it can cause problems, but please show me an actual
> path to this in the description. It should indeed be tidied up.
> 
> > 
> > Fix this by calling `put_device()` instead of `kfree()`. This ensures that
> > the memory is freed properly via `iio_trig_release()` when the reference
> > count drops to zero.
> 
> This change is not sufficient and causes some cleanup to happen twice
> thus introducing some bugs that weren't there before.
> So take another look.
> 
> > 
> > Fixes: 2c99f1a09da3d ("iio: trigger: clean up viio_trigger_alloc()")
> > 
> No blank line here.  Scripts that commonly run on the kernel tree rely
> on the the tags block having no blank lines in it to avoid false positives.
> 
Hi Jonathan,

Thanks for the review!

You're right – my patch was incomplete and can lead to double cleanup
between the error path and iio_trig_release(). I'll rework the error
handling so that once device_initialize() has been called, all cleanup
goes through put_device(), and resource freeing is centralized in the
release callback.

I’ll send a v2 fixing the double-free issue, showing the error path 
and correcting the Fixes tag format.

Thanks!
Salah
