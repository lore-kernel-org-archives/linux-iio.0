Return-Path: <SRS0=SxhN=26=lip6.fr=julia.lawall@kernel.org>
Date: Tue, 21 Mar 2017 18:27:02 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: Alison Schofield <amsfield22@gmail.com>,
    Julia Lawall <julia.lawall@lip6.fr>, Jonathan Cameron <jic23@kernel.org>,
    Hartmut Knaack <knaack.h@gmx.de>, outreachy-kernel@googlegroups.com,
    Michael Hennerich <Michael.Hennerich@analog.com>, lars@metafoo.de,
    Greg KH <gregkh@linuxfoundation.org>, speakup@linux-speakup.org,
    driverdevel <devel@driverdev.osuosl.org>, linux-kernel@vger.kernel.org,
    Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 0/2] IIO coding tasks
In-Reply-To: <CA+XqjF8Lsjf_55z+KdsWTxdGubG5PO1PYOY_N4wZDNrSNEBYBg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703211826110.3785@hadrien>
References: <20170321133021.6737-1-arushisinghal19971997@gmail.com> <20170321160348.GA1859@d830.WORKGROUP> <CA+XqjF9dVy33Dsv0H2z8xtaNeMOW7SQgr4qa4wLwz6xFNVTsUA@mail.gmail.com> <alpine.DEB.2.20.1703211738500.3785@hadrien> <20170321170221.GB2793@d830.WORKGROUP>
 <CA+XqjF8Lsjf_55z+KdsWTxdGubG5PO1PYOY_N4wZDNrSNEBYBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2074316742-1490117222=:3785"
List-ID: <linux-iio@vger.kernel.org>

--8323329-2074316742-1490117222=:3785
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 21 Mar 2017, Arushi Singhal wrote:

>
>
> On Tue, Mar 21, 2017 at 10:32 PM, Alison Schofield <amsfield22@gmail.com>
> wrote:
>       On Tue, Mar 21, 2017 at 05:39:38PM +0100, Julia Lawall wrote:
>       >
>       >
>       > On Tue, 21 Mar 2017, Arushi Singhal wrote:
>       >
>       > > On Tue, Mar 21, 2017 at 9:33 PM, Alison Schofield
>       <amsfield22@gmail.com>
>       > > wrote:
>       > >       On Tue, Mar 21, 2017 at 07:00:17PM +0530, Arushi
>       Singhal wrote:
>       > >       > Patchseries of IIO coding tasks
>       > >
>       > >       This wouldn't be a patchset.  Although they touch the
>       same
>       > >       driver, the changes are unrelated.  See more below...
>       > >
>       > > This I have send as a Patchset because as you have mentioned
>       below that the
>       > > [PATCH 2/2] was already done before by someone but I think
>       so it is not yet
>       > > applied in the Greg's tree yet.So I have done both the
>       changes and as they
>       > > should be applied one after other so that's why I have send
>       them as
>       > > Patchset.
>       >
>       > For the IIO patches, it is better to work on the IIO tree, not
>       Greg's.
>       > Greg manages staging, not IIO.  The IIO patches should appear
>       in Greg's
>       > tree eventually.
>       >
>       > julia
>
>       We didn't direct applicants to create an iio tree.  At this
>       point,
>       it seems more than is necessary.  They can follow the directions
>       in the
>       task descriptions and avoid the collisions.
>
>       Of course, they are welcome to create a tree to iio/testing.
>
>       (IMHO it's more overhead/busy work and maybe not the best use
>       of time in the home stretch of the application period.)
>
>       alisons
>
>
> Hi Alison
> As you have mentioned that my [PATCH 2/2] is already being done someone. So
> how can I make the changes of [PATCH 1/2] on top of it as [PATCH 2/2] is not
> yet applied on the staging tree.

Make a patch that applies to the current state of the IIO tree.  Just
clone that one like you cloned the staging one.

julia

> Please suggest me.
> Thanks
> Arushi
>       >
>       > >       >
>       > >       > Arushi Singhal (2):
>       > >       >   staging: ad7759: Replace mlock with driver private
>       lock
>       > >
>       > >       This one is already been submitted.  If you have a v2
>       for it,
>       > >       then v2
>       > >       the original patch.
>       > >
>       > > Is it submitted by me only before? And this is not the v2.
>       > > I have just resed it.
>       > >       >   staging: iio: ade7759: Move header content to
>       implementation
>       > >       file
>       > >
>       > >       This patch is done and applied already.  See the
>       Coding Task #1
>       > >       notes
>       > >       in the IIO Tasks page.
>       > >
>       > > Not at applied I think so.
>       > > Thanks
>       > > Arushi
>       > >
>       > >       alisons
>       > >
>       > >       >
>       > >       >  drivers/staging/iio/meter/ade7759.c   | 56
>       > >       +++++++++++++++++++++++++++++++++--
>       > >       >  drivers/staging/iio/meter/ade7759.h   | 53
>       > >       ---------------------------------
>       > >       >  2 files changed, 54 insertions(+), 57 deletions(-)
>       > >       >
>       > >       > --
>       > >       > 2.11.0
>       > >       >
>       > > > --
>       > > > You received this message because you are subscribed to
>       the Google
>       > > Groups "outreachy-kernel" group.
>       > > > To unsubscribe from this group and stop receiving emails
>       from it,
>       > > send an email to
>       outreachy-kernel+unsubscribe@googlegroups.com.
>       > > > To post to this group, send email to
>       > > outreachy-kernel@googlegroups.com.
>       > > > To view this discussion on the webvisithttps://groups.google.com/d/msgid/outreachy-kernel/20170321133021.6737
>       -1-ar
>       > > ushisinghal19971997%40gmail.com.
>       > > > For more options, visit
>       https://groups.google.com/d/optout.
>       > >
>       > >
>       > > --
>       > > You received this message because you are subscribed to the
>       Google Groups
>       > > "outreachy-kernel" group.
>       > > To unsubscribe from this group and stop receiving emails
>       from it, send an
>       > > email to outreachy-kernel+unsubscribe@googlegroups.com.
>       > > To post to this group, send email to
>       outreachy-kernel@googlegroups.com.
>       > > To view this discussion on the webvisithttps://groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF9dVy33Dsv0
>       H2z8x
>       > > taNeMOW7SQgr4qa4wLwz6xFNVTsUA%40mail.gmail.com.
>       > > For more options, visit https://groups.google.com/d/optout.
>       > >
>       > >
>
>
>
>
--8323329-2074316742-1490117222=:3785--
