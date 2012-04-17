Return-Path: <srinidhi.kasagar@stericsson.com>
Date: Tue, 17 Apr 2012 12:17:56 +0530
From: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] staging: iio: add lsm303dlh magnetometer driver
Message-ID: <20120417064755.GA902@bnru02>
References: <1333971244-10684-1-git-send-email-srinidhi.kasagar@stericsson.com>
 <CAM=Q2csOWte=C3iDrqBsKxrb-Yg4Ne-1kS+79iCaMVua1iDUBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAM=Q2csOWte=C3iDrqBsKxrb-Yg4Ne-1kS+79iCaMVua1iDUBQ@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 17, 2012 at 08:29:36 +0200, Shubhrajyoti Datta wrote:
> Hi Srinidhi,
> 
> On Mon, Apr 9, 2012 at 5:04 PM, Srinidhi KASAGAR
> <srinidhi.kasagar@stericsson.com> wrote:
> > Add support for lsm303dlh magnetometer device.
> >
> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---

[...]

> > diff --git a/drivers/staging/iio/magnetometer/lsm303dlh.c b/drivers/staging/iio/magnetometer/lsm303dlh.c
> > new file mode 100644
> > index 0000000..4b23083
> > --- /dev/null
> > +++ b/drivers/staging/iio/magnetometer/lsm303dlh.c
> > @@ -0,0 +1,803 @@
> > +/*
> > + * Copyright (C) ST-Ericsson SA 2012
> > + * License Terms: GNU General Public License, version 2
> > + *
> > + * This code is mostly based on hmc5843 driver
> > + *
> 
> How different is it from the hmc5843 driver Can we add support in the
> hmc driver itself?
The device differs from hmc in many ways, for example, it has a higher
range upto +/- 8.1 gauss, and has separate gain controls for X/Y and Z.
Since both are different devices, with different capabilities, i don't
think we can merge them together.

The lsm303dlh datahsheet is available here
http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00260288.pdf

However this has been superseded with "lsm303dlhc" version, will add
support to this version too later, though they are trivial..
http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/DM00027543.pdf

srinidhi
