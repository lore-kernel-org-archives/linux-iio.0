Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: [PATCH v9] iio: acpi: Add support for ACPI0008 Ambient Light Sensor
Date: Fri, 8 May 2015 23:36:57 +0200
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 knaack.h@gmx.de,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 marxin.liska@gmail.com,
 rui.zhang@intel.com,
 linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <1430569857-31386-1-git-send-email-gabriele.mzt@gmail.com> <6785300.EARed0uQ2B@xps13> <C630C763-9495-4863-835F-A84C36EADDFC@jic23.retrosnub.co.uk>
In-Reply-To: <C630C763-9495-4863-835F-A84C36EADDFC@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201505082336.57586.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Friday, May 08, 2015 at 11:34:35 PM, Jonathan Cameron wrote:
> On 8 May 2015 20:20:33 BST, Gabriele Mazzotta <gabriele.mzt@gmail.com> wrote:
> >On Friday 08 May 2015 10:58:29 Jonathan Cameron wrote:
> >> On 02/05/15 08:30, Gabriele Mazzotta wrote:
> >> > This driver adds the initial support for the ACPI Ambient Light
> >
> >Sensor
> >
> >> > as defined in Section 9.2 of the ACPI specification (Revision 5.0)
> >
> >[1].
> >
> >> > Sensors complying with the standard are exposed as ACPI devices
> >
> >with
> >
> >> > ACPI0008 as hardware ID and provide standard methods by which the
> >
> >OS
> >
> >> > can query properties of the ambient light environment the system is
> >> > currently operating in.
> >> > 
> >> > This driver currently allows only to get the current ambient light
> >> > illuminance reading through the _ALI method, but is ready to be
> >> > extended extended to handle _ALC, _ALT and _ALP as well.
> >> > 
> >> > [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
> >> > 
> >> > Signed-off-by: Martin Liska <marxin.liska@gmail.com>
> >> > Signed-off-by: Marek Vasut <marex@denx.de>
> >> > Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> >> > Cc: Zhang Rui <rui.zhang@intel.com>

Thank you guys for finally getting this mainline :)

Best regards,
Marek Vasut
