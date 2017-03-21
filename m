Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:31183 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755348AbdCURMy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 13:12:54 -0400
Date: Tue, 21 Mar 2017 18:09:44 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Alison Schofield <amsfield22@gmail.com>
cc: Julia Lawall <julia.lawall@lip6.fr>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        outreachy-kernel@googlegroups.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        lars@metafoo.de, Greg KH <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org,
        driverdevel <devel@driverdev.osuosl.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 0/2] IIO coding tasks
In-Reply-To: <20170321170221.GB2793@d830.WORKGROUP>
Message-ID: <alpine.DEB.2.20.1703211808150.3785@hadrien>
References: <20170321133021.6737-1-arushisinghal19971997@gmail.com> <20170321160348.GA1859@d830.WORKGROUP> <CA+XqjF9dVy33Dsv0H2z8xtaNeMOW7SQgr4qa4wLwz6xFNVTsUA@mail.gmail.com> <alpine.DEB.2.20.1703211738500.3785@hadrien>
 <20170321170221.GB2793@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1513176482-1490116184=:3785"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--8323329-1513176482-1490116184=:3785
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 21 Mar 2017, Alison Schofield wrote:

> On Tue, Mar 21, 2017 at 05:39:38PM +0100, Julia Lawall wrote:
> >
> >
> > On Tue, 21 Mar 2017, Arushi Singhal wrote:
> >
> > > On Tue, Mar 21, 2017 at 9:33 PM, Alison Schofield <amsfield22@gmail.com>
> > > wrote:
> > >       On Tue, Mar 21, 2017 at 07:00:17PM +0530, Arushi Singhal wrote:
> > >       > Patchseries of IIO coding tasks
> > >
> > >       This wouldn't be a patchset.  Although they touch the same
> > >       driver, the changes are unrelated.  See more below...
> > >
> > > This I have send as a Patchset because as you have mentioned below that the
> > > [PATCH 2/2] was already done before by someone but I think so it is not yet
> > > applied in the Greg's tree yet.So I have done both the changes and as they
> > > should be applied one after other so that's why I have send them as
> > > Patchset.
> >
> > For the IIO patches, it is better to work on the IIO tree, not Greg's.
> > Greg manages staging, not IIO.  The IIO patches should appear in Greg's
> > tree eventually.
> >
> > julia
>
> We didn't direct applicants to create an iio tree.  At this point,
> it seems more than is necessary.  They can follow the directions in the
> task descriptions and avoid the collisions.

I meant just pull from the IIO tree you mentioned, work on that, submit
patches, and then expect to see the patches show up there at some time in
the future.

If someone make IIO patches on Greg's tree, then they will have an out of
date view.

julia

>
> Of course, they are welcome to create a tree to iio/testing.
>
> (IMHO it's more overhead/busy work and maybe not the best use
> of time in the home stretch of the application period.)
>
> alisons
> >
> > >       >
> > >       > Arushi Singhal (2):
> > >       >   staging: ad7759: Replace mlock with driver private lock
> > >
> > >       This one is already been submitted.  If you have a v2 for it,
> > >       then v2
> > >       the original patch.
> > >
> > > Is it submitted by me only before? And this is not the v2.
> > > I have just resed it.
> > >       >   staging: iio: ade7759: Move header content to implementation
> > >       file
> > >
> > >       This patch is done and applied already.  See the Coding Task #1
> > >       notes
> > >       in the IIO Tasks page.
> > >
> > > Not at applied I think so.
> > > Thanks
> > > Arushi
> > >
> > >       alisons
> > >
> > >       >
> > >       >  drivers/staging/iio/meter/ade7759.c   | 56
> > >       +++++++++++++++++++++++++++++++++--
> > >       >  drivers/staging/iio/meter/ade7759.h   | 53
> > >       ---------------------------------
> > >       >  2 files changed, 54 insertions(+), 57 deletions(-)
> > >       >
> > >       > --
> > >       > 2.11.0
> > >       >
> > > > --
> > > > You received this message because you are subscribed to the Google
> > > Groups "outreachy-kernel" group.
> > > > To unsubscribe from this group and stop receiving emails from it,
> > > send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > > To post to this group, send email to
> > > outreachy-kernel@googlegroups.com.
> > > > To view this discussion on the web visithttps://groups.google.com/d/msgid/outreachy-kernel/20170321133021.6737-1-ar
> > > ushisinghal19971997%40gmail.com.
> > > > For more options, visit https://groups.google.com/d/optout.
> > >
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups
> > > "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an
> > > email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > > To view this discussion on the web visithttps://groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF9dVy33Dsv0H2z8x
> > > taNeMOW7SQgr4qa4wLwz6xFNVTsUA%40mail.gmail.com.
> > > For more options, visit https://groups.google.com/d/optout.
> > >
> > >
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170321170221.GB2793%40d830.WORKGROUP.
> For more options, visit https://groups.google.com/d/optout.
>
--8323329-1513176482-1490116184=:3785--
