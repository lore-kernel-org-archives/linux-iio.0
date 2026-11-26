Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693986;
	b=4pWofYur2MS1lGisZhCHE3X0K/zWI/yHQfsukJTFZ4Uqg4DoHzb+m5x6KB/vgwlisnsh
	 kLDN9FzRemg058JI01xEfqsb3jAhQ77bxwBiB2ocGcNt5TqybG1vEAxegN0Clhdgz3Zj1
	 T3JgxVZIbIndXacRd2pp0BZUnKRYdWwYoEMYRx1V8lNcwGXJOKzi4wgJFL39+5IsJyckL
	 siYDzOJDdvzYiIUzIgEttL5SXMcWWfSyIzqgG+oPlHYG0+FzYRnIibV151NqT4OcHCQNe
	 U44GQxObRcu2YK8HPt3gKhVEigfa39A3+G3J6i+1TVDvyrGh0wtgbyonwOhRtyibR4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=H9aEGpaBgrUqyjrZLFv+rrixVdKutJ5TaTpfNSMOxho=;
	b=nkvVnUVemchcc/ePIWfMxeKnWlFXjRCxBMOjjSZEgEDr6PVINjwySL+MaY9/u5b3iOTo
	 5FV5Kw4usB9+AswpDVu/3Du5nbxH8fHoR8gE69yegSRw0oycDbFU3+u+qLF7HHSZ46Ckr
	 SQdSdTM94zyK2V592dfAQM4mCn/QHFDaLw4IR2fd4s5w33jcwbC2tYNAF6IKc4NFrM9aE
	 bOkM/4KQFzS2YXnzM9n8Pj+iw6E35C5iMotnICCe2MpjyBbCvMHL1318e3l/XoVUdDDbm
	 0NGLP0Uin2k1Y1EGcnLVlfJrFbvdS0RT7DYPCcp6RsTLPxIzxm45wyqzJC90ZVDcpdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S0aeFzXs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316B606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 11:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B316B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S0aeFzXs
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4aa5833c263so6653962f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 03:53:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795693984; cv=none;
        d=google.com; s=arc-20260327;
        b=g+Bw/Hgw1ytn5Q1aBghSI9a7R7BGHOIwfWXmydMjy5fNn4rOKgQpuyLGTZ1VxQ0qfc
         Y8pmVImI8l3eGEevJBin8cWae9TUbAzh1aKg/e9qFjCy183+Do4sgiDX6uL6jkNkYBFq
         OAzfRb0LyYyIKOIeJUcnW+Pk8VJ2bGv7x7Seme2g+v40d89XZLMU2RuVDOJNuB57Sh2f
         2SWF832uX4c48F+Eq1QXnei4EbbYlj2WilggLGmDNMWfWLsTl2odn/0Ekx2/jIqx7eID
         bIn1xVKMRn1iaEW+CS8s0BeUfqVAr1Z3NYJTUypaXALyoq1HaP2iudIavnkABUaSAGmG
         07dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H9aEGpaBgrUqyjrZLFv+rrixVdKutJ5TaTpfNSMOxho=;
        fh=hPG1bye82c4ONXAalDyuxGhDUrWTTAn/pQu6gKojCbg=;
        b=HJZXIdGSWAZK8i7FCjFghSjsdZRJ0iOPW7RfK76SHO3VjNGiGA3DHqzH6dNcx3eYW4
         xXdJ1wu0A63at+Ji5oLJVwfk2DiZcufINbdl1aCUhpjiBk7j0NWbQ87ZeEGQE7DZeZnu
         0Fs7mdJiA3xqqAETOOO8iTQg7TJra/tD99NZtaDXqy6I8me4NScMVVYv+RxXT7lyvcLz
         TWMSiNNJDc7ZM43hrmGuA6I1Rau14sbKEpDXq1GId2t/o3K69tE9VewWYdvZkndwv1qJ
         RN6J/mMF4LoE9C9BJiDEgPsmcPCcKQksySIH0k064Y7hFTyg7oLdWI5U4fvT7DC6OQm8
         gHwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795693984; x=1796298784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H9aEGpaBgrUqyjrZLFv+rrixVdKutJ5TaTpfNSMOxho=;
        b=S0aeFzXs8Ydxkd9skMwIIs7vYu438WzLCdSH1AhQRK2t/3eQ/tH2INCrLxs8Ige2ym
         dTV3cW9r6JBOKuLokz/ZTzKF4wvh4/KHKWyioIo/roQe4ctBB8SLklKMOecXePLfDIbs
         ApUHSe49kqHosp9KeFS1skNO4y1Z1DUe1SvAgCMaJna0mJR43cBrFhUk2JzU2tNxGYoX
         TSyQ6m3GFNMU5Fh8vHr3ok+H1I/EzZoiZHBKeiIkYS+iTMnJ6hrBOULC6e1xzngCo+us
         Xo20s1nzuZcB5h0jY1X3ptrNvDZqzTYKZ7qh84y+6IfidobrggRjMpMFb2OPpOQkr2N+
         yWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693984; x=1796298784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9aEGpaBgrUqyjrZLFv+rrixVdKutJ5TaTpfNSMOxho=;
        b=06Xmk1CT2id/x898fXxeviyektTwq6qXvhyFlWY1eec43EzC0dmNkRZycSKqqxeESj
         /iu69QXcw9c2EUYc9eiTGLLea+qzwvg6XNy89873MjsOuOzjqEPmUJ1XDbU3tNDi6hxT
         rDIAfE2NPwV9dTymeuHWxuV33xsHHpJeXT/oJKGQ2MLX2TNcUEtMFxQpF8uzZJ/o/VZG
         k8MCV4MhXpujSuZuIhuM/LX2RxcaXmHC1mZug6/h1rPrUKYwFmqE+McxvgOcdhEcNkUb
         bc2A2HjiwnMyIbpNszMCuCNwPyXwcdIvOjrwLwScpuAelN+gejGhZc3d1ZF4XljSydp2
         OhuQ==
X-Forwarded-Encrypted: i=1; AL+hErFzKKQAtGpo4Ncuh8+zgf2TKzUxcmo503xTYeLtOmKBNOhOWbnWwHc2mA6H8OdfIBUzkeyAcY7gU0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BRpwyWHkl23HERGf/WT9zHQInmEY7mwLEZjF5ifpGzbt+QHHL
	mlToi3DWctbA/A3pRetdm6VrLtXmOIx/dvZYoRhNGeFvE7HIRvGSMzAj65geCquXZwEWlU1b2Tm
	wYk8VxN9BlIFD2bCn0QWbdY50L13nGrQ=
X-Gm-Gg: AZFdTZdRLlwKmJwe5flx+IpiYC1NyWSToVOwHlTN9jzlbXNysrR4GX87hsGLyxVfiVd
	T2JJWM3O23lg8bCc6IZ3SXqv42y1c+lIaOGI/NEZ2UieDsBEb/E0R2WLC6RxEmLtdD00rp88HAN
	INJpeKQFEFOYFM3k3OhgdQuPVEmAH26c0hU043gRgAVSlI2Yq4M6SAvi8+214qr2tsoai4hdj8N
	8alTXz0evhnpvRATlNNNjXG9GkkQgOhmuXgcwaYMoLuJnAK/k4lsqVRoswmnA5yXnKhOU9XRGhJ
	pY1xqWxdZ78+GRBbbqTv/h+Bo5qjGvgcLiLAjb4c5Mv32zXKZs+xyAO2zXamw3C+ax/Ur9sq6UA
	BMGueSdA9s8LN9SzuQDCPN+jZxoJlqEgoERqXzkSLzas975w7GqvnlVKnUVWRV1GGK1DzqzhlBp
	wpFn9Zupxfr2rB8wlbE8jW9TBrRx78s3I1KqkGsOzrDglm8bq1sRFOeXsmHag=
X-Received: by 2002:a05:6000:299c:10b0:4a7:9630:7b5a with SMTP id
 ffacd0b85a97d-4abb47b2043mr29738022f8f.47.1795693983751; Thu, 26 Nov 2026
 03:53:03 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126081155.501493-1-wenst@chromium.org> <20261126081155.501493-3-wenst@chromium.org>
In-Reply-To: <20261126081155.501493-3-wenst@chromium.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 26 Nov 2026 11:52:36 +0000
X-Gm-Features: Aa3M54q70A5WmDyjKjXpU3fpfqljo9KNpnEhQvgxjBv6crELfdOj0n7b-mbXhxE
Message-ID: <CA+V-a8vgFBmQ-ih35f6GrXg-JBekovdF4jOuXcvteGkBwDEGUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: rzt2h: depend on POWER_SEQUENCING
 instead of selecting it
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 8:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Commit bdfc454e8567 ("iio: adc: rzt2h: Add support for RZ/V2H(P) SoC")
> recently added usage of the power sequencing API to the rzt2h_adc
> driver, and directly selects POWER_SEQUENCING.
>
> This new Kconfig select causes a recursive dependency when combined with
> the in-flight power sequencing integration into the USB core:
>
>         error: recursive dependency detected!
>                 symbol USB depends on POWER_SEQUENCING
>                 symbol POWER_SEQUENCING is selected by RZT2H_ADC
>                 symbol RZT2H_ADC depends on IIO
>                 symbol IIO is implied by HID_MCP2221
>                 symbol HID_MCP2221 depends on USB_HID
>                 symbol USB_HID depends on USB
>
> Power sequencing is not needed for RZ/T2H and RZ/N2H, whereas RZ/V2H(P)
> and RZ/V2N do need it. But it is not a strict build time requirement
> for the driver. Change it to an optional depends on.
>
> This also requires a change to the pwrseq stub functions so that the
> pwrseq_{enable,disable}() calls in the driver still work without a
> power sequencing descriptor with POWER_SEQUENCING=3Dn.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1d6ed49041ab..7874d0e78e9e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1631,7 +1631,7 @@ config RZT2H_ADC
>         select IIO_ADC_HELPER
>         select IIO_BUFFER
>         select IIO_KFIFO_BUF
> -       select POWER_SEQUENCING
> +       depends on POWER_SEQUENCING if POWER_SEQUENCING
>         help
>           Say yes here to build support for the ADC found in Renesas SoCs=
:
>           - RZ/N2H
> --
> 2.56.1.839.g22a8290db9-goog
>
>
