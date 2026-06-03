Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C944CF4A
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487604; cv=pass; b=Ecwaws62y9dObB+teF48L4864xFxsuY418yRCFmgipOtxIwuXNmUKOIDZaBlkM+1Ov1BgUEv0Iz9aIg+dJl/BqCWBIvRUBbVBAnISYY5C6h3OA8KMVVTF3F1WgZO9w1+ROu0cB9lpDPkz8lKPH422xbYEba4cbFzLUoIud79IUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487604; c=relaxed/simple;
	bh=M9WSldGlqfI3X7Jfdo+c5NL1t3FFIqPnOl4CBOxVlsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZkBHH4FP/ClNOp3nD0znNF0Mf777g/0v+w+U2zwy9bKdaNgNggvjfuT8BvTG3t2p+NhIak+LmZKa0icGDYY4kTEVO5FfH2C79JNBA2/Cbpl5odgktNpbZ5Di3F8a5Xtj6Xi+DjowjI4k1b6HFjaw4EcSt2ypLzsAL2P8gD893Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=BERxoov2; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="BERxoov2"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa68d9d4a3so3638424e87.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 04:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780487601; cv=none;
        d=google.com; s=arc-20240605;
        b=EKW7W7bNF61hpKuEnkfdnY2Ye/ne8iC9VyVE7qXVjzYa35kenlgjdIeY62bNoJG1Qb
         EwFZKI1qxWI9RaTyoQkLumx+uvD4RoiFBKG1xKU3pidVwGUomW0hs9I3799tYT/JL1Np
         O00JoM/JPPjCZVAkYn+23OjzoEsHxr8J+sFJF/jVxQkpllsyqvZjcKuZ4E3CYJmoyA0A
         cVjemCnL9IXyK6m8n8Gkf1u+RV+9UZMacxxfKENE30euvaL/L3OeISxCSv6rtmvWqoTW
         DQ9MJH3CszivTn0qYVDhm9y3dbN+2T/73Q8MnYGduE9QdFWvbVWmeU0bs6HV0VlxAaP7
         U9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnrKCiBIkAUeV3/0i8fTDeAwPggbyWcJTYL9ZYQIBTg=;
        fh=6738RXxXvUc9Q0P5dJBp72Tv7bVE24+8xeL32X8DHBg=;
        b=dRI0Xsk5JcoKo65uJSpk9WCOfJdwCCcPuz2Ul9RyrlNtv2LN0l42YPllh3oDLMIS6v
         /0kWvLM80OHm1+rMAp+jP0JZMj7j8haJOllkLVOGPArGFQ1E2s43/lgHVHxWUlYii8ce
         Na3LNxeMxoG0+MXzonutmOaxwwUPvJw6lrNeCDUr4jwK4leO4gPQe6i8OB7bw2JVTYV5
         ILpmKwyWX1rH+Iyp3aLxGr3eUDxwemRXwygLWR+XDD0AtPi3Ltg+X4XCsC2Mhqg15oX2
         qlKiJHtxPLeH6UA1sAJU4qvEBN609FY5lnnxzYff9+w5WIx6JV/gaLe+dyoN1A5e4oCg
         x73Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780487601; x=1781092401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnrKCiBIkAUeV3/0i8fTDeAwPggbyWcJTYL9ZYQIBTg=;
        b=BERxoov2qOfAFq1C9/ZmSzHkuVwBdOgxx+0cmWRzkv8HLlx80EByVJdGOyJc2s7SWr
         PPsDcy1ZNz/pOJbY9Myf3WA1oFjrsVGChzuAH0pY72ovk9n7wG64aWri/2xVzTAOunZI
         cCL8Ep2FkTv0BioawHtgQghN425Bc3gcugRnOvSpyv6LTxLm6bnjEZugNm8j78qXf4Bm
         C5zwHMg6IQ3TIocMAcjaRUqbxWwPvDtfgoDz42CByBSlGvLg2wQQRtfgndBHKt3ACE2P
         eRE+Jx3qmaSKCXwXnBBBHaYJuNdYcQLwHL83qudhJa7GZ8LDfdvS4aj4PFXkZ8eUBet2
         xkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780487601; x=1781092401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GnrKCiBIkAUeV3/0i8fTDeAwPggbyWcJTYL9ZYQIBTg=;
        b=LxbQthRJd7V14ZYeNvE9PwrUsbflJOz6FffwtwGpdRYBGSDZza95doRqf+b0x4Id4j
         6aDiIAeXZjrlPxLlk/cBIKT4AQGpTIEXV9dyaDsgH+5gl+l261Z5zPbqE9CtKMwqyVO7
         Mhnwf1NKPgoKxMtNayi5aGmwHITeBIEiBcDfMHWspR1GfWn33ONY52Cf1O0G1YuunTFv
         aXZ3by9UTWCu0L2mxLumSYDoyOensAEp7thuaCUzNiWloTY9tpZ8Jeuqx0m50tyJtGjt
         bZE6HuWVz6eQ4wRZaVddKFiJt2AcdqwU80dDkKaaKAV873Pq2ADBDb5t/5dj05FdxWLz
         MRZA==
X-Forwarded-Encrypted: i=1; AFNElJ+2GoNRBmJZrmDRZT7lwSafmze5egiS7jnQNcNeeI9NbkyUBy1nIPdWcgRt+oUPl5cwdRjqrjY4UEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVsFIEdVgqqWO9DhPkeBCoGmL8qZL76wYNaswHRXithlT2dB3
	6CvJExg0zGPzqQFbW5VC4B9F3Imp7o3bJZ0jviKzWmVGq2vXNeQllsspe3v9EDiTsnzkl7At5er
	sJSCw3zI7YYcaYkZa34EnHPQIgjQ1BV1oEv5wKu1u5F+HM79xPZPILpB/Nw==
X-Gm-Gg: Acq92OGuUVw2LfmXO+f0Xro6J/ZwB8pMvxMAAAvF6bHaaw3BUgoiKHtqKCjZR95j5db
	b+UBpXNZDhkEc9ibxpXISb6TW0bV7Dn0gdv8zzlRCh9+ECDiokxOqZSHLphHWCYsw03NrEPcObG
	y/0EKXdGcKZIvfF6w1SxJm49uBNCeOa8/yv07Xp+RQqmzk8ENjPScVN1/ATuiq/zhQlIZvXBoxI
	yWNizr4jyqEggC2oEf8vS6Zs8xOEtNhp+XnvEYSKtaQksnuZjJZEaqGOcL8A+DVfq9VyH7iaD+G
	XRqoHFD67zBCyj0i
X-Received: by 2002:a05:6512:1247:b0:5aa:7126:c664 with SMTP id
 2adb3069b0e04-5aa7c07b74bmr999583e87.9.1780487601251; Wed, 03 Jun 2026
 04:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602164539.1541685-1-sam.moelius@trailofbits.com>
 <ah-ADnSU_VhacXqI@ashevche-desk.local> <20260603120127.03f9172c@jic23-huawei>
In-Reply-To: <20260603120127.03f9172c@jic23-huawei>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 3 Jun 2026 07:53:09 -0400
X-Gm-Features: AVHnY4Ir_ms4BPUJXGuNY9szFAUDlRO804-f9K80ano75ZRnnyp1dMp1AsgskdE
Message-ID: <CAE+C+DYE-8nNouH_Ec6vB0Z1tgyxznbbMvoQJ9S0iKqb1oj2Hg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7380: select REGMAP
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Jonathan Santos <Jonathan.Santos@analog.com>, Jorge Marques <jorge.marques@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
	Stefan Popa <stefan.popa@analog.com>, Julien Stephan <jstephan@baylibre.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, Samuel Moelius <samuel.moelius@trailofbits.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 7:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Wed, 3 Jun 2026 04:14:54 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Tue, Jun 02, 2026 at 04:45:39PM +0000, Sam Moelius wrote:
> >
> > > The AD7380 driver uses generic regmap types and APIs. However, its
> > > Kconfig entry does not select REGMAP.
> > >
> > > As a result, AD7380 can be enabled from an allnoconfig-derived config
> > > with SPI_MASTER=3Dy while REGMAP remains unset, causing ad7380.o to f=
ail
> > > to build.
> >
> > Okay,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> I replied late to v1.  Unless I'm missing something makes more sense
> to select REGMAP_SPI

REGMAP_SPI also builds drivers/base/regmap/regmap-spi.o, which AD7380
does not use.

So, to merely fix the ad7380.o build failure, REGMAP seems to be the
right choice.
