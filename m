Return-Path: <SRS0=1Uck=2O=lip6.fr=julia.lawall@kernel.org>
Date: Sun, 5 Mar 2017 21:56:22 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
cc: Alison Schofield <amsfield22@gmail.com>, lars@metafoo.de,
    Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
    pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
    outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 0/2] staging: iio: accel: Group similar
 macros into enums
In-Reply-To: <20170305194845.GA27902@nati-X550JK>
Message-ID: <alpine.DEB.2.20.1703052154590.2074@hadrien>
References: <cover.1488730643.git.narcisaanamaria12@gmail.com> <20170305185828.GA3380@d830.WORKGROUP> <20170305191459.GA20822@nati-X550JK> <alpine.DEB.2.20.1703052017040.3052@hadrien> <20170305192840.GA12508@nati-X550JK> <alpine.DEB.2.20.1703052031200.3052@hadrien>
 <20170305194845.GA27902@nati-X550JK>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Sun, 5 Mar 2017, Narcisa Ana Maria Vasile wrote:

> On Sun, Mar 05, 2017 at 08:31:42PM +0100, Julia Lawall wrote:
> >
> >
> > On Sun, 5 Mar 2017, Narcisa Ana Maria Vasile wrote:
> >
> > > On Sun, Mar 05, 2017 at 08:17:45PM +0100, Julia Lawall wrote:
> > > >
> > > >
> > > > On Sun, 5 Mar 2017, Narcisa Ana Maria Vasile wrote:
> > > >
> > > > > On Sun, Mar 05, 2017 at 10:58:29AM -0800, Alison Schofield wrote:
> > > > > > On Sun, Mar 05, 2017 at 06:26:03PM +0200, Narcisa Ana Maria Vasile wrote:
> > > > > > > Group related macros into enums, for clarity.
> > > > > >
> > > > > > Hi Narcisa,
> > > > > >
> > > > > > Is this enum then used in a type declaration?
> > > > > >
> > > > > > BTW - I can see Jonathan is following right along and sweeping these up,
> > > > > > but for future reference, this patch depended on a previous patch sent hours
> > > > > > earlier, that was not yet in staging-testing.  When this happens, one option
> > > > > > is to give a note below the --- (as you would for version comments) stating the
> > > > > > dependency.  This way someone reviewing the patch doesn't simply reject
> > > > > > it as not applying to my tree.
> > > > > >
> > > > > > alisons
> > > > > >
> > > > >   Hi,
> > > > >
> > > > >   Do you mean whether there are any type declarations where I could
> > > > >   now replace the type with the enum type ? If so, I searched for
> > > > >   these type of situations, but didn't find any. If I missed one of
> > > > >   these cases, please let me know and I'll send a new patch.
> > > >
> > > > Typically the constant would be stored in something, compared to
> > > > something, etc.  Are these constants not used at all?
> > > >
> > > > julia
> > > >
> > > >
> > >   Yes, they are used, they are stored. I thought she was asking
> > >   if I encountered any situations like in adc/ad7280a.h file
> > >   where you could define an enum for conversion averaging
> > >   macros and replace the 'unsigned int' field in the
> > >   ad7280_platform_data with the enum type.
> >
> > If they are stored in something, I guess you could change the type of that
> > thing?
> >
> > julia
> >
>   The scan indexes(si) are given to macros such as:
>
>   #define ADIS_ACCEL_CHAN(mod, addr, si, info_sep, info_all, bits) \
>     ADIS_MOD_CHAN(IIO_ACCEL, mod, addr, si, info_sep, info_all, bits)
>
>   (defined in the linux/iio/imu/adis.h header).
>   which are used to initialize the adis162xx_channels[].

OK, if the values are going in the si argument, then they end up in the
scan_index field of the iio_chan_spec structure.  That structure is much
more general then your driver, so indeed, there seems to be no types that
can be improved.

julia

>
>   Since they are used like this, I don't see anything I can
>   replace/improve here.
>   Am I missing something?
>
>   Narcisa.
>
>
>
>
> > >
> > >   Narcisa
> > > > >
> > > > >   Thank you for the note about the patch dependencies. I was just about
> > > > >   to ask about this, cause I realized there might be a problem.
> > > > >   I'll keep in mind to make a note next time.
> > > > >
> > > > >   Narcisa
> > > > >
> > > > > > > Narcisa Ana Maria Vasile (2):
> > > > > > >   staging: iio: adis16209: Group similar macros into enums
> > > > > > >   staging: iio: adis16240: Group similar macros into enums
> > > > > > >
> > > > > > >  drivers/staging/iio/accel/adis16209.c | 18 ++++++++++--------
> > > > > > >  drivers/staging/iio/accel/adis16240.c | 14 ++++++++------
> > > > > > >  2 files changed, 18 insertions(+), 14 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 1.9.1
> > > > > > >
> > > > > > > --
> > > > > > > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > > > > > > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > > > > > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > > > > > > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/cover.1488730643.git.narcisaanamaria12%40gmail.com.
> > > > > > > For more options, visit https://groups.google.com/d/optout.
> > > > >
> > > > > --
> > > > > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > > > > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > > > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > > > > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170305191459.GA20822%40nati-X550JK.
> > > > > For more options, visit https://groups.google.com/d/optout.
> > > > >
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170305192840.GA12508%40nati-X550JK.
> > > For more options, visit https://groups.google.com/d/optout.
> > >
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170305194845.GA27902%40nati-X550JK.
> For more options, visit https://groups.google.com/d/optout.
>
