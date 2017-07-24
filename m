Return-Path: <SRS0=sygP=63=csie.org=wens@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170723141354.42646-2-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io> <20170723141354.42646-2-icenowy@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 24 Jul 2017 14:01:27 +0800
Message-ID: <CAGb2v679W=Xzd1pio994Zu0PFmaF0VoUmw==_FfLnF0-DPLdBA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 1/5] dt-bindings: update the Allwinner
 GPADC device tree binding for H3
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
	Jonathan Cameron <jic23@kernel.org>, Quentin Schulz <quentin.schulz@free-electrons.com>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 23, 2017 at 10:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
>
> Update the binding document to cover H3.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
