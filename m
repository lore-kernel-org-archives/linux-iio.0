Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757639AbeD1QEJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Apr 2018 12:04:09 -0400
Date: Sat, 28 Apr 2018 17:04:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: potentiostat: lmp91000: add LMP91002 support
Message-ID: <20180428170405.105c8e9a@archlinux>
In-Reply-To: <CAJCx=gkUUo70O7c14orRr=tUSeQDNRq1PRX1mSQL6u3YP1G+kQ@mail.gmail.com>
References: <20180427021505.29526-1-matt.ranostay@konsulko.com>
        <CAJCx=gkUUo70O7c14orRr=tUSeQDNRq1PRX1mSQL6u3YP1G+kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 26 Apr 2018 19:17:09 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Thu, Apr 26, 2018 at 7:15 PM, Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> > LMP91002 is register compatible so add devicetree and i2c client ids
> >
> > Cc: device-tree@vger.kernel.org  
> 
> *sigh* should be devicetree@vger.kernel.org ... adding correct CC
> 
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt | 7 ++++---
> >  drivers/iio/potentiostat/lmp91000.c                             | 2 ++
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
> > index b9b621e94cd7..d51639f0ebbf 100644
> > --- a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
> > +++ b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
> > @@ -1,10 +1,11 @@
> > -* Texas Instruments LMP91000 potentiostat
> > +* Texas Instruments LMP91000 series of potentiostats
> >
> > -http://www.ti.com/lit/ds/symlink/lmp91000.pdf
> > +LMP91000: http://www.ti.com/lit/ds/symlink/lmp91000.pdf
> > +LMP91002: http://www.ti.com/lit/ds/symlink/lmp91002.pdf
> >
> >  Required properties:
> >
> > -  - compatible: should be "ti,lmp91000"
> > +  - compatible: should be "ti,lmp91000" or "ti,lmp91002"
Please put each entry on a new line. Reduces churn going forward.

Thanks,

Jonathan

> >    - reg: the I2C address of the device
> >    - io-channels: the phandle of the iio provider
> >
> > diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> > index 85714055cc74..90e895adf997 100644
> > --- a/drivers/iio/potentiostat/lmp91000.c
> > +++ b/drivers/iio/potentiostat/lmp91000.c
> > @@ -411,12 +411,14 @@ static int lmp91000_remove(struct i2c_client *client)
> >
> >  static const struct of_device_id lmp91000_of_match[] = {
> >         { .compatible = "ti,lmp91000", },
> > +       { .compatible = "ti,lmp91002", },
> >         { },
> >  };
> >  MODULE_DEVICE_TABLE(of, lmp91000_of_match);
> >
> >  static const struct i2c_device_id lmp91000_id[] = {
> >         { "lmp91000", 0 },
> > +       { "lmp91002", 0 },
> >         {}
> >  };
> >  MODULE_DEVICE_TABLE(i2c, lmp91000_id);
> > --
> > 2.14.1
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

