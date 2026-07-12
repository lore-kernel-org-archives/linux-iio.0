Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804F3438AD
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875162; cv=none; b=OruXzYRBidHJLe6Db67a+w04J+iAxete63E27uFqdp0gGk/ED/2yv4xgcewv90MMU8yM5nS6Xclh5gSyr4wyxCNThEfv7Z8J3S3Ggy1KxQ53GFRtZ/MYEDD7coEFjyLK301jlw1gwmUZ/eftpGHXcQk9vAZngonAyfEyW48UQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875162; c=relaxed/simple;
	bh=UTKGHyqJokQ3z0ueIulz6onYQgIIDqByTP14Kr6nXpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsKDNuRZ7LSYLkqmB7w6AG5hxDT18EXKqpSbHdDELhnk7oi1TEmJk4SMnZHloSymEu24/+RcX8BK0kz9XFVep43zT51VwqG/GCM3R2P5rnfRB6N5oFrxz0QIJFQwek+U5vqYr++3jWK/5ViN3Za3fh5keMbnXzyDz7PP+33g1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E72D9sZX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E72D9sZX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f6de72faso8847575e9.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783875159; x=1784479959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3IGUctqSRJukmRUvJ2jjgPy3v1eQvtxkdxkcO/xYck=;
        b=E72D9sZXFALzNbtUUtBPLD5AWd6T9yG0kguwKHqVxDZlksI7ZylGv8JXndnaCJd/HU
         Mql4Hgv9KJtoN6osqXJtZWjVAZlUvPfwnOlx0ykyt8m8pQRAhB1XXYu/AJTmYsjZPv3a
         NWEoIz2TDo6LtTyf9/84WH36Vst+xcfj23pf9Kn9bFieDl0qtqrdWt0IRMVKSgnG2TJq
         6cWaoflE8PZDcCjNt3ukM4tBXpwKsFOradtdcSZkFF9SZA2ErTl3hVbSbXnayMFuJjvz
         y851n/SEfBkdb8QhSFsU2cX5sqdRaR0E/1+1W9tJRJoGbshGa1YBuy4q+urK/n1wDe1Z
         UUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783875159; x=1784479959;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3IGUctqSRJukmRUvJ2jjgPy3v1eQvtxkdxkcO/xYck=;
        b=mmF8JRy4uILs67J8aCdzHHnbUQGzRC6lz84vKz7R+awzrhMOwf2s3KU0qF0fxJa4Kw
         itj08Iy138nE5Id4tDytCEdLu8bwz9mGXhq+Ksbu78rfJm7wTzZIG0jwdF+btAeYTI0z
         FGWutV9Qv8uSwxFuwoQb1j53F+yDpAInsAgwZEgmCnV2iTuBM6yydLFgvvMLLP+H55T5
         Wah9Vg5blAd6qsEftDkkbWu7rGgRz/QuKlaNfW75SQhL/op7SuRo9NDUq/NusaChmwu5
         8/ZVMGvjttTa0Hy8atbA3Om9aIaFBOPxSgtnf1Jwja9gHygkca/pL1hxGvocAKvi6JhH
         N0sA==
X-Forwarded-Encrypted: i=1; AHgh+RrZvwGgZvRCSsc7oL++0PJIZJ88CzpCGper87mH2pYhlB6M72V1UWEoCkB6nBPreYCJ+UP/zmZGNBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZkcxvJBCdbqpgNZruIN+wIW7YVDXne4CkOpxHSK3bYWIVW4e
	4qrHn3qexupTYx1QYQvgmSrr3Q0au8T7mYRluPctrpq3lE0kdGvvDE3R
X-Gm-Gg: AfdE7clhnbtFmQ2MAVXkfR6YXly9o0KTZvrj84Z4ePAt39XXuV2Ok86eBbtKja9jL3t
	mEsOYOH9i3ASdGmZ88iCDjDqxMXE2cQba/oC4WrvI4czVNmJ0Vhetj1QWBkItBegcyz9p0eZNz8
	AZ9/toPV30YSXD9Vd0Pzs3MnZ0Td1jQX0qloD0+CmNSDm8Eilp6xQyIMYizdOP2Ei1aS15PwY6V
	TG6adt4qjXpxh+/aum4oyGEaCER+N28F2Bzfv31SzscAj54v82aHIPnS2NuOuCLyStw6P+35fVD
	svJglMwsU36lIE3cpfMmbAFqmRY4wO9m99fni7RZ5H/XNsQPnIyxK5N35KBot299OsoRrJOzbrr
	w5Buhpv8A2uG8yce8ZnMAK0hd/0ejuQsDGbsQeVu1Ucjlz6hPvaQrIAqI5aEKOTYqjJ9ewDimXS
	zy2EmmhL8QAHYkpbMmMxr0RGtOWC7+XGfkBFJhUzWuk1fZMzIhEF1oBSeXyORo+KILKmc3hRrB3
	Fn6VFwmABWbzDG8rWVHCz3BVZriNwVED+eKOml112l+PHXlNruChShnMEY7axNah/Iuh69FkoBA
	G2BaNaGuRTCV7eaSusgMfjQA/49Ic2peCzGVBvkSqrlgoMJUrg==
X-Received: by 2002:a05:600c:8b65:b0:493:f478:4c71 with SMTP id 5b1f17b1804b1-493f8885308mr62186295e9.7.1783875159109;
        Sun, 12 Jul 2026 09:52:39 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e0f165sm163251925e9.0.2026.07.12.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:52:39 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:52:37 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Tomasz Duszynski
 <tduszyns@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: chemical: scd30: remove kernel.h header
Message-ID: <20260712185237.6a60e112@systembl0wer>
In-Reply-To: <20260712164225.358852-1-m32285159@gmail.com>
References: <20260712164225.358852-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 11:42:25 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> kernel.h is no longer recommended for usage because it can cause longer
> build times and pull in transient dependencies. In addition, it's not
> being used by the SCD30 driver. Remove it.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/chemical/scd30_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index f85cdd8bd84f..40bbf26a667b 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -23,7 +23,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
>  #include <linux/jiffies.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>

Since you're doing IWYU stuff, you should also remove errno.h and
add err.h instead, as the code uses IS_ERR() etc. and err.h includes
errno.h

Also consider grouping the iio headers and asm headers separately.
(separate patch though). The include list looks overwhelming!

-- 
Kind regards

CJD
