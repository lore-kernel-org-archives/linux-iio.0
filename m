Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5043DD85D
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660684; cv=pass; b=uPA82USZQB9p9meIeibrB+3sCkxqCIf0XDrd8gkfacZ6qGhLKJi+UxczvoZq5fs/vUQ5hHft2rgYfZL0+DysT0feHnbL8Ensn+wke3l3+5T2ipmn+grO5BVpaAgZYwZqt2D03bPBG/rNnE/z4dhLUZKTithwqNhnRb9lfJReSzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660684; c=relaxed/simple;
	bh=bODAjHIeKBs0VTLfUPHWvwyMkmN6tSZvIAkF/ANeEcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjXnaKQ+/3pfRw6hCoKywsXYOh6dDLMfpeTCFS3qoxAel0hNl21eNfcJIIcQR1/b44p2tuSFuhsUnFie1UOh4EBkuzOnXVK9YiGdVcXUKRHpw4Djbjn697/tgVryQJhTHInwuiahlnyqLhl/NHMM+534yklBsoEm5puoOlKZ5bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB40TxIC; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB40TxIC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48e82c23840so28210865e9.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778660677; cv=none;
        d=google.com; s=arc-20240605;
        b=i7As5ONibPdbay58uNrIIYhQ+mn87Pnk7bdccmlbxRXxefqkCtpEmTJdk5JuesTlZb
         3ID0uCaU7r1ppkHJqGp3+bW4BDU3Ss3BAN3AJ/RNYWF7Vkek6M6If905RhePWHZ0tW61
         /X7bKpCNZJaDYxIdnf2A5ph6ETuYTehH0KMxh8Fug6i2q9IPMRZX9Ap5mS0NyVsBIQ4X
         OeTBhtAAqsEvfHN4BUJlwiPE2MqTka0xgP8uyz7xc6/nQxuewGoKCDqEwHi0Z/LO8aRe
         yvqcG0Bx+fWLa8YYQ0ENB9xPTiARRasmwgB1vlWZNZRrOp/gi8z3sKRGbAfRqc78S6n7
         va3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FCfQ6sj0Jp+sf7cC32cPWjJKiBpZZiiDbZ/S0R2QrBA=;
        fh=CPkZ4yYzHhhrKDuDZjlFCJ40P+5/MNq8A+Q0TscemxA=;
        b=G0IUt7Uodtbw2I3Dj9wSFHD2h67lL5KiJofMW7x0TxsqwH41RsqQWoPZRAqFyWN840
         b5ieQaNui5fHpDQn+QQmJqJQudYapKDkG2v2Dc8AJiGFM9N+TO1i3dq7s6gPIGKxP4q+
         GplgfP3q5FJtUAb8inqs5P20P9ZgMVlqp965Pimv+5woUMMFjW30fHXyt719pe1g6mZF
         pXEvpDJ8lyZnf4DR+yBzCNvBxUADXeR9yqv17zoVc6ufl6M4j1pQnrLGftONaIkRtPwi
         m7XWpM44uXSk3H0nDRLULb/TlQcJ1up85lntAoSBOPZv7e/DxCkO2k9tzVTscXRIA6UY
         O+hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778660677; x=1779265477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCfQ6sj0Jp+sf7cC32cPWjJKiBpZZiiDbZ/S0R2QrBA=;
        b=FB40TxICcgYCWar62uJ9RbTDcIRvCj6+y9h7m1W9lh07cwv84Iq5jvy8h12v2K9i+5
         UmSDOXVV3tBUp4jydRK9te7Agqml+JGz0nPp5xEMsThad+3ITkM6PcXBAv5BMSYVNn6U
         a70O5dGAfet4Abuj3R0DkRJ3qolNwnP9TBL9TnRPpCsT/41G6/E3QlML3uflAer+g74m
         HgYlK++d2faK/WZpHMX7Jbia0c2nwlqwUXJY2HMMuX4hEP/AAMNuoAIq2mgC2q9tpGyY
         X0Q+RSPECzw/KRbmavDI9LYDKrJCSPbGyKkR7A21NAnr8kuRJ6Woeu3sfw/Lw31y4Jc3
         gL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778660677; x=1779265477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCfQ6sj0Jp+sf7cC32cPWjJKiBpZZiiDbZ/S0R2QrBA=;
        b=RSnno+CLF2BUPZWLAwf80WRelve0XG2FmP5YZvXEcb+cQosWxf8oiaeCpxMln5nMHB
         nqJb29CS9MkQhCsVa73zG+Jk5SrNST4HucMbduo1GrLmWIu1d4Tj5Ny4H53w37ExV/SA
         f6I0Ii9DLG/YSqm0XpwMePu6hvt7lQfz763R9p1acEhq7yr0SIplKsCUQ11Atex3FkAA
         qVXiE+0kJRZQKqxbRx8W4NhbejRyKYiZNl+0PYSlhZGtprfBeLObylNulAI8V9Y6uuoO
         xGFepg5XB3XDBZAc+valM6UQqOOpDmsybA24OvqC6lNT0FHkYSyuFH62j/79uiBXZiWh
         G5Og==
X-Forwarded-Encrypted: i=1; AFNElJ/ocoxgZqI/cVTmsEqFNagPM5NnvVVb/jIqIwxokKkxj9K4GpOBB+J4HP/CfxKdHf+Z3b7pTTnkkxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yPW6wva2qatH0j4qsTNlGPQguTSfvV1VfJ9okaw3w3zRMKEi
	fNLJH/8yYioECGRlbd1/6qNvjzcZjZXwWo7lJ+FM52mr8PNnP4MlKlzHoRVCq3JHM1x0UvAexDZ
	Iwb7OfNunHO1sG+XJ86Z7s+xBMMGBYtQ=
X-Gm-Gg: Acq92OFMON8vT3z8pX8LVpf2N5O0G13YK+9AbAGcNdUkdkG7CrCIrYmouc1AC3FYJ74
	p3fgv7yxaDJumbPOLIbm/8WJdMHs2uow9rEnO7L9fb/kKQvLAuHw49iXz7DgbiORZMDFlZVv4fS
	rY95yMxGdmp8Pkj8I3Wp/YJp/EV5JIyiKr48y+0obUor4jT9S+aO+gb1Nu7Lp2wMaRz1ifVWO/G
	AumZCSr4+K4DWgfCeMprVqSTg8xTWA8keTGhFfNGx1R6yO+5d8sakdZjwJAC4bEUKYe4rCtaDQp
	adRaPsymfgnu26NeBagKGyxr/Fns5+YOJnKyPtvhL4k1dCD47Th4ZOL2VNX72l/KZTOZgjkh+es
	aUdcnbSLLbPnX845KAUJ7lviIQ52trE6m614y/ropXZbIgWqptfOKJ5s0YGtfmgo00aog+MRWPJ
	X+0SZzNg==
X-Received: by 2002:a05:600c:621a:b0:489:1c1f:35f9 with SMTP id
 5b1f17b1804b1-48fc9a0a043mr32478805e9.9.1778660676657; Wed, 13 May 2026
 01:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
 <4742ea18-f3df-46dd-aad4-18d1e5f03f7f@baylibre.com> <agNMkMgSIgQJZLex@ashevche-desk.local>
 <f2c90ff7-09f6-4e56-ad2e-5b883e98db9d@baylibre.com>
In-Reply-To: <f2c90ff7-09f6-4e56-ad2e-5b883e98db9d@baylibre.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 13 May 2026 10:24:25 +0200
X-Gm-Features: AVHnY4KSjMjMkO0Vfxcmz7n56QfemSOI5QAu_QUKGkbmd7NATNEaF4OgMxvpjdA
Message-ID: <CALoEA-yaJPEZgkvwJqszaKU4GJoo7yaYSTLZ0=pNfKiNXqgpZw@mail.gmail.com>
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 17:57, David Lechner <dlechner@baylibre.com> wrote:
>
> On 5/12/26 10:51 AM, Andy Shevchenko wrote:
> > On Tue, May 12, 2026 at 10:36:00AM -0500, David Lechner wrote:
> >> On 5/12/26 2:35 AM, Joshua Crofts wrote:
> >>> As promised, I'm sending my IWYU mapping file, based on Jonathan's
> >>> version with a few additional tweaks by me.
> >>>
> >>> Other than adding support for more assembly file business, I've also
> >>> experimented with individual symbol definition (see BIT() and GENMASK()
> >>> in the following file) - this is to prevent issues such as the tool
> >>> wanting you to include <linux/bits.h> when you already have
> >>> <linux/bitops.h> in the source file (I agree, doing this symbol by
> >>> symbol is tedious, but BIT() and GENMASK() are symbols that especially
> >>> do this, and they're included in most, if not all drivers).
> >>
> >> TBH, I would favor rules that are easy for machines over rules that
> >> follow existing human conventions. Is there really anything terribly
> >> wrong with including both bits.h and bitops.h other than "convention"?
> >
> > But why? When one needs bitops APIs it includes BIT() and GENMASK() for bonus.
> > Same with (and especially) bitmap.h. The latter is rather a heavy header.
> > I do not see any point of having all three and even two out of the three
> > bits.h, bitops.h, bitmap.h. Also this is a type of unification that helps
> > scripting any further header reshuffling / cleanups / ... If we ever do
> > something with bits.h, let's do it on the files that really use only it.
>
> Because that is human thinking. :-)

IMO human thinking would be to simplify trivial include cases such as
bitops.h and bits.h in one file.

-- 
Kind regards

CJD
