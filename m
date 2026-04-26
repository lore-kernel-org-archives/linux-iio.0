Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83F4964F
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777175699; cv=pass; b=hQHLzztE+OnscUxNYi6rIFpPCWFi77op1wQ8Xq+qFPcFvsxBfdBRFX5VFzXSZVHHTZ8G3wtb4N5hgCqn87Xj85koPAPNSvHoDKa6VuLAgFMF0QUWF8ckbn3BXwnplU6BR4bhPwzAOYJh2ILA7ehO713FW7/N9vLNyZzT6E7m4EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777175699; c=relaxed/simple;
	bh=1zaGua4yo0gT6+/+UzKN3s1qddzTN1hyjepZZUU1qRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFvHPuI+J8rVu1yzupsUyk2zkas0pyL5khT28Py+FaDLGpHfJjd+Ve3QuCor2+ALOVG9YgQ05zRTDsPC+NV0MAvgh/Q/+LgIaOfHm23pooLho4V3fsNaN7dOyYeaD4xDYpYKmuAb5WGlaTLE65Oetc4yF5isC+I1vqA/ayXyT4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CISqkkmD; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CISqkkmD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b941cd869cso5735595ad.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 20:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777175697; cv=none;
        d=google.com; s=arc-20240605;
        b=ghsKL9evjutoPI3Vybr6wpSRSSuGLThTLeypiqdggnWA0L9uQhstZEhgJqBF2pZ6is
         1M65BphAhc/KmjIoBq6OBAda1LQ2CK9cC9FppBYAN7+jy8fmVsFW70fkFz+3mysqbb1Y
         oug2y42SHIcBojaypCvg2wm/82pRILB7awrYlw2sdiXFSL7hZnAcK/PJtFc0nhfWCChH
         Bc137Ser1CAGhgl9ZGPrg1X5iM5roMqSkrTC75LMBpLP//q0p6PAXEIypTeDZV2OZFox
         2io7H69JzvCv/RAf3Py8nW3C3JE0RqmSzwqXBsCfOU8s4UO7R4dgCECqGs2hB97mX+gv
         3toQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1BdFcpz+AcaZJuHG5kH6Dp7Mwp/lMapbOHRN2wu9PUQ=;
        fh=rRzUw7ZH59UwQckySJE4OggqF9YSgCQfjCQsBpACHco=;
        b=XpKaEEPLmIGxs94kZBNuQKfI71fe1HTpflugtLdFCq/xedwu/Tnz0tHLxr9hloQAAU
         a5DJx2tFyOnKyYmWmH9rC4ofg4IG/eTgAWlEy3Dwd7PEgMzNxddcvBeocQBi+TGsuPBb
         II6aRP5QS5lDlkR2Y22q7RJnE6xOToUcNuSHc9+aStd708aeZ8XjD9fQLfvFKPnQVRkd
         oLg/D9Dz9YhRosAHELkYYxXh3rVdMHN55A70R4RT/BjQdLdmtlv2Q1+5fsLKIMUBa0rE
         4grSFBR3aohPQc428KZQTm9gNGZIzXx1R9s5bsz1xG8Jd2Qu9LxHp726vIha+Y4nci7A
         MWjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777175697; x=1777780497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BdFcpz+AcaZJuHG5kH6Dp7Mwp/lMapbOHRN2wu9PUQ=;
        b=CISqkkmDa7ZG/igmUjpi5LwNSdjK79ub718T3TIMOP2Froy4eKklzwUMHyRl7zbYc4
         I7qzMVVFdiuUiVxZQ0abUs2nlWxrXCBl/tsSwbeIGmP9NgvXRWm6GN589T+pH3yUFqk0
         FyizU1sLlc6it779faN2+sv1uqDyAa7ze1ioY0PQ/vLWMJISdag9pJUNyu/vM4FE28Kg
         qSc+EO1GUh9SSp4LcFo8u71quN7iRbppshIpb2IdhMHOtcQ04BG2bdjmvpskYWI7xuih
         83Q3Mr8s15EIVIWhWVaGrPinM4/wLYwgSn68zfO01rAGANOMWP3jFHEqC46P0zACSMFE
         oEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777175697; x=1777780497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BdFcpz+AcaZJuHG5kH6Dp7Mwp/lMapbOHRN2wu9PUQ=;
        b=Wftss0uREPylhbrdfbZhsFrqgjmXLN/PSd2w1wWTbsBGJUw+ieZctnlk0mlLbpF2ot
         m/qPMItGfRXK/715xnGJB1M5WNWgFPL40PfR8Rd9w5lqnhe3Q3llopvgUibiU4qgPVKe
         7mjOi0pdDDkKtNHbqeOUszHxokba6AS0ctfpXExI9OKaIUc3axbWok2gTzyLbdAljB2N
         uVBnTcH7leknx4rkUu3YAzE1wxmt2/JoIO2CkCAo0i9nSojtWHLXBLPJbkI9ZdJMRWqa
         BvbhsNijnlkm8Rv/OJjEZo8SfsxZmRxfqJpy0cC9Bts3w7ssxmPTfHREBzrffn6G0Rj3
         jM0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8xU3LShjNL8hJUZ9Hmjhue1jcZx16+Kvcx+lakFRxdV8CyjZlr8gqWSgl+OfGWjRWvq18HdFjvOKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TWPdtMxHZGbBo6PpcZjfvzdi+3ciWPm9PltGOG9nFOPeUMP6
	XjLiOfd6pND9SzH3aAVW8SKuWWOIXq2UqavfW/zUqMAHuqbqmZdbdRh0LDvr94gQvw+f9inp8K+
	31fKMAe5eUHYnGKFsSB/CjdyxqpeDOOg=
X-Gm-Gg: AeBDievR5KhgfbhPy/Yhlfrm8UnycGpW4VoqS35J4hShJP5jlWNQ17JFuo9ZEWkazhN
	t2oYXMtSJx7vQiJiaMCrhZg4HASTplGtY13dATSXAH+wEfVDRDz9nZELBmKMkf3/4oBR5fvhuDe
	0LxpGXZ1ad3plyh3WiaC/HXSnC6I9uBbe1V7poA0V2eSq1jSAB0/zQzYSVGbWEZW3JGxD/3UNW1
	ROJSRPclq0AAZ0xMBz79cA5Xplg+XueUOkbLjOJUxGvaakomEUKC07hYQEaXzYS8h4O6yM9LNi9
	xjo2w5tjSbEBZ0WlayfQtyTEAnidvcDelvshvxLmmj/InQcAwmsk/UwAAWjh1wGppezTWqehbsA
	=
X-Received: by 2002:a17:903:1aa5:b0:2ae:57e6:616c with SMTP id
 d9443c01a7336-2b5f9e5e312mr361056635ad.3.1777175697342; Sat, 25 Apr 2026
 20:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
 <84cae83c-2d67-4927-aa40-6c416d4f862d@baylibre.com> <20260425194412.1872eff8@jic23-huawei>
 <754b6044-2285-4694-99d4-18d4fd5d8f6d@baylibre.com>
In-Reply-To: <754b6044-2285-4694-99d4-18d4fd5d8f6d@baylibre.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 26 Apr 2026 11:54:47 +0800
X-Gm-Features: AQROBzBzsaXQFVJdkYRHjTgsoiLM-gr_cIOC3RLib6DRouSrwbDmmVsVhdBXyy8
Message-ID: <CAN4SLj0hp4N_WXPxxQcLjY+espY96LfizsNEqJ3L2UF4_GoCHg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on error
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rosen Penev <rosenp@gmail.com>, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 7:16=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> I just updated iio/testing today and I see return without kfree().
>
>         priv->tsc_regmap =3D syscon_regmap_lookup_by_phandle(dev->of_node=
, "amlogic,hhi-sysctrl");
>         if (IS_ERR(priv->tsc_regmap))
>                 return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
>                                      "failed to get amlogic,hhi-sysctrl r=
egmap\n");
> >> Should `#include <linux/cleanup.h>` though rather that relying on it b=
eing
> >> included through another header.
> >>
> >> With that fixed...
> >>
> >> Reviewed-by: David Lechner <dlechner@baylibre.com>
> >>
> >
>
Hi Jonathan,
This code was merged into linux/master yesterday, perhaps you haven't
updated the code base.

Best regards,
Felix
