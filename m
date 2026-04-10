Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772938A725
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804297; cv=pass; b=RpxA7p4dDl93NunhYxy96NXWuARmkmjhHf/q+m/LpDnBgPH/WyD/1fdWsRNLc39AGplYt+rUvi9vRCA2U2zIKVVh7Nj5UBJevGRdTWBirX/0Hs5cyrbD/o6eJl3iZszKD5Z0/4J+cVnzmHI6qT6PWl1TnxkmlWmG7ICr3XosO4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804297; c=relaxed/simple;
	bh=QL9d7HHZz+ESS1CIPm4LO2dUSyXw6mHBSlOn5wwi630=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp9EBaIAJpfPgRUbbgXb7r62QiQYBrGRdUbQuhmmNqZC0fK9E8ER03P9dVR6HZQvTKigWxNhknJGvJ1xxrbT5tbIvPx5K1abXwCIN7BL61Jsoz+iqFntyqlVWK/XvsYrQYDTtFk18PfrDFFRK00K6fE2VKAJq6zvMZtmAeiWN14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBJVbmsV; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBJVbmsV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so1475736f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 23:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775804294; cv=none;
        d=google.com; s=arc-20240605;
        b=Rp+eYTqk2DTNTmr/WxwjQXWAqA3iHQ4DQDswj93EBcey83f3tgdA2VkokqaD6Jh9OU
         yMyFyu+5Y6eGo3g13UHJrUOhY/RJP2EjyOSIUR4A8t9BsjcA+2fUyaSnZxLTj+P7d20C
         ei5aW+Gz6nGNhk+AjH4mUh436mC4JjrKGlKTl13UXEsgS/LstfZd9lkJPvM9pzJGfLvz
         0mPda806VYm1OmH1tC2hLTd3N6TOPz2XxM4Eh7CHiueZCQWxNaNGMu+mMdJjLlZjvP7+
         H3NNxWWcX99l97ckYU7akxgAcLLNiO/L9p76L38jxJIyjhO/+ZupFyZ8XEk4OLbguNaD
         IgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OElDux2FE2thAXeaVq/Hos4B7MJjORPl7dXwRgj8mbk=;
        fh=k0hk9dXwiu503IV50ZVo6Yd0FknYwWxBI4xnCGHFf70=;
        b=XaP5ZwcfkxlLlmH0mzjbrjo0wvvQmOW8u5xTUYEWgG2WSl1ki9bdkQAt8VWHyzS4LP
         yOHrHoY8hfOuEE8tFbFb50VhXp/CT7G97tP2AuKoUABh8+rNIm1HBeQpATHbKk9GamZ4
         mm7WQ777ILd/Grp5LSAIutTUgRQwUhn+09hxUaIcd615H0SKQeiPo4e669CdEKXJR8cH
         gYSC8GgtIuvz+LUBDcUgGtX9NVbxBaT2ZfTNln254Qg1oWEI3pR84YtuQ/jeyYtZDMdR
         QbCf0C39c+ofCzFqUNCSx2/d7HsXa3A8ihvxKQFnv0WPzhg1mcjrCM17OeJaszUHLeM0
         pdLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775804294; x=1776409094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OElDux2FE2thAXeaVq/Hos4B7MJjORPl7dXwRgj8mbk=;
        b=rBJVbmsVk44HdlVxcaGvHrZrvbTbP6bzo1QJ4cCAIWW6Xn5JWblKdbFdpYGwgZ9XhQ
         +wV8k1aq6K0M1xDiWJ7yV/FZ9AfNDQj7NJeqPYUxlDvMGKU9MV8TfNNlENuAzBKvkPvp
         RBqtCeMGqzWqX/Sb+/xIhDi2xdZRCtD8XPiyWfnrVcucaZjUYgbk+5XmFCmpGPiMRl6C
         82bewJrEj6PNNLJ8u6anjSIcGKHekilHkD5tZciEgKjyBt1YUI2O/NSV2BeYDvKIyMnG
         0cGx5KF2levB0fypJz7G3Bq6bJlbEU5Oe+HF2guTAy5zl3S3SS1t9Bjjj2caslu/8WhO
         mQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775804294; x=1776409094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OElDux2FE2thAXeaVq/Hos4B7MJjORPl7dXwRgj8mbk=;
        b=T8VpUQYH1KQkMjHAS20y2p6GbhE5o3VAwq0dyfbHaa1Txdp4lO9hczA2PuM09ELHDi
         upezTAp/dMT7OtNEzPsgvKcyyuk+T4O2fFz1BZ5iWjKLvspBToJD6P+yx9B/XX2tSIEY
         ZVOU2swSC1vSoWTlyamOWy+w+PKB1w8ezeE4ZqFb7uUIShJu+sISLx1x8l2Rfva9asbT
         U+O+oyDa4t2hq3ak1lr4VQVMSTaRSlVFr9VTQaBh2+M72zXTKDaDoOCaJWo+qK+cTUjZ
         PUREjDe4NAFhS9ieBUQPEqBo1e2MlHrBob4JxKma0M8B3nRAACU1gAjy7qhYM3y08qn6
         z8vA==
X-Forwarded-Encrypted: i=1; AJvYcCXntanX0SR6qAQ7iiueiADo++YZcS66/NtukOsWh9l6RXBvU636Pk0FrOFnFiQnniLWb1pvzgXnVKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0ALP8XtdnopQJZH9Ek8l5D/4GIzBFnbrULRaFmu4ixNFNQ8v
	g6MOQU65kBedXxdEqW/kU+1Z+DthUv0tIPlS1sF1pC4wUT9uz0X05R0l1i9+Ht7eJ3MqTiGtp6E
	KkiizuEo2RbflZZw0NdM04QAlCj0Xqtc=
X-Gm-Gg: AeBDievncFC3xC39DxJGu+ogP6xJmOaaIiqFayARLEpqrXBKSj+XvxPuW/W2Mt2nuf2
	zs84W7rfcM1sRqaoNMr9011OS50T+g8u4HaMBdKJ7ElZ/dNGGigtwnUCsOZ5/C4baR0i5qo2VRg
	qOxWTbqQtJxzwIKEfMgRfN4RQJ7nW/WFZCiha4Vn9WV0XDYg+gONTn+9M1YK92lo5bC+6M708mB
	wsfpM2sN7A7YnavHKNPplskUTtSlanfP5tUYR3T04QioGXa575wsdFFlTC1HcUqyAg7aYJKQYi/
	SbVZsAzo9u94BxmRpK0K+XvEqbAC6ENR48WKMZ4S81MTejihYA1+e1DKPbrk9ccGN4Yh/IsmQGN
	hj3DapaH2fgUu93/lxegRTxXFNAa8f6jh3JPH
X-Received: by 2002:a05:6000:40cd:b0:43b:912c:25c7 with SMTP id
 ffacd0b85a97d-43d642c4f22mr2693360f8f.25.1775804293832; Thu, 09 Apr 2026
 23:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409131823.1289-1-joshua.crofts1@gmail.com>
 <20260409182755.499a419c@pumpkin> <CALoEA-yVCyyiA1gUCj4Z0JcLscpSSssPCPXnUPOciWJOHj3VUg@mail.gmail.com>
 <adh8zOCQDhGwgf0Y@ashevche-desk.local>
In-Reply-To: <adh8zOCQDhGwgf0Y@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 10 Apr 2026 08:58:10 +0200
X-Gm-Features: AQROBzDDgEHNQvvBzy-gtfuLSSEi14E-Hy-7gsCI_Htvde6Gu6XHxgVfEoH4MBs
Message-ID: <CALoEA-xo04NZoZLboZ_RNg+m8QfCaDMrfNRb0cZwnE1DMp=8ng@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: ad983x: replace do_div() with div64_ul().
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Laight <david.laight.linux@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Greg KH <gregkh@linuxfoundation.org>, 
	nuno.sa@analog.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 06:30, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > The clk struct in linux/clk.h explicitly uses an unsigned long to represent
> > the clock value, which is used in this driver. Using an unsigned long
> > ensures platform independent usage without type mismatching.
>
> ...which effectively means the frequency most likely fits 32-bit. Otherwise
> would it ever work on 32-bit platform? This is a mistake in CLK design.

So we keep the do_div() macro and cast mclk to u32.

-- 
Kind regards

CJD
