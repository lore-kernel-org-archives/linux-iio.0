Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE903E638C
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173264; cv=pass; b=AdDVOMOXicMHgovR92hlsRm90AsYx1HX+mvV41QmY+DdnI2H4zlUbAzA7+oIVtewPIrI2qFEuX6UnswJfRzOWRzVa4YvF+aIrhRPsFAjoqQiWbBXHvkQcBk3kPtVlZefz6GWIWem1sxyJbflhfb8XMCp8WHDQ7OTHZacTeD60bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173264; c=relaxed/simple;
	bh=KWT3Rcv56+IvnA3mpuzLgWBkmDOqdSGo4ZkDl7QnnKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir2EPEUQ2V2CJF/Riz9DTsykQW23J58RSsvqzAy5LzZqgO6X0qHJgKdVFwWL8O8bsNO8UpBj2kR3XCGJMBB22j9GfFDGyfQrUQ47wKx1YuU3qSqt1Vlcsn7rq9aCmA86GVfsfp7cZI7Whq0YcsLZPnFIJE8jFH/genrG86smdV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pU5J569W; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU5J569W"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so5626653f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 06:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776173262; cv=none;
        d=google.com; s=arc-20240605;
        b=TYMIN+Oumjq74Ew9GN7OWO/oldWOLmFiOlNRgOPzb+jM7xQoUOrSumh0CNN5qCegO8
         YeTWnPz3uVgMIc8v+t5dMFf/JxADLqm6u8IY+O6AywMpC9j7yxZN0Je6QxfxVlZOCsOW
         Yx/IYC7LdPZBtsj+dk8ML9Gue0VlUwKzhP3B+Uj55/Rt2nRSQ6Gko9sIYiM63h07O8PU
         yr2RSvzmY/C0IxJB2TJaqM5p0E9vu24bp2yhL1giZtFJuEBHHi1O1BB8da+XPRSD5k4H
         mlAjtRGNESKbaWz0P8uSwjGTBia6F3Uxgax2YtxnAnY7G41Wqw3LvqVjwlaWYbrncRCm
         ktNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=un0rHxymCkMN5f7gh8gNIZQ+0xDLGUek1PH2ppFnbd0=;
        fh=bkB3BEUVN8xh68O28NbCVz+d9mvTrJCKg/75/GIKqhU=;
        b=HKd52UczqRatL/HnZ1k1PneHazr97otA0/VpAwqpCAqVnNzy6QWo8VulDYbZ4IjB5n
         qqdM02NS+44OU1xlRvMdprEXX2j9fXytHnj1PK6QkG/2h1Ku7md28kmGaQkpS0S6p+/X
         GUZ/7lfbpYDCpXRv/S8j32ZoWA5ny3yC6dZhzPnH2lqrFdGRFNxhR9ZIBtZE6KQnvbor
         QC0oIj/8Rye8cfpWO7ULaZ6Qw0PmIlzS4Jj9xivp8v5bWcK4cQ0/14U1krNiRNJO7zCQ
         6bgmZ4lo1HT179AbxH9eGOq25Kw6Sbpfi3VwPHzd4rP0xAnJvX6Fp7+ckg7ctOOWa1Ho
         LGiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776173262; x=1776778062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=un0rHxymCkMN5f7gh8gNIZQ+0xDLGUek1PH2ppFnbd0=;
        b=pU5J569WTYVCkQzOL9hAtAa0YXA6gRh1LqSUnQA181SHKpPyluMQL6r8rPvmwqSaBv
         Vzp61i//A1gET2kQ+hhyygsIp1gVJUewiYjdlrf02My2IyD9Xj+XQaw4v+rg8TRYiyl6
         mjPTy0vgjq/4Sp/4j+mo8FLbrUnW1mwLy1S2fyXugRIz9GHlB2Bz7fUV0l54gJKc8guS
         TXQTtlbY5loj2lxsCz6wG+IzTMVyhp82Avnl8tU1GSaRunCcYrBFXOh/T1BN80HWgblb
         uXI0dntKhTybmClJsiWtKWvGbZX4KysjQoCrtqwI3GHIotbOLJ0QNTmw7HiajFVLzYnJ
         VgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776173262; x=1776778062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un0rHxymCkMN5f7gh8gNIZQ+0xDLGUek1PH2ppFnbd0=;
        b=CdXuvRsQsixB2AfiYCESl1jqbxQVXdTLoRRi6iTScHrbJUY9RySi8ZXrL9ZQmmVGHG
         0Kr5O/fmem7WVj1RdL9ybQF6Fq6Z2JiEMEcYWZzyNogErMZ/uY54BSG2SensbUNZF10S
         hXbtX/7mWXdJy/HhfiAOGdO6btO+TumijpcMbrLKTf5TcFru0p+u1wNYZp1QBI7Q6mmT
         m9CtCHJ7jlmwB+ObfgM/XnLfHtF9cme9r7abA2aM5DI2JT5+L7XWTbxbnJnmBJaHzY+n
         C/XRHKm8sRtxjwg9QLe/9IS39z5vGQgAv3F7gSxsPOBais1bfB94sEUd5PFAXyAkQWHs
         IdLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Lt+3sJ2AOedHWAMQdFw2cwbp+M/u7iH/vrxxxBgz30mGytDyk/0Gf9ssbpfL1UfdiHTJ4wHs4QsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHdvVl+zYtiAbflbXuFpWOyQvpUexdpWMflyhMISaNegCNY9G
	v3vmQrGF/qq+YwrS2ZsrZ/Jar2s8yQELwLmgto+xQhM+eSDVVAFutjWjaf1+48wn5kkQXuZnH0h
	fUf9XObtLBKFXepwRhplGGZc7dvMAIdM=
X-Gm-Gg: AeBDietBOeQQ9pJt3U15vjqzRE2JxZXYGK3rkTPTfbsVmYHFmKDTnic9wSaKCU5tn7u
	FO49ZVNuDLKhz0Ib4B2oCxqJDd+iRVSX55zkIXmAZOpLtMYuaaoaS9oJtTf3An1ru3F8uDCZ3Q5
	eA5bAYZVwrGkcC1iw1Qwv696mPHfq3hV4kBd0NE5zi82Z92rBmW7y9co1qQ2gB2sapZfbmSkx1C
	nNFxdGrSIM1cAIgtxzIKCz9w3u96tqVRWUXNngHB5/wZpRBr17xu4kpMRx7G7cqkYRgNw+llO5h
	EOsPxG8cEGGqhEElCiofvRb9pmC3dzEoES8eIy9vsnXOlMAq4W8q8xQ2wxiJ6vHQZvhT1YMAitg
	obUq0RMTfRBbU/pjbJKVEuPqlR0TIrRS1P/wQ3nyo6trx970vkhamliPPcJpeCI474jy2sWWkX1
	72oMgOA54ux6snPp9H
X-Received: by 2002:a05:6000:2211:b0:43d:1deb:a5db with SMTP id
 ffacd0b85a97d-43d642008bcmr22799091f8f.0.1776173261580; Tue, 14 Apr 2026
 06:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-2-joshua.crofts1@gmail.com> <ad4K-K3MpwD3U4F-@ashevche-desk.local>
 <CALoEA-wikg1aDAfhgHYR10ep8a0Ab+hJ4mAUyAR4nuV4Uysj+g@mail.gmail.com> <ad4oX0Py3T8j9Y7h@ashevche-desk.local>
In-Reply-To: <ad4oX0Py3T8j9Y7h@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 14 Apr 2026 15:27:39 +0200
X-Gm-Features: AQROBzB3_vRmQuXKz884wbDyC6ipYpYDGkHF1IcWEy1WF5xQRzrs189J_mYvgmk
Message-ID: <CALoEA-zbi1VOv86FrU2Skkuota0UGcMyHVJwffyEY7+ZsMSNcw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 13:43, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Please, avoid following the suggestions blindly. This work needs a careful
> check of what's exactly is being used and which header should provide the
> necessary information. While it may compile it might be still wrong. You
> need to (briefly) read the code in full. I don't use iwyu tool with tweaks
> by Jonathan Cameron, old school guy, but you can also try it [1].

Don't worry, I wasn't blindly following your suggestions. After some tweaking,
IWYU recommends keeping device.h and removing slab.h. My question is
whether the swap from asm/div64.h to linux/math64.h is valid? The asm
implementation would be platform specific, so swapping to math64 seems
like a good idea.

-- 
Kind regards

CJD
