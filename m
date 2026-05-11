Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574E365A19
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498252; cv=pass; b=fn2xm1CFI6Cb9yKDIMiCVw85N2NK68Ie0gcvqEocdNMCHlINc7YOPkJSTrnWcEi+2wyRu6VqD75prYy/2kOVinwx6jd4N2CXuXr73Xhdk1b9mNLREOUQImtGrbE/f9DFxQ3iZlN94zdc4rXcAqxyqGKiH15A5P6tjBh0Ys0BBVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498252; c=relaxed/simple;
	bh=pmAbqMBnsKfp4SiEj8nl2yLSaJak2SLGuLW3XLxoWQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epQLRwyHI/ko+bRo/2pQFCpOYgmgUYHofFNiGxK5qtg6ARTTnBHFjonF/7j7WuPv5V5Ll0yLqUiti4aRmuHPrahhl7jFYMNM03FZMGiaxrC45x1MpEnfvAtVw7KEnwHfq5zt1543EDalwRFOMkglrHasDOBDoyNM5fYwrO9m/UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJVd9ZaL; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJVd9ZaL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso28673225e9.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 04:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778498249; cv=none;
        d=google.com; s=arc-20240605;
        b=d/BkQdb+htTvD9pFQQwrRJga6ESL6YgPjzNeDqafDeI6r1tCk0oKRWqH2YO6khXJT3
         mI+zEaYuDtkHTHnZkcMnaQujD3KoYeaaS4E+bhKHUde1UBMoKqv7xibrQMQp4KmEMv0K
         +wpOUlb6/d4AEVA5B89Ws5VOfthST0igbLfjCs7x7/SbxO82wp+RFeq2pZilFOmZlMuf
         cu6kVGHLmcb1XB+P+7rPFtb9HPNuI6lIkmA/Y5nDzqJ0LnNOI1p4zrzWlpLQCcSYaeE+
         qSIXKFrXkaTx0moOaY/Dhldh3WwDy64+l130iFGbzC+kxF+6bIX/PIIS1nHDj6VFyB9L
         eD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IhMfkz9L2pNEJyntY85kSzAabjbO+SlIqdWcnCaQJ2E=;
        fh=2CixuyTWlIeJBD2GqULCfC1pHiYEe3gYk+mMajDGlEI=;
        b=bLSK88DFr43hQjgG5t+z40mADXth7EpS1m4MHHsW1UqyYQJ+LaJYVIL0+YeRvPDHrA
         0MTzSDdrlFmGG1qq9JyCY7jqkb0eyvjkHHsgeYrrGuMYj2X0C0NwEnTMg8kcnNK3o5ao
         4+HeZtEl9i/BrFi3twHeAV8nt3MPqahvQMtJmPWLfrh7dmlFztTpe4CTEbqwtdItQuwK
         YkTqUX/83hwAwNh8QdiziJoLBpyvK1Svtn4/rNcSnRPOloZKtcOmY9R7ARTl/AILRdNi
         rAzY4gmrasid3FmQXpplrGdqWO585BEg+3gCDMX4KSd4Xq6eNmJR9xLZV2fq+O7Hz3lV
         KXdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778498249; x=1779103049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IhMfkz9L2pNEJyntY85kSzAabjbO+SlIqdWcnCaQJ2E=;
        b=VJVd9ZaLMtSQN/hVxu2CWMs4EI/K0FY2hvN5pfyE1eX6A3MFdFE02tyA3yfeXR6cX7
         yCMXlCjWlRSqZkWk0svkP6ruXSJQD1D1ee/AFKtYU6EtzCU/pqfWoMiXMqNl1wgsIUSr
         +0xjEI4CIwkGdJ4K6IdHHNAyV/9LpXkgYTru+Bqf19uxSLGasmXDoucbScC4yMO59P49
         ikRS9L98PauPfKEKGDFHe+Nmybk6a3f2YxBIfwxBxDRapI5g0VROeoJIBI7PD9k3NNu3
         jTFtsi2k1vSK31Dqu1lg6DLrN/KaSYRPONppFOG66Lf5KLSInlszBRurkAlhcgiS750P
         wEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498249; x=1779103049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhMfkz9L2pNEJyntY85kSzAabjbO+SlIqdWcnCaQJ2E=;
        b=KoeQZdjW2ju9YK3Dn7ClEdnPgHh787VWrKswjQ50fvppafvNoTL1l0Px2NKuAjVLRO
         OWLa6Oj1+8cvIRkXRX1y9X62+IJV35O8qg/N8tGczGVdWr7L/AtctZ5g48WQjzSdkN7i
         drtVLnbKQZbOnl1GY6pQS/nsTpxJoTNtKRap5DJMbPy4+WzGOyakGdn4dDELU/Ew6HfH
         hz19nTmHprFWvOo8UUvR5ISkSh9/LRterHDIp3T3WegavO3jR+3m9Gzsp9MwnpgrM/uO
         KrA9eZODYibEKNagKh4vuaItso0J3CNNi+ETRwrgqalWXU2eyeBm0a3Jh3ApTkGzHvWo
         otgw==
X-Forwarded-Encrypted: i=1; AFNElJ90sss8Scw0RI/A/R8RpDKPyYiN08VDTJsFwBQV9Am/klmPePN8sCclPA+vTI13ooQz+9IyJvrS4fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+jzQOF80eWvgZld2rCnl+Gq4kAxAPzMSrf87Sceeup6hGiHy
	XmS9cv8GE9T+beyzez/uAyNYDkeYvCBz2LQjrMNT3kCoPq+UGBa6S6Uz5Im/Pu4jgHehghph5pS
	2lDbGFzEKH8XPmv/039kH8WcFwUFcSBI=
X-Gm-Gg: Acq92OFy6TaAxQDmhF7Awgf1irnKAH2g6Aw9MlftyMRa1pVEM2IRK4tn0LfaDhvPcTn
	lPDpftUiHq0NYycvcASJ9OE9yo08HSmc/z70ZBwSmSPBOBJNXsa8eA3IV4L42IeTf1wNu4o/226
	Pcl2nr/s2eO6eh11H3/LBN6C6nLQmwIAXg7OuuYryY/5TJa798xRcQFtQkc/WuzNSLFvKM3B+3S
	OpDi6YHNU5JIrwAfSsA/0HkLGBm9qJ4tTLsy9jVsznRmcON+L+PjBoxVoKuas4OdComu/Tlalhc
	qJws/9B9u278lCxVL+0n7wYcbK8hXpiCCnedQfB6YGO+aePPd23ibr5Nwe4GlQxxC6TWM5Wd/1E
	M+fxKoJU8KEoDiSWREQkGsytaApbwfrv/ShldJDgkTQLFJ83acm7p3DneYvD4ZUI2bzkqIfkR/b
	8RUnTXVA==
X-Received: by 2002:a05:600c:3e0c:b0:489:fec9:a17e with SMTP id
 5b1f17b1804b1-48e6768514dmr240780285e9.12.1778498249173; Mon, 11 May 2026
 04:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-7-f7879dc3455c@gmail.com> <agG5xusKnl_NOn8_@ashevche-desk.local>
In-Reply-To: <agG5xusKnl_NOn8_@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 13:17:17 +0200
X-Gm-Features: AVHnY4IYBn5yi9t6PrRtfSdq2m34S4JIhKoWaxnNB29_iGDo7orTtpKAKNr9aFg
Message-ID: <CALoEA-zU_8ZJoDO735GyotGQHo0qyxUmP8TGAHqbB9204SwVog@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: light: opt3001: switch driver to managed resources
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 13:13, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 12:04:12PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Move the driver to use devm_* functions to automate resource
> > management and simplify error handling. This also allows removal
> > of the opt3001_remove() function.
>
> ...
>
> > -             ret = request_threaded_irq(irq, NULL, opt3001_irq,
> > -                             IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > -                             "opt3001", iio);
> > +             ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
> > +                                             IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +                                             "opt3001", iio);
> >               if (ret)
> >                       return dev_err_probe(dev, ret,
> >                                            "failed to request IRQ #%d\n",
>
> You need to drop now duplicate error message.

Oh yeah, I remember you doing that fix in the AK8975 series :)
Good point.

-- 
Kind regards

CJD
