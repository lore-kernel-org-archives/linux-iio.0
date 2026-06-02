Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECB1C84CB
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403607; cv=pass; b=W5ibewyUaeJZ7Of6gMPuY9s6w+Ivq40N4OCWq1v0NmmXHw1dOgpwkQhnLhUbio1XjpoJLjHAexIc91vK5SWew9EB50jHDGOyy9Apa5pD2+siP3dVFGxpTaIgh63u0uypufXgwn0hMX8BPRgcVLUjpswjR8ua0IBJZscMHJAZog0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403607; c=relaxed/simple;
	bh=7rr7i1DeFDlRQ4sV8bk/3mLvsybuK8FZyPk5gbKEYII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzUwaB9vQImIIionpNn+eAi++oR+LWWzCoFe5ek7R3Msc07LpPuh9yxTfarzSs3xVjyRmMFYYpNUOe4iVGVY/A9fmvBiyq0xlhkLGmck0+yIOns/Jak2KiPcEm8aBgtneVx0COs9BxL2cUurKyk0wQaTxS1G0SBhtza0g/mgELo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgurOTpI; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgurOTpI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a762db7aso19594965e9.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 05:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780403602; cv=none;
        d=google.com; s=arc-20240605;
        b=eyu2IVCAhjGPZcbWTVE+QT/2UMgqRLuq/NR0U55ePU/Hz8VsT2Mvs/zN03iKGe4h4R
         TZYD5QfTQYj/WZlOLZtsIGVgrSfRKO28yZy3aYp34p1cAhN2sunY16OSf3ZaXQ6bGoYM
         phZDR0wTIRrtWBcMYDeTGjv2zPGzPsp+cL9/CffidL2vVq2hDzDwVVbKdaMQG2JxqYDV
         HqHf7P9YygL8qFl/R3bhqx1Y07IZKS5aeO334JWMEQ110B+NmRATT7u/YiGsBymfFhXH
         A2/L7xiZ1JL7M9Q8FC1fiUXOlA5ieOpZ4e9YlVG/OE3oa3+8zEAZenIR7+0kSg4L0p3f
         zeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E16/X02NEFh/HWi6uxt/+AI8HBUQVZR6eLcIHEdYo+4=;
        fh=01xBzrVe5UvNitFm67H5KPPirgSk3u9hbXnKUql4mPM=;
        b=I8nZOfAMucQvIrRPyRK4RO2pOJ+NTt6z43BppGmSA3MWwzOEKjIZEwfdIOcGya1OK4
         4dxh2K+HTfvOztJoQHGHHx+eIV0N+ovQiPhe/3Vlt+LbCjRazNYAqBjjhljbI9gAlbZ0
         ZuPhEpoLKDIedu4m3/uOkOLvlxm5dZO8p9s1iLyLSfcbXjEGwRInTXD3bwEyIVbicVtd
         asM0nonj1xyBvuhkjKErz41W6ptnW+/IYJGV8LeK77rBAJ3TpMKwduYam9UYwDTwrPLN
         16m610tciRdU4lf/PGp88H1wYlCBfu1OUDwWLcItdoDQH45LshVY+cCrrm9XktSITnYG
         A3SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780403602; x=1781008402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E16/X02NEFh/HWi6uxt/+AI8HBUQVZR6eLcIHEdYo+4=;
        b=EgurOTpIaukWScF9m7NpEbumAyjSLxCaWXRJmSuQceuO7oNviJFcvE5g9Opa4LvDAZ
         FczwtSyhxBKSENMu6bkUmFcZSEZK6IaLTDzNo7vnYQqCvekPiHHf4foTkkIUqEyd/Ma0
         sBaR7QdKEj+TFxnlw6pCxbBeLsBF4Hoh2vN6dS0Ah9AvFY2k6hWD2Jx+BJ3cChZg0/bA
         EOnetq1qP8GLpaTSxGuByhO6k5VFYch4QbWsBva/eyL/wNIUGBeyEAm8ijJM0uhrM1PS
         J3+zlEUe6eYzJrHbzU/lnRrUjnCS1RsL9CWz4Ai6zYgQhosFdv4ZWwQxkJaCi7sYuVsL
         b26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403602; x=1781008402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E16/X02NEFh/HWi6uxt/+AI8HBUQVZR6eLcIHEdYo+4=;
        b=BTFUlTYFQuAsl/CcvSSdMqd/ZCZ54SFzlFmL1bOyT/rOyqVS8eHS+8eAz2L7AyaPwj
         +7uKvk5IAvDjwUB0BF0RIA7L3CW2FCplnLLVTRIqwRYzslTtv9okexmmd1B0KO89vTQI
         dgOqjtvUbZcmRGak3+41J9QlAdAm9fQrDhLZzhQi7eqD/slKtIr3h5UcnxTHNKYr6E+w
         TvStD3ZO2btNAcgtwqSQBO6L9nKBq3RN+xn/nSyF2fKx8YfI+tzotj4hxG1fP1yOx1BP
         RJFYi3w7j3Gv1ndYcWOt0SkQL4HsGznjHiGBlYtEYqFZQiZu0Uu+/Y33EFVluSEoy9L7
         rcIA==
X-Forwarded-Encrypted: i=1; AFNElJ/1IUaaN/kL2LMuzYszkGvZFDQpxeo/WgrK5OaEHo/8b3GVYzIf7D5C8PiAXFAtludPBwYOTB02kJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxcC94kRdnET7w9VtsaHe6a+L5GAC2fi+TyY8wm6kfinngsQ0
	TygbiXM0x69qMAbKxNn7uVTJFlhRkkIeSn5xZoewSd5/Slf5Yg9FxUaW3ujQwmBq6Tj9AO3U+Qm
	EwjHhOD75qxNin17+grqFpenn3rq1QpA=
X-Gm-Gg: Acq92OFbL3qRA2Xb12b88tftiswET+AkzeAoRlPzzrlm/VNtx2xDKT69u7RctIQpejl
	+GYkvfjR3Jv6sHIU70FdKMkye+EIWzi3YN/FvoF43becmivAdd6+S524ljC7wBSUkA1rBWct7wG
	jzLf7ouFSirbYtT7cTVZ7+WARQNzOfF3ir/x1rGYT1bX8Sd9Ak/m6DYXJCBJA5sTC+WukSkxSFX
	rSut/L+OErwGXccUpuSpoRfGvDNXAk5cnBbX/qdjEqv4QIJxoqx5eIIm2cxzA8bZjyiTVznLxpU
	oKa0nGU/0R2FhwE0vc/b8ZOr4IT/2cLnwCTpXWCtLifzdU/UZLeMhsQ60R+2SsNzsT2QcPrSZWe
	l+rFpJmjAnvZg8dzG/dkkUKPAwUv+HPSgMMo5fdiAqGT6p1lpcVq0TKRrQRtJTbMzp8B1uOtG/k
	mrWlAZEWjqAAmRyuqS
X-Received: by 2002:a05:600c:46cc:b0:490:b0dc:6999 with SMTP id
 5b1f17b1804b1-490b0dc6a2dmr72712985e9.29.1780403602255; Tue, 02 Jun 2026
 05:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com> <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com> <ah66ljSiIc0ywFC2@ashevche-desk.local>
 <CALoEA-wdakU-Ei2FE3WpGR+CYRDN1bjv2sZ=XJ01ZeH3NP8xeA@mail.gmail.com>
 <DIYJ5ZACTWVS.13T8L275VHTKM@gmail.com> <CALoEA-w3TqD=2YP36=ScmRttmmG3BBCKvtfSqeJL0PVxRxEbuQ@mail.gmail.com>
 <DIYK6APQQX6S.2KLGTD0G5GCDA@gmail.com>
In-Reply-To: <DIYK6APQQX6S.2KLGTD0G5GCDA@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 2 Jun 2026 14:33:10 +0200
X-Gm-Features: AVHnY4L1aNrp6X9UJAt4paTN1MSnCrIzKR0xmd01VQ0YJFvsJazQhY76BG307BA
Message-ID: <CALoEA-wXRhiTr1gA8GdLAmt2PO29N9S9FrX4ueab7P7FJ+HOPw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS series
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 14:22, Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> On Tue Jun 2, 2026 at 1:47 PM CEST, Joshua Crofts wrote:
> > On Tue, 2 Jun 2026 at 13:35, Javier Carrasco
> > <javier.carrasco.cruz@gmail.com> wrote:
> >> Thank you, Joshua. One question, though: maybe you remember that your
> >> last driver was missing one header (which I am not criticizing at all,
> >> as you can see I missed some too!), and I am wondering if it was because
> >> iwyu missed it and if so, how that could be avoided.
> >
> > About that - I didn't actually run iwyu on my driver, I recently migrated to
> > Fedora and forgot to set up LLVM and iywu-tool :-)
>
> I installed IWYU and added your mapping for a quick test, and it wants
> to add a million headers or so:
> If that is correct, I bet there is almost no driver prior to IWYU that
> has all the headers :D

Well, as Andy said - it's still far from ideal. It generates unnecessary noise.

Question: did you run `make compile_commands.json` before running iwyu?

iwyu_tool -p compile_commands.json drivers/iio/magnetometer/ak8975.c -- \
-Xiwyu --no_default_mappings -Xiwyu --mapping_file=/home/josh/iio.imp

This was the command I used when I did some cleaning up on the ak8975.

-- 
Kind regards

CJD
