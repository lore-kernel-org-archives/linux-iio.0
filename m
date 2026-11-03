Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743074;
	b=sXjN08iFznTogART7YJbBJfOK+sxG8Nx23ecaqEI92EwcN/VVgxF2TIE+9uaHlN1Mi5T
	 No+44xL+I+Vw3KMrrwZmyKiPUXjj8fuUJiI4eYSKPRfXdkMyAKIHNDh0QPvLGAdhnFbf5
	 OKUGSkTsPewoU4ZwyZKxJOs1yVmS4g6TBmKI/acGeQAnpI8TwCKlvZNls2DkuHdsJPT8A
	 5q/q3yMwn1n7D1QLH+N+nQKc2mw/cue59hICCrUR3p3GVyyVUfMR+Y9eBidy2vQI62H4Q
	 4JagUACWMUdcaRklG7Nfsd5nPS1zTK3MEmibm7jlF8Sxg/O+zIX5OJo6Et9DASZDM3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743074;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4H8eU6z2JR3iXPnaXPV2uTwunMPI539+3YmBBPsTqq8=;
	b=fs6FJFhkHYk9E4Mp0GsE94Sm4Eepbdu1srI3yDy1roUYldVlVU7mYqFyXPejGyAlfRmr
	 LujILQsznEmKZD/ew9nONHfwa45A+op4H2zJ2K9gt9rx/9sP3BwzvAjjySTOWb92ZlLIr
	 DpaL1s+PSy0NZFBgWisXhSBbAWNBQr4jyQ0ltMhcN7atk/wBxpJ6q7KCaQ6R+4CJbhQtq
	 t0UHGkU6Ss/ThRVm6Qjlqpau12eCbrCky41QPeY1qbElXj/6EHp0o+nkFPSCzPaYTSFG8
	 j9r0VmAondjmxucCUkovxvirQy1GEzS5P/5WjpI6JIEP9PQiPwItCa1XZg/gsdhfjGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KahvjGle;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42362606A33F
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KahvjGle
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1C51F00A20
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793743073;
	bh=4H8eU6z2JR3iXPnaXPV2uTwunMPI539+3YmBBPsTqq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KahvjGlehMHjoebJcxO/t3h58L7/qpUpxiWE0L2ukOdqdSIwTXVi4iX4x+Tq8bVPq
	 YCxZQVJNZ9G/CPTdq2RUg2Ox/MrWr0uYiaFr17waPMkKMNvRLZpBOzQk183fIdxL5k
	 LX5jYuDlVdnENMXPuYNsf0n6+Y32C1svNhtzEUe5ZzUfUkRM55shi0XdYAu/a7+3dB
	 XZ79OMbF1X5P83mNsriI32imupSqnnas7sglQYi2r+eYr09pmfSCESFprVGuzOmrT6
	 eQvByBMQ/ZNT3Rm49nC2wx5eCxUIff7DRGN70ID1lU/29uVRLBTg76Ast0vDK1KIXm
	 P9QocOI0+f6vA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bfa686881fso1721e87.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 13:57:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzT3hnEWDb3sP016HQQWZdeP3dChzqrORNNEiqHaoISOy24O1pcc8bE7U2oELLKcfDMafmArRt0zT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aZhOlHJhGX6l2yRKKHjPQW4jq7ljGhaUt2GxcCw8Qf69dQFiN
	iKp8OZ5xeZKqzswgRkGzVqADmZz+9zcHIvXg6yQDkjYv1QqJoHzszy+NmWk4MmHFbbqFN5cd8jP
	ECT9JyIU3U6oI/bchrFhLlae2u05V8oU=
X-Received: by 2002:a05:6512:a94:b0:5bf:b246:87a2 with SMTP id
 2adb3069b0e04-5bfd957b610mr4953868e87.10.1793743072116; Tue, 03 Nov 2026
 13:57:52 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Nov 2026 22:57:39 +0100
X-Gmail-Original-Message-ID: <CAD++jLm10TL4FkkyhvyF-CKNREA-mOSjbR5zKUisC_Wx1-nqgg@mail.gmail.com>
X-Gm-Features: AclHuK-xZTzLWXlPWAOCiWHBj5C4K-MSmY2Fnjjj517UPimoWDCn2vjwhrapfPU
Message-ID: <CAD++jLm10TL4FkkyhvyF-CKNREA-mOSjbR5zKUisC_Wx1-nqgg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Shawn Guo <shawnguo@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>, 
	Alistair Francis <alistair@alistair23.me>, Julius Werner <jwerner@chromium.org>, 
	Paul Cercueil <paul@crapouillou.net>, Dmitry Osipenko <digetx@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:53=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:

> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
