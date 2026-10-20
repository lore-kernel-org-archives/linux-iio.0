Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516593;
	b=QiCMzGOrNdZzLplVIFR+yKdtyyCreTvc0CmxMe/hWr3Cz5yW1lP6OFcobfy8e0HLGdDW
	 sLSSdPo37pYG7fxaCJpJN/CzH2hMOrL9WmDueHLMIo+XVPYHWDYg1ir8UqdI/9fe9xvHZ
	 Au7TnZJzzxUyeWFtDzzqA4JHWclCLSheXbPwFly6fVpYhUNkllucoF+YqKfWU8xeBHQqd
	 vd5gKkmPIRbNYsvl0WhWAxhNEJbusYH/Q/J2Hjomeb/2BN+QIhRwYB/HFijcr0RZxSWmm
	 8GaXXVBl0YPmxdkubb/nwUq2txpxwUL6Wddlpkp2tGlQZjMZMzfzMUmPD8eWkZcs+QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516593;
	h=Received:Received:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8JgZTskEhAe6xxV6x68aEhfu2INYkml8PjbzJi5N0lU=;
	b=v/1L2sK4X6YtkPG95lSg1LmIypI5BC8M8Mif0OVUcsjsjsBibZ/toqkFfK0rCuths16e
	 b1WLRYT3LiETAUKq2j5AakFqPR0om5XvvIXa0v8UdPK4oQ+qfUP4h1pbMHBn+ABsj1+I3
	 mtsJct75WZh+o5SXqprMwSDIOS/yCBEqjJZa0enNApSD3Rkk5KVB6IYJxIg66R6C6TqJS
	 X34NPmkRnl2ROQ5hZSDAMxs94w0lGqcHzN3BLHUKAlU26rgVhTNg0iDL8wMG/pOKZnAoD
	 P21kKerr8fFdJQ96BADGTY7P/1sTzOELeKbwNBHWIGpK/CgDPd3UkQP18SEw1lBWtuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B810606D5AA
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 17:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D56A1F000C9
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 17:16:32 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be469d4f9fso3096068e87.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 10:16:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzrzrDvqd3t0htHEQ+wBfpptsOYwo1k4Wd6sQvev/5uTaT/DGjuylH55gcT1QfKiiDP+nHCtY3Rb60=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsES8enUUo6A/diWsoRLjW14lAUweOpA+ijApYgNtCJ71W0GMP
	o5mBPUJ9wPzPKv6CfpcPSHW0Nydt/b2aFLGLBGqsHU4+OL6sXAlmgDbbKzbePlDOtl68zUqD0Ft
	b4X1p0RQQs8tJVspi5zpfluJWviXj1RA=
X-Received: by 2002:a05:6512:114c:b0:5be:4d37:3bc0 with SMTP id
 2adb3069b0e04-5be50a9dbd8mr4119073e87.62.1792516566187; Tue, 20 Oct 2026
 10:16:06 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com> <20261020-iio-light-gp2ap002-v3-2-b7e0946c9e79@rudorff.com>
In-Reply-To: <20261020-iio-light-gp2ap002-v3-2-b7e0946c9e79@rudorff.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 20 Oct 2026 19:15:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLmCo8tnG5vp4Qv=6rDG3nob25LHELretdu7t3_SLxQASQ@mail.gmail.com>
X-Gm-Features: AclHuK9jGkoAjznqQZwxFsnHN6Zr-n0TfSZfEnfEZkRBZOBxywfmSrVOcQu4ooA
Message-ID: <CAD++jLmCo8tnG5vp4Qv=6rDG3nob25LHELretdu7t3_SLxQASQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: light: gp2ap002: add led power supply
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

> tested on samsung-j5
>
> v2: Use regulator bulk api.
> v3: pretty up, rename vled to leda
>
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>

I think that commit message needs a bit of elaboration ;)

With that fixed:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
