Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF763C81B8
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760814; cv=pass; b=CIuvXG1X3X63KHRP5fwDX5K2qk4rev2xwhJf+jXIqIYPvuNCWO0FxoM56ANptn7kCOr5DW1QfvJaXSQw7KSQ/Zzt2d+sjpOQeckBJXDVdiQNkNyehMCU+xBcSqhsfvQRfcxhZ1DItgFqtS+AQtINFrVpeWr84Lg6fqw5y6IRPl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760814; c=relaxed/simple;
	bh=ni3wzkLyA3yJhGADjOlUkhT/YUz3yaeC6w/J7cOueCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ka4aVO0Pu+sw043QUXEOMOsGMPboy9hU1D/YwsnGz1U6l8fEKwxzKn5H6ECz2A+E1Q9OS638KO3vBAJ7KVsOgAevbCG/+D8w7EgWfz9md2dxVOeFrNrx21t2ss7NfpY8GFU2D0g6XInjDajjI/Hyqyts9lUuXwu8fOh1r7A2mgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBAhlkKA; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBAhlkKA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so48416565e9.0
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 05:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778760812; cv=none;
        d=google.com; s=arc-20240605;
        b=eQBDhilo5UQyjTnB2lUynqAh9Q21UenY/354M9azhQcIUEzK2Wv2eoBYfr/HlLQmRB
         MyRGEVykSZ944adTw+P9tXqy9fix4mpghLwizaAljgzFReLsDPjTjYRcFZNT4weyEg/3
         j/ax6HxmTk1g0A/WZVwsbMAWEqQKPT6dNjXowHzt/xE/UlzlvqPzA9GbryJtpO/6ZUcM
         OZ3vqC9Ptc05BLa0fjs/1OcoMg6fRA+UPXVHtUj9gs7TepUD4E+FLoyXlqjfYuFvpVQM
         LCEq2sVRMKZsCo8KhV1FoDQhAwoaiF8cvFtdi/IwDEY7a3e99ATfz0ADBt5pbmH90M/Y
         cjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fRsal/BdUcyFgKh8kL1mNQA5IvkWA0/w0SIKFrkFwEY=;
        fh=pwLVspQlMAz0luOks7cpZMF2kC4rG0i5A8zAaRBOqhE=;
        b=DMJ65SsA68rzGgLQOspBf5iibv5sEx3W8w0tXPoCg5lKpo5j4LkudLSnSQKgoh2Ycb
         jvhr/ht+vWr89vRwxpnEhECE4xfu6gv83X5d+7bIwZjDsNea8t3ZpMGfe5zqvpyQeNC2
         5EsZw1DwlMUvx3odoDnpAKq9LoiMKhYINx9AWIff2wnf//kUvZutZwvQdIcdlZsdLklI
         1hX22pQKILjtryjf3j8Kctc1J5SIZiR3VvBU0wEWDV+oHa/hOnExhQie6+bonFs+gly4
         9f3FapxO/yRtJqKHFcXsMWaW3LG+A7FBrexvDDFcLFev7nbMORzsIMMJUostgLbLDGn+
         A0VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778760812; x=1779365612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fRsal/BdUcyFgKh8kL1mNQA5IvkWA0/w0SIKFrkFwEY=;
        b=UBAhlkKAbhGyxpixcgCh3hc+HYWj6VxOYUKiTgWUcfwqd5e/bWYeVlZYZtegxiYVDr
         WQIQE2531Wgbhm0TNudcskNRErWJHoVjxHIQwRO+D6PmF/7jBBbKvm1kwaYJWnsoY4W6
         YOAw9aIjNb4j7eVdTwdwR2RCb4NBH2bELNC8ouYMKCQkJ7+14+Y8nxLZVMu+B9UNipBH
         brXrqxKA05wjDkaFmyjHHj7md98KZpv355MyYa+yJ3lO16l0dRfL8h67hX6NSgqfyKW/
         BAEBCDdDZKw5+ZdjHee216S2gavCmLzfb2nJwMLHgHSuoT1NBWY4ofqzNZFdE25mMATw
         u7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760812; x=1779365612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRsal/BdUcyFgKh8kL1mNQA5IvkWA0/w0SIKFrkFwEY=;
        b=FwMirDV9KYmLpSY4LgZM8QrnpcSMYqk4BAlDQc90BuzVpgmC0CTt6PGBmPxwHgg4c4
         YIg87LxyoI06xw29LyzZgMdRoIfoXkhXMola2a2YoNyo8SidyQ7h+b1Q6jvqz6UbpURj
         EvlSwnlNIJaJYLyph16TKBzr9eTGmSVgxUPY0n7LO5X7vBRlxVlGBOv4QjjAkuN7CXMo
         XvHFi6V67CNuhmRgqFRgj2Py9FAxR5iNtRvCAhWfvrZcWF0+Xho+dMKORRNOQpKgKmat
         HbdMjglAGPyfqHdolaivQmE3aJsqJNwH7Imqee853FATNZojuJsYurQ1F5Auv2CWNRWS
         T31A==
X-Forwarded-Encrypted: i=1; AFNElJ86M+OiOlw45qDOTYWr5iHZ28k6fd1DPOmfIcEcUIhD4Ymk66OjqOJtHsQvo3yTkPIhd3dT0u/PDUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkHXKWLPsGMuCLQA8OMNHwTatwr3qNVpg01V8QH7cE9vLezyK
	zsEHEx1gbdR2hPJhP/557h7dth/tPA+1ckVEdsT3uyZOcnl7evd4aRJD/CB/GNA1PdSu4PkioJS
	2S5MPaKu57Q6xYdULfcnI9BmSBB+IGjpONrFe
X-Gm-Gg: Acq92OEg4JQXv1+jG/LbsMqeYE4tTUIVbyg+YDrBP8AXtqVplIaguR2D06dY7wf7g3z
	pB7AHQF0jn6i3OYc9H/OjQ9abSaChGVnJiSQn2Zv4JOXofTI4GPmU9Jpb0dzlJFkFx0b9EEr7hz
	Ajld8MvgFDS1E8CHPdlmYF8PtjRaCX8drEvyDhZxiiBEiFVoKwkKUy9PpRMu19UUpQw0sN5WTS8
	bsG6yV0ajePg6db6XtFsTDu+EMyOHcmGKNBb8G04joKg03gBnjk5/5cGPIDmWgQksFtEsrubJbJ
	TplUskUQcoRe9wpI7sr2DEit3SQW5Xy0RsiliVr5qmQcVhBSuRZyk1exU6CSvn1K6Ed6IK01iEE
	D7i1K/0O2SkfImJk9FCExMaUDYBrxqN/pLJzqhzKvLQktLGBM3owUvy/m7jZKiWn8G/TFhD6vep
	1Ao/259g==
X-Received: by 2002:a05:600c:4e41:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-48fe249dfa3mr11504305e9.15.1778760811998; Thu, 14 May 2026
 05:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514085157.20327-1-sozdayvek@gmail.com>
In-Reply-To: <20260514085157.20327-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 14 May 2026 14:13:20 +0200
X-Gm-Features: AVHnY4J5ZwUyYpPyKga-Z4xCln2b6N-gK7uGxZO0NnEuWxP8pZ9ESoc0Ciw9EPY
Message-ID: <CALoEA-zY2C0H2173bx7ETNDUceh8+AyWF_e4EJuoFfSdrRFHoA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: iio: fix typo in triggered-buffers example
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: corbet@lwn.net, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, hcazarim@yahoo.com, linux-doc@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 10:53, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> In the "IIO triggered buffer setup" example, iio_triggered_buffer_setup()
> is called with "sensor_iio_polfunc" (single 'l') while the function is
> defined and later referenced as "sensor_iio_pollfunc" (double 'l'). Fix
> the misspelling so the example is consistent.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---

Looks fine to me.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
