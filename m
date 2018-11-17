Return-Path: <SRS0=fLPQ=N4=redhat.com=lbiancon@kernel.org>
MIME-Version: 1.0
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
 <97543627e6e0a26d7ea6b4daa160f10813c05335.1541945612.git.lorenzo.bianconi@redhat.com>
 <20181117153754.GA23006@bogus> <20181117162648.37f51749@archlinux>
In-Reply-To: <20181117162648.37f51749@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Sat, 17 Nov 2018 18:24:03 +0100
Message-ID: <CAJ0CqmWPYsm=hx0p+O3NuozW1YDUeGbQ5ffrPNDjFSsPEEJM8A@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] dt-bindings: iio: imu: st_lsm6dsx: add support to
 i2c pullup resistors
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Sat, 17 Nov 2018 09:37:54 -0600
> Rob Herring <robh@kernel.org> wrote:
>

[...]

> > >  Optional properties:
> > >  - st,drdy-int-pin: the pin on the package that will be used to signal
> > >    "data ready" (valid values: 1 or 2).
> > > +- st,pullups : enable/disable internal i2c controller pullup resistors.
> >
> > bias-pull-up is the standard property for this.
>
> The problem here is 'of what?'.  Perhaps it wasn't clear in the current
> binding either, but we are talking the pull ups on the auxilliary i2c bus
> (which doesn't really have a direct representation in DT at all).
> If we just go with bias-pull-up my instinct would be that it was applying
> to the drdy pin for example.
>
> Lorenzo, could you send a follow up patch fixing this once we
> have it pinned down?
>

Sure, it sounds good. IIUC we should use 'bias-pull-up' here, without
vendor info, right?

Regards,
Lorenzo

> We have plenty of time to get it in before the end of the cycle, so I would
> rather do that than revert this series over it.  Conversely I don't
> want a binding we are still discussing getting into a release.  I should have
> given Rob time to get to this.  Lots of precedence doesn't mean there isn't
> a better way!  Sorry All.
>
> Thanks,
>
> Jonathan
>
> >
> > >  - drive-open-drain: the interrupt/data ready line will be configured
> > >    as open drain, which is useful if several sensors share the same
> > >    interrupt line. This is a boolean property.
> > > --
> > > 2.19.1
> > >
>
