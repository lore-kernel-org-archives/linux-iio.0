Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03913314D2
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737991; cv=none; b=D/XhPJ7cb0/JHoh43HpVEVlpHl6ztjoQKQ9SWhJ4Gfn4TiPlFOlgZhhJNDqSEJTAkobvfOlHS2vPITKnHvGNHrJKRBbK7lv4dClFTzTEmr37PaphO4ZRJ7Skt3d7AqitfZws7/k2eZekqjfrR8IkMMlfU+ViZs3OVk7wEns7LYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737991; c=relaxed/simple;
	bh=zzX+bR/bpZKQ81jw3RUBBGETlg6PdarFM/AeCbAvceU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mr1EZj/acNHHDFEjJNpw8ZOxbu5HMc5mTYZtudM01U1T2raM5nawohWZRQ5NAr45hKvtMiJguTO3WZD+Z2TBeBmZlL4pP5A0AuJhatr+JWTfQcSVzJEKKk0324IloK7AtAgI9gdmr6BMzrCkM69/xfOneAZVKZ4sijSulfbhK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfqcPhWa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfqcPhWa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so9605795e9.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 09:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791737988; x=1792342788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5RXedlLBJ3gV51QO7vHiNXtLHjWPUcDaWUWiW5a/LE=;
        b=kfqcPhWa1Ssq8wZOpxpsY/ZeLK4Ylyi6TCz2lWj6ZhUw8kSdANLNIUhz+cpmNe/9OJ
         CdE0+QUP1ekkl6xJ629PtbMpsOCEJJ87cX1PqEqLmYrVCUkiGM0JzSj7XI4t3d+IJlqW
         VTV7tfG/Lxppkw67g09VRmgPxiPQ3aCK/87TY9uNjrjGcy8c4HSgsc3YO4lCtronnPn3
         sOu/ky8V7uPFgPHpf61zndcJsAWS7idodJjghkqngKiA2igtUUcSQE2Fgt6+SNGF44HY
         wCjgvYUHlvgZSraRHq/DuoGKETOxASwCBcnRuzntsu4cUh9jZxGQlSiMBBQre1R15i1D
         /Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791737988; x=1792342788;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5RXedlLBJ3gV51QO7vHiNXtLHjWPUcDaWUWiW5a/LE=;
        b=1n3MyaG83MO1cXiXc7S27B+fdRSY89aH2wPxuLFanHg3/AL/IOv8yoOiIL7lBwjqoA
         Tg4m3G8Q8J2UWSsZS1XXS4PyBO5OhTUuDz++d7EjbKMJwybiKt8NDphlP4hHd6wFnmlP
         OCR+I3Zelr6jBp3lioDeaCU3vT/MwCP0NYZ8SQM+6m2A+mCscGba0J3a4eY+ILtmMXFu
         JMG0b9B1lLKQYzK/XdvWbBWKm+5v7yCF/ZM5CuoKWNQj7VGHiKiYDHTQpePWZqJZy1oA
         fgIX/qnFKy0XJ0NrUb/gGp1x8HXC0b3Mao71ZZS8VMbPuMGn+kB8AzsVaAEgD3D9wcSq
         YCYA==
X-Forwarded-Encrypted: i=1; AKwUvBxczjRPv8QIcvd2f/F/47rXFyeDpE+aZM965Ye31dGa5srSRsJxWo7npQbE/FBR5budDlII+Zli5BQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOiFKdJ2oYNv9HLDvx2GOkHKpJyiIJJSsFV3MykGjOTNKTzh2o
	aoMfsFGa0d0qsm6MVT1HOXSRwhy+A1eyAkvSkRRQO2ahsIL9QcqNwtui
X-Gm-Gg: AYBFou3jzWqtScN3JEz5JaAvf7XNZBDfy5FQZm7PCdom8yqVtWwYNEayPc4i5B8xLJZ
	P/4LuiAjjrXHicw34BMpLpgqajVCqNUghxQofIvhBMN5NY2HtYlPIUX29FLajgGsOvj1h7MLJAn
	tDOJkAFn7CaumVx1Hk4EnEATvDzk9j03QW10kCm3AY1gfn9x4/uoW/JV8KCj9ubQCglYmqTZuwB
	3n61ZPNuVgWL+TM1VTgub3cghV6OS0yW+zGiGd/9neuNb67u64V0LDZ9Fx5+tuIzODiDioauoWV
	qmb4vfXLxPtuqyAdNE4HaawwYC88djGdRHUbt7PeQf1pwnDLampP1pZGnwpq+7YggLkwvMXcNLL
	b9Mnj3ZzbK6gTJ0XyHYgRhAgqNdwwAMZgaWK49mWXQXTSIEVz/imMQOXhNUQm90yitTix61OjnN
	LYB9m9u+boywtI9olxWXWHrdNTaFSlpGQ+XAkatHgerCX9WVLoFb4TqVTLRKeus4aiWOA8w4wun
	K78Mmehc+jHeJXb8gLsTRLFDVWRfrlR9mHB35aIg1jBVZWegLgxl75JKNg2jZzKDoSfQxxY15CG
	Vs9h0wr8da8ZZ6SiBYMtPw+NIi2r2iIHHjOfs1/UcRMZz4vFMNNbxL7QwTG/mavG0PThyFjC2TR
	mvFWmT7e0OgyFIfo6n02UeMy41DbQ5RY=
X-Received: by 2002:a05:600c:3d96:b0:4a1:76dd:8c57 with SMTP id 5b1f17b1804b1-4a18e4bed95mr121487985e9.24.1791737987931;
        Sun, 11 Oct 2026 09:59:47 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm305431435e9.0.2026.10.11.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:59:47 -0700 (PDT)
Date: Sun, 11 Oct 2026 18:59:45 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: =?UTF-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Lothar
 Rubusch <l.rubusch@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: accel: adxl345: propagate errors when reading
 event configuration
Message-ID: <20261011185945.0673cd1e@systembl0wer>
In-Reply-To: <CAF2O-sO1YuVQWLoNT4mRN2+mzFOG-WdQ5Nt80s1k+7PP8QUtFQ@mail.gmail.com>
References: <CAF2O-sO1YuVQWLoNT4mRN2+mzFOG-WdQ5Nt80s1k+7PP8QUtFQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 11 Oct 2026 02:15:41 -0400
=E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com> wrote:

> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345=
_core.c
> index 6c9080d..5983fc7 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -1176,9 +1176,9 @@ static int adxl345_read_mag_config(struct

This patch is corrupted - I assume the email client you're using added
a hard break here, therefore it fails to apply :(

Additionally, you didn't use a cover letter, so patch 2 appears as a
reply to patch 1, which may break tooling.

Please use git send-email to send patches to prevent these issues.

> adxl345_state *st,
>  {
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
> -		return !!adxl345_is_act_inact_en(st, type_act);
> +		return adxl345_is_act_inact_en(st, type_act);
>  	case IIO_EV_DIR_FALLING:
> -		return !!adxl345_is_act_inact_en(st, type_inact);
> +		return adxl345_is_act_inact_en(st, type_inact);
>  	default:
>  		return -EINVAL;
>  	}
>=20
> base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83



--=20
Kind regards,
Joshua Crofts
