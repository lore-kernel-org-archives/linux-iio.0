Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11454377020
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507306; cv=pass; b=UewXo0JiiW4CWby4lJAP9DkNRaoR239recEVbF9CVeH4M8zk2Xhj1LCtcq2MaAkQX1+G2V2HGdEP/fCVksacEitWfcqwkzs6+Mf2gWowGtdrH2dQclJZvcMipG7vJdFA6fIM/I5v2aYL937lr3/GAPUFh5CK6r17pOdxupmUXGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507306; c=relaxed/simple;
	bh=vkLZtzYyoUvi9QWRbolwqSSgMEuhKWeGA66l1nYHQjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic69d/lfc7yZ1bCefjeyvOMte8Bc7ATmYkt5FSo67vwSA7fWkM9FDSNCfV5rxAtwmaFjfbWSZ9CS+UUeIgiUd81Ao6i9klNbusn9ehZN2v1UB2HWR3l4MFrErHKju4OwDjRq2LFldV3GQh6ZFb/QuXpi2A0CyM929KcyLTydbY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlVQ63hp; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlVQ63hp"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so3263596e87.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778507303; cv=none;
        d=google.com; s=arc-20240605;
        b=diulCSNsVyfHS983xrbE9CsznAPk4adr7How566SFFFcrCMisZ3vEO1089o0V5SrvB
         3KkMkHeJe5gydhTfUisVA/aMhc8yJYO2AjFDm3cSW5XNzeUWqMEfEQsvQNABs1mZrn5i
         al8uRn1O7kiSAq/xeogDXnw+f+oBv5+ztSdv09vx9wC6+BsP+3rrZ+D59LH2jNVct0G/
         xTpreJ/KNcLpsFgpiVMIk7adP4w6YjJHxQllBNAmOL4UbUXTy0O7X6FYtPNKUHB63puU
         M5/oB+YElc9vodb3rdmu7JCxK0rBoS+fnClhDDjOpej4otR+4XCDtHdbcR8z8Mq3Qs2f
         hPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5QD0vSA6KlrB8wp7vy4LEBT/AgKCiPQqAPTMrLq8TCM=;
        fh=3JwwwZoGAAi11WZ8xH8df7eoCePX94r9lbGMTdqnaKI=;
        b=Dkg7qMQohZcbOo+de60xYij+d29f3dZazWVEeHG/OuMaWRfJKGvfRB5IjqNTqaTgnF
         w6963F30hbsMPrNkhbUrfXYrtzZp80TGLZQsrynkmDofZo/DSVKpl33CFnEe87X6p9da
         3jhMAe0/1/SfG5QnJxTGUnt1WyKBncBGXVDPyT3irKMdpdaiMfpTw8TkHbnQtqmcTYCy
         PtmVmwxfhBeAROeminSvOHnRrqOINlHStgAc55uW2eWn1Dsq2DYU/1K+Pma7B6OM+2Ug
         AxAv7nnaHWrVDAxWSJoofu7vw983icEjr3wU/t4fBoh13JhIRLvtp8A/8ngfCMS96m90
         rW2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507303; x=1779112103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5QD0vSA6KlrB8wp7vy4LEBT/AgKCiPQqAPTMrLq8TCM=;
        b=nlVQ63hpoYX1okEhKZEo+RLOOjIsnEFvqwhB0CTlJLKHYLzRBj1/M55kV8iV1kvN2i
         uSHvNFBEyCHgbd02LpxByj7h0uqj4t5Z1VZug8kkI3BTO/o+ND1C6LDc8p+/uGP/j3XM
         qfihisZonsCcGtXPcr93rrL6+FC1j/kzzI5+9DBXx52/nxDKH2p1MwxYgnHOhpw209Gu
         mK/VT2JpWa4eczo95/Zh8tZfNsfP1Gch0w9mphy4OFxCrRoMQ+hYYUdCBkKyeXdllViW
         jVCuQf6G791pWCCq7S/T+w7NdoHegECwMLZZzjnuUI6O+1624JATHhcfrMeA8O6pIShX
         yU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507303; x=1779112103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QD0vSA6KlrB8wp7vy4LEBT/AgKCiPQqAPTMrLq8TCM=;
        b=ZC7rPYkXjusZtPZ6fO8qv1hKm6quuWNt8L9k7o9F0Tc2TTm2VeH/3PQdvapAjrXSJb
         /OQ0Kg8gcOYUn5waT1RTN1w1c3ZUBNAP5HPlt+/SbuOSsvBcLGpONR0+lrLUuCxvEKKJ
         QuFGR8/O+DRkPywppI/inXS7M5RT9G121X6jNOLq67+JjnZKDgF+vKC0lGX1CVieu/qB
         bEbUBVT0LEBtiB3WROJ6hjuBH+Mtcn4IghcNcJQjgkWupErK2oqPdVJhaHlIs3TeMgzv
         aGKvMmrXRJFnl4AMbxp82fbd7IceUHu+5iTv2Z0+6dww5XEnnVXFDGIOsZS1AY8PsNLG
         7VNw==
X-Forwarded-Encrypted: i=1; AFNElJ/keC4TiVEnQ37Ag+Eoas3VKJb5PZb8H8F2+A6o0JlEGjC3vR8Qf/UCeJAtiAk7pPyYJ6OYKK8Bsr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWU8FbTfLHWOYopq9dofVuaSMgatAJafiSevLeGON13w8ZUw4F
	egHQxNrB+zFy+CjnkUD16mZ08MZpHpyfYTzz8d1Jm3zdiicMr0m0sjbwqbrD67WYbiP+uG04YPl
	p/HGvpJZBhW7zPkxKsdyU9vMWzCo7TPI=
X-Gm-Gg: Acq92OGFrRxcsGnLnvYXatxj4FpK+33Q6AYJRUjh63drA9Spz9qCpNg5RPkOJRVwMhc
	v8i15sZYxpQNnvC+w9/55B0WyNI6HBiOsY6WK6MR5AxqC2S24s4WM6dIbGYFnNgl5NT7JylvlkN
	f3KZ7N0hWoeU1LZ3tgJSSGyI26MBzh0+E9wMl1rAxojaBza8McTsAh3U2uA0HzjH5n/xG5WRXeA
	j254qkBDxd+1qRQEtP5n3QgO8PuY6CLVBPdEM5ZN8eAwudfCw++QmXEQhmByg5fbV2x2rX2VTy8
	ETrtFD4yqeKiRDzoGmhrYKtBSmB2A9fhGmYsoQwhudT5Iw4vXAlIDwx+DoaytV88XGBWFAC+M79
	Sh87Gps72t2lvG3lL42YUxe1YwfutH+H5e8BvfQ5VBO3SHy9l8HLDcsw/ddF0U0a065LYcqOJBB
	VbJOy0GA==
X-Received: by 2002:a05:6512:3b0d:b0:5a8:53c4:f8b7 with SMTP id
 2adb3069b0e04-5a8b709cf32mr2392409e87.27.1778507302945; Mon, 11 May 2026
 06:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALoEA-wQ_hYsP8iOhHf6yAzpgA-Bq+78bC=BqZdaPcz9bW1Gww@mail.gmail.com>
 <20260511062715.21-1-sozdayvek@gmail.com>
In-Reply-To: <20260511062715.21-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 15:48:10 +0200
X-Gm-Features: AVHnY4LN7Hig2wF6zjgBxt5XHncp2kELQyHN5jfLNR-i9xzIR9_jRX2PGCEEuyI
Message-ID: <CALoEA-wUB1u8NfFSDPxoghMW9eLHKwBMBSuBrVBsZLyP+Oam+w@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 15:42, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> On Mon, May 11, 2026 at 15:33 +0200, Joshua Crofts wrote:
> > I would say that this is a functional change, you are changing
> > how resources are managed and how teardown works. (But
> > maybe I'm wrong).
>
> Fair point -- the user-visible behavior on success or on module
> unload is the same, but the lifetime/ownership model changes.
> I will reword that in v2 ("convert to devm-managed lifecycle"
> instead of "no functional change").
>
> > consider introducing a local struct device variable, so you
> > don't have to use &pdev->dev constantly. It makes the code
> > easier to read and saves space!
>
> OK, will add `struct device *dev = &pdev->dev;` in v2.

You can do this in a separate patch though, maybe for the entire
driver.

> > If I'm not mistaken, devm_request_irq automatically throws
> > an error on failure, so the dev_err() call is redundant,
> > just keep the return.
>
> I do not see this in the source. devm_request_irq() in
> kernel/irq/devres.c wraps request_threaded_irq() with a
> devres action; neither prints on failure. The caller still
> needs the error message.
>
> In v2 I can switch from dev_err() to dev_err_probe(), which
> handles -EPROBE_DEFER cleanly:
>
>     if (ret)
>         return dev_err_probe(dev, ret,
>                              "request IRQ-%d failed\n", irq);
>
> If I missed where devm_request_irq() prints, please point me
> to it.

Link to the definition, it's described in the comments.
https://elixir.bootlin.com/linux/v7.1-rc2/source/kernel/irq/devres.c#L94

-- 
Kind regards

CJD
