Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32870 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbcILPo4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 11:44:56 -0400
Date: Mon, 12 Sep 2016 10:44:52 -0500
From: Rob Herring <robh@kernel.org>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Fabio Estevam <festevam@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] iio: sx9500: add final devicetree support
Message-ID: <20160912154452.GA29955@rob-hp-laptop>
References: <1472827740.1929.26.camel@googlemail.com>
 <CAOMZO5BeL1EKOQvZQoXXObttHSKxL7UQ1s2r8H4EOuROOb_YnQ@mail.gmail.com>
 <1472828671.1929.32.camel@googlemail.com>
 <CAOMZO5BVDS=AaSyRS0ELBiEKx3RxdstXgA_xJ6ANUzKDxdyBxg@mail.gmail.com>
 <1472829819.12668.3.camel@googlemail.com>
 <CAOMZO5DbJLnH1wm2KuML+O36O-eSYWeGwrxE5pdKSRtB-Js-yA@mail.gmail.com>
 <1472834833.12668.11.camel@googlemail.com>
 <CAOMZO5B8ttBvf-zimO5R_kgpzR2bxF73Ur0vZpBKUX8Ytbs8uQ@mail.gmail.com>
 <1472898600.1918.4.camel@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472898600.1918.4.camel@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 03, 2016 at 12:30:00PM +0200, Christoph Fritz wrote:
> This makes sx9500 driver usable on devicetree based platforms too.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
> 
> Changes in v2:
> 
>  - fix docu: add optional property reset-gpios
>  - adapt docu: change example "reset-gpios"
> 
>  .../devicetree/bindings/iio/proximity/sx9500.txt   | 24 ++++++++++++++++++++++
>  drivers/iio/proximity/sx9500.c                     |  7 +++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/sx9500.txt

Acked-by: Rob Herring <robh@kernel.org>
