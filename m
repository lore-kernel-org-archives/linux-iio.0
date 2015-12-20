Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:48671 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbLTXhW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Dec 2015 18:37:22 -0500
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: Correctness of acpi-als channel mask
Date: Mon, 21 Dec 2015 00:33:32 +0100
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>,
	linux-iio@vger.kernel.org,
	Martin =?utf-8?q?Li=C5=A1ka?= <marxin.liska@gmail.com>
References: <CABFtUbQw0nH5LXf_+D5_mSBqEdAsKEbbLCmrD=VDfgosqcWq1w@mail.gmail.com> <5675813D.9040808@kernel.org>
In-Reply-To: <5675813D.9040808@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201512210033.32862.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Saturday, December 19, 2015 at 05:09:33 PM, Jonathan Cameron wrote:
> On 17/12/15 20:32, Gabriele Mazzotta wrote:
> > Hi,
> > 
> > I have a question regarding the acpi-als driver.
> > 
> > Currently acpi-als uses IIO_CHAN_INFO_RAW to report the data coming
> > from the sensor. However, as per the ACPI specification [1] (section
> > 9.2.2), these values represent the ambient light illuminance expressed
> > in lux. Wouldn't IIO_CHAN_INFO_PROCESSED be more appropriate in this
> > case as the data are in theory pre-processed by the firmware of the
> > platform?
> 
> Looks like it to me as well.  Cc'd Marek and Martin.

Gotta say, I haven't looked at ACPI for a while now. My impression is that these 
data are RAW and the system software can adjust them based on the values in _ALR
table. The result of that would be _PROCESSED I think. But I might be entirely 
wrong.

> > [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
> > 
> > Regards,
> > Gabriele
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best regards,
Marek Vasut
