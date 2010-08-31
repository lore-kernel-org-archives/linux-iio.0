Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C7D1CA3.5050403@cam.ac.uk>
Date: Tue, 31 Aug 2010 16:15:47 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, Barry.Song@analog.com, m_brugger@web.de,
 mensch0815@googlemail.com
Subject: Re: [PATCH 0/2] Adding support for adis16250/5 to adis16260 driver.
References: <1281535939-7190-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1281535939-7190-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Barry, Matthias,

Any comments on this?  It'll need rebasing anyway after Manuel's
clean up patches....

Jonathan
> These parts differ only subtly from those already supported and not at
> all in those elements that are currently touched.
> 
> Matthias' original driver supported some functionality not typically
> found in IIO drivers.  Although I'm not sure we want it to generally
> exist in drivers, Matthias needs to be able to specific in platform
> data (and then tell from userspace) the orientation of the sensors.
> The axis control will result in attributes with naming as if this
> were a multiaxis sensor (gyro_x_raw etc).  The negate parameter results
> in the relevant scale parameter being negated.
> 
> Other bits that are different from Matthias driver...
> a) irq is specified using spi_dev->irq and we don't use threaded
> interrupts.  They may cause us timing issues and I for one don't
> understanded the finer points of them as yet.
> b) we don't set the default frequency.  This is userspace controllable.
> c) datardy is handled by a trigger and we don't store a buffer of the
> data in driver.  If you want that use the iio buffering architecture.
> 
> This set will need Matthias and Barry to ack.  Once that's happen I'll
> send Greg a suggestion to remove the original driver.
> 
> For copyright notices, I've added one for Matthias on the plaform data
> header (given I lifted it form his patch)  The rest is minor tweaks
> to Barry's code so I have left those alone.
> 
> 
> Jonathan Cameron (2):
>   staging:iio:adis16260 add id table support
>   staging:iio:adis16260 add support for adis16250 and adis16255
> 
>  drivers/staging/iio/gyro/Kconfig                   |    7 +-
>  drivers/staging/iio/gyro/adis16260.h               |    4 +
>  drivers/staging/iio/gyro/adis16260_core.c          |  159 +++++++++++++++----
>  drivers/staging/iio/gyro/adis16260_platform_data.h |   19 +++
>  drivers/staging/iio/gyro/gyro.h                    |   18 +++
>  5 files changed, 170 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/staging/iio/gyro/adis16260_platform_data.h
> 
> 
