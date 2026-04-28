Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2E3242CF
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393692; cv=pass; b=VUKTmBzVqEtvOojZ/wSbUm+DyNAZQ/fEJYFo7nzFZHfqoM+SIatR6C+abSWZh2fT8/bhXk3uJY8NvSy3/caT7rRT1/hJhg07qhkRYgwooH0M2O6gYh1+pNDxKMcwODjSQRkJN1XVevvRZCnJV/RdxwCg8N0PAMc+g4wc66pd+O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393692; c=relaxed/simple;
	bh=Q3bWOuEE2EIOwuL+Zbr8EUm/TDPisQB1WmyN9+T7ghg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjK1Sh9DzZeeIeRKcULAU5oRCKq+XhZYGSGlXogBkLIpE6zx4rsgiduMNRqwW95WZDsjExCll6j94KFP9+pbxlmzzLFD6/Ks66SgZtj/edUp/Dhdd9snheCVTGxujqVgODGbytq0cDGVZPQXZ7K9wnMBCawTV53L/CQM6N2qi+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDO/0CrR; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDO/0CrR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso88396725e9.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777393689; cv=none;
        d=google.com; s=arc-20240605;
        b=ERG2mTAX94hHpUBAgf8ta702GuMV6cafeFLIo9+L3uSuULtyTEMdSMKb7PBzxLh8b+
         bu2IzlTNqeg20NbsJH/tupw6JWzS2SNrUQhLCWdEOqPdZE/5rWvfRgMivIFFDuhQpHbG
         Q8FZbzPNG8LDyYe1HyKedlo1izqS+2O1Ie6ALN5ZviLbM1tWb9HLnDSAtQYsaqPWVg8N
         Mn/5HZJwwaLPkFUNYs64Vu6w4q5tju/Vi7KO+HVssNst/hj3cGjItcLeARXIyJ6FH8hD
         IuWrDI6/uQRum44XbVT4aNsJW+EI4panovY7nSbLMqQmVH1MZjLCjHwPwQPKrz/+fTqk
         m+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DEqXJau3JDG+PB4xOaSfrg/qmMfvTHQCF5ukxvXD2pA=;
        fh=qCitGqBz9buSfFoBJszRuBoWa4Eakor5qjNPkXYRE3I=;
        b=c+I6yHmfihDzAyNQYXwNmIIRfoV5m511DC5FwF1lnpHNxpjTHWZrKic+jPIvdeRWoP
         2WsO/iMEv95Vxfgg1+vLmgxoYOlphlxwjvkoADAegLE8JGoXrbhuWE01opWc8xpvt3sG
         5ZuIepHMR7rFF5YlKTZ5si16MgvfGZ1Lvx1lxt/WA/TXeKCWr+jblXDJCSjAbnxLJniS
         FidahGe8tw1QqQp3mtKQhc6nleFze1xXaKDaE8blw/tsHGA4yA4hDMxgDndWd2jXwXDF
         d2c4syuLTRw4pqlfsCOFCFVtYJaVWjn1MGRrICb5FBJKA/jgE6w3vkbT5cJNQRFzWBsy
         IyrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393689; x=1777998489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DEqXJau3JDG+PB4xOaSfrg/qmMfvTHQCF5ukxvXD2pA=;
        b=VDO/0CrRI3LI48rMGovuIT8Pke7KGMzCIvZMQIZ4hOK81O0q2Aq44Hu+9iLcDCWpOb
         +EXVshM+zbjUY7Sdynr9A9yaqKztW5vu2iLGGwqz0fqti5lPg0gZ8jz1FfsXgwwUg6sk
         wdeHwqKM6dKVhz4b4oS7y4tmSReWmwvIzOS19JHI0ONzOO3YglRLdXpqnW445pfemktF
         o/e5ilIudVwYEgj+BWtlMd1PEOY3/P9ZWRQJlfevqILn2I4H4MmFKgnWSdk6hpPMzWaG
         vnwDzhHLmhjzc3IQAiG4KuXbprpoTdfhJ0OIU95PFjvkoGPhW8QzedzZgCDX9RBlcWWr
         CJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393689; x=1777998489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEqXJau3JDG+PB4xOaSfrg/qmMfvTHQCF5ukxvXD2pA=;
        b=Y7RDnxwthbNAGi53foPutYKYfjIO7HoIRpWnim+jkAR9G9AZ+Sn9DvSoMVgNdqOWHj
         LljsofNP/nl3DUOB3owif2oTSCYsxL8r0Y01fQy4wBwllwXr4pj34Fja0SARz0Nnre/v
         nj04BAXoxc5tecWRVTRu5Kya7b+7w0qE2dI1JazNNaWt2J4VvI6YHSOiZMMd2LQncF6F
         FrAOrurTw+6xZGtNfbfMjATzAJDHeGlpedhbEgkfphv7xSsBTKceoAEEbD/43ORo1TkJ
         pK9zkZcOJz2NLmkl0FQwkZ3q471qUnpOfl0HDYmgY0BhUl4bhNR2ReVzUA0MG90hoZrR
         a0/g==
X-Forwarded-Encrypted: i=1; AFNElJ8M3bO2E8erp0BM51dNonrhZekOzVgOEewmJ1YHjsFC9YLzyYFStTkw8CFC5+yukqqIVLv2eEP9lF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpheYO+R8ycJXZsZ3aaz9fgqSQCMo9l7UArdNjk9g9TLQZk3Na
	lf3grhWQXkOoBsp9TGzVp86hNwV7glnuegl8QY06HOOwysRHVO2uDmZXO/8i+ovor0yGNBfWykA
	VpvRX/X0zn1IygQ2o32C6eByd4Tyzas8eGDcivpE=
X-Gm-Gg: AeBDievX2jrccPWqCxJiDCSuhTyVvPbNyeLrHRn/NBE5s5xJCCSADEDrA1e37VGGz4s
	3FmQCbC6GnGYHrHGgMbsT875VlYhHz9l3mkUNlNfgxqKKEtrBAvcYhToA6dTUy4J4aPMbt/hM2l
	17JeK73J8lAuLRQkHedznLRXc83fDhE/MUZmuiEuDuG/HbNO9ve4ibQjlcbSPvushclzdb2HJhf
	n65tJ+28iqNLjVs/GPQvqnVNVfZDqAgmN1ruMQ6g9RMvRs6pWWajlyoJgAtFL4b5mmAtA/dRDB4
	w1yfzYxHlHg8Y0MDKcT9lQXvf80c0UmMBbsNvI/qBmXy2x9c9UJAnndTvYXKeFO3iGUJ2n5HmqS
	wjGG338ZlQmYAxPooT7DxEC5+JtrLpexGDmlckwul5qZjSi7yILtrkhoeFdSV8eOxRloDUm9FW7
	QFUOkIrmwCFwEwJY0338PvPgvqAoq2BjCkti1gPkNgK+rXh816AQ==
X-Received: by 2002:a05:600c:3d90:b0:48a:554d:b9a2 with SMTP id
 5b1f17b1804b1-48a77ae541dmr64050855e9.6.1777393689235; Tue, 28 Apr 2026
 09:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
 <20260428-si1133-checkup-v2-5-70ad14bfefe2@gmail.com> <20260428162034.108fe4d1@jic23-huawei>
In-Reply-To: <20260428162034.108fe4d1@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 18:27:56 +0200
X-Gm-Features: AVHnY4JhIGt-Y2I_qrWr5uR2R2sr6z0jqo1XZbr2PwIZI53sNpUs1IYNn37fA6k
Message-ID: <CALoEA-xGt9xdQee9gY6fHbyB+M36R7SK8L6pfP1S3Pbm+fXnvw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: light: si1133: use guard(mutex)() macro
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 17:20, Jonathan Cameron <jic23@kernel.org> wrote:
> >       if (cmd == SI1133_CMD_FORCE) {
> >               /* wait for irq */
> >               if (!wait_for_completion_timeout(&data->completion,
> > -                     msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS))) {
> > -                     err = -ETIMEDOUT;
> > -                     goto out;
> > -             }
> > +                     msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
> > +                     return -ETIMEDOUT;
> This is some unfortunate indentation from readability point of view.
> I'd reindent and not worry about the long line - it's very long but still under 100 so
> tools won't complain and I think it is worth the pain here!
>
> >               if (!wait_for_completion_timeout(&data->completion,
>                                                  msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
>                         return -ETIMEDOUT;
>
> or perhaps better yet, use a local variable for that timeout.

Okay, I'll probably do a separate patch for that though.

-- 
Kind regards

CJD
