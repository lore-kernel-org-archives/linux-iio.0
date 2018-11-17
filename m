Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKRCoE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Nov 2018 21:44:04 -0500
Date: Sat, 17 Nov 2018 16:26:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 9/9] dt-bindings: iio: imu: st_lsm6dsx: add support
 to i2c pullup resistors
Message-ID: <20181117162648.37f51749@archlinux>
In-Reply-To: <20181117153754.GA23006@bogus>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
        <97543627e6e0a26d7ea6b4daa160f10813c05335.1541945612.git.lorenzo.bianconi@redhat.com>
        <20181117153754.GA23006@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Nov 2018 09:37:54 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Nov 11, 2018 at 03:15:36PM +0100, Lorenzo Bianconi wrote:
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > index 879322ad50fd..69d53d98d0f0 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > @@ -13,6 +13,7 @@ Required properties:
> >  Optional properties:
> >  - st,drdy-int-pin: the pin on the package that will be used to signal
> >    "data ready" (valid values: 1 or 2).
> > +- st,pullups : enable/disable internal i2c controller pullup resistors.  
> 
> bias-pull-up is the standard property for this.

The problem here is 'of what?'.  Perhaps it wasn't clear in the current
binding either, but we are talking the pull ups on the auxilliary i2c bus
(which doesn't really have a direct representation in DT at all).
If we just go with bias-pull-up my instinct would be that it was applying
to the drdy pin for example.

Lorenzo, could you send a follow up patch fixing this once we
have it pinned down?

We have plenty of time to get it in before the end of the cycle, so I would
rather do that than revert this series over it.  Conversely I don't
want a binding we are still discussing getting into a release.  I should have
given Rob time to get to this.  Lots of precedence doesn't mean there isn't
a better way!  Sorry All.

Thanks,

Jonathan

> 
> >  - drive-open-drain: the interrupt/data ready line will be configured
> >    as open drain, which is useful if several sensors share the same
> >    interrupt line. This is a boolean property.
> > -- 
> > 2.19.1
> >   
