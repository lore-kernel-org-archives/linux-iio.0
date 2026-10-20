Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516641;
	b=2ojkGoDpGSClB6g7OhNWzAHLhuoStcYaxA2h/M3akWX3FVoKOU24XkvYSHbsbenICFgg
	 U57qQIsVtUXw8wD7IzNXmrDgy/nvXYLHatVYjuvcGnOOVpizG+zzE6TdYZ5QJT5pANl8H
	 ZdFT67G8IlhEKhxmuA4niAyEwC/pRxypVVUiErFmxPl3u7liV5hKV8C9AufMZEusz0nwJ
	 nZ/zaXjxZzcuSWwOn0+KwIdHmxTXumNb8sd5B6xbcUfBVXG8DYOYAhfKSF4DDdFiOugVn
	 ZKEDCxk2FlVFzu9+zn/b6txkPckZ3M+KJoT8AJ6FmgMey6IxIo1pQRYOeSLnr857hxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516641;
	h=Received:Received:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=lZsoV5xV/qdIzsmQoRFkHO+0ZG2LBiefLdsROQtEphU=;
	b=jca2T+HXPLIbmaSxr42mmC3KOftgje7eJHvM6DnTJx78Q+9YQrHe9hv6xJ09lrbsEVf4
	 kxJdsAWjnwgsm0U6lY9SPIUB1lzahueGXWxzkWvtLu47cn3bpx8lrWNn5LBFB1XkkNVql
	 5+wU6/eZySDuetZBrgE+DxMEwsFC8uY8KDxl1A8P7nFBBhYrW0jnLR29aZr8QUvKaJOn/
	 IZDO7cCR37lFAD/stMjHkjVCziqGS4YJnH2iEQonoyO6Tu+n3RFGqFBwQ7Ry+C/Rigq3K
	 80ufX1ZSkYNzFtBG33adwELaCn6fRllqjmvZDfkCIzg5eyRd154oiB/3LGYggvqpn3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0135606A332
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 17:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0AA1F000D2
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 17:17:20 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab46699a09so14180891fa.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 10:17:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJ4YPVxjxX9ajhCMbiGnw/oitWOfn/MiA3UNQJv/5wAgcYS96mg71fPKGe/xJE9peOR0UtwBJAlOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8tulBy6bvy0cxThp4dLa6968YrdxE6X9fuXRxpZtAXNqvjuGm
	z7/5CBn+ETQXsTbz7d64KUpZin0qLcLjvmjM2SqvrC5Wau9g0zCc4JW2t/il2c2UxwnGbWUGxaC
	nFS5+v7LXPzsvFxXE42Dww+Bx+Udim1U=
X-Received: by 2002:a05:651c:3614:b0:3ab:1639:9a79 with SMTP id
 38308e7fff4ca-3ab292b7375mr20330481fa.15.1792516609558; Tue, 20 Oct 2026
 10:16:49 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com> <20261020-iio-light-gp2ap002-v3-3-b7e0946c9e79@rudorff.com>
In-Reply-To: <20261020-iio-light-gp2ap002-v3-3-b7e0946c9e79@rudorff.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 20 Oct 2026 19:16:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLne9-+i5aWejLoqb4ZYf8Bk66iifcaT1MV4uY80+9ORww@mail.gmail.com>
X-Gm-Features: AclHuK8o7YJtu4fGAIWMm54FLQfyDMwv1SgdLwwrUNSyOsI4L3FOJbzTrlMgBeE
Message-ID: <CAD++jLne9-+i5aWejLoqb4ZYf8Bk66iifcaT1MV4uY80+9ORww@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: msm8916-samsung-j5: Add
 proximity sensor
To: Christoph Rudorff <chris@rudorff.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 1:36=E2=80=AFPM Christoph Rudorff <chris@rudorff.co=
m> wrote:

> J5 got a gp2ap002 sensor, add it and it's supplies to the device tree
>
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
