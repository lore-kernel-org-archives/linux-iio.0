Return-Path: <chf.fritz@googlemail.com>
Message-ID: <1472828671.1929.32.camel@googlemail.com>
Subject: Re: [PATCH] iio: sx9500: add final devicetree support
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Fabio Estevam <festevam@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Vlad Dogaru <ddvlad@gmail.com>,
	Hartmut Knaack
	 <knaack.h@gmx.de>, linux-iio@vger.kernel.org, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>
Date: Fri, 02 Sep 2016 17:04:31 +0200
In-Reply-To: <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
References: <1472827740.1929.26.camel@googlemail.com>
	 <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2016-09-02 at 11:53 -0300, Fabio Estevam wrote:
> On Fri, Sep 2, 2016 at 11:49 AM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> 
> > +sx9500@28 {
> > +       compatible = "semtech,sx9500";
> > +       reg = <0x28>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_sx9500>;
> > +       interrupt-parent = <&gpio2>;
> > +       interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> > +       reset-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> 
> Datasheet says the reset is active low.

Here on my board I'm using the reset pin as an open-drain with external
pullup, so GPIO_ACTIVE_HIGH is valid.

As this is an example, I don't care if it says _HIGH or _LOW.
