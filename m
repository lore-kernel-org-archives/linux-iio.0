Return-Path: <SRS0=1l5d=2U=lip6.fr=julia.lawall@kernel.org>
Date: Sat, 11 Mar 2017 10:27:47 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: SIMRAN SINGHAL <singhalsimran0@gmail.com>
cc: Julia Lawall <julia.lawall@lip6.fr>, Lars-Peter Clausen <lars@metafoo.de>,
    Michael.Hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>,
    knaack.h@gmx.de, Greg KH <gregkh@linuxfoundation.org>,
    linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
    linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 00/10] staging: iio: Remove exceptional
 & on functions name
In-Reply-To: <CALrZqyODTiF+gdwwYnmL1W1oi-R0u2rM4c40jb5iWXFxJpfdJw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703111025390.2202@hadrien>
References: <1489203401-17518-1-git-send-email-singhalsimran0@gmail.com> <alpine.DEB.2.20.1703110741530.2202@hadrien> <CALrZqyODTiF+gdwwYnmL1W1oi-R0u2rM4c40jb5iWXFxJpfdJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Sat, 11 Mar 2017, SIMRAN SINGHAL wrote:

> On Sat, Mar 11, 2017 at 12:12 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Sat, 11 Mar 2017, simran singhal wrote:
> >
> >> This patch-series removes exceptional & on functions name.
> >
> > The semantic patch shown does nothing to check that the use of & is
> > exception in the given file.  It just removes all the & on function names.
> >
> yes, I used this semantic patch only for only finding the functions with &
> and then I find out this drivers and use semantic patch for removing &.

The commit message should be written with respect to what was actually
done, and not copied from a patch that actually did something else.  The
original semantic patch, that was probably only put in the cover letter,
actually checked if the file mostly used function pointers in a particular
way.

julia

>
> > julia
> >
> >>
> >> simran singhal (10):
> >>   staging: iio: ad7192: Remove exceptional & on function name
> >>   staging: iio: ad7780: Remove exceptional & on function name
> >>   staging: iio: cdc: ad7746: Remove exceptional & on function name
> >>   staging: iio: cdc: ad7152: Remove exceptional & on function name
> >>   staging: iio: adis16240: Remove exceptional & on function name
> >>   staging: iio: adis16201: Remove exceptional & on function name
> >>   staging: iio: adis16209: Remove exceptional & on function name
> >>   staging: iio: adis16203: Remove exceptional & on function name
> >>   staging: iio: resolver: Remove exceptional & on function name
> >>   staging: iio: gyro: Remove exceptional & on function name
> >>
> >>  drivers/staging/iio/accel/adis16201.c     |  4 ++--
> >>  drivers/staging/iio/accel/adis16203.c     |  4 ++--
> >>  drivers/staging/iio/accel/adis16209.c     |  4 ++--
> >>  drivers/staging/iio/accel/adis16240.c     |  4 ++--
> >>  drivers/staging/iio/adc/ad7192.c          | 12 ++++++------
> >>  drivers/staging/iio/adc/ad7780.c          |  2 +-
> >>  drivers/staging/iio/cdc/ad7152.c          |  6 +++---
> >>  drivers/staging/iio/cdc/ad7746.c          |  4 ++--
> >>  drivers/staging/iio/gyro/adis16060_core.c |  2 +-
> >>  drivers/staging/iio/resolver/ad2s1200.c   |  2 +-
> >>  drivers/staging/iio/resolver/ad2s90.c     |  2 +-
> >>  11 files changed, 23 insertions(+), 23 deletions(-)
> >>
> >> --
> >> 2.7.4
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> >> To post to this group, send email to outreachy-kernel@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1489203401-17518-1-git-send-email-singhalsimran0%40gmail.com.
> >> For more options, visit https://groups.google.com/d/optout.
> >>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CALrZqyODTiF%2BgdwwYnmL1W1oi-R0u2rM4c40jb5iWXFxJpfdJw%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
