Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF13264DD
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396137; cv=pass; b=bQt7wmXXrycAeP/NS3PpMgqcUDx88YrpH5vmYYj0W9HZNYwqOX/Df4Lfp32UUEa6eUatePNfeTKicAIpn+acFMULpgr+OaYFoI8/A/bVnjoF2Tm0YQocsVn4dgS//L6yaX6YZ+7OHcQPd01S3+EBOkHY/1x8YzZfHsrScIHAb+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396137; c=relaxed/simple;
	bh=LLR33iW2Y4jV7zxlGqWLjZhlUj2opWQRpZ+mp3cdTIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA7dTDeZ3QZQ40yGRX2eSgzh5a3lPqyF41njgNbYCsQoMQiQFhOMe7IeyBQIyA3TweXYPG5ujyDLzNnFpv1QIeRy3/lPH+rdNYF7j4HCDq1Bq1DosNlS5KhzSmVm9re5eGfF9fOe1x75/fUm67yo1Bb31zAAKTAMWdBpa0kCTyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrGhORAY; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrGhORAY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ea87af213so1053657b3.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 10:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777396135; cv=none;
        d=google.com; s=arc-20240605;
        b=fgSUbk4DaV/eYY70qgLVD6uvNobiqYF3VqGQi7fMLFtqHEvZsXxRpElN01J6kGvEqm
         NK0NvMz4kIl6a5Q8UYP4v8xKcCeIEP6au1CqZhKBr5frh05re+nlfh3ECFz8nriCq8Sb
         Xrx2SIZbzpwW+oSsLirya4g9ShxMu+0nJeUFkgahtr/g1r+i5f08cpunvEyGurqho+ma
         OSKqIpq2aIhE/z0Kw8OeM23Fltm1/6lWvN1CHiak0kEPXDmlfnac4FiUI+AonfNCIQuY
         gRnHgQcPm8+GArOfU7Gr48A60CfTTtYBcJ2efGV2qSLWpVGqbeL1ET23wnxOBYCjO54G
         m+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=41Q4TqFhapSt44Vzyw1wJCTcz2iKhDalAAlyWqfPZv0=;
        fh=e10aCE8XNDc8NWB76ai6s+A1MVbIyFOTw32Dt5mm4Lg=;
        b=UuP/z3zYmwWSJjo4YnnCMsI9rIbPXCEz9M2z6nnJc9/2VawgUJyUWbBymj/TkoP7ML
         lJXGzhif/x6cKxw09Z9ssNVuw73QiS05OLiMiGsWNHkJAyRd5F5c0nzS1jr25b7beXkf
         VEeeq8iWG6CT5iSvx/QNJ/YMuXM/WHl1thrS0J5JO2xbYFO0tbfloUei0CPCWlCDGDaT
         k/5cbl3ASqXWddSOtPfMz7tH8W4zFsZif5pljujLgi1ZriLThS0ofgdwgjubItUr9wxR
         3pz9B/1cy3pWD8RdPI6aSrYGf5rPHGJ5S1tL6I9vGuwwlr1hH7BhTxdUM/Quvp5AoEZi
         9WIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396135; x=1778000935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41Q4TqFhapSt44Vzyw1wJCTcz2iKhDalAAlyWqfPZv0=;
        b=MrGhORAY7Viv85R95U3rQQpLsK06NNkqJfcZoO8TUwP/yGEhwZK7rA1oa2FQqQNaTS
         vjTabSFAFXThJ+LCv4heuaBSZzJoinXTeexwjsiCFSP5iEvt+FyiRdwB6oF5MWwRCDhs
         TrWpi4UBy8DQPKJCn8DCpZFWFJOuI5VKntk1UkHeLMPjoEGj4vqAi48/Qv53n2NIb5IG
         NeDMhxBAaz6SXwzVbb72Te5A7fEuwm50Kxe0iw2GPGtZ1WzPJt3903gCegLrLiywyT5G
         s9XEcfr8S7hD6xV5wmhTdLQWrOGVpMhPeOFRVEE1fjc+Ba8Lr6qm/+11Xa6+1s8UNXfM
         Bn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396135; x=1778000935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41Q4TqFhapSt44Vzyw1wJCTcz2iKhDalAAlyWqfPZv0=;
        b=hhP6OfNEdJ0KFPRBukik5huPqEpy6Ih5Gzr/uXMiT92fGUO0wxZUBFkvl5b3QcR6kX
         PHTAz8+MFZ+PWdqhbfJVBKzLHkWXedO3RAXYw6A2H7u24+jkLCxGk0o+yU39PnLbzz0s
         pF61qn9ALbSxbVzJTG9IYBBDGnAkLGTggVfYIU1OMCkP8s5dlxmKVYwM5Umj5zLLOr2X
         tR3VAL2RzUeWjXcP/YIckkIXRfcUlY3roUQiPnRPvGtjHsNZV9lFEqWDizUD4Act6zBE
         QXFyVUD7EtbrDJMT0LFGQlzot+07GjDL6o6ft0cGlii5sjKn3nYGN6as1xTnRwUoIPWu
         icXA==
X-Forwarded-Encrypted: i=1; AFNElJ/y2ajTalKbyo5iPCXhWmPgIW2hLtlqAgrqJlOErimWFHgSKNlRm5ATNiPXIKj8Cqy3vL2ZlYjU4Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6cHF0BJouR42v5L8xWhTH2a8BRzUNtQk2V9A1g5ZIoBStD/7
	x/RqNowe8vkUtIRid9MJbWKnv3Vqk1+EzAR6j6hFm17+SWP05G06YE6uopexalvazeURVdgjt0U
	YYaEVJTl7dIYo3nVBngETlq6co50f5y0=
X-Gm-Gg: AeBDieu6HK31rBVG7I8Arx5NPPv4gwh/3NSFbZoSjM2zqxe1PU02cUq1NLv/w7uplrd
	Vyt7JZ3nxE7jB1qwuS8MNtA9jBU5SYB9htn+wouiSnvp+h3gQ3N83/r59mx8cBauVBsYeZllNg/
	BCu6Jkea0x/sfc2ZgrVWMtbkJQ4T3CuGPFTgT0xlv0hKr164+lfKjq/kEYIDpyVneuSlkGXPPS9
	FuKCaGjjCOOBwnktYPUjWs44U8ytcu0mvlYgu3Xs2KFAd6YEouUYejxR9u/cjF6Akpa7CQh7B4J
	CII6p9IolkFDsARYxBrU
X-Received: by 2002:a05:690c:690a:b0:796:45d4:9e55 with SMTP id
 00721157ae682-7bcf415ec02mr33895097b3.15.1777396134876; Tue, 28 Apr 2026
 10:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428124644.49707-1-m32285159@gmail.com> <20260428124644.49707-3-m32285159@gmail.com>
 <afC1mdCZGZKHQx5V@ashevche-desk.local> <CAKqfh0HfbUkAFDpf6vmBba+JGRafemoP0HeVy5hzzQB4=Y94Ag@mail.gmail.com>
 <20260428162458.09f28de7@jic23-huawei>
In-Reply-To: <20260428162458.09f28de7@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 28 Apr 2026 12:08:44 -0500
X-Gm-Features: AVHnY4IUz8syjWr77yhUDfsGsSv2lXKtask3xuM-u6ZLeJ-cXn19XoA33vog8lE
Message-ID: <CAKqfh0Ekf5C6SB2EeQtDDJJmM6FD9YBWYebiKEF_hZ2Uq8KpcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: magnetometer: rm3100: Use scoped_guard() in rm3100_get_samp_freq()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, songqiang1304521@gmail.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:25=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> I'd just use a guard and not worry about two value lookups from static co=
nst data
> being under the guard()

We'd probably want to keep the scope as close as possible to the
original code, but it's your call, I can use guard(mutex)() instead.

> Why is this series broken up into lots of patches doing same type of chan=
ge
> in different places?  This could definitely be combined with the previous=
 patch.

I've had some suggestions on other patches to split some changes, and
thus, I've been erring on the side of atomicity. I can see now how
this probably should be combined, and I'll merge these for a v3 and
add the suggested fixes for when I have free time.

best regards,
maxwell
