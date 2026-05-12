Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C63C415E
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601467; cv=none; b=Nc2oWmySclS7nj/O58R+m6y/H0rH4o94nlNFbtmlLpGCdrfpyZv4/PzXmJdzMruLETeg+FQTgvIy/3yn0B18a4Rgt3Dpi/0AUYiZOc84pBq7Yx99bZenl6vCX7pgI89Aed1+Gsc8kkYSGfNV36sm0X44qY7lnBM77ovwtrv4OpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601467; c=relaxed/simple;
	bh=ox2uSWFpauWjzzvNuCrFahLrj3lcl/0QEqcGEGnZIK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+ESzwhTy3BjrAPREoJRIy42Yz4R5GTKs71S3Q+UAgAiML45q3bQEyaD7Tstq+mSmKxKwyK2mheE4zfs5WIvoIw9LFKAZT1z8jfb3+CavglhuLVCHUapfvYQuzuJnMwFSi8cp5m50ZWBtDd906bww6ACrbvsNvN9Pv9hsaw2mgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=hf21uwPD; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hf21uwPD"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-47cba53479aso3532934b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778601465; x=1779206265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UY5jtfu2qbBerQcmhH9e8mkt19otLXw2xZhPPXUcnUI=;
        b=hf21uwPD4WB+7Nc1VGD+4yxq+MU9LJjsZkFIvQKYr2kAemHe39efdABbqa/zdanOih
         p48kuh4U1U2z3p2n29KxrJ3GpvZyTYIG38x66OqGaNn7d8IAexy/Ndw0YhGkx8aaCVsg
         q6theRfGB/ebsBkgTQCDOxsAFjDHUHrp/fBEbgJVUKjvL8ew3L3/45sTLjyhJKD0M2fM
         IVDIHNjwGbecm+kULPK2+UbTOoSJEPJs+P0Rpk51kWEmh8xhsdPiwvfmisD5InsF4qmf
         aeOfhcUZtSc07XXJ9iAG9WHu20UEyOc4xmCl+sJ8MX6kLJ0pkbt2yB2BY9rXg+AIdiNr
         UrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601465; x=1779206265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UY5jtfu2qbBerQcmhH9e8mkt19otLXw2xZhPPXUcnUI=;
        b=U4NCoy35MKT12ua/qHihvjIQdctx6634O0RwxBeNZc9x7lIwYe7YfGtOJOFVNnmdim
         3tzdBdi6nk2/o1kB5IapDcV6KujG8z2rSOsqQScQgec2srGrtto1fiocNjg5xc0KTcZx
         SfADq00zpOa8zysS7fvD7v8/FRuw+jXv2+i1SayyRcum9o3fCq2dkEzGxbga4VXW9vTc
         oOGCZYdKqopQJlWpX7AOGhmpFdV8+fKv9LHmoYAcoMfOr7cF9/J18QnQPjU+p62fmy3G
         tw5HufPSOuqbcwub0KyUuEW8wYveSM+6tNW9IPx6Bp9UOEksRZOMiVbZD8t1+s+eU4Fd
         BF9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+V23UmLzvLJ9mW3nnSI1/QyU4DZ7S8Yc40LWXg1w8N4P6lfeS/zvDMF/YE56bx3SgywQuY567iTdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbrs8RSXyUWdRcBIIBOIXBGhmpY5DlgV4ypUYR4SgyenVll0gK
	5W1jLkc64oKwRKR6E+Sunq54YEeUrJ2+NvnfeL8jWpxuRFShKMz017Q5/+Ve77cL350=
X-Gm-Gg: Acq92OEmeMjaw6NBOUFNWFIs8YnzuJpwGY5Wip4zHwV6mmz8+k6euT/JiE7LdHSKolO
	PRbS49nmUhFORKvsvwVj71zhQTlqhPHj9B93tD5bbUVN+Gfz4oFk/QAItY6iDSQC3eRglh4q/dk
	3fWq0IE3DJnecwwzCdpN80U2cONe8lt9KNaYbSiOWHkRu2sRf1BVD0GXJrQ8PzO41fj5WIlOxXU
	FhC18Pj8LgK89ViMwo0Y6rKJNmIWnlHfPubrlgdX1Kz5bj5sGm/wC+F5cory2UWoqaiyU7CzP+V
	slf5iideCzyAYRFQ71UzelNJmY6NNG4HapRTsPK3Py2b6K76xk3RbTcnr/JsTd4na5RjEs4P1Ac
	MY/V+GN2ZRe7myNJbCIX1uKrcyQrSMlszj+QUYhmX3897TC0sCRG+QtA+nFZXVZceWZNTwFqc40
	4hXDNVqagw9thzLQwETgF7PIns/2v+m2Et6qd+VyZsmzNeJLeLcU0HnJYTNqt/yH01ezP5NQjIy
	w==
X-Received: by 2002:a05:6808:6501:b0:479:e96e:65b0 with SMTP id 5614622812f47-482970b1562mr1996746b6e.10.1778601465103;
        Tue, 12 May 2026 08:57:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:baa4:f7fb:528a:2457? ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435573e94edsm13047414fac.13.2026.05.12.08.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 08:57:44 -0700 (PDT)
Message-ID: <f2c90ff7-09f6-4e56-ad2e-5b883e98db9d@baylibre.com>
Date: Tue, 12 May 2026 10:57:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
 <4742ea18-f3df-46dd-aad4-18d1e5f03f7f@baylibre.com>
 <agNMkMgSIgQJZLex@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <agNMkMgSIgQJZLex@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 10:51 AM, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 10:36:00AM -0500, David Lechner wrote:
>> On 5/12/26 2:35 AM, Joshua Crofts wrote:
>>> As promised, I'm sending my IWYU mapping file, based on Jonathan's
>>> version with a few additional tweaks by me.
>>>
>>> Other than adding support for more assembly file business, I've also
>>> experimented with individual symbol definition (see BIT() and GENMASK()
>>> in the following file) - this is to prevent issues such as the tool
>>> wanting you to include <linux/bits.h> when you already have
>>> <linux/bitops.h> in the source file (I agree, doing this symbol by
>>> symbol is tedious, but BIT() and GENMASK() are symbols that especially
>>> do this, and they're included in most, if not all drivers).
>>
>> TBH, I would favor rules that are easy for machines over rules that
>> follow existing human conventions. Is there really anything terribly
>> wrong with including both bits.h and bitops.h other than "convention"?
> 
> But why? When one needs bitops APIs it includes BIT() and GENMASK() for bonus.
> Same with (and especially) bitmap.h. The latter is rather a heavy header.
> I do not see any point of having all three and even two out of the three
> bits.h, bitops.h, bitmap.h. Also this is a type of unification that helps
> scripting any further header reshuffling / cleanups / ... If we ever do
> something with bits.h, let's do it on the files that really use only it.

Because that is human thinking. :-)

I don't particularly care what the end result is as long as we can
automate it. It means one less thing I have to think about.

> 
> So, all that being said, I prefer to follow guarantees and change them
> if required once for all stakeholders, the mixing makes it harder to achieve.
> Bonus is the compilation time (maybe negligible, though).
> 
