Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA34A33FD
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045296; cv=pass; b=lzA5vFqGPTmRPqBzzOje2YwpiA0YR8hOMK3rhKbx/USJbZJAgaBdtrAL0nkV+bkb3kkzehbQhZ7SUWFekksT7JD6NXvwzJgoupy8DrO8Hq52NkGasjdXcF6dx+zkXEzxvf6fh0zhFM0Ww78nWg6hj8EgXCBfU4h5DAj6zgEy9JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045296; c=relaxed/simple;
	bh=ZbFdtg5sjBl+H2D0nTxkcOm/iY35+wEQQikqVUFjc8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYeV31N0tsydR1uU2GxRiWKBBvKG0CIzPkgTCbfBZsJ5SW7riLKt4koFKcisX1wr91M7IrcaVsCSQIkht1EsT150nRSBIQdv3sdWUxIsDX3+wnu3Dtys1tQPpFXR5vNqBSkFyKhGLzUkvm9nXZS+ln1uvY18xG2xhsVCjBOGrO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDLATQ6w; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDLATQ6w"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c94d4fdb9so18140451fa.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 09:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784045293; cv=none;
        d=google.com; s=arc-20260327;
        b=pY8vhDNx7Ln6oc7fY4ziiFda0Rg918CGEf+JIqV0M057upy0wwkcl0tdIlqZcBgscI
         LRAsdLsD0eroEQArQmsvJiPnrpxssdXPKgcY1gHH/7DcClc1cJGviS3oD9WJdNHVWGvq
         6O17v6o8v9mreUb46OFAL0SjiHSNcPj4k/Lq0qPVmDxIF9f8bLOwmbnYvDTr1lr80K3i
         JCb/CBO/nbDHSI7cbarxrnm1JPGj34KAiOAgbZcDoC1GTO7vkJ6z1eca/cwtUKQvmrKw
         puOWxzoorvQpnSqcoAOh3duccHyTSLH6z80mI/7pZmfrO24f1faEB+2rzM6zgeR/doeZ
         MTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZbFdtg5sjBl+H2D0nTxkcOm/iY35+wEQQikqVUFjc8c=;
        fh=T0XlqNh0yEju8XCi4guVUpETBzWTA+S0XsOC6MlcHMw=;
        b=RgXsBLDzWqTL9HW8XFXKiBB1Hezlzao2oeBExIigOEV4BHcUP0kK1PDaC+swRZw/G3
         vNUz/gS2SpbeoxH8JLW9O4Z1dhte1OSP8B87ahuXaHQICc0dxS4sXltgb2AH4r5oQBOS
         zfs0TJUstWaeeELD6aWsQFHGy6C+l6to0X7kp8qEmYKbAZyv+97pBnvdr8BZeeAvrK9s
         LRNjoaLFLj05pyeu+oKqq043h8Z+5kyuDAS0z3hLlL2E9q6Fqo56bjg2dcdgHzKuqnXB
         ErbMcbzblo4XdAF0Wj0/qxO/GU8AADcoEhSGNq/dFVfPXf6gZBF3qaospZ7FPJqV5qkV
         VAuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784045293; x=1784650093; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbFdtg5sjBl+H2D0nTxkcOm/iY35+wEQQikqVUFjc8c=;
        b=mDLATQ6w0u58SlPK85ojsN+O1HgYo8r+l7kAnXA451dg0g7KHC5uiPD1NSJnWTZulH
         Mzm7+1EUxstOb4vddW5yDNz/D/hJ4MkQno2z3hQZyTwuI2/g2If6gEGXsX4cgVgBdoPy
         t3qSxDbLmkR+Qp9wK/Tq23QeMXR4/SB2Urcdz0lp1NM9pd94N1Y1n+w+7xdopVjo64Ku
         /fHbxLP3xlUUhrQuJay9mtrJQo2vnN2X8x8U/DBaT+Lb2MrARs5WXZBad3P1cTsZMBHi
         c1ot4fdt1DO/Yl2zh0k7LIRJrOzREr3qd/vdJCagltz/lC+bSSI9ROgyPQNaDaY+F/Bt
         xt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784045293; x=1784650093;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZbFdtg5sjBl+H2D0nTxkcOm/iY35+wEQQikqVUFjc8c=;
        b=hgWEDBSGxmkKKOzkuk5KPm6c7grONi6KH3GjbhPzJOMbQj0dUFwYp5xAnt4VVvS9R6
         IJGq/ltnzXOxiyUE4hDmW7eWD8YVX8Ul+P8wTX3OAD6jjAuDRPZeq/ph9VB4a3ya4Vq1
         P6RSM6tpcmM5jKTuqnpQ+XQ33aLS9Gt2kkYXpUDCTvtsgBHbyH9bE8WcTC9f9Pn0Arnu
         O2zh94EIqT2CHdWLQ9jzya+sjdJsaRDazzGQfuNEqvN7CvGFV07+PJxIRyzgoT24gAVZ
         XnWInZKknrzQjG5LjvCioY0Anos4IjS0F1Ll5ZqqglAqMurbO0nxRYqQC43DEkaJ4THE
         3/lA==
X-Forwarded-Encrypted: i=1; AHgh+Rot2HzHB45Mxn0rmLi0VX989D4674M9fadwgXQ5LSjPb2Ip8Mqh2eVjg7HroEtLLmrkpbe2kx7Mtkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKDgE/PhQKvHh7cD6BbYG4+V8/pxA+ndgcL9tnAXTyjxwPSYwa
	sAYIG7plfsJY6hlUkAhGPVE5wT/Ymo4CMfngbIEd9s10nDCYAkjKRYp8kcwAaojlk6Qvn+/KZVo
	Q95exc6zV5QhwOgx3+HxYPY7YM+YMhrk=
X-Gm-Gg: AfdE7cn63/Y9WwuHQiWRdkskIEl1xdsgw2os29cVZ+PDVgR/e5c16bdrmWNmCp2wuZt
	CuhFBHgOK6Z2t2iwkcjqt3Z/bjK7kZt7c4E5ldSeX+hxZ+NEvb8t20+nTaPccexhf5O7SU50U1m
	ERfIGxeAF2GTOlmTi0lLGtX82chCj0l8ZAddNrOZlOWSE+uaquc7ufo4pua9F2ax8OuZ6ckesIR
	F69d06pJKrRYOCaePfpxiiHFVhnBtgV2IJC0PdLX0hYutMVOVg/W4H5rNfzdLMzj9DL9w7bdX0A
	7iMFm48bMED3nyPAmosH36GdqY3Abbs=
X-Received: by 2002:a2e:bc88:0:b0:38e:8357:c5ae with SMTP id
 38308e7fff4ca-39caa138bedmr31683491fa.9.1784045292310; Tue, 14 Jul 2026
 09:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com> <178376430529.16552.7043868463863908196@linux.dev>
In-Reply-To: <178376430529.16552.7043868463863908196@linux.dev>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 14 Jul 2026 23:08:00 +0700
X-Gm-Features: AUfX_mxjHjnxb21MnCrWbzQJiYZvtYk867vc7GSuACQWoJdxFFCJgHfV8pHaNcc
Message-ID: <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Igor Korotin <igor.korotin@linux.dev>, dakr@kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 17:05, Igor Korotin <igor.korotin@linux.dev> wrote:

> This driver only calls try_read8()/try_read16(), so AS5600 itself isn't
> affected in practice. But the abstraction being introduced here would be
> unsound the moment any write-capable consumer reaches for it -- and I
> don't think patching try_write8/try_update one at a time is the right
> fix, since it just leaves the same trap for whichever method nobody's
> gotten around to overriding yet.
>
> Danilo -- since using Io for I2C was originally your suggestion, I'd like
> your read on this before we go further: IoCapable::io_read/io_write are
> infallible by signature, which holds for MMIO/PCI-config (bounds-checked
> implies success) but doesn't hold for a bus transaction -- I2C can
> genuinely fail per-transfer regardless of address validity. Given that,
> is Io/IoCapable the right abstraction for I2cClient to implement at all,
> or does I2C need its own fallible-native interface rather than overriding
> pieces of this one?


Agreed. I will rework on top of Danilo's FallibleIoCapable approach
in v5. I checked rust-next and neither FallibleIoCapable nor
io_projection v6 has landed yet.

Danilo, should I wait for io_projection to land first before rebasing,
or should I carry FallibleIoCapable as a preparatory patch in my series?

Thanks for the detailed review.

Coirul
