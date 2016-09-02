Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33819 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbcIBSZl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 14:25:41 -0400
MIME-Version: 1.0
In-Reply-To: <1472834833.12668.11.camel@googlemail.com>
References: <1472827740.1929.26.camel@googlemail.com> <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
 <1472828671.1929.32.camel@googlemail.com> <CAOMZO5BVDS=AaSyRS0ELBiEKx3RxdstXgA_xJ6ANUzKDxdyBxg@mail.gmail.com>
 <1472829819.12668.3.camel@googlemail.com> <CAOMZO5DbJLnH1wm2KuML+O36O-eSYWeGwrxE5pdKSRtB-Js-yA@mail.gmail.com>
 <1472834833.12668.11.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Sep 2016 15:25:40 -0300
Message-ID: <CAOMZO5B8ttBvf-zimO5R_kgpzR2bxF73Ur0vZpBKUX8Ytbs8uQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9500: add final devicetree support
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 2, 2016 at 1:47 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> But there is: devm_gpiod_get_index() calls gpiod_get_index() which calls
> of_find_gpio() for of-string "reset-gpios".

Ok, great.

>>
>> Does your board work well without passing "reset-gpios" property?
>
> I don't know, the driver looks that way. I'll check that. If so, I'll
> fix the docu and add the reset-gpios property as optional. Okay?

My main concern was the gpio reset polarity. Not sure why active high
works in your case.
