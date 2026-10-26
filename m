Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024500;
	b=kcxNyKqnUkE/qCnk3yTr8CWBv/qo9a6tgT3nnbyhqfDj/9Mno0KUFZhYgGeq0WqEpHII
	 jLJxwEplwc+FB9CvvF8Q1dJ0yuCV4Ip7CTikpTRpQWyf9kQKY3Wb+v8L5udt3DAlop51/
	 e8Io/tajnYTM5arWPxMalwlzWMP6xLV5JQndur4s5x3O5dreRfYNLswG2/lJnAHcx34Wa
	 DLxaJHgf4703PwXALTTDUMn7n0u055j5OAtOvV4vaX0bgrvY1WhlDT5mRoDhJsVZ5k0GZ
	 xZZgDhLNGod9/uzTgT6VngOGtPhBsE0gEE4VaqXJMzUxZTUVC0PLx/IXKvFTNGcWNTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MwdXN1TCWe2BL4b2dfairQrlmjtBR9ajoa0+SCjXZog=;
	b=FKlsHuxoUtKk4msomH/awoB2Vbbc8FBsZO52iwsMXufKKN/6FckNHTQEcu7o4Ne3zV7o
	 gjDGS0y0vvedPlLXQn3wuC+HVpNPQOKN4S7SXYn7mXZvSGQQKokZ6dOV1z/pelEIq/wIw
	 QMpVFEOotT0oQr1U6ZcYJOyCxmKPr1znckRljqZzTug2fSlHtBmxHxdZ9XKASo3u6Dl5C
	 KQAJ0ya+TdtcRvmktF9/5S6egkizWDHC/xoDM2F9EYxECEglUjC+Alk7K9sT3LExR0bsv
	 b7I8jsm2u0LB17Luq1e9ow/j62BY/EpR9KHH9I8ECJA5io/dSJA9ThhhbHs1NudWqmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aLGjbnY4;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B98606A320
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 14:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B98606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aLGjbnY4
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so6124515e9.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024499; x=1793629299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MwdXN1TCWe2BL4b2dfairQrlmjtBR9ajoa0+SCjXZog=;
        b=aLGjbnY4YqWZICNGtjWxs4lRVA3bjXXY7CKbgPyRyQlLvc+9cdycQj1oe2rKkgQA29
         no6pwmzDV3pV9qprfLknsiWnfdLmcV8h+X/2Z6l+AiaPaamSnsD9UlJIn5aP7r1VOYHc
         XDuAuPbQAegZQz1tJBn/P7f1QQptUYMIuNJpAFgPAMSeC2b3j1nFBr4o7zO1OOT6qwDp
         auZTvkPUqt4kgwxCnCAP3tUNWw/SeT9vtUj0Jltt4tarbisSTwLbghUXJmcbu2lEOCX1
         uNa1ONDz5FuKxxJsPP/7y85v06hqMTOFo4wlTGHTK/4bJFU606IXsFETl1W7RIRTCW3H
         7MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024499; x=1793629299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MwdXN1TCWe2BL4b2dfairQrlmjtBR9ajoa0+SCjXZog=;
        b=h6M+SYVGQ/UdaMYp1MwQTe4mjwAzBHLuC5awLDBCwLxNgdnqTWI1QmFyVz2sy0RRQZ
         XDopHNDQXvbp9cBAwCOhlXz6M5zP3VTBrgy+jJd5WFzEJgF2gFRezhDaIW9rWMYcPQFw
         pYQwm6ynBrS0/pqeLtcWfDsGJUHqus0hWNUI7Vklp6fUxYI+fVEI58qb+pwXJSokmjLz
         FWgYuJNUK18RZWYDFbmqwRZUaF6Cod47Kz1Lz0OLqx9DNJ+piJ1v/hbSNDxE7DvLlxMG
         lyHZMbCmq/8bqFmbhX0hdXCVwa2op2gK0ubgCnzVEckc7Q5XXnSWdns+GdO+ppESOGtG
         oEoA==
X-Forwarded-Encrypted: i=1; AKwUvBxUTqXzch2u2lzwKUialQruWi0ICMd3FT6tAxYfoPi58rzLN4VYO+c//XSgOTAdvAkyjcPyqxV7Axk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNhudS9xEKEt9kC2IzyfEhPjzX5bE8uwgVNBryP2VKvivZd9Su
	uqOgmeB9Mpb8SlLk62O+NL9ZFatqAzhDwPicM4EYB0QcVFYOPSE2yCH6
X-Gm-Gg: AYBFou21mgrsBO0O+GtINSD2aUt6EgBYoXQFDt4ZJfGV6IBTx1wK7OQ261EQESAyWNM
	K7d+D87dlTvcjNuwiR3jbcV4S4SYH3Y/+KZR9Er2HKZ5/a2vZLiueSV5+3T/49PQFEZJLInXL10
	lbcN4L8JAvQJJCIsU86qFr3MekaZ8DJ7MQ8WpLjSxMj/tiM0C2PDD68d3widP4pz2z9AnLztXeg
	CK+QY/70ybXHooVMN9Lp2PPQo61exiabBFDHruhaARpoz5i8qAe70nc2+Cuj9pno9uiF/pgaxOH
	qaqqhkD3jnqTaro80qgX7ZyiG+Tc6g0jR89IjWYEkmfE9x/1SmZpj7CGjMwy+AUUF2Rh0ji+JTE
	zYKY1UsPTqjAVf12VdcNm3bHYLWCoUeQHl93zby4nwQnkOa63iIlc+ZBTyDwanIp8MldXjoJRWG
	mqfKduhd4N83OkDIceOsXWOspxh4fT7aISx4JRtPPO1BjkYlCJA1rKjLE3/M6B3P+736T6ew8YF
	+qXYXr2c97XHXH7wSaZuyCFfqpt4+Z6C57PZUuhPctbMD4wa7SXf1ZBWVtUSmZErItT+2vj79YN
	42NOeogK+TPhTuJt81w3/ctgBO41v/F4PxFMp5ZSn/DxFVP6BzZME3lgA2HnweJp4muSLIuF44h
	sUcSzC1ZahlAdXES7mayL4hCZeCESgkm7hI4YQco/820/f/+xoHjywSzN2LnxC++VDKJv9XArBq
	4uvwTRh4xZ87luhRQItT8Rf6dOb1BFsUCP37Axev4a5RE6tz5PMHfd0y8QXLTrjw==
X-Received: by 2002:a05:600c:4e47:b0:4a1:fb2f:eff with SMTP id 5b1f17b1804b1-4a772d05e3emr11795885e9.18.1793024498731;
        Mon, 26 Oct 2026 07:21:38 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48fasm16668508f8f.31.2026.10.26.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:21:38 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:21:36 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: proximity: sx93xx: keep the IRQ balanced
 across suspend and resume
Message-ID: <20261026152136.0000047d@gmail.com>
In-Reply-To: <20261026112342.65917-1-kapoorarnav43@gmail.com>
References: <20261026112342.65917-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 16:53:03 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9310, sx9324 and sx9360 disable the interrupt in suspend before
> anything that can fail, and don't enable it again when suspend or resume
> fails. Without an interrupt line they also act on IRQ 0. One patch per
> driver, as the Fixes tags differ.
> 
> Changes in v2:
> - Send as a series with a cover letter (Joshua)
> - sx9310: move the wake-up register writes into a helper that uses
>   guard(), so resume can use the usual early returns (Andy)
> - sx9324, sx9360: no changes
> 
> v1:
> https://lore.kernel.org/all/20261026100322.16720-1-kapoorarnav43@gmail.com/
> https://lore.kernel.org/all/20261026100408.16874-1-kapoorarnav43@gmail.com/
> https://lore.kernel.org/all/20261026100450.17023-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1); I don't have the hardware and haven't
> reproduced a failing suspend.

The code seems good, would be great if someone could test this.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
