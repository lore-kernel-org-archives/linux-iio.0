Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56408 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbbGWJnR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 05:43:17 -0400
Message-ID: <1437644508.2863.3.camel@hadess.net>
Subject: Re: bmc150_accel i2c-BMA250E:00: Invalid chip f8
From: Bastien Nocera <hadess@hadess.net>
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 23 Jul 2015 11:41:48 +0200
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0A5588@irsmsx105.ger.corp.intel.com>
References: <1437590935.30706.106.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0A5588@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2015-07-23 at 09:37 +0000, Tirdea, Irina wrote:
> 
> > -----Original Message-----
> > From: linux-iio-owner@vger.kernel.org [mailto:
> > linux-iio-owner@vger.kernel.org] On Behalf Of Bastien Nocera
> > Sent: 22 July, 2015 21:49
> > To: linux-iio@vger.kernel.org
> > Subject: bmc150_accel i2c-BMA250E:00: Invalid chip f8
> > 
> > Hey,
> > 
> > Running kernel 4.0.8 on a WinBook TW100 tablet, I get the error 
> > message
> > in the subject line when loading the bmc150_accel driver.
> > 
> > The 2 items in udev about that device:
> > P: /devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:04/BMA250E:00
> > E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:04/BMA250E:00
> > E: MODALIAS=acpi:BMA250E:BMA250E:
> > E: SUBSYSTEM=acpi
> > 
> > and:
> > P: /devices/platform/80860F41:04/i2c-12/i2c-BMA250E:00
> > E: DEVPATH=/devices/platform/80860F41:04/i2c-12/i2c-BMA250E:00
> > E: MODALIAS=acpi:BMA250E:BMA250E:
> > E: SUBSYSTEM=i2c
> > 
> > And the DSDT for the device:
> > https://people.gnome.org/~hadess/Winbook%20TW100%20DSDT.dsl
> > 
> > Any ideas what I should try (apart from a more recent kernel, I'm 
> > onto
> > that...)
> 
> Hi Bastien,
> 
> Seems to me that the ACPI table declares you have BMA250E chip, but
> the hardware is actually BMA222E. Bosh accelerometer BMA250E has chip
> ID 0xF9 [1], while BMA222E has chip ID 0xF8 [2].

I gathered as much from reading the driver.

> These chips are very similar, except for the chip id and x/y/z 
> resolution.
> 
> You could try forcing the driver to use bma222e for your ACPI ID and 
> see
> if the values you get for acceleration are OK.

Will try that.
<snip>
> In case it works you probably need to modify your ACPI table.

But I won't do that. Windows works on the same system, and so should
Linux. I'm guessing that the Linux driver is more stringent than the
Windows one.

I'd do something like:
- ACPI ID just tells you which driver to load, not which variant it
actually is.
- Use the chip ID to see which variant of the chipset it is

I'll test that after identifying which of the variants it is.

Cheers

