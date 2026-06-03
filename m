Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8520402427
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484590; cv=pass; b=N2bEUvn63xtfZOMPcnF7QFuFAYqL9eYFy5bnZCRfv7dpTKebTzPGGdnMvBvunb0iLqULF2pWDxyyQnq4vyU3DV1Y3pzn09xsmRfo1xheyahraSP1GYTPQqTdPBbVENz2Ig3ojbVGiNz8EqQq0wLPmo8mgCyj8DCIKUNhe4CdAtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484590; c=relaxed/simple;
	bh=jHEGkQWmCiRquYv7dcdV7LUzPZN4+dB+tUT+2l122Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRbDDr7bFNEvaPNocjm/OpOZkt5fvpy9/5Eg0v0gTnOh3mgyAYT/XPp0rQi4KtONeyykuzsXpB1vqVjmFkdUEdv8hOuv5VQjDnCpnGI84tbwPbtWqQ8PZGx7BCfci1uUx3PipYINwZ7g7C+N98ysyga3DXUcTnMU59evMk1Thn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY/gxJP9; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY/gxJP9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45fd464d51fso2073831f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 04:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780484587; cv=none;
        d=google.com; s=arc-20240605;
        b=WdQbYITfqteQ4Kna29vdvruIkdlbXk1AGjK2VW4ApMbWz8EUCZSxvEHu+kSfqStd5E
         GnPni8HsrE2MpJzmV4ik4y+msCLVP+2LPgNTMK4WpNA3tAYXUjJTEJVfFZrjpXwXAKiU
         Fss+zawMzTvRJHWXKrm2Iih5x1cYaXsi9HCMKzuxQXgMUU+bo7MvluKwyPIS+PMmpuU+
         iCyVMUPEGvu+PzMpvTOxhfU2Ut5hMRV4JoxTo9O0xhnyVwYeecprp4aNvwPuSylN8wEO
         999/kfyRce5n0EmWxxPTRanAhXWyb+8kYaWE+WaleSCyZ7p+J1nriVQOBRaSVDyf6T4k
         LrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=19ZOqLcRfEJQli2TJQ57Z80anY5/azGxsdyaKOdIypg=;
        fh=1EWhvr24PQ8dICM+nYhK8yPLWWd4atuUOz0iXjWW1J8=;
        b=afjjwVOUEj1uc0uDh+BCho6dHQ8s+IVcr2nV00KOHvFoUux9+4XKV2pBoHPfUZAyvu
         R/ucoZX20iasPcaNSbJtq9Y0+txiMGFZGmUd4cP84kg9JHUo9G+EAXgsFFxzLNsGEN4C
         ImxSO0XWYa+uAhelspD6fL/I6IiRsQ4NQkJG/pNckefeWVtnHJmkjiJF9UrOIK0AE8LI
         zHtNNIR99895d6OSn22cT4v59ozsAnA4gg5bOtXgQYJ7aIbYeaMza94bQzkcK9HGDPpy
         U4/hoQoqzkw3GcStBODdcObx2TNE6oOyu81ysTcYHJhDHp1ca2j6B1OQ6RVRUKKPQvkV
         WItw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780484587; x=1781089387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19ZOqLcRfEJQli2TJQ57Z80anY5/azGxsdyaKOdIypg=;
        b=nY/gxJP9e1y0FKjZrO5EqSbnO4O8hk9sQ0hTUGdTlzHuJtkOdx1M9hOh9T3xtNCCZ1
         MreNqdPOI9sL4RHsWTOlS5hh7qJ0g7c5fQdqa5JBGCZ5TR1Y72rlsPZFqRI/yeGWpNX9
         iZdDnpDuErE1uV6dunqz8BKbHbT97LGP0PNt9yyQUIeQqmt8tf6H1a9T9Lceb4S3CXaq
         IJGdbAb/zGnSKy8vsX/T/EFMstKy0p+oZ9vfxqbpkb3eqnF0ofyWvn7ecM61xnNZqSu3
         x1MvRCweOcabb9C1fOvXCGPulA3B6nfWW+dZ0pCa7Ye5MWD8E/jcQrgyrVVy7yN9fyR5
         fh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780484587; x=1781089387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19ZOqLcRfEJQli2TJQ57Z80anY5/azGxsdyaKOdIypg=;
        b=dBhfoycEaRHBEPQn5NFrdP25jJJdbrheUJ7718kKtWmpweR28c4FmOjlCQNr0oEbze
         vS8rxr261tZ96zeR28VdqeWfQ9oqXiWj1haFF4Iu/QKNQbrjYZ6ASkeGiZSmQ5IESYK9
         xa3u0cgjCSGzr7PQVJHoSrs/doMcfeT1XigzQMB+tQXFM5tjcT8I1ydIxm7NLJ92LOuq
         IHwbCE59EYkcWPRyLiKv7FdLZUQWk/Pb8Z70uK+gNOJGds9md/C3YC12Em40gMdILRM/
         N86fasahWLHFSwL8cSZJBPyZVWLoiFaJgvs3kpsyoEFnp6rb6RApfcHOP3Ev5mCYgvlI
         ZlqA==
X-Forwarded-Encrypted: i=1; AFNElJ9t47JD0O115JcxSBRYt7OdVJtUWQpM7woI6upJFeBCRcEsMGkY8kQZb8xbePICQ+Oh2rREYBeMYSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkWv4ImlG/Qwy9l5MA6S72kRRTyQdihdY9JeWVF92Xv04iHWS
	5ap+zHkQS11VkLOMeqvy4GVD9SV8+nUlpfsC7nL3OR6ilpw0Wkfc7i/v2bgu4ZAlQmQ9WHYl0Pn
	BTYe/QHyfFcsX0lvIMjN/NGHFQ53imB0=
X-Gm-Gg: Acq92OHmn3hWBCXewvjLEWKT+dXzCeOm1EkDHGDun0uPaj0t75YN7/uJ1VxWq93gS33
	DzovO1IE2qs1r8FepuLgUTpq7eGZGAOhETzzd/nZAZfMB9wBRzhAhSadq48Nfq0Ns8AxMkeYopb
	YzYmOvatBZ87FnXV2CujyLk1Tc0r7iRloQi7VIdcahAqARWzhE+zjpX4SdKo09C14Gl/TSkzl+G
	jL8w4jwKZZkziZcIfbdMkIgvmknMAXwiQhGddyP/6Ue6St+m1TlrYBDJ/5dGQfWcZHt5ccHX9xn
	rR9mdzLBT3vmUZqMoKP53BRkLKsxwGjMc6/1Z5WBoORRUO100bLRv8SCthWd4WSCWLgfZOYHowo
	JTN6FrusB2m6GHJg3eIV6schGsRvyZZWuZ6fvWK9ZN96UqB02tmEWDyB/asvvFhSp4dIJjzK5Dn
	/py8nREL68cHvu7d6g
X-Received: by 2002:a05:600c:1d09:b0:490:9d5b:d721 with SMTP id
 5b1f17b1804b1-490b5ed62admr47852065e9.16.1780484587272; Wed, 03 Jun 2026
 04:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com> <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com> <ah66ljSiIc0ywFC2@ashevche-desk.local>
 <CALoEA-wdakU-Ei2FE3WpGR+CYRDN1bjv2sZ=XJ01ZeH3NP8xeA@mail.gmail.com>
 <DIYJ5ZACTWVS.13T8L275VHTKM@gmail.com> <CALoEA-w3TqD=2YP36=ScmRttmmG3BBCKvtfSqeJL0PVxRxEbuQ@mail.gmail.com>
 <DIYK6APQQX6S.2KLGTD0G5GCDA@gmail.com> <CALoEA-wXRhiTr1gA8GdLAmt2PO29N9S9FrX4ueab7P7FJ+HOPw@mail.gmail.com>
 <DIYKFNVUW1RR.1KP94ER0FKNES@gmail.com>
In-Reply-To: <DIYKFNVUW1RR.1KP94ER0FKNES@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 3 Jun 2026 13:02:55 +0200
X-Gm-Features: AVHnY4IcRQxRd24RJd5myssr89Xu543nyDRJPW1Xny6CHV5wBOKECYlvGFFZPyk
Message-ID: <CALoEA-ww3xT+YkyvDM7runoOP0xc3cijBgiGau2=hYqm7wSE8w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS series
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 14:34, Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
> I used the compile_commands.json generated by
> scripts/clang-tools/gen_compile_commands.py, which I always use to have
> a better experience with clangd and Neovim.
>
> Should it make any difference?

Hmm, I'm just wondering if `-p .` and `-p compile_commands.json` are different,
otherwise I've no clue why your output is so verbose. AI is actually
pretty smart
when it comes to working with IWYU and the mapping files, if you're up for a
little challenge.

-- 
Kind regards

CJD
