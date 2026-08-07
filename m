Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D5641DDE0
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099067; cv=none; b=GNG72kLRifkPL+WgxXsuvWbyOGQMM/wO2RnZ58g3XZXqSQvp+mZXRq+y2QI9Wb0lCq5emJSlaE5FEE7hLFu/76k1g0SZeKdCIyL+fblEtj1Ln+egqLQZoCsVm6gkqf+P/n0k36p1Z33CC0cIbcbEp4qKGJy4DBLn40UUcQIlww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099067; c=relaxed/simple;
	bh=0osyU0Eei1ghBAIeDh53nND29cJLCbKBrbgTAnuTeZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsR9aV6s/PN0Q0GegKEsijLMfsBjJoRTnstraCNexccA7cipJFGUHPT5/WGtkionxcZQVy7tIGLvfUENV0k43D9w4tsuP5Ub1V4xjw0uHpA8E4z9SR6TgESX5jf89wSTJtZwx6YRVsF8k6XdUCS5wtMQDp34S4u2I4Blt4skC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dscQSS4t; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dscQSS4t"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso29476775e9.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786099064; x=1786703864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ReqVE0zF5sYuPuVqJdocfOpxaTR0IUKRNwoPkTUY/3g=;
        b=dscQSS4tN3YjZ2V8x0t7ge5iVxsTO1/QUY+dCTqK1jz5364hJ86gzz9Jn8LiL6KTPd
         /AEHrpej+crBblA5cBF4aiv6dTu17AD7VC50isg8rB7hpsMZvVHR+J+SxFh5E808vz1o
         /DRrTpFgRHF1RBNlQQ+KIxMVqu9HMqDXniR3ewIX5Vqg79iLF27lzZbXZ4CCn8OqxqMQ
         R9YVCI8C07oNzOoxLLspHWcqsLPiDTX21NwepbrtJCrJonfUAJScPh/fgVZT1i9TaiAr
         niweGuvzBk+YdhjChC/3cKSWsFjnq8moTR6ANYWgVuHIEy5iE2sVJpPm+sX7wXOHR1E3
         DX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786099064; x=1786703864;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ReqVE0zF5sYuPuVqJdocfOpxaTR0IUKRNwoPkTUY/3g=;
        b=A1L7oTKtOssAKeVWBpPdFS/Gum5vPb6EXPVwdHyz8V9oh69rUP3DE5fmh1zncmb0j+
         cLE4JwzKKxSf/MbYKWy7p6W67bwfcMn60NsFVWUawDeHlI9l1kkjjaNsvrRoDkzwneWu
         ajeR4jbbxjhQ5yLLWc7J/U8TCRwEU/gPZ2siwfVwQBC+yBqaqTZ975isqlihcJEs2Bs0
         QbeX9tChAvQETiglBytnAAwJOzLvEx78w3OQc8WkRABCqndQlvqijA6SwfFMtWJJ61NT
         kDcWRch/tjLUVJvyze7mzY0/EnZWvfYy0F84ujjjLqil8X63FTLFcEhDJP3owKYX2VKk
         445A==
X-Forwarded-Encrypted: i=1; AHgh+RopWp0apVT62AmI0eFYas4J6VLmCgylONZ7J53uicN9TX22qbGJtv+piCRNXmZPTPEiOSnJ3ev45Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrj/9cYbr1Z/p4t2j9CgBNNncnCFJq0VmqFkCLGOu3tF43OjdF
	Wh67UFgs0iA3Rfal1rQR1FjYKkiMwf0j65U8EB/5s3lDzp3y10ABR1T1
X-Gm-Gg: AR+sD13p5ZLdpNwSt/BzkPBQjtnyCEQEztWsrFOQUYmI0TIG9SMvfVw7sh4vl8ynjZZ
	JqC9TdR91OXcS6u9JPojUUKVQrgEREnI0q6WwYF9dM1b6FvUsyrwQYIhzKRA59mue0vj0b8gXYG
	5nFkOAjZB8Bebj44YN2eDnMu4DbgtVK7IT06KCnr3a8r8VrVJyjE/JncstJkWL2L/fLodxnr0bp
	edOshEgg+BEuoN9fP6PC9u6co0n4lCERFLHuGH+AvIMB3kk8frrtQbarKjeKxnAhV9NCLNyQJxm
	/+Xs/LgFcqnvSQwRZ4iB6db+pIwDDrdg+BzRDe9ByWkjhN9p20BfxSGg+2M2/Ildrdhv7oJRdsL
	THIE/Uuj9+9uXNMvBJQhCWpRSloQyCM3Dir50wHTbMLHWMeG67T5lHEggQ04dRDJx5+/gmHCWrV
	o0bRnHaXdO5WdqtxmxRrGHw8kYtObQc2rTLYv1pjdOppxiog7VLPV1ySLhjceRoeimkDpLeAXaR
	ASu5u3zVZ4jTCeFUcuyLhejtUjx74HtQwBqTZuNO9UkuQTN6SWruV/q4KwYuKndBSGi9t9veZNv
	Y8T7PTbGoq8woIzqmD6RqPDGm+LQAcoGVU13ZZVCdzJqnWjv3ByOLEH6IlNsd6zlg2JGxrA+4vG
	Ag+Np2sG0vBNIteOHiccY1EzW7FlMYNXDgkqgILING7OpTQmPLN+QL9y/lR2keR1BgjIvYUI=
X-Received: by 2002:a05:600c:1f86:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-49952aba5b3mr174593855e9.1.1786099063373;
        Fri, 07 Aug 2026 03:37:43 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421934asm143535625e9.5.2026.08.07.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:37:43 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:37:42 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ade9000: request interrupts after
 powering the device
Message-ID: <20260807123742.00006d8e@gmail.com>
In-Reply-To: <20260807085643.5502-2-antoniu.miclaus@analog.com>
References: <20260807085643.5502-1-antoniu.miclaus@analog.com>
	<20260807085643.5502-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 11:56:41 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The IRQ handlers do SPI register accesses, but the interrupts were
> requested before the vdd regulator was enabled. An interrupt arriving
> while the chip is unpowered runs a handler against a dead chip, causing
> SPI errors or garbage reads.
> 
> Request the interrupts after enabling the regulator. This keeps irq1
> registered before ade9000_reset(), which waits on it, and lets devm free
> the interrupts before the regulator is disabled.
> 
> Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
