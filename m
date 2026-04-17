Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76033AD9A
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776410022; cv=pass; b=kO49gvgQswJodZLGtpq71KdnY95B3J3P/PvUeu76laObG0yXkaqXMhBfx5dx05QmPdm/KqGrefQ1gXJ+HsTXZ61HYM0USI6+XVFS9PZ6bDh1u6St4l2TYoJ/iYC9rrdkhbAA4ZueztzQjglGQ0dg7LK42pUI9CYjkAsaB/w0Qmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776410022; c=relaxed/simple;
	bh=akd7HIBiOl2zes6WbtFl8EbAfWbnby/iKl1DHS5R4LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJxM1CftJbDwJP9+26c3yjQ1iyw38sFfaAG4AmMbphfZgGqGRRrp7XYXuKkh9wpTcPSKZO7kLtV0FpULkb01ZxvJxJ4L5KgqWEQrdhJqK8LTbiYTAogxWoPdoW/QbbqXQ/pwe+xqomjNTlD2A4LOxWHMD47zVeFI/D/6IQxoXaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T806gLbN; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T806gLbN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so5056705e9.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 00:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776410020; cv=none;
        d=google.com; s=arc-20240605;
        b=TfsR0rSS9qOPgDCD2aBhbqMz5+PZI4MiYItQsppRuVx9Eg+qxKw0Jre1xcD/LngEeS
         fh0DngOlC+jRBBlU3TpfO4+HYLE9fXu9stoFmOL0aDlr/f3/QXTzcT4VBdXHNfxGVO8U
         XABwUVdob48R/KU2I/2PTHqx7tDWZ2qneBh+BNp3gqe+jJAF2Uk1IT9lub4B/rZ3M71E
         pKvoSotw4+JIbGkMQ4eP+RoivvvG4WC5718BFNxSxmLclaKHDQFEQaY1yCAkSZTIL6Ah
         Zb7cyzsBN1mIB77VitY1FSYuHo59K9dnMJt7G2sbbmkQB0ppii1AfpTy1Jm1jIVAi8VD
         z/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=onobLBgRd2p4ezygh5Ux0L0xRK0kx6wb+n95CatH13w=;
        fh=1jqbxt2tT7fyQWnJa6iO4hROrpc2bT9Ou8fIuPDgpBg=;
        b=FMWQ568RGkYmYfbV5xWctmpq3HNlTrQL5/N5f27lfP2FS3RLClzFRqTazcnfVCLU28
         /mG7/5X6MLZFoRxEeE0Fdwjdlp4JOOOmUPZeNAQisjTc8z9MGNDI+nRxMLovRVH268C1
         UnklU81T56Lj14PQ5ENGhq20OsQX2TE3Vj3h4XFm4CdS/tjSAZsJjMq9122zRLZD+Lo4
         Fnv/3zmBpR5wpM8rsDamMA82D3JucgbsYHOhCrznDRN9nF51vBya+oKtxyxzvw4xmPwJ
         j0/zy80FQg9E3sDqfnigojRQjATjSs/CiyAUCHeH6c9fRh7Aal/7jmhkQ3oyufqR0C9B
         exPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776410020; x=1777014820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=onobLBgRd2p4ezygh5Ux0L0xRK0kx6wb+n95CatH13w=;
        b=T806gLbNhoJfFjr8LF+xp1BH5hILLoh+oN73Pk8pESRoliGvYF3+pzWzBfgb5fTE/t
         30MMvbC36Ytqjdm0g9+EAZFGCkFYimVQ8tLu6KQnkovsU5YqwE0vpwzjo2U9TUBeC2gC
         pt6I90U51krHPDJtFExDQ4dOQKSuDJJr7/DlX1uBdjthqUFASqbL68JLQZMcjgpm8MjH
         qxxBzStAP0om/35Tcy29d/EmmyFmU8+p31B3ITTje2ZKvN2vrv/CmM31NwPvOLRG+pCc
         5u4bS2JBvFqZl18c9sidxc2AdZ0QHcbgg6Wa9f+fTFbqrbX3J8N1E072oPOmG0KBQ3Eq
         hCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776410020; x=1777014820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onobLBgRd2p4ezygh5Ux0L0xRK0kx6wb+n95CatH13w=;
        b=hw3VsBcJdqFSBdgsMXfxvku6VEjzihZZMJysBKCDwGWlNCexS6OivtI3T+8Thgcf1s
         /o7pvDgZ3F/6hBAIQbyAECXNjfhc7b0Hq43Aq2eN0reD6DorlTFOokp4pvz/+1MNanHr
         68VIbYwX/DXJD0zbJMDbKK7buMeKnCUBulgQfXQaM1W4Icb0w6Ku4l/9a+x5FOmMnO6P
         28hCa7adDgxW6+o9vNwhep//Qamn+gkNwUY57aeq0kVnN5tKj0JmgAnb8r/4wGnuKpmt
         79gZPCDLZeTGiqbj5enOUwt1CH5vis/d6J/A01P8r6jNh03Vb34vtp2d970hponm0pH6
         IPsA==
X-Forwarded-Encrypted: i=1; AFNElJ9dqPMmshByFvmMMGlRRu7GfsWluLwpm/rlHLXYgage6DesHZ9s4/b9UkXU1c55bClpEoxKupBlgFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbj0FzCEZYRSbz9o3+yeCIfMDVa11/axuWgkwtPSyC7W4GodBA
	DWy3hXvzTvgb/9gQpo/pKWjrCGFIz7wEk2fhooeYWEvYCxxlt4J87gquu1yoqn/QrTu44S8pTXO
	aXf4GnRBHPvUosnMEolTF4FjgZjJxvmc=
X-Gm-Gg: AeBDieubXID09ftH7CpWa6ZSAhm5JvbWrb9wb1neDkeAQ/9VLa7F/ByyxTOfGaqTsam
	fCnK8ScFFwAPP3cDmvJ/WY8MrWoFFCzmtK/UmD+dRc/LwkxWFVz/8cDaHPKrJwTesnlPRafZ2w6
	crEHc1Gq7GLG/efC0ebOaU+A++iyJFhNaHYXsrYGoalFmh/FrT7IWCmAc6yO9p4y7xny/iu0rkI
	BxUzkrgL56efa4UG8qDAKz1H0tzNgTEIppav4GxIf/FrWGSKt6jTCwrXdk+g91Ib+gln7F5Pejo
	ulejDunFGStSq/aD9+c/6V4hA+YLz86vlLrtg8QWH7AvSuaOL5o+i2r044u7Qae6qkQqH9FO9Bu
	KAuE471kDzqOS1kDdXTFuX7PCgoe/Mf8bPJakjXBLTdSdMQYIaOyJZDy1VZfcuTi6S0hfEuhhVQ
	qNrvVbzTPnc7NDEFUk
X-Received: by 2002:a5d:64c3:0:b0:43b:5097:6f62 with SMTP id
 ffacd0b85a97d-43fe3e141bcmr2193334f8f.36.1776410019561; Fri, 17 Apr 2026
 00:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416093240.1294-1-joshua.crofts1@gmail.com> <aeHXi8-zYZu-9NPr@ashevche-desk.local>
In-Reply-To: <aeHXi8-zYZu-9NPr@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 17 Apr 2026 09:13:27 +0200
X-Gm-Features: AQROBzCmNJ4DWunQ0iNo95-q4JVl5-6OrYAgT0MMb7tusnqxjMjjr_ZBVM1Ggo4
Message-ID: <CALoEA-yhUTYzHUkOqAQ+nunUrH=DqzCzMS=hW5ZxO5M46ETa8Q@mail.gmail.com>
Subject: Re: [PATCH v3] iio: frequency: ad9834: clean up includes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 08:47, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> I'm wondering why in previous round the tool haven't noticed what I did...

Yeah, the tool is pretty noisy unfortunately, even with tweaking it's
not exactly 100%.

> > +#include <linux/string.h>
>
> Hmm... What's used for here?

sysfs_streq() is defined in linux/string.h.

-- 
Kind regards

CJD
