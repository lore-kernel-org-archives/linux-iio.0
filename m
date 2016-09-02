Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33412 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbcIBQQg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 12:16:36 -0400
MIME-Version: 1.0
In-Reply-To: <1472829819.12668.3.camel@googlemail.com>
References: <1472827740.1929.26.camel@googlemail.com> <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
 <1472828671.1929.32.camel@googlemail.com> <CAOMZO5BVDS=AaSyRS0ELBiEKx3RxdstXgA_xJ6ANUzKDxdyBxg@mail.gmail.com>
 <1472829819.12668.3.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Sep 2016 13:16:34 -0300
Message-ID: <CAOMZO5DbJLnH1wm2KuML+O36O-eSYWeGwrxE5pdKSRtB-Js-yA@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9500: add final devicetree support
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 2, 2016 at 12:23 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> What do you mean by "software command", to send a reset command by i2c?

Yes, by writing 0xDE into RegReset register.

>
> The reset GPIO is fetched in sx9500 here:
>
> See sx9500_gpio_probe():
> ...
>         data->gpiod_rst = devm_gpiod_get_index(dev, SX9500_GPIO_RESET,
>                                                0, GPIOD_OUT_HIGH);

but there is no code that actually reads the "reset-gpios" dt property.

Does your board work well without passing "reset-gpios" property?
