Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35241 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbcIBPXn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 11:23:43 -0400
Message-ID: <1472829819.12668.3.camel@googlemail.com>
Subject: Re: [PATCH] iio: sx9500: add final devicetree support
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Fabio Estevam <festevam@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date: Fri, 02 Sep 2016 17:23:39 +0200
In-Reply-To: <CAOMZO5BVDS=AaSyRS0ELBiEKx3RxdstXgA_xJ6ANUzKDxdyBxg@mail.gmail.com>
References: <1472827740.1929.26.camel@googlemail.com>
         <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
         <1472828671.1929.32.camel@googlemail.com>
         <CAOMZO5BVDS=AaSyRS0ELBiEKx3RxdstXgA_xJ6ANUzKDxdyBxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-09-02 at 12:12 -0300, Fabio Estevam wrote:
> On Fri, Sep 2, 2016 at 12:04 PM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> 
> > Here on my board I'm using the reset pin as an open-drain with external
> > pullup, so GPIO_ACTIVE_HIGH is valid.
> >
> > As this is an example, I don't care if it says _HIGH or _LOW.
> 
> Then probably it is better to remove "reset-gpios" from the example.
> 
> The driver does not parse this dt property and the reset is being done
> via software command as far as I can see.

What do you mean by "software command", to send a reset command by i2c?

The reset GPIO is fetched in sx9500 here:

See sx9500_gpio_probe():
...
        data->gpiod_rst = devm_gpiod_get_index(dev, SX9500_GPIO_RESET,
                                               0, GPIOD_OUT_HIGH);
...





