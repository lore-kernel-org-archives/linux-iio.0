Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518C3CAA48
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390901; cv=pass; b=BYpng1m5MJGCLE26QdEWxu0Kj/Vzo26Ax/wTFRXQGANZI1K4bEkegrPSuxoSyRJmb8oKYhd0dbPHPrvgbivA8VBRYL7KTaSZt9yv3bf5nwsG9QK6ClD7cBWcwCa1Jk8KoNPt6e49+VZKGpcNzXOEztVC2HZS+wfn2qitPdX65Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390901; c=relaxed/simple;
	bh=PvNjpviXkYA1FFty4/Q+gBmLQqlfuee4Buo9o4I7PyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieBwC9li1U4bbVq/A9D0GUiVXtG5F4Fr63FUORb9hhJfdmf+dut5ZGrl7JCHzlxODyQGlfSZL2m/kEGEmT+DD7DYGY7UQ7dEh32VxYDRSFCjFFViehfCWJ+G3JechEmuiBgNxN36pYVOuEHAg1Ocnxn/qPehFEfrSpSZe8YYNF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFnuPcnm; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFnuPcnm"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3372190f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 02:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780390898; cv=none;
        d=google.com; s=arc-20240605;
        b=DVQKSmf/XkUG5Rl+koNn52o8MPqPc6O8dftBFhQ9zafj5hMkpMyr/lcC32xJzRMnk3
         6MLVFPPKP/baZ2PK5LjT0pHyYu2Fr6/jRoaEhQHk/0qCKOE/hIcVhS/4vY7tgqrfJ0xS
         6w6PA0GEpoj9NdbxKJ4EyulexfLkXf6gswxmNNeImOPsoQ+SFRfKcya4bfDjDrMAvT4b
         ZqdgsBLEyEV0Zi1OdPJm7na6d7rNr7MeX58TCcqceXw4TocX1mLt4JUvJvgc2eUbhIQX
         U+NMpmQWqjZnFL1eRzdcSUXFdMFy0YjrI3FRO08u2zNygF3iNDj1Ow9ad59INqVE+0ON
         dsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Se+sI4jTWk/8fRhjpAWSPoCaSg1vtTI33/fQUujTbYg=;
        fh=1WuVZwOwPYudttv/4zh41YTdWjoHGIfhzpbvKb4IYRo=;
        b=Awy8bv6akgXVQYYhGFeMzoKpHya0QfyKIHAM907PfAxvgk/+UCijWR4RNLBoyvjLdr
         KbgCBVZcCb4f2YOcxIoGXDJFGs0gVaepB15KRmIphg32Y8eO4X9v2dwH90jzjwpoksGS
         lJ+9OTBGQSUoNm7SpZYL42iLUMDKPTKnRsreUCKO81TtwdUPfOeiNNbe29gAYOCU2IQU
         mdn6lA4knpYOMdWBXBcbw9GYeMfnLMCa1UISYwCrxDQD9U3qyfFzAc2yi+zKlHhhbFfQ
         7MdvHMW+elMojx/823wMpMLNW2yE7+E3x2i3r+YyC7Z1/A0rPYMgyQOvt7pOkC72uLzQ
         RG7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780390898; x=1780995698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Se+sI4jTWk/8fRhjpAWSPoCaSg1vtTI33/fQUujTbYg=;
        b=WFnuPcnm9hcL4Ocy2rTiMkaZA17Pz9UrEe5FKPhP38HraD0Rl+gZ3cdmEtjhBsBjqB
         rLzU9VmZ89MpMGYWQraVDlzJWr6IhqSMS0YDFCzuRevOJAHAlIWrcK+t+FiF1Cw63jMU
         4co5BD71vmu6b7Wyvs51gIUDpqsZemeXG9SZ+L13N9PnNtgBSj09Hc6JY/i2rerCrC6s
         iD2gVkpjriOaSfoWoM6xBhP3SzHdfz4lXu4ApwlXYI8EVOl3mkLkiLhHGfTxEWhJdjPe
         ulMYh1U8UPsjwm0+av7NKKlYJQknbvAImYghtUNp5jtuy6HqQXrcFb7ciWBw3RmqMBfV
         GtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780390898; x=1780995698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se+sI4jTWk/8fRhjpAWSPoCaSg1vtTI33/fQUujTbYg=;
        b=qQNTX3sl/n57Wd1Z8aq60lhv6GEXFLQGP/uf7U8daCl8iY5HyJ8Fn+0I8y0ts++s1O
         c94Jonm66RTiT5iSk0F+PDNxN0yHRNLnWw6F4idsOmQ3kYOVDUDNBfBtqFC7h5Bk/OT8
         h6xLZjWdSQhUp0kvCUWzX1rggK1A5XwMIhzNnkdAuiPTSj25IiUWM+uOdHDpTsnL5TLW
         EBV83fDBt14WAw75sFnmyBv0FVbqXotu618Cg+fX33ncxgkLwK1YfXSRkT99UaKa2/Fr
         ESdC07TrSqwmtkLvEtA3lmaoVb8LHCe8ubKGUPX11P8SlP79hVppoinre2hJVhviLmhW
         pVvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wA0OEviZ1UYujaSJHTsp9uYsa4ago1tZBJI1Tj8mQscEgoKNE4lgZr9sJlV78fdGYc+FHM+ws9Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6ML+xn21o3SVfKwQzl3QYitt9xLsW7v42nu/sCl6Fj3antHD
	LLa2SinVc0lnR59lJXMZ72x7xaFYAXf+g+/7/lw/LPr8YEaLAv2lML5NWIw41GaC0HyG2IXhUSY
	nSLkiWVLnyUgHA/JatrIP3B9kRNvm0cQ=
X-Gm-Gg: Acq92OFFCGuUqM+rzIFeEKO/fF4A9WQmhryQ7NFeE7JtG8AOnkqRSgLVp4Ir4iwch3y
	oZi4B7xZMJUefEPTrasDrWTpCeFghQ5N4wNV/93Ga57Tt1CXqdDHyYaOt/DGEu94ApRLvFv47A0
	KIhKeT1MtPdXpfLzz6oO75P4Mtj7uKoUaCZQXALMxbBqDjaYdp/2rcDEWNkFEXasn46R/9fxbWI
	I+t+D+fAZREohJoereId77D3+oui2RS2leYHUfZZZzW5GoSwIpmAATidtN8lBSLs1XS9g2QPgwn
	HwQ765HrQNlgjJLaU4hKKKkgRcE9Vl8lNmZX8jPKMBL10NMsLiDRl1W7fiOigQYlK23s0/GlqPN
	jT20X+hzCfp/PC512MPezIN/CG3OZjnZ7MDS4vMv+7ygZBu+A1jlFelDmXbUnXp4sq1Ijqk1nLa
	s+yY3yR3ORja32Zs7a
X-Received: by 2002:adf:fd03:0:b0:45d:77f4:1ac2 with SMTP id
 ffacd0b85a97d-45ef6a8bd4cmr20581242f8f.0.1780390897893; Tue, 02 Jun 2026
 02:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602084019.2564-1-antoniu.miclaus@analog.com>
In-Reply-To: <20260602084019.2564-1-antoniu.miclaus@analog.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 2 Jun 2026 11:01:24 +0200
X-Gm-Features: AVHnY4LEejZJQkbGjf2HcEZhN98-KJfi47wz2Xs-z4zqbV0SnFT8AhdH1ugR8aE
Message-ID: <CALoEA-yz-kJGHXDC=Fwmi1C9P_EpEcimxt=9a94vv6eAHQ-TXg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad4080: fix AD4880 chip ID
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, linux@analog.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 10:52, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>
> The AD4880 chip ID was incorrectly set to 0x0750. According to the
> datasheet, the product ID registers read 0x00 (PRODUCT_ID_H) and 0x59
> (PRODUCT_ID_L), giving a combined chip ID of 0x0059. Fix the value to
> match the actual hardware.
>
> Fixes: 35fc53e802bf ("iio: adc: ad4080: add support for AD4880 dual-channel ADC")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Sashiko failed to apply your patch, are you developing against
an old tree?

Codewise LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
