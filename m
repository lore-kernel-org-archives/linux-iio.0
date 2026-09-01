Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EE37D101
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239363; cv=pass; b=aKMJkeFuGCjgbf2z3Yfny83U1St573e6Ng6Xfv/CYIsJuwYvIrtMrCWnPWAxLm2Cfiml7+Ajr9nRPoNun70fJk9+/pqDAfXg6r5LUSQfppB61bct5l9d/7YLkKCWad9Lx9cqewROgazcWFAn9r5yUUWiSY9xsW6bipZ6U5QgElY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239363; c=relaxed/simple;
	bh=7s9K1HoX9x+dEafgUdPowqAMD1KTmRH3WBaXqNwCyo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR1pNOZCFlYqpSqq40z+AzzaeR/rySTR6s/QasBgJZwlq0b/8tnb7OV/Uy1rsmGyopDT9W8few4RCC0vTunjIthlif7bSFXkLD98nonnDyssNS7YjoR9t/kwrVFztebLuzektJkIPlhxXYH7OYaw9XVF4Ju5hCJ0d7trcDfcbY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJdt2UKi; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJdt2UKi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482e257a23aso2472127f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 22:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788239359; cv=none;
        d=google.com; s=arc-20260327;
        b=hoJJmLi6v6x8wmADwR3BY7nHQ1qskwSPh+qW2YZs0LR8/qjCNxKyxdihwvk5wk0w76
         gT2xOcaVfrA0v55YCP+oY8qCMy5SkI/2lcTgPakvHl0SxnZ3ogtAdDKc+I9tdONpgU08
         VSSdc1PHDhOxJxGww72jNs4OSdMfLmsDWCXEBPG6ZOcFYI7kx477kXhdNJUGpguGg6qy
         vWJhxeeRnw3T3XtrEgAT1xCkbxdrQQ2Hf01p9JA2Sx1IZmB4yQ9lBP+D+Zgh8ecobI9U
         8i51ZzTnI3h56J+MBAyAi6hP9XqnHOrrMW2itxoWKLD8jIrAta3CMo9F5z3Ejv9SzOKc
         VLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C2PUTgHcsLskwFoSohUTw+25rm8zLsVr2BA3a9dwt9o=;
        fh=2L017JiJL7tB0U98xU8GT4+pJLDwKP7gVvV9ibZ+xS0=;
        b=e2UmX3N2qfBqfXHF69tKnXwJg/Hc9FVMEiwRBzBcALk0nbZVt5ql8PWAwVcn9kMssY
         GxWtCv4f0cSWozltQUEDm1zmhevsWc8LIzXYfwbkmLwodTFlhV4gag0B0Jhr8U4OlIUy
         RgJC6JnLttAbV7HDtEh1OkhYHL/GD2C8BNT5tL4/4klSUiQkHs4eUoZfWXxqAhXcGiPq
         FXhS85Cva4kqJua1arbOXtfLU9b3LPhvjnbkXu7CkfXfljqYgEuZqvNoscyPfS925ADZ
         hCTRYMBjlhkYvgXURZM7qjjyO6GtlDssMb+OSIPeV9cJENfHjueFY6EkP4gqF34GEx7f
         Y3/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788239359; x=1788844159; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C2PUTgHcsLskwFoSohUTw+25rm8zLsVr2BA3a9dwt9o=;
        b=kJdt2UKitBIJ/tlllxl1enM91Rrs6CyuiA8g5MQciu4xZlKdPq46ynuk4aIeLG1+OQ
         3RUFVFDuD/2RoLW6vixo0p6SEf1eSfCDyVVY0UbFqZ7pcq8YJQwv4LBP2xohPRq9dw9D
         6FAzXm7QiwPDtX0J6CuPtYMSfsWW1LIq/twOIM0NCMOm4ZKeDZrz9os6fSSs72KzKodw
         zbHxCUm+h3rWfICC3tKMyemiIKPwFYwzZ+b55DzvJp+glKAdp5ebBTlejZyxbXs/TXeA
         sQBPdWiTsZ+MrPQK7HGI66i4FCAkD/mbxdDVH8VJr1jDMTxn/MDQcEFTZIkOD8LPTOkG
         1DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788239359; x=1788844159;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C2PUTgHcsLskwFoSohUTw+25rm8zLsVr2BA3a9dwt9o=;
        b=SVc+0A6l8Ry/8YO2hE3UPmDyuZIGE5P+U1K/esK5K36NsS/hKZ1frA5KZP1G8iea++
         UsPXpJVO8JN/lgIqIkRETkfZFVTGH9FH8W5NBUN3Dcvqz7CpNIRplx7MmSMDp04lyEsI
         5fqfr7Tf6/cglI6ZicDUCWAHeiuNm4Ge+TwrJKrpnbT3h6ZY6S3GThQyhWsfGyRsX3+O
         k1LIdBtoN6QOgDI8KtwGPac7TpkPbX7m+nuJNd3HJlwWMpXn1/WM4Rxu+E8ArZytmZ5B
         PXNteypuKMiN1Fp8+B5/x6MQNMP1fmKrAWnsEzpTIVQkQqI64kTWxdP3zFhBpK4bS5Iv
         EYhA==
X-Gm-Message-State: AFuF++mGDDuCEY7WVSot5+87K2EqbE4dm60TJwyVFtVWDk4GgwbQ8MBn
	9qGFmLz77kEE8zDX4CnJ4XUKqYisETA1zjayJdahoDggKDRPlag2MZaeAI1m7949qoTGPf3oWO3
	M2Kk2QSK8pHzRzPkjjr9zxNmDkTsqgxU=
X-Gm-Gg: AYBFou0Xu5ds91uOYPx0ylzHMQK5DYAI5/RReTSHzF1NtzZwesulLTiwyUpCV3aPI1n
	Sh5v6CXp0g10nu1ddE32OC0as5a1dxaMnOAYmlL3F18hvNoBVnuJbGMYABuijG5X1yWlpbMIT7j
	DpKyZgdbdVd67uffQLuiVxj2yP8pkyAQ0IDVCta7urD1U0Q2LZqGqZsrn4Q1kUaUda6YxSactZr
	C2ganXToF7KPEucs3ctXJm8FpY41Lnl1VeYBNgw7Q/Ew4UqeRye5rsGQ7lxAGBjfvV7AN4jVZhh
	xscD0D49E4oAlHQ73F8QljnEwqdsKo2+hQ/7fEE9mH7D28OdeLisZsopNe1wDzLaJbeHTuk1B+L
	PYwMz4zR1dHH4BETDot4gX7cvvyXfMzm8z7SlxP2geiPVK5SBl+BC3SUKtUQ5HR/QphckWJ30LQ
	g/3WQJNe8EcSgMgViRxFgYffpWoVdjAL0mo9w7/POXclBs1qfh2oMD8sJr7yebAmVC8pYEu8o0t
	ap0rFfYAdZqRv9q1h9Te9J2nqOeFA8t9Cxy8o+7MqBBEiTd
X-Received: by 2002:a05:6000:4b03:b0:484:3311:4bfd with SMTP id
 ffacd0b85a97d-48433114d72mr35032962f8f.26.1788239359463; Mon, 31 Aug 2026
 22:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
In-Reply-To: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 1 Sep 2026 07:09:07 +0200
X-Gm-Features: AcwNN1W6wa__J-okjdxCBU1tskK66mBKa1zmpVquZePN-PuSotqSooLrbKb2NAY
Message-ID: <CALoEA-wDkFkKVLCkQOvntnw-cD76Gz=MVW6qNJL21Obn+s-wEQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] iio: temperature: make headers conform to IWYU
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 23:13, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> This series removes any instances of kernel.h in the temperature/
> subdirectory and cleans up the headers in order to improve readability
> and enforce IYWU instead of relying on transitive dependencies during
> the build process.
>
> I had Gemini generate a summary (a bit more verbose) of changed headers
> under the --- in each IWYU patch to improve the review process.
>
> This is part of an ongoing effort to remove kernel.h entirely from IIO.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> Changes in v2:
> - Add missing headers pointed out by Sashiko.
> - Swap <asm/div64.h> for <linux/math64.h> (Jonathan, Andy).
> - Squash small reordering patches with iwyu changes.
> - Link to v1: https://lore.kernel.org/r/20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com
>
> ---
> Joshua Crofts (11):
>       iio: temperature: iqs620at-temp: make headers conform to IWYU
>       iio: temperature: ltc2983: reorder headers
>       iio: temperature: ltc2983: make headers conform to IWYU
>       iio: temperature: mlx90632: make headers conform to IWYU
>       iio: temperature: mlx90635: make headers conform to IWYU
>       iio: temperature: tmp117: sort headers alphabetically
>       iio: temperature: tmp117: make headers conform to IWYU
>       iio: temperature: tsys01: reorder headers
>       iio: temperature: tsys01: make headers conform to IWYU
>       iio: temperature: tsys02d: reorder headers
>       iio: temperature: tsys02d: make headers conform to IWYU
>
>  drivers/iio/temperature/iqs620at-temp.c |  9 +++++++--
>  drivers/iio/temperature/ltc2983.c       | 19 +++++++++++++++----
>  drivers/iio/temperature/mlx90632.c      | 10 +++++++---
>  drivers/iio/temperature/mlx90635.c      | 11 +++++++----
>  drivers/iio/temperature/tmp117.c        |  9 +++++----
>  drivers/iio/temperature/tsys01.c        | 17 +++++++++++------
>  drivers/iio/temperature/tsys02d.c       | 12 +++++++++---
>  7 files changed, 61 insertions(+), 26 deletions(-)
> ---

I seem to be having b4 issues as this sent v2 again with the same
mistakes?

-- 
Kind regards

CJD
