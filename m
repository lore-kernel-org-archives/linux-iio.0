Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657495;
	b=J6rLAZAHGxqkwFfk1JU2yvCSnZ5lkWSTgRU0X2U2eSq1BbPh1vEK/Pjg3j8xuk93jjbn
	 Vxyk72auv6XzByv8x0ivAdMwr6IjmZlB7lW4K1wtb0jKThdxiI13QXuTy+DKWDs1cBF56
	 OHx/kfEc0P1uRQbnm4LFhkxqvsvvwA7I5lKkS9nuhN3+uutUOFunTw6I7TJzbM0rkT5Lj
	 i7ZKYSh2WIxl+1W+0svUaE7HCFr/dQOMfk7Dghp3liomMGnSRA2xQGO23qLrnxZ5K03qq
	 bBLVT7vRAbv1b11BMI9pcZaD0VYZEAWQ0sLDRn5hdViPPLuUSYw+08h/GzKtmJiH2gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7Vd7izru+6/lgo99qhm4hOGTqXdwgysuGRl6/uCpNmY=;
	b=yNpOCubGBEJskb9PoWIkl9/L1RTn1BRv9u/0eFff6Ve/wVFAk6ZwuEGMum/8Sx5elHdR
	 yzgVeKfiQVs55bqVq6eXw6BD5LFc3xz/gBiA4eC5ayo8gX4qeqp8Vn2GMLGQaGTY8eYjS
	 6ZsU0YdnWz7r0pQtGglGSmgk7LSKzCWQt60Z2lcBmEYGjyTUQUwW/wVI8pHXL1fK9vlXQ
	 5QKLYgUA2Hw6RWqOfrjjxhaoQHba8wbhQIj+P8k4ijLytMSDojJ6C1upcb4av2n6+3Nm6
	 qeHbtfsob08ifpqhEHSrpQ6jOlvH/ZX4xGpQpF0tZ8ZFFNH1qMiEubYo5jKjEo8Jcyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DOxI3ENA;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A159606A31F
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 08:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A159606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DOxI3ENA
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35f1f76ea84so2312835eec.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792657494; x=1793262294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Vd7izru+6/lgo99qhm4hOGTqXdwgysuGRl6/uCpNmY=;
        b=DOxI3ENAEcruVbjOOf7E0Qad3+/ETA7XsNDIyoy3589tZRxR13X/NC4KdDSavH4l9p
         gcQdhBsQ/xONblFurjSzQ5nxZ6iElRdi7WdOIFRbFxB4hakLCyaANjRsPD2Pyr5+Vmsc
         A3V41YGqCscZ72pPMjw0WQOcYnSHXAqB6sjZ4nPwj2MSdf31gCppjoMCOgwTGRh1PV0D
         nzY8h+Of2ZmA4AnLxA94J8rXQTKAQoBG6m5OIsqhh6eVpIExEPjV+KzcyUABVAjOr4i9
         VpCe5c3sySW78+EEPQi3RpOY/9nhL7223tWCh7RVkn091wtKrroExSJoc6UqrmUdrLCe
         eq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792657494; x=1793262294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Vd7izru+6/lgo99qhm4hOGTqXdwgysuGRl6/uCpNmY=;
        b=Jy1ixevTL9x6xLal/txBxQWTrYNJtCO79QUS8N+biJBvUAh5rl/at2pKReDx3g/PNA
         XMY5cPSOKt/07V/ArcS2m6JazxeHqCFWrPo9UemvQMX1hXUVDUVzDHUJU/We5eDz0nSo
         TG+7dzVsgEZEPY8tglslC6YqFU6IdgwHgyxys4fY+WG7MwQnGYqTfC10jEvdkacf0UHk
         X0JsK6QpSARLmL9FhSLRoFx7nv4Vqqat5EEyvVDTXCEZTdsSv4+Rd+wfBgfcUkweAelG
         7tgVGDOnpCrru8rF2m63TtDIgsf//BF3uL3+n2nuPwN93OoafXWJ26rjQ9P0h31YYsAA
         B5PQ==
X-Forwarded-Encrypted: i=1; AKwUvBzskeXy6kd/yMQh0P9U44+UI/nZo+UitLo3CYMHwTgmo8qsb0xC8xrZAmIZebKQZKGQJY3RnG50kcU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/1M6YB+bIzrNmhk4kua125g0Z+p6yvjZoHfE0r/M7pzfh0tKr
	SE38kSUbEAmx6EeBVFL9BUroq9ONCc0SOX9H9qGU+7FO5V+02e3Zvpap
X-Gm-Gg: AYBFou2mfVfSVxpiqjQw8xi0g0zF/hTFEsRchCwBck9rTATLwN37KGNKDIop9LAYAC2
	1LsjG/xV5a3KhM1AiyZaLLcLxhhLODhx57GlD9kI7pzAOF1wfi2v0LFlvmytN/9se86okjrUvle
	X+PlR5uqEwhYykpHD5nNOmb3PJK5ofAePaJxNMo0ksdbgove7QIjlPUVz5hWM5p4h2yb/ORxOO9
	G8Bbl0ZKEhUg3aAzxH7DK1WQLHnsTr0h8h0MEntRq4G2CMHraT6eiY5rZaLZ2I6R6RHo4t0F7dN
	K0g1AVsgmsMMLaNQhmxGljpG7qk9ZtZtFMCK5Cs01EVynS8EopA6uZxSqfFZ8o4PRuxUzowttcV
	wsiz/xDOX2O6bEKh/Y3iLKg/cc+GQKAJf800RrVyP1G2CmobngUAZwkBUiLkNtYj3VZmBYf7/+a
	JPPVuQGcpmdDxfMbsU/PpArag3it4holF4o1P2FxVHfra4fBsQMMFEmUppFrUljBg4l9YRibPcx
	SC3XGsQUDrUoHprMtqBpygOpGld8qTsuro3S+9YLIPDCebWs4C0/nfbJWcejtAyjzn/3uy/pkXu
	sqXlobHxHZtFw2vEbtozkhPOq4ned1iK4Ir8eOsfairhSRxTTXsEhjV94jaXPcFYYYO2A5UOJYc
	ZtS2hQ/xI1rw=
X-Received: by 2002:a05:7300:fe46:b0:350:869:d106 with SMTP id 5a478bee46e88-3674ea39d18mr5791998eec.34.1792657494222;
        Thu, 22 Oct 2026 01:24:54 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc88b5sm14857858eec.10.2026.10.22.01.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:24:53 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org,
	rodrigo.alencar@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix signed integer overflow in
Date: Thu, 22 Oct 2026 13:54:48 +0530
Message-ID: <20261022082448.275582-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atm2WhX9KDkbUIPk@ashevche-desk.local>
References: <20261021225306.623361-1-kapoorarnav43@gmail.com> <atm2WhX9KDkbUIPk@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Resending with the list Cc'd, sorry for the duplicate, Andy.)

On Thu, Oct 22, 2026 at 10:08:10AM +0300, Andy Shevchenko wrote:
> This needs a Fixes tag, otherwise it probably won't needed as Rodrigo working
> towards tons of improvements in this area.

Will add:

Fixes: 6807d7211327 ("iio: Factor out fixed point number parsing into its own function")

> OTOH, Rodrigo's test cases might be good as part of this fix as well.

As far as I can see, Rodrigo's tests in the E notation RFC exercise
kstrtodec64() in lib/test-kstrtox.c, so they won't cover the current
parser. I'd rather keep the fix small for backporting and send KUnit
cases for iio_str_to_fixpoint() as a separate patch, if that's OK.

> Wow, what's wrong with INT_MIN?

Nothing, it was just clumsy. In v2 the sign is applied while
accumulating, so INT_MIN falls out naturally and the limit goes away.

> What's the point in changing this line?
> Why do you need explicit castings?

None, both dropped.

> Do you know about APIs in overflow.h? I think you wanted to use something
> from there.

Yes, v2 uses check_mul_overflow() and check_add_overflow() and keeps
the variables as int, so the s64 and the declaration reordering are
gone too.

I'll send v2 shortly.

Thanks,
Arnav
