Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934939FCD7
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418902; cv=pass; b=O+A3nOJmFUpBG9XdjxY4hFXmey35e0wEEXeg+Lu9SzdxIRMr9P/KwAjIxTFQ/SzV4q4PLHkrBMRtWIQFotgTX3Af6+yQ/HTvQIEgzjfvhQpT4322TinZmQgaJlSIMtJiAGHCXxRTAmbxQrZTUzMSZVGEp5jw3VYumwaYIhUZ9t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418902; c=relaxed/simple;
	bh=JfJAqk5oIrZsohve8ZfE/wBhlkGru1jKp17SUQ6K+xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=favPLJI5tSRfmCnnKAC27las5znbZXjLHDzIAp6MjMkq9Kg+AEUv0mVfyF9fcdW4d6o1Ad1saTGCn2jRTrLmOIgJjTtaoag4Vt9wzunK4EHAvi/U8onFbZqaC3+wvhar2SXbodU4cZzStjLFsTiY7Zhl9FJyTt/YCMezO6BhBfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkpKUZ9Y; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkpKUZ9Y"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso5100375e9.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 02:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776418900; cv=none;
        d=google.com; s=arc-20240605;
        b=NdOMJaIrtCTV7ed7cJiF3Cm7iq2Yc+x4jzC3/xZnrAnYMNXKMN662k+5IMs3doVkg1
         pkQjZatEeJbqkqxyvbacepYnmoaqyQ8aPb2e1VD31CRKHXy/v7Y9FvJtLQHl+Tyizvpg
         CCp/irsy8IPYkHocY6FQmIaWjEkwvM67e40oCumryLv3WO3UI+obSk44Wa+Ji0ZuuPzf
         zxySai+tF3Y1F3c9J3ACZABcYKqWsZkS5kxCSd6aKcTvrPeI62HkUb0tmVouR4kWuvps
         bROLy1lHMJaIbgArgJsHejgDrBPjpnjrf0GzkchJSNp5O5bZOF/8R9xvXIK4QinCu+GR
         /emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QrDrIe8FR3tZyBg9NmE79HAi9ciGBsGaf6xAQfWRS8o=;
        fh=VFw0yyaIVXxU6d4V1WOIgJ8a6EYXcKUj6Ms9AxxCTlA=;
        b=IIl1NKr4yqRiIDQKnIpWoVxQ+jYQf3aNkVUqidlMIDtGOfkR9IMM3jsk9Jgzdl2OFm
         ih12UCDOYoTRxoCuvZIXRrZJDPsxF1LJvVJqd7EOdPrf+UqPhyizyuByaDLwExNvho9c
         XtKlDtWe6hGPK5qeHJlEDiaVUM+VNnW3Fl42Koi1OB0ljc1orpFw/qef1VMYtyWpDW7F
         vvf9MQs3emrPiYuyZ+MeE6f2YLBz4XOsYjReFtQzug+CIES1GL6mXcaAUsDJE2mnmGoR
         Lv6SyOMhSi9t2XkSGBzC6Jr7ELWEqbIYkTLLc/PbuVqQAgOO0aV4p+2tnluSSlgBEAp5
         bdpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776418900; x=1777023700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QrDrIe8FR3tZyBg9NmE79HAi9ciGBsGaf6xAQfWRS8o=;
        b=rkpKUZ9YtpVMpNO4u1+NfQVvCSINYZlHUvZayQokEqXUEFOE7MY3IqvYhr83xNRkPY
         tb3CMokn2e1AFXWOGzlGRJ10bERx07zbbYN81pyYn085hBbpd4W9efKA/baidfy37A2m
         TdzxnuY9im2bGfsO0yfKgHw5wLM/J3VnRqH2+A5Z1j/Ap49w8c8ITI7LICU6XPT5m8uG
         I84u/3de3sxwz7/Ww2UxA/KhJxFnV6A9S2BAFotu7PMle69x20kgj82AbLjRxuq5uo2Q
         0wkH3Njdv3KS1z3W30TPdxZgb2udbJ3gTpBCdvEsQw0q9NCAcLKP6KQj34/Ag0ougbwJ
         2tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776418900; x=1777023700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrDrIe8FR3tZyBg9NmE79HAi9ciGBsGaf6xAQfWRS8o=;
        b=nKeV0L9+DSOXSTewQVEJYw6G/Xe4OCYwTKoaZmNJeSG4awE6GWTJon0gMAdiHqgFW3
         68014yScXJeQDDHfTBTluzCbZy7Z0AV+glJLZYEZpNFPQXXt0tDvTGocY2eK8IGuKOX/
         B4iormr/xdSNwcG8P5/Tnohu1HUtx/EM9o9O736shMdbrN9VeenP0yUZ/KX7+EqG1tfw
         Jgx5Z33aONTQtY/i0ndGI6zgZDBdOY1HbM0E4jF5VOPm4nq8uOzSuh0BRoFz5dVGZ9pp
         UFJyleJcB52aZzqbbmTOvn4AB6f3XNxSMUOBDjEU1gqE/oDq8suk30p8IVDrliHXxCIz
         ZETA==
X-Forwarded-Encrypted: i=1; AFNElJ+aa6e+X58gRa7RD7MmF+WnItN19rsdxSM1vE6a4UjPTayrxLgyskgoukS20eR7ZP3e2SLI5y/jFLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweTTwTxZBoAc6vWMLgpozORX0fEyyaG6eT3lZsDa4Tnom7oAYs
	eZAezIfhHSqMtWj4YWyeBJsr5S8n5sRprQZj8MKsVMZBTgAATno7/RGtPHVhxrKi/JLvVWlKCKZ
	7xPROC52FTaI9jk2rTYbJySGfyizqikI=
X-Gm-Gg: AeBDieusTXt1ISIPXkqJ2yY5Nvovaf1wTMn1lukBnBv9AjUCsakZQfxDyPTISf+s1DZ
	TX5j6bxkxk8ITJpZ4XdhjV/JwCTodFpsD+0uMv0/9J9o4bCPhF2orp8tQpReu/2YKubtJlpvWE9
	mMPUD1vpY5RF42ritsnbT3vJGRDuSd98xjuUTlkiFOJxiRvxoUcBMZ7i26jIJALshSsHb/q669n
	IcpLVVc/kzrorHiQ+YaDFk1HFz2k0ZHiDDgBaLdbpUPfzjgD/nUiYewlkRGB1+tX+DQg+dSJb2o
	kwXW7cqTgfYes0QPNXOXvOWdrMOqWPLQjga9a0j0XgO16ZiLRJhy6nN9F2i5JGe8sZbOWS5AOPt
	yOx3DvHtHLgTfbGTDXRHz86EEm19pPlXBUtJkzDxKbBc0bDaiTCZ8wylFUilFrGgOu0FjYhOVZz
	pHGcIlfqYahU7Mbftf
X-Received: by 2002:a05:600c:8587:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-488fb7880bdmr19258525e9.28.1776418899584; Fri, 17 Apr 2026
 02:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416065118.1299-1-joshua.crofts1@gmail.com>
 <20260416065118.1299-2-joshua.crofts1@gmail.com> <aeCe9Za3aGPiRFC1@ashevche-desk.local>
In-Reply-To: <aeCe9Za3aGPiRFC1@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 17 Apr 2026 11:41:28 +0200
X-Gm-Features: AQROBzDqnTOn1YvsDC2Rr16HAGzs8AJwRihGFl_bNTLs3HtHHbMW3-SABh6dQ6I
Message-ID: <CALoEA-wTk+32wUv3M_wLX-+4Fi=6BjLh6UsRZYqQM1Wcf+-+5Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: frequency: ad9832: remove kernel.h proxy header
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Apr 2026 at 10:34, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> While I gave a tag, it still seems need an improvement, id est
> there are missing headers:
>
> array_size.h
> dev_printk.h
> kstrtox.h
> mod_devicetable.h
> mutex.h
> types.h
>
> asm/byteorder.h
>
> and unneeded one(s):
> device.h

Adding the headers above is fine, but removing device.h even
if there are things like struct device_attribute in the code? I know
linux/iio/iio.h includes device.h but I thought that we're trying to
eliminate these "includes in includes" unless they're trivial (like
linux/bits.h in linux/bitops.h).

-- 
Kind regards

CJD
