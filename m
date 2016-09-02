Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33898 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754137AbcIBPM0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 11:12:26 -0400
MIME-Version: 1.0
In-Reply-To: <1472828671.1929.32.camel@googlemail.com>
References: <1472827740.1929.26.camel@googlemail.com> <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
 <1472828671.1929.32.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Sep 2016 12:12:24 -0300
Message-ID: <CAOMZO5BVDS=AaSyRS0ELBiEKx3RxdstXgA_xJ6ANUzKDxdyBxg@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9500: add final devicetree support
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 2, 2016 at 12:04 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> Here on my board I'm using the reset pin as an open-drain with external
> pullup, so GPIO_ACTIVE_HIGH is valid.
>
> As this is an example, I don't care if it says _HIGH or _LOW.

Then probably it is better to remove "reset-gpios" from the example.

The driver does not parse this dt property and the reset is being done
via software command as far as I can see.
