Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A93D348F
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148390; cv=pass; b=XZtGrUPD4HAF7PFc94uLI1jW6P4uthhR4bDXb3/D6jTlYLsy9jMKJTYMYwZfQLCfuDwPX5inOZB7PwcTwAvNIkGhgzKQudP8P6LEpxQEH+J19Hm9bE4zHy1pWhVNKjuPUJJwllx+kHHQDKWwoq5u9xcP5uhnjVTYeM4iXoqVX3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148390; c=relaxed/simple;
	bh=BJJA6/oKhj4SWzfPB9zdZUnbbOZJ6d9MAYU0ujeiVtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARW2IW98Sor91HJ1KE1jenvHBLyK9eaWcj5Pv+GCHGYkvYQFBVfvd7LUmIs/KToR07FYmJrvDh3YwmXcl7ZM6PqY/9qRMvSWIkqv071hG/+ztjqPN2g0M3cbcY1qX5nDSNFpZdPsrdszuLXy14GjZ3RGJouRaMy+Iu+m48A5pzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0HLNA8Z; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0HLNA8Z"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-448528f4e69so411481f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 03:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778148387; cv=none;
        d=google.com; s=arc-20240605;
        b=DHwhVNnwmcT3EmjcoRp1N16ZUN6bpw3gcau7SQIF2YFKlgCJ6lHndDTXqZ02ND/9In
         tWpJ7OG+2zi/QLdtwytA9NbYi0RRHK5Ewqky+iTELSgsgEdD+gGN1M9OZJoSaWyiiO2X
         TXrhygWCPeIlJEYQIsoOrFGapN0BvaXgSNgFqtZ4Efby7/t5dw9MCqGo0fzLpnWxg5XM
         bLcsdRW61MU/Mgl81TGvmPvf5TVSWxBOjmrk/D0Pgyd0egRGgKsZ0Jg3h7s+eT1ytuyd
         vRueNuZ3iFJVwbUIi9d1I81LIBqfqEEVgV3i8WFlA8ZZdjrcn/R45X3j4Fqy+vN7sDM8
         P6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1VkeiErrcofO/e6OzGwzhbtyygF8+HJjfEmam8QJqTY=;
        fh=u3USYDS6bztGHHnMpo9ByrFywyZijyM390PrYiDuNdE=;
        b=W6o+Od5gJdqJOTal5FU1VywMspB38yM8OU+QVeozSFRZ2zFQQezU0RcuWSbANPDJNx
         /k934DHwHw+WcO2rzEQhjxUh5xyIWY1xmHBVVUR7xTgsXokEtRHZxn+fpfaRyFh/lqrw
         IqCS6nghoMske90zKbFf+QJ7rrvGMcuiAYjulWWTkL+D/yF5g4y3zRuvBLya13sHuhV/
         7N+9C/0Axg9CnEXq2CuhcmZeiBza4qfS9rpHViPSUBPwXccCpBWppC16dr1sn0OuCbc/
         /Og5RzBAVZogsxDuwaqmY19yRctabIThnGF9edB4+ZZjxVx6jhLko0uHHPNxaIu0/5eu
         F86A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778148387; x=1778753187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VkeiErrcofO/e6OzGwzhbtyygF8+HJjfEmam8QJqTY=;
        b=c0HLNA8Zs5DtqW35Y0dg3bY6gD7zBt+qUnbNtXZsVWHSId0i9KGMhAjTtJyXBo0vEi
         cUcgNcaxsckgNoZkhS3C5RSSM+SxBHU/mIRQ+kRJm5PCGkAlhw0Qck+YLoO4tlWF68fc
         fLuKkPxlLe/NZoIUTGsysNaspGQJR2Z7RLQ+Ya0vTuSx9492YSlXmVBccXfGj3mPSmc+
         2g/pknwRUqrO3ByFJc7inoZLiD1ywkqBcjS3fm22ihSLGB1+DcEniFfPf7A0Qlrhj2nw
         7oVnLrP4fge18VyPkLlap0AfPWNjrpjd5cll1xKsEgb0syHDYvKaykJvhGIRP5eEeKbT
         4+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778148387; x=1778753187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VkeiErrcofO/e6OzGwzhbtyygF8+HJjfEmam8QJqTY=;
        b=F+7KZYN55tUmhiYTPqMit5DjB4Ijgh3asxNbwcXXLox0EpSHe1IjXAy0sqALHa+ZPB
         ea+mj8fx8sPtpJz7wjNnGL5HPlApQ+y/3LLkC9959BmG6UG5rr5E+Vuc841LAx/6PLSw
         whop1TLkVCWYDQssJpbMpXbkQkiS1NVMF6tQ20eE/jcLE66Ta24SsG2kvfD5EdS4m3xF
         zKlhIeNZxEnFPojUc19+7jxjQ9ErG8WwqDZ/xH+5xwkFQFAO1uePBDq7KO3tqKxj0sxG
         s34iyuGHM9ZWQWGS8ZCsWORt2Y/BMj7B1SnYg0qt36Z+igJ2iAghvo/F8QvG4yDkyeOb
         kiLw==
X-Forwarded-Encrypted: i=1; AFNElJ8VBpeGZOi/5vb1BeP7TnLM2hytAxETcoYNmtwSz4v2M4wUpBmfUgYlI7CVkedPJr1Vzp8Db6ob/LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYdc1yVt3tYKRIhpbl705EnDjNS++Lm74X9E3wMPlZYr8ldpm
	pvgqp4pFJK6BA9NZoKPlc0FKIKp6+Nxa9P3aF4SQRRRCP0gksLByFSIhl4LcFRbYkxdl9jXnCqU
	irl1ta52L5S86A9PpRkC8qQpEpfstoqc=
X-Gm-Gg: AeBDies+HIlj0W4V4VXojS2wXsU6B0ZUzUH7Ue2bVzXGKwK+FiAtHaz1QYss82YxaOV
	j1zws000ybZEoUZLsMAFNGPjsMGFG8gTidVLIxuITeVIFJbpr5qEU4NmXYE/ZCtlMtPrN1WX1kE
	IfQ5arHkKOJ81H/87jyV/5JiM25e21OTOIOe86+KGeHeeGhFNyWjQRDMF9EF+sS7pNJe0pZ0ANd
	PXU+SfFhhkCsFIxWa4d0/6FmkyTRbnrEmYCrO0guA9ix/bvtM3xkIdokP1LVcM/6EvWiLZytEhz
	aRE3b/ErV/s8tAbZTCjqMtKvIgvLXQsnb2z2lQvSXroGCSDOZhoBoujwKaqVFH7XkxS4WK+RyIq
	8TrcKdHGldV8AvIJJ0l/0icR/aTuEZI+foThMSZKX8E12fYiO4hJYxbCJjAm9megxZ0dQMaWRfz
	PFSWiq2vkJPXwpk8JN
X-Received: by 2002:a5d:5d0b:0:b0:43d:70b3:7edf with SMTP id
 ffacd0b85a97d-4515b525dfdmr11777220f8f.12.1778148386893; Thu, 07 May 2026
 03:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-18-831b9b5550fc@gmail.com>
 <20260506181216.049f87f8@jic23-huawei> <afux1tXZJxG-5yDt@ashevche-desk.local>
In-Reply-To: <afux1tXZJxG-5yDt@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 7 May 2026 12:06:15 +0200
X-Gm-Features: AVHnY4LMfttk8SPHo2uu-Mx40NEYB3st0mwrOlbuVmawHSiGd0uW3jcuXWJ8PtU
Message-ID: <CALoEA-zweOvB2nxWygEYiB0zTOEOoWedCwkFJ21U3-E8CDG+YA@mail.gmail.com>
Subject: Re: [PATCH v5 18/18] iio: magnetometer: ak8975: make use of the
 macros from bits.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 23:25, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 06, 2026 at 06:12:16PM +0100, Jonathan Cameron wrote:
> > On Tue, 05 May 2026 13:46:14 +0200
> > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> ...
>
> > > Make use of BIT() and GENMASK() where it makes sense.
>
> > One small thing in here.  Feel free to just leave that for a separate patch
> > and for now leave it as 0x7
>
> ...
>
> > > -static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
> > > +static const unsigned long ak8975_scan_masks[] = { GENMASK(2, 0), 0 };
> > Hmm. This is a fun one... It's actually 3 separate bits so please represent it
> > as BIT(0) | BIT(1) | BIT(2)
>
> Ah, TIL.
>
> > or maybe add an enum for the channel scan indexes?
> > BIT(SCAN_X) | BIT(SCAN_Y) | BIT(SCAN_Z)
>
> This looks good to me.

Sure, simple enough.

-- 
Kind regards

CJD
