Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB53E63AC
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505549; cv=pass; b=q/2NpvtwkP6F7TSfx43NlkgmmI2Zp4jBrS7uTM84MOMmDGYzJv15IAziNLBJkJdVFK0JH+ghisS7ZCV3rg/kxbnaPQr10tx5GIBIUuCo9A1BtIPWBH5aq2Gp1NcnIJVLckPH5AX41xi8zs+iSfHJAQAauia18Y1IxzCh6gLkNvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505549; c=relaxed/simple;
	bh=T7A4SSSsBhfTv/Z77XrG6SGrUNTz5GwYW86QjKIQloI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EASj72GcmGilYTkbnFbZPZnJuIoED0Wj3TLYP5X2KeLjjCVudQ1HtbMrhjbO8GJ2n8KcNyoHXNmCxp1otQ8pFfZvjX+t0UsMsYus+vBEOHQF5Suuy5uwYx7qkjPzJoGToO4gCXH1QWbB9yh6SQ/W3dR+XMFxJlHDqyY3uo8Y0QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6zvscJO; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6zvscJO"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eb05b1875so2558048f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505546; cv=none;
        d=google.com; s=arc-20240605;
        b=FgFSz42GzLiYsuEltwlpEoZPJP1Prkcd+Ak2SVQrfa1vC0n0wlwYlHL5DSmQUxbj7M
         0B+jDylZ+NKXLnd1ZCQVmOkPJJYQRMuCPiKjlaUIWO/x3aXTomisezbKrOeJCPkORFt/
         4DG1rGNcQ4VEx+NYN4MG+5RC2/GPZn+V/nCOplwoZHJ+Q1Dnpb5UgQwSQ0YB6Pfio30N
         lkjZsWzE5JlCJzys+vZkGL/ES90A6VVpDTantbIVAWriXbh1oTk730tKF34m/tRQRLKm
         oZW9Xx9Hzdc3ik0khaOOOB6Cc3vgGtjzrEE8vzMDoCb7VhOxQkldc8SFoja8eaFcdA4t
         yPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rjfREyylEiGopvWvXQkqnll7QScU71nbyRbQLFqM5EQ=;
        fh=BIlhTzQ60QxEx2A4XoOPWkysHnrf12D3x0YDljePw30=;
        b=iUenIr0MHZc64RASkqc2LnlQZ3ws84WKOuXY5XQIaIOdHYgKnLCSm8XGA7rqUfMchd
         l7G9WXYYFXTxPzBKmd05/ZXxNmu6aVlb+i7Gk1fP0JBreTImu7IgxdTVX6LYK15VD7Hl
         x7kXQD/VQugb5OwDBEXVQ+kAzPUaDOeloKOluW4AjA2+pCIKC/G/T1g/Y/r+Shphk6n4
         A33eE/oZIHREuQkRhkHkM20/q1kI8iEVnc3J5QZDhXJ8C8Ek2VRBRElCBz0mkllPTe9P
         Lwa8a6v3afWu2EeYSBgMSAaga/BuudP49kVPyYIPTCFvwwJUUeISTG7URpn3qsowpnhi
         4MEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778505546; x=1779110346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjfREyylEiGopvWvXQkqnll7QScU71nbyRbQLFqM5EQ=;
        b=c6zvscJOuUH4ed8fSNC+FzSIXkbiiFH3qrOQctTuOuIxhlLJOLMN/NpLMF6drnnAN3
         gVFlwCyMgoyOlhbVhMdtwCRjNnv9Or1i5dpr4QvFuyGK9goGs2OlM7TTvrZoaK5fsph1
         ZYOcmktVL5OiJyIGPVJVM5hPf7THzOBIiJOATnMbN6mapDaPcJGqePTeJE3LHreesNiG
         2qygd+snvFrbC3Srhei6c+/WztMeYu+6RgwEOJbV7nTUKwRRgHuEKPAf95Kpg2TvIZsr
         89+9Vd3iO2okK3ShQ9QqpSJ9F/PWBv3itoXbIwH64MmHezE81SAh2csTPh2W5illsuw4
         Bdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505546; x=1779110346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjfREyylEiGopvWvXQkqnll7QScU71nbyRbQLFqM5EQ=;
        b=oU/3wpe1YIikR+vuOpTxd4BzdwKQUK+RZnCH1/TUon5EnlyKubxpSRMUemf24M2ism
         4tulnJ+UReCo8HqSC/jPhDcK9fCYEth9ItWFZobD6Ans9kyIQYYj/NouCbQ6783ZwI2K
         xvkmPgMNlD1DG9ruZ36SOjPRMoiU7gdiRn/Nd7XGlQkJOZGNNmN9Fk4HgxsQFrB1E+Me
         ItyLYo9dOf/z+fn4HDGKyS0BsO8E3XrKsyPTxQ4cXmua0ZPLbZN5Hd8+QUCHOLLJoRuo
         6ci0oyLhPsGh4xMLsiwl11g9jA9UyCCdAqSFhWdrmkdcwW5bcd7pHnN6QnOIwLqNiXuP
         jlqw==
X-Forwarded-Encrypted: i=1; AFNElJ9ibSFctxMfpYT39IDfch+aNe/aajpWxCBvBSxwsY5ICA/0JYTQHR+VJ3tPzY3E+xELRwvrnRbGYy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUo4Qi1NleGkEMCCa+69kq6Xk9EcmXwLNzl4pg6wRXkDwipMB7
	mZ8cew4O3y1SdLWsG07Q5pqbEluH1K9f6/9TVthhNNXVQeiYCcJMGTj8SQ/mwP1g7YkPMEMlFn0
	JzK3Dql/rhluqdKi37ZDsuQ8/7lFKp7c=
X-Gm-Gg: Acq92OFR8kR689jbjSVsgExlV3LsacdWVjehslv5SFHkEE6GhouPIKkejF5z6blHGuu
	KTfOXmd85vP+gnDDd65PbjNSLpPmPqqEDDUAJ6HXi+CcVqSgayMUXWKimdRr6Bvs8dy8uA9lcQA
	e/zLNqCOHDeRWJXGFDUn1qdhnF+Y7Bc0lw0NgyIKSxplIN8KYUG4vR6ZyvHIj0+p63mn/rzktji
	wjl+zBWcJ19zL0k1pNuIKZ0NeS17S39cblwxWawfcdVqmlhFhtLHB2pTqAfgQokOAvdPG0eUcmv
	9FSuaXbOLelNEY9ASACimJW8wxx+zItGA2AFaHEW7qSJLFOsS1WkLloSXFror4A0PP/ux5MLLp4
	TNPUGuwkxqMbOYWftbw2dI825NQ55Sm/zGNJpgKQxGKYPxBdUXBLBvIMgkC8B86qqjasV8FiSig
	UGHSopKg==
X-Received: by 2002:a05:6000:2902:b0:43f:dbbf:6d93 with SMTP id
 ffacd0b85a97d-4568c19b2b1mr13891132f8f.27.1778505545834; Mon, 11 May 2026
 06:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511054441.2980-1-sozdayvek@gmail.com>
In-Reply-To: <20260511054441.2980-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 15:18:54 +0200
X-Gm-Features: AVHnY4KeBSmCahSz3b-BpDg-OJ771OdKgArbo6lUTNSSa90aO2vOb1-_hrSy-pE
Message-ID: <CALoEA-xgWJgW14gOwO-9e2FF=JChc=dJj+qweDjM=OggoQ1Hyw@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: adrf6780: replace usleep_range() with fsleep()
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	antoniu.miclaus@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 15:09, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> The ADRF6780 datasheet (Rev. D, page 23, ADC section) says:
> "Wait approximately 200 us for the ADC to be ready."
>
> fsleep(200) expands to the same usleep_range(200, 250). Use the
> flexible sleep helper, which picks the right primitive for the
> given microsecond delay.
>
> Replace the generic "Recommended delay for the ADC to be ready"
> comment with the datasheet reference so the "why" of the wait is
> visible at the call site.
>
> No functional change.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/frequency/adrf6780.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

This seems fine to me.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
