Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbeKLBXC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 20:23:02 -0500
Date: Sun, 11 Nov 2018 15:34:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: adc: Add ad7124 support
Message-ID: <20181111153405.45ccb948@archlinux>
In-Reply-To: <1541695681.2091.10.camel@analog.com>
References: <1540831111-3040-1-git-send-email-stefan.popa@analog.com>
        <20181103121606.2fc461ec@archlinux>
        <1541687328.2091.2.camel@analog.com>
        <CAL_Jsq+zc2RGWgkwXNk8qjJqjo+FpdPZUOOxd44mb8Cu7+EsaQ@mail.gmail.com>
        <1541695681.2091.10.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 8 Nov 2018 16:48:02 +0000
"Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:

> On Jo, 2018-11-08 at 10:34 -0600, Rob Herring wrote:
> > On Thu, Nov 8, 2018 at 9:02 AM Popa, Stefan Serban
> > <StefanSerban.Popa@analog.com> wrote: =20
> > >=20
> > >=20
> > > On Sb, 2018-11-03 at 12:16 +0000, Jonathan Cameron wrote: =20
> > > >=20
> > > > On Mon, 29 Oct 2018 18:38:31 +0200
> > > > Stefan Popa <stefan.popa@analog.com> wrote:
> > > >  =20
> > > > >=20
> > > > >=20
> > > > > The ad7124-4 and ad7124-8 are a family of 4 and 8 channel sigma-
> > > > > delta
> > > > > ADCs
> > > > > with 24-bit precision and reference.
> > > > >=20
> > > > > Three power modes are available which in turn affect the output
> > > > > data
> > > > > rate:
> > > > > =C2=A0* Full power: 9.38 SPS to 19,200 SPS
> > > > > =C2=A0* Mid power: 2.34 SPS to 4800 SPS
> > > > > =C2=A0* Low power: 1.17 SPS to 2400 SPS
> > > > >=20
> > > > > The ad7124-4 can be configured to have four differential inputs,
> > > > > while
> > > > > ad7124-8 can have 8. Moreover, ad7124 also supports per channel
> > > > > configuration. Each configuration consists of gain, reference
> > > > > source,
> > > > > output data rate and bipolar/unipolar configuration.
> > > > >=20
> > > > > Datasheets:
> > > > > Link: http://www.analog.com/media/en/technical-documentation/data=
-s
> > > > > heet
> > > > > s/AD7124-4.pdf
> > > > > Link: http://www.analog.com/media/en/technical-documentation/data=
-s
> > > > > heet
> > > > > s/ad7124-8.pdf
> > > > >=20
> > > > > Signed-off-by: Stefan Popa <stefan.popa@analog.com> =20
> > > > Hi Stefan,
> > > >=20
> > > > The discussion around the DT binding has gotten me looking at bit
> > > > more closely at that for this version.
> > > >=20
> > > > Some most comments in that section.=C2=A0=C2=A0Also a really minor =
ordering
> > > > issue
> > > > in
> > > > remove which I'd just have fixed if we weren't going around again f=
or
> > > > the binding.
> > > >=20
> > > > Main binding thing is I don't think the odr value belongs in DT.
> > > > Gain is more marginal (unless the part can actually be damaged by
> > > > a wrong value - which I hope it can't!).=C2=A0=C2=A0I'm not that fu=
ssed
> > > > as there are definitely reasons to specify a default scale to
> > > > cover the reasonable range on a pin.
> > > >=20
> > > > Thanks,
> > > >=20
> > > > Jonathan =20
> > > Hi Jonathan,
> > >=20
> > > Thank you for the review! So, how should I proceed?
> > >=20
> > > First, we need an adc.txt file where "bipolar" and something like
> > > "diff-
> > > channels" should be documented. Should the file be placed under
> > > Documentation/devicetree/bindings/iio/adc? =20
> > Yes.
> >  =20
> > >=20
> > > Regarding the "odr-hz" property, it totally makes sense to remove it
> > > from
> > > the DT. How about the "gain"? Should we leave it in the DT and also a=
dd
> > > the
> > > possibility to be configured from user space? =20
> > Look at other bindings. I think there are others having gain. If not,
> > then it probably should only be user space configurable. If so, then
> > can it be a common property too.
> >=20
> > Rob
> >  =20
>=20
> Hi Rob,
>=20
> I found only a couple of examples using gain in other bindings, so I guess
> it's not common practice. I will remove the gain as well from the DT and
> set it with the default of 1.
>=20
> @Jonathan: I think that=C2=A0IIO_CHAN_INFO_HARDWAREGAIN is the attribute =
that
> can be used in user space?
Sorry, I missed this.  Guess you will see my review anyway around now.
Nope, hardwaregain is an oddity for devices where we aren't controlling
the thing being measured, but something like the amplifier of a
time of flight device.

There is some argument to potentially provide sane limits on gain in DT
(particularly if a device really doesn't like going out of range) but
in general I'm not keen on it as it is rather an application specific
question so best left to userspace.

Jonathan

>=20
> Thank you!
> -Stefan
