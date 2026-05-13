Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E83839B6
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658440; cv=pass; b=ezjAIQgCnxzkXokTJQgoutHT42WSUTVWO+6W57nbGwL4sFHQeduG1T8YsOtq6u70lfD5kfq/J1USO779oAoExeVHTuANttf0FLiAToBPteZYZTBEbkeSketNZkpbPHNJG/C6YuljzfJqNaPwo9mc4YtHRruUhQQ0Uk/P73EA+VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658440; c=relaxed/simple;
	bh=CiwARpb5y/JOPNljtNF8s1Sb7KOaFDTyfR+4JB7d3II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhZxHgedtmVqCpwj75IYwoy1AkTMBzyfwe/LENpRzeAoy63NNemxeGeR4+hk/SDHqorbC+YnRu1193MacAkbBl0+Ee9Uhu0BjPqe3JHlASpdpfnOPny/LwLWPH9A39UpxdeYER3Ef2fpIXxaG1ccHwa9Cn0F3AaHComyzLVno8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4W7YQHM; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4W7YQHM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d734223e4so3938672f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 00:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778658437; cv=none;
        d=google.com; s=arc-20240605;
        b=jcWzL2abBB1QsPL/roh/3tKb/QmlryaLNgZpbYAV+2Eaq+MGSbLrxDhj5QPX3qlZP0
         t/l1WB828dVreIY8DeHkzVS+zBhXPTGAsUlYXv5OlFjHNtowaVb1Q2obnXwERLkjNKL/
         0mJvcoovif9Avi7ldl3pjWnojh1puKX/6Uzo3B4Netlla00GcbNgt9pGyDrZk/yiC9aa
         U8bfenQAoRdjT7FKR3hUdbanyOf1udk0QynKPIXwOgKsvQQd0GCe00IlOwBUY7r9HHjS
         I7n5KU4eWe5SZPdekAhl5WGPWs097mOK2R8JfoUUBwjgSLSQ2KXALm2g4P7WDaN8AVvx
         x7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JLebtwIlmx5XxfdgtLUv6xYtkF7xCCbgL/yK5lUJGIg=;
        fh=B9Tkgc0FMia0D/nRkaY7nKzdFVal3CuqOnmYq9CjvlI=;
        b=OjyMVPmqonhGg9Kf3raAvpiDlXj3vEhPkXzqtuhzVPi8QMumfSX5wXN9PfnF6rq/If
         Y+cWjbboR+xXHOWm9K7m0AEhpGGmTMP90aQ9bZ0+Lw1TVMJ3n0paypC/TxeFq72zQzVX
         fu+sibdYbuPQ96Mc/XhCcgPN7Hb4AF2pC611w4dyz3Advs4TYv6NHd3tRPTZTWzuXE+e
         TkgSTGzEUirNT227JecFXJvO0wzmgiz+Q15m5LMazs9VyFEgjqpjidXjej8QH5O13uXc
         nG6Is6XOcigW5VXJ9dOjs54RaVHHOFLlwt4yG7nnBMSVEzRmYVHqPzr27e28i2jS08gv
         BALg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778658437; x=1779263237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JLebtwIlmx5XxfdgtLUv6xYtkF7xCCbgL/yK5lUJGIg=;
        b=c4W7YQHMILyPHK8jiCpArq/2DJBUUfgbXHXxn0pWQyX6bblmIRu3LiSphnKiXkMVhT
         pK8x/4LfggUbcht44DWiRY/tqVCiX4hWYkq6i9a28TwBJue3qRsIj2b2n2T8nHU0KuLH
         loBheEE/NnAnS7LIeuzN9iPsfgD0n1aMvoDXiQb1Qg1W/YnoQHQ7VE3AC4fHfE/T6KEo
         2rMkR+h992867WE9MUNMlxqnCYurKaR+ZQxGcI7+RHs8fgYFw/38ym6bANr8Fr9v3dv8
         SOa60tqOZyUrfrZMNLZsZUC2iA/UpQbxmcJ56sP0kmOg55xVLRcP1yU7Cru5642WS/Ik
         3gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778658437; x=1779263237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLebtwIlmx5XxfdgtLUv6xYtkF7xCCbgL/yK5lUJGIg=;
        b=OTGEO11+msdx+tuNwc/aGuawwkacxyG6bySaCK1MJm3LVoGSvljIhmDamhVWRFdkmq
         tDpdyEgoKUF5fuLZVx5VZpTxj9KOEX87xLfNC1+9V9Du+raQ9uaBlJ2czXDuRhqjQ8ER
         j0+a0gGcpu0INZ0mbUcLTWorh7Qca/ybyPXrQ970WpM+2LyY329lpeuRpL20tsaZYvBP
         qplQCwgWkLQSOt1o09H8XyNxSurKwvcjbmCD2fTtaLlDivX7qesg9Q4qVrB2JrytDZ/c
         hxUJ6QLmQm0McqDvmi9NICvCA+/VdCf3eIn9p1IXbi7oB9RTuUKDayvDHHadBuWiBZkc
         91/A==
X-Forwarded-Encrypted: i=1; AFNElJ+kJAjKAno8HH877Y21Ox4wT2KyycGcN82SsrakvLOgQIzsZmORDF+tRtKRBPLdAhtp41i59Yao+Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytCXO4PWIbBmQ64aPasiSf9mMruu8L7M0cPNp96pbHFlE63f3K
	Rr4HwgrydTRjx31X2rlNx2JQ4vEWr1GtdVaTjA5gqoaMctllPx+N9PD38a1pGizOCkQVBrdUgdr
	aSz9Q6hmDTl7p0Ij2uQXP6YAWuJpVfdg=
X-Gm-Gg: Acq92OHdSx6GxZJAh4HHuEdRu7sfm2y3LpOGmzgTfADlJhAbaJCIVuAWEf0F8B5HXZv
	6P1oacfqUZCTHxDsQh6Ggps5701lzlfy/pUiR1l01wF3+D3r/N8YpLRb+lIjTYKCWMH4MdcD5SZ
	tR6r5Khut4hJ113cGWiki0N4NgEczfHihyiSCCSxlOadr0QSGWBmXDlyYVX/nDPMGfzD5M6gq34
	o8cKo3VCMMHkymTdLSkuY++rntPL3rgcYskYBOqjcZyFIGL384TIkepFpOvfjfA6mpOnFgmO/HR
	+uMwQt8wLgObaA191oW5ZJkcdSGgHOdqmdKt7YhkDaKnAw+6cjhtR6pfnXgKDB3HQgjWnBNRZBQ
	08T7S9dPx7tL7nnRtRr4LAAnXeBAP/M/M3uNMcCoXhREpYLyL8Rw5WwqCysTUgoiraKkxKnnldm
	8fERLRpA==
X-Received: by 2002:a05:6000:2f83:b0:448:d2f8:be2a with SMTP id
 ffacd0b85a97d-45c46ef76bdmr3528287f8f.19.1778658436945; Wed, 13 May 2026
 00:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223215.25596-1-aldocontelk@gmail.com> <20260512223215.25596-3-aldocontelk@gmail.com>
In-Reply-To: <20260512223215.25596-3-aldocontelk@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 13 May 2026 09:47:06 +0200
X-Gm-Features: AVHnY4IUY9UvVM_elJBgnXW6mOK4SSq1FjhxHOEd5Cpqzx0IiOKJzJBMv7fgZbc
Message-ID: <CALoEA-zrmGs8PjE6N=ToQ6fUk3H63_rpJy1=mBCVVBb1xRAd+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: light: tcs3472: convert remaining locking to guard(mutex)
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 May 2026 at 00:39, Aldo Conte <aldocontelk@gmail.com> wrote:
> @@ -379,6 +365,7 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
>         } scan = { };
>
>         int ret = tcs3472_req_data(data);
> +

Unnecessary space here, function calls and return value checks should
be grouped together.

Othewise, this looks like a solid cleanup.

-- 
Kind regards

CJD
