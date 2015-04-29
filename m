Return-Path: <gabriele.mzt@gmail.com>
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marxin.liska@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: acpi: Add ACPI0008 Ambient Light Sensor
Date: Wed, 29 Apr 2015 17:36:32 +0200
Message-ID: <1724765.vloEsYdA9s@xps13>
In-Reply-To: <201504291633.18558.marex@denx.de>
References: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com> <1625165.pchJQFHZZe@xps13> <201504291633.18558.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Wednesday 29 April 2015 16:33:18 Marek Vasut wrote:
> On Wednesday, April 29, 2015 at 01:51:21 PM, Gabriele Mazzotta wrote:
> > On Wednesday 29 April 2015 13:27:25 Gabriele Mazzotta wrote:
> > > Add basic implementation of the ACPI0008 Ambient Light Sensor driver.
> > > This driver currently supports only the ALI property, yet is ready to
> > > be easily extended to handle ALC, ALT, ALP ones as well.
> > > 
> > > Signed-off-by: Martin Liska <marxin.liska@gmail.com>
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > > This continues http://marc.info/?t=140163463200002
> > > 
> > > I've made few adjustments over the original patch:
> > >  - Code aligned with 4.1-rc1 and cleaned up
> > >  - Use signed integers to store values: sensors report 32bit signed
> > >  
> > >    values. In particular, -1 is reported when the current reading
> > >    is above the supported range of sensitivity.
> > > 
> > > Most of the changes are just a consequence of the changes in the
> > > iio subsystem.
> > > 
> > > Gabriele
> > 
> > I'm sorry, I've just noticed that I haven't changed the value of
> > realbits in acpi_als_channels. This makes me wonder what would be the
> > proper value, given that this is a generic driver and all the
> > information I have are those in the ACPI specification (which states
> > what I reported here above).
> > 
> > Should I just set realbits to 32?
> 
> I believe the ALS reports only 16bit signel value, no ?
> My observation with a strong coherent light source is that
> the saturated sensor reported 0xffff .

Probably it's the same for me. I couldn't get to the point where
ALI reports 0xffff, just really close, I will have to try with some
stronger lights. However, looking at my ACPI table, I can see that
the value returned by _ALI is just the composition of two 8 bits
variables put side by side, so yes, I can say that even on my system
it's a 16bit value.

The problem here is that I'm not sure we can assume this as true in
general since the ACPI specification doesn't say anything.

Gabriele

> Best regards,
> Marek Vasut
