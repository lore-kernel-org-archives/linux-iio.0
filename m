Return-Path: <SRS0=XeGl=7K=gmail.com=vincent.legoll@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170723141354.42646-2-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io> <20170723141354.42646-2-icenowy@aosc.io>
From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Tue, 8 Aug 2017 13:56:05 +0200
Message-ID: <CAEwRq=oJDmUBhb5n5=X-M5NL7855yW0t2J=TOJf0WSmBQuKyVQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 1/5] dt-bindings: update the Allwinner
 GPADC device tree binding for H3
To: icenowy@aosc.io
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
	Jonathan Cameron <jic23@kernel.org>, Quentin Schulz <quentin.schulz@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hello,

Sorry for the very-clueless question

On Sun, Jul 23, 2017 at 4:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> +  - clock-names: should be "bus" and "mod",

When I first read that, I wondered what value clock-names should
eally be given.

Then...

> +               clock-names = "bus", "mod";

OK, now this is clearer, but still the documentation is less documenting
than the code itself, sigh...

I cannot think of a better wording, though, as a non-native-english
speaker. Maybe just add a "(See example below)" would be
sufficient...

Or decide that this documentation is for clueful ones.

WDYT ?

-- 
Vincent Legoll
