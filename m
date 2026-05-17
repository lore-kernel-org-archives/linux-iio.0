Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49963258CD7
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042322; cv=pass; b=jSInKWym+FelBnrqGBMV/9tTPJOtvwkBMkVlWKYwckmj/h5OwiEyimf+u26jVEH6IhXQxFxEocLp7H6QteicDe/IYBs0ZFG8aBNiFm43GJWdEJQ4LhkbeOoAA9s64eu4dJ+NQ1hdqjc/7Qz/cq+xGsvuGh0GR/QhfBegAxL0PRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042322; c=relaxed/simple;
	bh=GkbeR81ymc+H09AOsCzk6sr084l6KGeUJdbvFMLI0fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XssQRdRcBibw+b/tU9rmrDyS2cpXPBdpfqzEcp6w6enOXWN9ulhWa5D/J8WXoNPw01gy6+e4AyulMk7DyDr41u/+2T298GrALzbS6ZYRYA7lUlclYlMwe5VPPx5Axd+JWD0sKf0f/jxm4VmtUUqfIxNzTDg7wwBmSGEn7R4w1Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUlpBP57; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUlpBP57"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so13367775e9.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779042316; cv=none;
        d=google.com; s=arc-20240605;
        b=QgIfukLcQfouh3hYUTQWnARwt7cKa77MjeTTqNjmvr/4vWVfY/uEVlk/RENHxgp+d6
         qbkA7FmOORlqxLQ2keYRY1cWIk232z1axHpQiY1NyvUAT4l3T3nDwovZ3WJlnY6t6zCi
         kPTMdUbKAxSK2/38Z8HBq+tdWsCiiQ0PlLqLg2zjoVBY695Pwe81eE/LjZvWlDftdBUd
         j5aDyY82MKaptxtjC3dsKwgQiDlB/d0SY1XB93uRUDy5iyoh9d6qo5SISk2sK4LkmUEY
         Z1YYLjar0FDxqaIiuFA8LJr+FpeXXIiRmu+4lS48LSN1LleSrmdo7S1jPSAEjJMGrLxx
         IgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bvu2S7uW8lMaReHhzULjOHAxqrKDkECvWWstyH1zeAc=;
        fh=a4g7+cuuMDLFe9fgQ2AUjP8dpOasrODWj/zKreKfhqU=;
        b=Ng/6mWkyGeeubpawGqq/kAXSNsdxur8QWA8jgv4WNZyIab7GORZZ6wzstqnsRq5vD7
         uK/LD3gcwyouPIqv8DOpyJNkhbA5FrrQT1j6oNW6LR0U5QcZYbUmKZw8eLof23RnsmQ2
         YG3a1DNhyMMPgcVUw+VTfCFJ44PTVk/pC+ChX3s++OX3wO9xtO74XcxlHRj5sz+BQJ18
         rGRgTUrFYSqnCoC7buYMcC0DTppha1rw7+IVrbOYYF1UePMyqj8qAMb/NbA+Buf5ADDL
         RXxCpVwSPl/O8dUCvi8ruzVgh/od+8VgUZD54iH1b1r0h9iIpirOfZZN6I5waZSGp8WJ
         oM2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779042316; x=1779647116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvu2S7uW8lMaReHhzULjOHAxqrKDkECvWWstyH1zeAc=;
        b=FUlpBP57mz8juZSP2XJxdkCon1+YqbNFHwgxjQ/5KWdoKgYBHLsfHcSZ5bARVxhMzK
         tm755C6gvthld8W/H10o3dJMLD7sengN1yGr5i+45mfMBE32SjMaN00xn89aCmCuClT6
         I5HuCx0qY5uxIHmlrNHBr5SKTqrK4LZ55KU1U2S/ZCQWETcg4s0/rds02gxQ/luz5lOd
         /A5TJW1T3fZdrJFrrG9dKJp6XPdxhAWucrsqh0T4KkaLaEIBhKXfJ5c+oL3yPlaAUU3P
         DqcjTbjPd3LGelHyQhKwPVBmnEHWzf5FPKLxyCEaF3HIWeI2ePbQdfjaWGzOYx82RfEs
         x8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779042316; x=1779647116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvu2S7uW8lMaReHhzULjOHAxqrKDkECvWWstyH1zeAc=;
        b=W4GjHN/Vrn7/ROgSYexWE/BQv74cV3wqD9YgQ9gFzdnfPeVhtHXYyISCdAjh6Wvvp9
         vMPRo6fk9TTQFJdX1jSE/xCMap8rYzqHKlJ3QWNXAQcXistLg/DVkCbJzTPJpbMfXkym
         /uZRUcrbLGEO46Aep/iAWfxhhgTRhueP0pGJL0PUMAK9h6VQH99tGiyReyVUcn+2vNRG
         incAKF517Nq1P0f37nZm4TfRht6hLqpl39kkKMc3+ZNFQidsrVuYk9GrRrLezepoktkk
         tcNf6/dp0PJ6Zxq1ZW6cZvQWnqwGh15DvaZizyRtAvfBXGCEO8D3POFDetp3DC7QHNsV
         NnzA==
X-Forwarded-Encrypted: i=1; AFNElJ8R6ztAu/nlik08jh7J9cF303DAuBTV3lsy08yyCXodhuPinbBU+/cUN82AqVQCtSC4fMH/h3VJ5Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMr7Q5UY+mrry8DSzbpLnCaWO1Ed5lD9+jU4SMdYmovqgBLDsG
	snBYobwARzRyWfjgk+EJOgoYRvnMZ7WKKhEImU1kwvl++DI3LVHUmawG1ffYz2vy41J4O5qWVOg
	ieUkUiqOE/H0iZFMT5aFVpmkruyfjNJM=
X-Gm-Gg: Acq92OHqiBVi+AkoEKK7ZQBnnRNiFx2VKrtVnpBFLKScG2Tm64cuKKyAS7qmB85hNWq
	8sZVh4vdyAeOOwOFP1dD9lGLvbfwDjHgjZpJc2CFRPno+Q6J+duKXWVg+Es8qi+iZrqbpUJ9nec
	vUG89sxXL3uWtBOn9VOmFIT1jQ0SOWVL/lpgVgKNaAIlykb8WvtO+ebCSbNFS3U+XRT1qd7Lm47
	wqxvKUFZQ9u2KpQP5RMHkbiVauip9Ev/ZYcc4Et4lxizS8f5a66eKASOB+QnbU0QBIL/ll4gbZ7
	isrLE06R6mPleWeLlECBXrVJRss01AO9Y8PlqHRQw/FcJNMMT2Wc72dvHCTkfeHqtOXo5ZWMOgL
	ciQJkmgbQUmwC+6uq4YCtEVa8c9hcNruyKU6KsrMd8aACpwvQYOMC8Fa8DDrGHlc8Rfd1vXog96
	IV3A4IJsq6dbbEyj0B
X-Received: by 2002:a05:600d:8450:20b0:488:7d01:f67b with SMTP id
 5b1f17b1804b1-48fd6333288mr179025615e9.6.1779042315978; Sun, 17 May 2026
 11:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517181042.668-1-sozdayvek@gmail.com>
In-Reply-To: <20260517181042.668-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 17 May 2026 20:25:02 +0200
X-Gm-Features: AVHnY4JKEuJMFvnl9Iuk2kfWUrTxhh5H5DAv-9mWSIWRzyZufvX9msH562IyovQ
Message-ID: <CALoEA-yv5XGkYCLkxhENUnffN5gFNumN1aJhkjsDUEEMOv2=5g@mail.gmail.com>
Subject: Re: [PATCH] iio: light: tsl2591: return actual error from probe IRQ failure
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, hcazarim@yahoo.com, gregkh@linuxfoundation.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 May 2026 at 20:15, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> When devm_request_threaded_irq() fails, probe calls dev_err_probe()
> but then returns -EINVAL, dropping the real error code and breaking
> the deferred-probe flow that dev_err_probe() handles for -EPROBE_DEFER.
>
> Return the value from dev_err_probe() instead.
>
> Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

Fine by me. Maybe this could also get marked for stable? (Up to Jonathan
of course).

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
