Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54273 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbcAIR16 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2016 12:27:58 -0500
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: light: acpi-als: Report data as processed rather than raw
Date: Sat, 9 Jan 2016 18:27:50 +0100
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, marxin.liska@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1452180105-9584-1-git-send-email-gabriele.mzt@gmail.com> <569135DC.2090400@kernel.org>
In-Reply-To: <569135DC.2090400@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201601091827.50571.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Saturday, January 09, 2016 at 05:31:24 PM, Jonathan Cameron wrote:
> On 07/01/16 15:21, Gabriele Mazzotta wrote:
> > As per the ACPI specification (Revision 5.0) [1], the data coming
> > from the sensor represent the ambient light illuminance reading
> > expressed in lux. Use IIO_CHAN_INFO_PROCESSED instead of
> > IIO_CHAN_INFO_RAW to signify that the data are pre-processed.
> > 
> > [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
> > 
> > Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> 
> Hm. Whilst it's a fix in a sense, the original didn't really 'break'
> the ABI so I worry a little that this change may break others.
> Irritating as it is, perhaps we should keep the _RAW and add _PROCESSED
> (which will then be exactly the same value).
> We'll also then need a comment in the code, that leaving the _RAW
> elements was for ABI compatibility.
> 
> What do others think?

I'm not an IIO guru, but this does sound sensible. Do you know if any userland
code which actually uses the ACPI ALS already ?

Best regards,
Marek Vasut
