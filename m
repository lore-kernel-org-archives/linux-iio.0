Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731565AbeKVFco (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Nov 2018 00:32:44 -0500
Date: Wed, 21 Nov 2018 18:57:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: robh@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 9/9] dt-bindings: iio: imu: st_lsm6dsx: add support
 to i2c pullup resistors
Message-ID: <20181121185709.0e5b924b@archlinux>
In-Reply-To: <CAJ0CqmWPYsm=hx0p+O3NuozW1YDUeGbQ5ffrPNDjFSsPEEJM8A@mail.gmail.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
        <97543627e6e0a26d7ea6b4daa160f10813c05335.1541945612.git.lorenzo.bianconi@redhat.com>
        <20181117153754.GA23006@bogus>
        <20181117162648.37f51749@archlinux>
        <CAJ0CqmWPYsm=hx0p+O3NuozW1YDUeGbQ5ffrPNDjFSsPEEJM8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Nov 2018 18:24:03 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> > On Sat, 17 Nov 2018 09:37:54 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  
> 
> [...]
> 
> > > >  Optional properties:
> > > >  - st,drdy-int-pin: the pin on the package that will be used to signal
> > > >    "data ready" (valid values: 1 or 2).
> > > > +- st,pullups : enable/disable internal i2c controller pullup resistors.  
> > >
> > > bias-pull-up is the standard property for this.  
> >
> > The problem here is 'of what?'.  Perhaps it wasn't clear in the current
> > binding either, but we are talking the pull ups on the auxilliary i2c bus
> > (which doesn't really have a direct representation in DT at all).
> > If we just go with bias-pull-up my instinct would be that it was applying
> > to the drdy pin for example.
> >
> > Lorenzo, could you send a follow up patch fixing this once we
> > have it pinned down?
> >  
> 
> Sure, it sounds good. IIUC we should use 'bias-pull-up' here, without
> vendor info, right?
Yes, though my concern about it being on it's own without any reference
points.  Makes it unobvious what we are applying the pull up on.

Jonathan

> 
> Regards,
> Lorenzo
> 
> > We have plenty of time to get it in before the end of the cycle, so I would
> > rather do that than revert this series over it.  Conversely I don't
> > want a binding we are still discussing getting into a release.  I should have
> > given Rob time to get to this.  Lots of precedence doesn't mean there isn't
> > a better way!  Sorry All.
> >
> > Thanks,
> >
> > Jonathan
> >  
> > >  
> > > >  - drive-open-drain: the interrupt/data ready line will be configured
> > > >    as open drain, which is useful if several sensors share the same
> > > >    interrupt line. This is a boolean property.
> > > > --
> > > > 2.19.1
> > > >  
> >  
