Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1472827740.1929.26.camel@googlemail.com>
References: <1472827740.1929.26.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Sep 2016 11:53:52 -0300
Message-ID: <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9500: add final devicetree support
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Vlad Dogaru <ddvlad@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 2, 2016 at 11:49 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> +sx9500@28 {
> +       compatible = "semtech,sx9500";
> +       reg = <0x28>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_sx9500>;
> +       interrupt-parent = <&gpio2>;
> +       interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +       reset-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;

Datasheet says the reset is active low.
