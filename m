Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeKICLR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Nov 2018 21:11:17 -0500
MIME-Version: 1.0
References: <1540831111-3040-1-git-send-email-stefan.popa@analog.com>
 <20181103121606.2fc461ec@archlinux> <1541687328.2091.2.camel@analog.com>
In-Reply-To: <1541687328.2091.2.camel@analog.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 8 Nov 2018 10:34:45 -0600
Message-ID: <CAL_Jsq+zc2RGWgkwXNk8qjJqjo+FpdPZUOOxd44mb8Cu7+EsaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Add ad7124 support
To: StefanSerban.Popa@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 8, 2018 at 9:02 AM Popa, Stefan Serban
<StefanSerban.Popa@analog.com> wrote:
>
> On Sb, 2018-11-03 at 12:16 +0000, Jonathan Cameron wrote:
> > On Mon, 29 Oct 2018 18:38:31 +0200
> > Stefan Popa <stefan.popa@analog.com> wrote:
> >
> > >
> > > The ad7124-4 and ad7124-8 are a family of 4 and 8 channel sigma-delta
> > > ADCs
> > > with 24-bit precision and reference.
> > >
> > > Three power modes are available which in turn affect the output data
> > > rate:
> > >  * Full power: 9.38 SPS to 19,200 SPS
> > >  * Mid power: 2.34 SPS to 4800 SPS
> > >  * Low power: 1.17 SPS to 2400 SPS
> > >
> > > The ad7124-4 can be configured to have four differential inputs, while
> > > ad7124-8 can have 8. Moreover, ad7124 also supports per channel
> > > configuration. Each configuration consists of gain, reference source,
> > > output data rate and bipolar/unipolar configuration.
> > >
> > > Datasheets:
> > > Link: http://www.analog.com/media/en/technical-documentation/data-sheet
> > > s/AD7124-4.pdf
> > > Link: http://www.analog.com/media/en/technical-documentation/data-sheet
> > > s/ad7124-8.pdf
> > >
> > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > Hi Stefan,
> >
> > The discussion around the DT binding has gotten me looking at bit
> > more closely at that for this version.
> >
> > Some most comments in that section.  Also a really minor ordering issue
> > in
> > remove which I'd just have fixed if we weren't going around again for
> > the binding.
> >
> > Main binding thing is I don't think the odr value belongs in DT.
> > Gain is more marginal (unless the part can actually be damaged by
> > a wrong value - which I hope it can't!).  I'm not that fussed
> > as there are definitely reasons to specify a default scale to
> > cover the reasonable range on a pin.
> >
> > Thanks,
> >
> > Jonathan
>
> Hi Jonathan,
>
> Thank you for the review! So, how should I proceed?
>
> First, we need an adc.txt file where "bipolar" and something like "diff-
> channels" should be documented. Should the file be placed under
> Documentation/devicetree/bindings/iio/adc?

Yes.

> Regarding the "odr-hz" property, it totally makes sense to remove it from
> the DT. How about the "gain"? Should we leave it in the DT and also add the
> possibility to be configured from user space?

Look at other bindings. I think there are others having gain. If not,
then it probably should only be user space configurable. If so, then
can it be a common property too.

Rob
