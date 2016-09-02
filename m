Return-Path: <chf.fritz@googlemail.com>
Message-ID: <1472834833.12668.11.camel@googlemail.com>
Subject: Re: [PATCH] iio: sx9500: add final devicetree support
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Fabio Estevam <festevam@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Vlad Dogaru <ddvlad@gmail.com>,
	Hartmut Knaack
	 <knaack.h@gmx.de>, linux-iio@vger.kernel.org, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>
Date: Fri, 02 Sep 2016 18:47:13 +0200
In-Reply-To: <CAOMZO5DbJLnH1wm2KuML+O36O-eSYWeGwrxE5pdKSRtB-Js-yA@mail.gmail.com>
References: <1472827740.1929.26.camel@googlemail.com>
	 <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
	 <1472828671.1929.32.camel@googlemail.com>
	 <CAOMZO5BVDS=AaSyRS0ELBiEKx3RxdstXgA_xJ6ANUzKDxdyBxg@mail.gmail.com>
	 <1472829819.12668.3.camel@googlemail.com>
	 <CAOMZO5DbJLnH1wm2KuML+O36O-eSYWeGwrxE5pdKSRtB-Js-yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2016-09-02 at 13:16 -0300, Fabio Estevam wrote:
> On Fri, Sep 2, 2016 at 12:23 PM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> 
> > What do you mean by "software command", to send a reset command by i2c?
> 
> Yes, by writing 0xDE into RegReset register.
> 
> >
> > The reset GPIO is fetched in sx9500 here:
> >
> > See sx9500_gpio_probe():
> > ...
> >         data->gpiod_rst = devm_gpiod_get_index(dev, SX9500_GPIO_RESET,
> >                                                0, GPIOD_OUT_HIGH);
> 
> but there is no code that actually reads the "reset-gpios" dt property.

But there is: devm_gpiod_get_index() calls gpiod_get_index() which calls
of_find_gpio() for of-string "reset-gpios".

> 
> Does your board work well without passing "reset-gpios" property?

I don't know, the driver looks that way. I'll check that. If so, I'll
fix the docu and add the reset-gpios property as optional. Okay?

Thanks
 -- Christoph
