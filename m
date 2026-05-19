Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9DC30F957
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198120; cv=pass; b=keShVSOMWWGrtc0y/RFRS+qBZNVS9whrw0lbj2dD4qHuYjkOe7w6DakmcU/B2z6HLkHobWnvcUp5Gsa5mAF+yCfCIHyduyUOBovSQzdsev+PPSjCOkRTpm2xQinwUu3c6SnTiaG/FXTRUOAqTQoNxAxGP/XTIOHw2+S17zyssfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198120; c=relaxed/simple;
	bh=3FOfUeYhhCU9BCYgxXetX4EBS4UNbIuuLpXNM8h+TTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VivnbW4K1uiK8DIOwGfWHVSbaGcPosc5KMbYb+oSqJOCa8p3TXRsIsN7JGKxhveq5LKrURyZNJOf8Zcadr5O6RiHUCpBOsmBDbpZ7ZR5q/dwuj8KPMgIcgaex56rqj0bZ2Oxt7hYWXYeywi+DA4D1LMKwZc1FroWxDHeKKzy03Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z71d8BeM; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z71d8BeM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so28358825e9.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 06:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198118; cv=none;
        d=google.com; s=arc-20240605;
        b=drmHaOLWo4u06E3MnzhhFE94js2cdjUf9g/+khj47tZPYYV6C/o6n9qVzw6ZhJA9vZ
         FGp61jVT/28k2tmvpzZJmmo79K2RILkEU3NenwgrGRvQBetkl848OjWvWdujz0qHyqGL
         3hZrr8dl9BH8wPbWcAAsDKlplC9j179t4nBw1CpAKufBBSpvGDK0qSFgh6a9h2J8wZmJ
         2kB+OlD3iJG+mHWxVwBHfcV4IEp8n5SPvuJmIIZ9eERUuW3x3O74L9k9fVOPvcf/5jCp
         TtBO6HgtNMBSCYUIqYm/7ZhOSNObfuSkZirdlTZpQ1V/jNySNZVEKJX3B15KdvBy5U/B
         Z0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Xpv71tqgZxCpTXiO5zYvRqZ/ntiGB/vhqn6xy+Xo+48=;
        fh=00cul6W55zE55eUBw3FsS4CMepF9nQJrlewlp3IZ0Eg=;
        b=Uz5y7Dkoal+R6tpas095z49s2Bw859FYe5qVCPgHIWT97oSXzsdz1h8Rvf+iMH6b4r
         EedPHremsJ+rJsy3lgjQtcbW/1OvKGTT+fTg04cPkFkiKbTgmF/g/JXHaKNY9kJxA7mZ
         UFzb5HXwGPBIZSfy1KFhssyhfr4q3byZEaRGgJewYjngSzYDWfPV0luvhRT7HyKYfUvC
         r0ByHzFFuLwYjiwD9xkCDCB+HsFhiO+xWd+LrVmvqNX4Lf5m5xgB2S2mjwQfrXybfR2Q
         KDhlZCvwlziv+DuUVkX7K9MVNdtPmGqxMGtinSwLoTw8uFXZj389wNgdYgG3Kq3iKAh7
         V1OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198118; x=1779802918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpv71tqgZxCpTXiO5zYvRqZ/ntiGB/vhqn6xy+Xo+48=;
        b=Z71d8BeMjkv1txl48Qa+KX0vHhXCnagX8wIc+lY/7YwTjmj/JYOHnS4ZlRAkh6ExJS
         rX8r5HQKKn6SSz4hvuSi5QQMC/ghtmMKVSDQdcsGMlHaJLebHgZOV3VfK71GBW7y3f+j
         sUm8rbpE+SZxAPsgggacrRpclUwE1AaPoVe4C8FhuCtKvLsuLc7GOItDje3BxIFqIPdv
         duYbT+BflUXxNjepEvBvqm2I/4g74RrskvdiZK4kchOMzeSH3KvPkbBvEl9eojVeurgs
         EXgWgbf2guNBBhdNRuZwL6wqaL353ze6I60p54dUE0+/QitBSKxbDdmyQklHXFWa2/j3
         bScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198118; x=1779802918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpv71tqgZxCpTXiO5zYvRqZ/ntiGB/vhqn6xy+Xo+48=;
        b=Wc4CM3I+WQBsGBpVUV4vGug1fHq2tUATMfEvtqpaR5tPht3Ie6WPbfRYdQUq9coU8v
         JW/AEfl/TaUlPDlgnn8EPiQXyFCQFbBxPw98v7vmEEdHn/KTz3BM74Lh6LvoPTfXm2H6
         jhZS0FW8oEJ3kK209N71h3MVsZFekIrveZ2iF3dUdiNQElnaep/wtq3K8FRK6bKawS+I
         HwQGd82LA3Rso+OahehUGvCCKjJOCKJIBGSE0eUMzLDqCYSXXmAfLlRZzzJZ4D06DLvR
         3i9COLftCjzzE0/Nv0pQ96tIaAuAkDz1IurQ8fsyOrP2T3plpxiRWYldi4xhCPQGE5SP
         XBRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wWbxhle3R2ktKCcre29/z9uBXyEfHLT6jU0Eez6ZGjd1Rr2rKAsQenHD6TIg7BQbSIT7emhNWOj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0mPcmmxGmZqJZ9LPecmtGxIbldu4/qcql2Lcc/KdKXogA4/zz
	Yin4eomh+LrazdPrvZ+4unIYJ9yLP0doUqUzRf8oYzdPy2EDEZquJp73q3FG3Kd+DKmKQM2wh3Q
	Hn3J17ePSPtwNWa8HUVKMUIOw6CuaqEQ=
X-Gm-Gg: Acq92OEfNGgJoov+5NY+RbqqRMs514j8Hatvn/oabQJMCZQzU9xtiTl64FNjb+nB9sN
	GANZArdGl4bNYe+65YufTxWjDkRuz+60pIR/n7HYlhHQvuTACMGrH+1Fh5tJfX/4hURiKZJ7LgR
	R0U+jzqx/qTcl7qI5GduUfumCshKqdA5FnweRO/+OskzVvxQ7Gg7SqIq26SjjABeZ77Yt81ONj6
	1fwFYbtUjMS/8sYIVj1M4xXo+qGI7comco1eUpSQAggQaL+zm64JIlPlYFw4RTMnATcOnqS259z
	l9y2XXOdEluy4hrFkSiSFF8/dJtVTFfKxuKEIROPrsenYpR4JdeSvMDZd/ttmdDs/oQVyd8wPhX
	SD0J0wUKYsDtSC3tnewyj1T+BMYaNRSK5/OvqmwYdti2c7fevd7uKklB/qF/DZe7zzm/qQxhLbQ
	2u1yyzopKjBYolzyJv
X-Received: by 2002:a05:600c:8592:b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-48fe60e51f8mr233545105e9.4.1779198117130; Tue, 19 May 2026
 06:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519131944.25174-1-m32285159@gmail.com>
In-Reply-To: <20260519131944.25174-1-m32285159@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 19 May 2026 15:41:44 +0200
X-Gm-Features: AVHnY4LXqsbKNCXyMqXYYoTukg0J-RF8HuPArGK1gX5fbT8mEjWQArRC6rRA6rw
Message-ID: <CALoEA-ztSaPV_m0oj_aY5M+BKTFyzO6dh3R4fu_iOnfKz8oQiA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Replace manual locking with RAII locking
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 15:28, Maxwell Doose <m32285159@gmail.com> wrote:
>
> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
>
> Add new helper function scd30_trigger_handler_helper_locked() containing
> the critical section for scd30_trigger_handler().
>
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---

LGTM, Sashiko also seems to be alright with it.

On another note - this driver sure needs cleaning up.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
