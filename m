Return-Path: <gabriele.mzt@gmail.com>
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, marxin.liska@gmail.com, marex@denx.de, rui.zhang@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: acpi: Add ACPI0008 Ambient Light Sensor
Date: Thu, 30 Apr 2015 21:14:26 +0200
Message-ID: <476808774.8mfOQFdoFi@xps13>
In-Reply-To: <CAEnQRZD1AcG0uPG=DMh+LwUWwKQ53y1gL8zE62=VhPDhqv70ew@mail.gmail.com>
References: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com> <CAEnQRZD1AcG0uPG=DMh+LwUWwKQ53y1gL8zE62=VhPDhqv70ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Thursday 30 April 2015 15:24:07 Daniel Baluta wrote:
> Hi Gabriele,
> 
> Please keep the version numbering from previous patches,
> I think this should be v8 :).

OK, I'll use v9 for the next submission.

> On Wed, Apr 29, 2015 at 2:27 PM, Gabriele Mazzotta
> <gabriele.mzt@gmail.com> wrote:
> > Add basic implementation of the ACPI0008 Ambient Light Sensor driver.
> > This driver currently supports only the ALI property, yet is ready to
> > be easily extended to handle ALC, ALT, ALP ones as well.
> 
> I would like this commit message to contain more info about ACPI0008 ALS, like
> this commit.
> 
> https://lwn.net/Articles/345648/
> 
> Also, would be nice to point readers to Chapter 9.2 from ACPI spec:
> 
> http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf

I will do it, I simply used the same message of the previous
submissions.


Thanks,
Gabriele
