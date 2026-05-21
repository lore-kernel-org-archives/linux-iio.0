Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CACC3A5E9F
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360206; cv=pass; b=tHkLFUxLC97vi/99S+pnCk/iu65+yossPOxCV+u4KQNiXyL1idaU1fQZS4xAelXhStlX9FpXm3aBJ7qDx3D+XBiMVKaHDikHaBzLx7KwB148RfSqe65Iv6LRrAkWT4FA0gYSrU0pfwmZcUKQT7KyD0SXtZZVLpcrSvHldgA/i8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360206; c=relaxed/simple;
	bh=jyi+PkSU1Lo955lQFAcRbPcBwlYnbWRTr2e8VW3lVaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zh7Q9q+x2um6ZX6szjOwZ9ZjYICO6//AiQ8gIBdmURT4q81xQwrsRh4UWfvuy74hH5elfzPgjHw6bYwDtm1ASWq5opgyNJDmlY+3WPmVdzqF3ruN3/BTYtCgpfaEjQBqVw7crH6e33MJZthYkC3L/gQji1B8ZUs425ZtDF/iRK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWBubRbe; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWBubRbe"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490229aa522so25566155e9.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 03:43:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779360203; cv=none;
        d=google.com; s=arc-20240605;
        b=DAJ+CCYd4vo8e8PsoYO9ZZvUDJx2xPPp77uZhrvHxlI04ZGergPgobGRTBoPrtLXe3
         w+5D7cbz1+Jb64KKblzj+k95z5rsbHSBLvxFcZQQp7e8Z9VH3tdLDzhKpNPlK+lQNj1V
         98BrMOrMc15dcHrqgBy+Wjv1urDkJmkTq44TOB5XRpioak3DjO9ZkOE3SPUTm9KWXnfn
         A9qjutoUYtwuzwMeGruKfHgaajAEUk4N2brRJC5J1Vdkn8pTAtBBZSI9TlBovpSvWxi4
         Zx/B5a4PkNeEKk1QQRUFKzXVOkJ+3ehznKEfJAaiiEgl5ENBI3Usm6AjRjhH2yGTLvmn
         2Mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QTeWsTxPa8DEjvEG+x1uSQflUoOO/k0GEAZmP1Sd2X8=;
        fh=xhbjJCjo0p6qbgJd3FOTfKRSOmpT6CLw2xeRp68c70I=;
        b=NLJgea9BMMWIc8XTnh7sfb6AjvtQe223ZE2c6v7R/kaN4GhB24cKc+4OnPiL9yBUAy
         bLBmu+CQAwIaU4lwSV6uEOz+wlV7SrM4N27igCKHyl2EzefVbaY7VkKlBakV3+MkNeTz
         ukkjovKp6V8ZFTmYG29VgP4a4r1JRTnsw9QKzUX1L60r/vvZvs79NzLrwexYF3+o//51
         xTj3VI+m1AXaT5JG2v9q/2BXFCsKs/95hQeoHfUGHrSwrrDIMsA5Xn54AIZuqL1lKM9n
         ZQX+r9FXRodV17aSJCDu1cqu4txmmonbDSmoM2LO/oK9X4WmFJ4Af7BGRU0/7kAcy/NZ
         Ymhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779360203; x=1779965003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QTeWsTxPa8DEjvEG+x1uSQflUoOO/k0GEAZmP1Sd2X8=;
        b=AWBubRbem7vSG/anRQxid7T5g/AI1oQHOBnz/S6ZOIqCu0GfEGTUnJqGg759Q6p0Ez
         2HE5+rowKY2Dp6vIbBV5dWbIWp00MohMShnnkRrwiW73BTc9eCRftHrEMZGAzuTDpw/B
         NGNkj8RqrIsyQW4B/Pme1RUQg0VwxuY2J86F7BfA/gj/F50ba8wHV3SOGKsh9Kb0kzdZ
         YTX2kJ4WvJYevSxoe5ZMlPiem3HhHFdlyp7JZ24kxRsR77+2hQqW7cn9zeH0BBTXbb+Y
         XpYAn8R/8gAbcvrABQrAJz++SdSMk4CUXcxj1HyJBHcJ+87VNsmkEQg8B4rHiwqkGjQ6
         MUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779360203; x=1779965003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTeWsTxPa8DEjvEG+x1uSQflUoOO/k0GEAZmP1Sd2X8=;
        b=L1jCB8VTw62kfhqCmNWNS8Oq7BZ3yAYsR2jUbWWLmiiuDN/Pswmq6sMNXNaY12SvTc
         vuUC1UQbU1Kaa6RXls9jh2CfjmnDj0BXf5sJlzGD7oQ4xtARYlW0JQ/K1fk9whucIdpb
         n5HoK6sKKPftq1urarep84ZFrv2D9oVqmSJIZ2hh8lS3xeynVKv/0RvEL7jen9KAyUMc
         EdN8HSAdSeMDnVJhLguPM7/2vi21PDHgdYALS3/z55UokzloaCpk5S5QFAOaord3U/rZ
         3ct666NNfELBSdCKwluy+D+VQWDsMMUXCMhg6+qDbvPQMsR5WQCf/7k/5spVcfNRu8rw
         0L3g==
X-Forwarded-Encrypted: i=1; AFNElJ9MZqqCRG04pV03LZaANURPg4Lx+UFV8Ur1eQL2wkj3CVo94NsKOF9nJZgJveG1vhvrsHKchtpZmHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitUnfKpuwDQ/653R0bE9wCY9vFfQw+a0f3/IDP3PxlYdWODBC
	g6Z2uT1e/9CtQnQqpKTRKfzo+BtalSvualGeBwtYL9NM17RXdlqVQ3x69Fvw/3MmcOs5mrHIuFt
	1malBp6hCe9XexfrO47S/MoQzIKq4QyU=
X-Gm-Gg: Acq92OHWAIfKwO8NjKL1MCbPYEX/ti4CWaMvidSxPw8QXshFOfBJhK+J6ZN3PQqfbrZ
	fzTTDK4wXn83c+TkwDz9mn9fB4O1vO7Rc6KN+9kArKKFH2Dhb49AIFAcQuiHKWzKDDrMnn5vnBn
	scuT9mcv0VxlW2rImFDcEwlsK+1OCo5Hvj6lYnnRRdzlqjxt7Rf0ElXIvcNzc2cP8x2IN95X+yd
	w47Rk0TEXqv1yi8ARJ9bdBcBlLdkHQnjKKLtG16YYlm/MWUHQHWFqgXuOUtiCQPV1THB1eDpAC/
	baoxuLXQR14pZA6AnHeWMYGmRZgqW8uMTzqzCGIQmiDZg7KT9P0+YpPFWTxuy5OO90C1yqf3WZc
	Ter94WlgvaaTXv0/4I0ghbSw9szsdezsd5mQ7tctkBNWnSYgbwVjgrw7p43pLe0IUBvv3RHeT4s
	phcyIV9krqHo0yCdsW
X-Received: by 2002:a05:600c:4654:b0:48e:635a:18d9 with SMTP id
 5b1f17b1804b1-4903608439fmr22276575e9.15.1779360202985; Thu, 21 May 2026
 03:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com> <20260521-opt3001-cleanup-v3-1-820169dec8c3@gmail.com>
In-Reply-To: <20260521-opt3001-cleanup-v3-1-820169dec8c3@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 21 May 2026 12:43:11 +0200
X-Gm-Features: AVHnY4IXdX8E0Wu-SmHBWi87m6N_UHaBCa10pUFKZz-05rm9w5sXgVPhKkLHMJQ
Message-ID: <CALoEA-wx42LqmNsu7KSyGG_ssMRcNntPA485x7-DFawCfTb2=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] iio: light: opt3001: move device registration to
 end of probe()
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 at 11:55, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>         /* Make use of INT pin only if valid IRQ no. is given */
>         if (irq > 0) {
>                 ret = request_threaded_irq(irq, NULL, opt3001_irq,
> @@ -894,7 +888,7 @@ static int opt3001_probe(struct i2c_client *client)
>                 dev_dbg(opt->dev, "enabling interrupt-less operation\n");
>         }
>
> -       return 0;
> +       return iio_device_register(iio);
>  }

As Sashiko correctly pointed out, I'm not freeing the irq on failure,
therefore potentially leaking resources. This will definitely be fixed
in v4.

https://sashiko.dev/#/patchset/20260521-opt3001-cleanup-v3-0-820169dec8c3%40gmail.com

-- 
Kind regards

CJD
