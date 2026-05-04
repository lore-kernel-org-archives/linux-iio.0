Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D0363C64
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893925; cv=pass; b=qFjTSXmVUVSmQcFmiITTInnuGNWEafEZcyvT9OD1Bd1tlOWAlgf8IifAmCHGOEzZn8Ge9NdRQgZkfVVpzfI2NFYmFSkP6vDtMPdtwBf/d3dZe51obsOmf/v24+TKhoPEmapoCZEXeHDyfLmfgaymfOvWGOS3nBZoWdJxaxrFcGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893925; c=relaxed/simple;
	bh=npzpuz0Oy9vz3cI37s92kZ9/Ea7LKoSVmJZlYjLZVrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD/i+h3S6LeMgtPKKKIOQXPCixf8wg2YMLpHxlqQqkjtwfpv5ucf45feskx/IohVlDpHCIThgIZHnV1XmWNubti1uK5NNrCwcGS7KtdBuf5r9FVcm1WV3WyGo75cayviF7klS0x7A2gsDpmcovQ46wHjfq0BQAe3wVrfFy5/k9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCZiIxRO; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCZiIxRO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso49581355e9.1
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 04:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777893922; cv=none;
        d=google.com; s=arc-20240605;
        b=eVqeBLomEiva2NFPJdJ1H0+6GqjUKy8/4//8d3QRE+2YlmG5JHlFeia8nh0tt+yry9
         LGCpwflAHjhGxbDehx4FnsGzuissghglRERd2X9jqxjakawJ80cbqszUdt0W81yT8ny/
         6n+7GixAm+gc2YZRubV7TKZGIwYtuWfJoHCOf/4atdRTY4xDA/CKdRgid9QYYvPRUGQF
         g3FkKriB6le/TIqbW91D1VZZMTV2jdar8pt3jgCfcSjMnr5b8M9A4kxjG/z2OpXltuRq
         +QHwMhk6MTkB1lXzQmsYAqNbXHeyU1NsnArxgWMzAyJ6tMs025lW/l56UkSp4vSspyXb
         09rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=10O7kNjZmPICKHhcgd5U8jW+RnayD1FuDOPMj3SxSK0=;
        fh=VEKioRkuJoQVlvNLygXHC2C2cHaYxmxm6C4UBACkylA=;
        b=CY0en+SuYmuYuR+b9pvaArQ+PYD02cHZWIndTktjp+gJVg1E7IVQdoQ9g9STXpT0/+
         ZxslPOY0z31yZ+lwzpKO7IJQgZ/eY/l8P0JpuzZzWh4y9mU6HhtAsDdVzYcOr9Qah5wD
         rm7fWlks1XYlPa/GXQ/Mk4xNbngWV4sqyGO69GXsU+Z4JjPXh1ztv525Kk/hjAuAdn6g
         6DALt5fKRSRhit4FofGG0tseBcHCiinM8yllc6QJRhQfKD/YPuY1PBHyjK5zh8bl/uw8
         9PwTbW1fD4WVQu4UoZaqKq2fzumLrY+dXRfUaaik/9Cg3fwmcc8uCSNdwvUfQUtk5QKQ
         wbZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777893922; x=1778498722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10O7kNjZmPICKHhcgd5U8jW+RnayD1FuDOPMj3SxSK0=;
        b=NCZiIxROuY2nG54J4ZzOMprDL9VKC2kNPE1xaToxFInOY/2VtKmcuRBAxOgwkNgIPH
         IzZKvldiH9NNBAH45QwdW93Aodj2paeiqF3JUy+EEcRn6dJWd0xZmpnvKPDW2hwiSNKJ
         c4IqgylktGiAyDqPl9CkxnePimLc6FI9nFVSHQz97sr5wf3dOOI33HjX63uo0vo+u99h
         uq4H3hOdCnJJGU/4YCWEU9KcgvKutfyVOe5NFCdp35czU4kfhbb788yUei+WH7VBEM0G
         43BARk5oo3JYMUsc5ibfZ3mav0scWRUnpcfBfluHh8eEOi7iYpn0JZbo3ftr0hK5NPKQ
         5Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777893922; x=1778498722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10O7kNjZmPICKHhcgd5U8jW+RnayD1FuDOPMj3SxSK0=;
        b=eHBF2d6P2g86wFg78JQj8GIjujttk95p5fTJFoHxno2Yvkd4AtX3MRwrXbD3pg1T9j
         1B45n67r3vWu/ZRbwt6z5+fH32agiaoIZC+jrveUGIZOjygX7/Q0W38pFDRmBw6gMpXv
         Ct1czByEcv7L9q3zW8eE6vcsE5E4lax2DxS9MGRW5zLuuIC+rAmkbXZczSucr5nbpmpk
         QXlMf/y1YDIbN6YJwY3CICTMOinOLrLUyweVrPgQa97CZMddwCGfBR+gbiKZpJ1uE4Z0
         mMOChk+0qRdBCyV5yMW/VhqF7s/Pa22QOGYdrf9moNznn+KL+dTRk/kGXpI5E+LDYUbE
         VqPA==
X-Forwarded-Encrypted: i=1; AFNElJ//7z1FK/fi1oRF468yPQFg+WWp9v/FevAHQmjJ9ZhNCVpFhunlgMC0sgPOwQEeZ8+UyVrAz4dWyhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyso/qr1NvR/KOmn+lHu11d7GyQzgfTQoV1ygkIf6+AKk0QbpQ3
	jRUlObHaql2eYXZT4rG8EzVU1lk/A3naJ8v7vm+1TPebkg+Bic7zFmi4xaO3NFET0jXAFQWjgwN
	BIhRAAyNPnlYjEWm4BEKMXKo8uEtxzLg=
X-Gm-Gg: AeBDietIgDGy49nt252WmflS2RlQ7MNO8uVHp+YJgehRqRSENPpBHZDeMFEjKZCppRo
	kXhZNFyAzq6QVyg9LUJMG3pw1yAMX8YRBxQ/bTqlBnQunyK6q0/xa8xMMya3/yJccYPjG9eU3BG
	fYLUpMbociPGKwiffUReQSx4H498dtvxzhQnw2J778HEDH/nqgK8ii3F2alg6HSa96da7FEUDQx
	2k2cVU6FqoJ7XVSN+EVTILvm1R7Pf94pRrVRbLNr9RXqjQM4r0D9WPQnFVkzWfuaYzwnXfe4W0F
	q969kkVAzorp6lp+JtzCJpRXxKa0qqLdHwlkPWDtkL/EKNpx5IrJCac4wt4y4QkzqGWHWMKEYDn
	TGrLP0f3ZuN5avXCXtJvfUlQMbTqyIOElRLs2aI6j8URhj5p/vs1TAb5IQmSfgS2qyge+DZ86YX
	kpdj0feOMhD6de1jY31sKRu/YUHyM=
X-Received: by 2002:a05:600c:1385:b0:48a:5970:2005 with SMTP id
 5b1f17b1804b1-48a9853c8camr159540635e9.2.1777893922417; Mon, 04 May 2026
 04:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com> <afh-smyJoL7xRiqZ@ashevche-desk.local>
In-Reply-To: <afh-smyJoL7xRiqZ@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 13:25:11 +0200
X-Gm-Features: AVHnY4JbsTpjGFpnifGYgc_piBaRdD49PdA8TOGJAHM018v5UAN4uELCHBbQmaU
Message-ID: <CALoEA-yr9B+74KdSY1iEYssvPQoSXdYjXpNFBzrdZm4RHvJ1jw@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 13:10, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 04, 2026 at 11:48:19AM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Since we have switched to using macros from iopoll.h it's better to
> > use poll and timeout values supplied as parameters to the helper
> > functions. Also added local variables for poll and timeout values
> > to prevent magic number use.
> >
> > Besides that, fix the home grown and obviously wrong in some cases the
> > jiffy-based timeout.
>
> ...
>
> > -static int wait_conversion_complete_gpio(struct ak8975_data *data)
> > +static int wait_conversion_complete_gpio(struct ak8975_data *data, int poll_ms,
> > +                                      int timeout_ms)
>
> Logical split is preferred:
>
> static int wait_conversion_complete_gpio(struct ak8975_data *data,
>                                          int poll_ms, int timeout_ms)

Fair enough.

> OTOH, why are they signed? Maybe

> static int wait_conversion_complete_gpio(struct ak8975_data *data,
>                                          unsigned int poll_ms,
>                                          unsigned int timeout_ms)
>
> (but please, double check that there is no possibility to have a negative
>  values there)?

Well, considering each wait_ function is called exactly once in the code and
accepts only the hardcoded ms values (which are all positive), I think we can
change it to unsigned.

> Hmm... I don't think we need those, esp. taking into account the difference in
> the timeout_ms for different cases.

Okay, this was suggested by Jonathan on your v0 version, but I guess there
is no need now that there are poll and timeout parameters added in the function
(or maybe the suggestions were for the parameters only and I
misinterpreted them).

-- 
Kind regards

CJD
