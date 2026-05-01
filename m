Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9B5A79B
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660678; cv=pass; b=vAQyF0e4A2hzxCUt6dsQIa1Vv3P/YW2CqcK89wyGUfhpigyr93isgSAVHq12sh1mucjnBYDAGgC30OFz29Tvnr8gTPfQi+IAfEd59rUWA9gQxyrigvBVayRcBAOnePQAi7a79Dq3/uyIre1y1E5nSZnASDfInpdx1QDzOBrAcRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660678; c=relaxed/simple;
	bh=ZdunVuZccmEsl0FKLA+D0KRnqlCz263C7yvIwNf/nTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xsl6MfrTHIgTdoPI8q/dmp7qQ9HljdCDhCyCmKfZtdBIXeX1s/+cTOMo42V/icDrz9bY98Mz3CZK8V6k7MWr5ijAqB+KnUXa2LAEEZCGUT4axr++KNO8NhHlo14CjWjvwFyJ35O1o+7O14JJT8caR9qs4TcsSIJRW0vySeaHtls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClQvrV7c; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClQvrV7c"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1360480f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 11:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777660675; cv=none;
        d=google.com; s=arc-20240605;
        b=SGx2/EZiq4E0wfo9wInE8l58eP/dToONYMhXwPudcV0Op0UPJDBgPguczwegPK5oQX
         Lg49/268F3SMuHhznVzQswbxZVPbYVbgbRq3vFp9jV1JKZa8o4aJV5J0/fQUnjvsgsK6
         SIHjXIsjXi6I2dOZ6Yo4t0ShkiSvKuWLy4l2qz9yOR2hKFSbFdX/thcJWmQSFjFaXVFR
         UxSA/hwr9aUYhevKVn97V823rCxpcNckql7t3CLl/V3/6FLkVcX4uPH5m4z9K08nlRkq
         okQRuGsOcGXLREdRt3seZ90AYlkqWdO+dXsQXxqETuUmsxwLENQKW7XZW6a3RByBGETw
         QFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZdunVuZccmEsl0FKLA+D0KRnqlCz263C7yvIwNf/nTw=;
        fh=6OWlDhUs3t87bDF6Eas8Q1U4O2pyhwX7EGMh493wKtY=;
        b=Z+17Scav/sItfSc7OH9O7RpY4M+0ReMI6la+tDQjQ1LqK6pxFfsef7E2Cc7m+CKVTa
         XrgT6BZWoYpG/tQPe56FtoFnsCHsjRv+GNiWTBNOJagHdHZ45ZqN2IxErP/84A43dUtI
         D7PfuXsGelRRfBi8cj9Mz4jxqCQ8QGAiNhLhUhth9zzmGsU5fzaF9NdqRGwvENWyIPY1
         rv2wzG+ksPW1y4NtKuZ2hxBABganVSNXZTMAtJI0AY93hAbeJ4G0hXXWYx1nb0mam0Kt
         YOSSH+kGvq9aTvVyq3vkuOumLWctNhmMRgXSaQz+A7dG3lJCpweQgvdnOJmBWKZJOFvG
         2JMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777660675; x=1778265475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdunVuZccmEsl0FKLA+D0KRnqlCz263C7yvIwNf/nTw=;
        b=ClQvrV7czr7pdGaRmT76bHNWQZ49YRaGk25/eXdHaRz6Dn+t7Ihf4ZqtKK+4kvA3lF
         NARRvxRD12hgyZJB7sxB2fxvbHbV7FYobOsPwJ6gH6oX3OjLOufiMnDNKtEYKONe3lwK
         v/K6H57f4gyJFnqhklRSgeTvew2SxcfzdL0tuVS8pzN+rpgCR2v+fjuDGyhuSCYquOV/
         LVdSpRL4loieuYp5BrjS8qotBU9EM/dZgfFgRjafQvnEyV9V5d/m0X+GvGd0GsePWohr
         LSgnJDc5+zfU9KecmlkaQwYOVPYUMu3ZmOOku6gIDoEbbDBSLTDpxIEeIESh/WvOLriI
         1czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777660675; x=1778265475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZdunVuZccmEsl0FKLA+D0KRnqlCz263C7yvIwNf/nTw=;
        b=kNKkdfhiAg+ZRPGKILHwB6aQrhaYI42K0QXMJACuvLzhTKFGIV2Ni3W+9BjA6HWoMM
         Y5Jy0+vnK1Uu0UBS8Jxtz3zTlehCW80IAkf9kG2LA7ThQqFB3AYvDzXlqwpZ8kBCOGc5
         sFopevRLYFJe1wrdj3fQi37IinrNGg8oFUrKqrwLNjNCPoyEo09y1Y9bNxJDv1gHepp0
         1+I28UdA+zy1objnAqKCgzduN8Oohq/hqBtL7f8Msthu7OAE0gP9vESoemtN78i9DtZh
         mdcj7MoW+QY2HYOWJfC+PGPbMgWl4z0O9kD6E4Zyx+sjwK62X+1/C/FZrKgSqPZHZcDK
         55pA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZQ9hOmfglqJubAZ1BlcBN4/9KSDE+/VMOMvIxEGqLgopkJZ6clEYMVJDmdSRLR9LPhM6WEwKFj6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBW6XsFOG3Gbl8l3b2YaKKB65GyP2CflQkmaOkbeYtgOk0YDlP
	ppzmQ0T9DvLG+VwJBQVld72UL54X340aUdHL2N8L6HD4UkT/+QyDWAuUayF45RrcBFZ/anrGuJK
	5evsu4Y3Zzpr5w8ZevJVt8LlUU6Q0YGc=
X-Gm-Gg: AeBDievV3o5JYSl5xDObeJj4hdxoB2aHgguHp+r9tbhbMHojRXD+/nZCuFO6uNmGN32
	ofemRZokoLAs0p1e/Dlobhg8q7hBOx2lCMrwn3CzFYs+zKjSM+BO1zZNGhk3cHTXxJewXeSv3k4
	oT9t616acSORFaJjpu3KjsDpyzQ8cRWAUu7k4Ew7XseWa3wv73lA9p2LBANVWFj7aKSAOP+sJCF
	feRw+E+JDOpC28l0dxFIbO2gNbtcP8/KqaAWcwjoxQmfftrpTqO8Nfm74XDSlo0J3dWLdUYJZeI
	7YS5++tFjUaTeyrGxybMibC8ZuZD/EjhEjAW7qglgD51/8oVxPxOuGvrWlpSwmYejkUPIvlrOab
	tXOYAswhzvATmTXz38/2CASZZ6OqT6iOb7Vh7thXfQU+EVLZ4EDGLRa3YOS/kbXne4fxB/lycg+
	mqA5aCqIv01N+LMDhbofm8Ap0NaA==
X-Received: by 2002:a05:6000:18a5:b0:44a:b0a3:7c1a with SMTP id
 ffacd0b85a97d-44bb558c806mr823892f8f.24.1777660674802; Fri, 01 May 2026
 11:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200515.7915-1-guilhermeabreu200105@usp.br> <CAHp75VfsEkAWfiiNu0xPLLPN_1KLdxfoY_g+mv2bQRkgQpfyUQ@mail.gmail.com>
In-Reply-To: <CAHp75VfsEkAWfiiNu0xPLLPN_1KLdxfoY_g+mv2bQRkgQpfyUQ@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 1 May 2026 20:37:41 +0200
X-Gm-Features: AVHnY4L1ZN5oViL_htojX0CNuEW2LMkwcRgg_9IsFyKiGQAThTg07_kJ-Qr5Kfg
Message-ID: <CALoEA-xP8PUpLFWwGrohHPUSC45jJhNuD2db-kFFo0AoH8SX5w@mail.gmail.com>
Subject: Re: [PATCH v4] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Guilherme Dias <guilhermeabreu200105@usp.br>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nish.malpani25@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 May 2026 at 20:15, Andy Shevchenko <andy.shevchenko@gmail.com> wr=
ote:
>
> On Thu, Apr 30, 2026 at 11:05=E2=80=AFPM Guilherme Dias
> <guilhermeabreu200105@usp.br> wrote:
> >
> > Use guard(mutex) to automatically release the lock on scope exit,
> > simplifying the error handling path and removing the need for
> > explicit unlock and goto-based cleanup.
>
> LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

The code is still missing a <linux/cleanup.h> include.
How does this even compile? (kernel.h does not contain it)

--=20
Kind regards

CJD
