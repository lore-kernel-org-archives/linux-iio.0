Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40003 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932907AbbHDJ6R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 05:58:17 -0400
Message-ID: <1438682293.22369.10.camel@hadess.net>
Subject: Re: [PATCH 2/2] iio:accel:bmc150-accel: Use the chip ID to detect
 sensor variant
From: Bastien Nocera <hadess@hadess.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Octavian Purdila <octavian.purdila@intel.com>
Date: Tue, 04 Aug 2015 11:58:13 +0200
In-Reply-To: <1438632544.17718.46.camel@spandruv-DESK3.jf.intel.com>
References: <1437664867.2863.13.camel@hadess.net>
	 <55BE50D5.30905@kernel.org>
	 <1438632544.17718.46.camel@spandruv-DESK3.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2015-08-03 at 13:09 -0700, Srinivas Pandruvada wrote:
> On Sun, 2015-08-02 at 18:18 +0100, Jonathan Cameron wrote:
> > On 23/07/15 16:21, Bastien Nocera wrote:
> > > Instead of using the I2C or ACPI ID to determine which variant of
> > > the chipset to use, determine that from the chip ID.
> > > 
> > > Under Windows, the same driver is used for those variants and, 
> > > despite
> > > incorrect ACPI data, it is able to load and operate the 
> > > accelerometer.
> > > 
> > > Fixes the accelerometer failing with:
> > > bmc150_accel i2c-BMA250E:00: Invalid chip f8
> > > on the WinBook TW100
> > > 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > I'll start by saying I hate that this change is necessary down
> > at the driver level.
> > 
> > Is there no way to catch it as an ACPI quirk? (I know next to 
> > nothing about
> > ACPI and a quick a google isn't pointing me in the right 
> > direction!)
> > Seems irritating that we have to deal with this but such is life I 
> > guess
> > (anyone want to take the bet that at some point the windows driver 
> > will break
> >  horribly as well for these machines?)
> > 
> > Anyhow, Srinivas, could you also take a look at this one.
> > 
> > I suppose I'll cope with the horribleness :)
> We have seen where manufactures replaces a part for some reason, 
> without
> modifying ACPI tables. So matching chip id makes sense logically. But
> even this is not fail proof. Some parts have same chip id with 
> different
> features (clones), in that case ACPI match makes more sense.
> There is a way to patch ACPI tables but that also need to be based on
> some DMI information.
> I am not aware of such issue with Bosch parts. So I think this would 
> be
> OK to use chip id here instead of acpi id here. But what about using
> this only when the current logic fails? In this way we can still have
> another entry in the table for clones, if required.

For clones which don't advertise the right chip ID, I'd just have a
separate quirk table, "use this chip ID for that hardware".

Seems simpler, and I'm happy to write that code when we encounter the
problem.
