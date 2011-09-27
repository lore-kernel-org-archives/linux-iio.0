Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E81AB82.3020202@cam.ac.uk>
Date: Tue, 27 Sep 2011 11:54:58 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, manuel.stahl@iis.fraunhofer.de,
 jonathan.kunkee@gmail.com, michael.hennerich@analog.com
Subject: Re: [PATCH 0/3 V2] staging:iio:Documentation via dummy driver
References: <1316534313-20212-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316534313-20212-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Anyone had a chance to look over this?
> Hi All,
> 
> This has v2 of the dummy driver introduction to start with,
> main changes are responses to Manuels review and a kernel doc
> fixes (as I remembered the format wrong whilst writing the
> original code - oops).
> 
> The second patch is somewhat evil in that it uses an additional
> helper module purely to fake event 'interupts'.  This is the best
> option I have come up with for how to write a 'standard' looking
> driver that will work without hardware.  It's hacky, but I don't
> really want to spend much time on it if it will simply work.
> 
> The code in the actual dummy driver is pretty simple and standard.
> Note I have glossed over having a top half to the interrupt as
> the evgen driver can't run one as currently stands.  We talked
> a while ago about a workaround for that in the core, but nothing
> is in place as yet.
> 
> The third patch puts basic example buffered support in place.
> I haven't provided a trigger because that would require either
> extending the nasty evgen module, or writing another.
> 
> Whilst it is decidely 'unusual' we do have a hardware free trigger
> in the iio-trig-sysfs.  I'd not advise people look at that one
> to get an idea of how a normal one works though.
> 
> So at the end of this, the weak point is the lack of an example
> trigger, but those vary so much anyway I inclined to tell people
> to look for a driver that happens to do roughly what their hardware
> needs and copy that!
> 
> What do people think?
> 
> I propose to drop the 3 files I moaned about the other day from
> the documentation directory in favour of a short description
> of what this driver does but only once this is in place.
> 
> Thanks,
> 
> Jonathan
> 
> p.s. found a few bugs in the test prog, so I'll send a series
> out cleaning those up soonish.
> 
> Jonathan Cameron (3):
>   staging:iio:Documentation Simple dummy driver to explain the basics
>   staging:iio:dummy Add event support + fake event generator
>   staging:iio:dummy Add buffered reading support
> 
>  drivers/staging/iio/Kconfig                   |   27 ++
>  drivers/staging/iio/Makefile                  |    7 +
>  drivers/staging/iio/iio_core.h                |    6 +-
>  drivers/staging/iio/iio_dummy_evgen.c         |  217 ++++++++++
>  drivers/staging/iio/iio_dummy_evgen.h         |    2 +
>  drivers/staging/iio/iio_simple_dummy.c        |  540 +++++++++++++++++++++++++
>  drivers/staging/iio/iio_simple_dummy.h        |  108 +++++
>  drivers/staging/iio/iio_simple_dummy_buffer.c |  206 ++++++++++
>  drivers/staging/iio/iio_simple_dummy_events.c |  190 +++++++++
>  9 files changed, 1300 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/staging/iio/iio_dummy_evgen.c
>  create mode 100644 drivers/staging/iio/iio_dummy_evgen.h
>  create mode 100644 drivers/staging/iio/iio_simple_dummy.c
>  create mode 100644 drivers/staging/iio/iio_simple_dummy.h
>  create mode 100644 drivers/staging/iio/iio_simple_dummy_buffer.c
>  create mode 100644 drivers/staging/iio/iio_simple_dummy_events.c
> 
