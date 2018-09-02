Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180823212436.17423-1-geert@linux-m68k.org> <20180825093055.2cee2159@archlinux>
 <20180902095916.6aa5e5f6@archlinux>
In-Reply-To: <20180902095916.6aa5e5f6@archlinux>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 2 Sep 2018 11:48:57 +0200
Message-ID: <CAMuHMdWY3cjDHOGzMoh9maYJRq_RwerLzD4=eFnsE6yz5CjEYw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: isl29501: Simplify code to kill compiler warning
To: jic23@jic23.retrosnub.co.uk
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	m.othacehe@gmail.com, Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Sun, Sep 2, 2018 at 10:59 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On Sat, 25 Aug 2018 09:30:55 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Thu, 23 Aug 2018 23:24:35 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > > With gcc 4.1.2:
> > >
> > >     drivers/iio/proximity/isl29501.c: In function =E2=80=98isl29501_r=
egister_write=E2=80=99:
> > >     drivers/iio/proximity/isl29501.c:235: warning: =E2=80=98msb=E2=80=
=99 may be used uninitialized in this function
> > >
> > > While this is a false positive, it can easily be avoided by removing =
the
> > > "msb" intermediate variable.
> > > Remove the "lsb" intermediate variable for consistency.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Looks sensible to me, but I'd obviously like to leave a little time for
> > Mathieu to comment as it's his driver.
> Long enough. I guess Mathieu is busy so I'll apply this (mostly before
> it goes so far back in my email that I loose it)
>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.  I thought about marking for stable
> to reduce noise but decided that compiler is old enough (and I've not
> seen it with GCC 8 IIRC) that I wouldn't bother.

Thanks!

> Basically I'm taking this on the merits of it being better code rather
> than the warning fix :)

JFTR: I only send patches for these warnings if they (a) fix a real bug, or=
 (b)
improve the code.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
