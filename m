Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44325 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932758AbcKWVcR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 16:32:17 -0500
Date: Wed, 23 Nov 2016 13:32:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: Jean Delvare <jdelvare@suse.de>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: acpi-als taking over from hwmon for light sensor support?
Message-ID: <20161123213215.GA22924@roeck-us.net>
References: <1479921689.16940.9.camel@hadess.net>
 <1479922686.5115.2.camel@chaos.suse>
 <1479935231.16940.11.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479935231.16940.11.camel@hadess.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 23, 2016 at 10:07:11PM +0100, Bastien Nocera wrote:
> On Wed, 2016-11-23 at 18:38 +0100, Jean Delvare wrote:
> > On mer., 2016-11-23 at 18:21 +0100, Bastien Nocera wrote:
> > > Hey,
> > > 
> > > I did some work on iio-sensor-proxy[1] those past couple of days, and
> > > tested it on a MacBook Pro.
> > > 
> > > Before that, I had written a (user-space) driver to access the hwmon
> > > driver's "light" value, so I was a bit surprised when I saw that iio-
> > > sensor-proxy was accessing the light sensor through acpi-als's IIO driver
> > > instead of through the hwmon driver.
> > > 
> > > I looked through the hwmon, iio and applesmc.c logs, and couldn't find any
> > > information about how the move from one to the other. Does anyone know?
> > > 
> > > I'm asking because the applesmc.c hwmon driver is the only one with
> > > support for the "light" property, and if that's not used anymore, I might
> > > as well remove that code now (or schedule to remove it).
> > 
> > Light sensors are out of scope of hwmon, they have nothing to do with
> > hardware monitoring.
> 
> Why is there still code in applesmc.c to handle the "light" sysfs property
> then?
> 

Interesting question. Because no one bothered enough to remove it ? Because
other applications may still use it ? Because old apple hardware may not
support ACPI0008 ? There can be many reasons.

If the question is why it is there in the first place, please keep in mind that
the driver is quite old. "For historic reasons" may be the best answer to that
question.

> Also, this doesn't answer my question as to when this switch happened.  I
> don't care one way or the other, but knowing when the switch was made can
> allow me to prepare the hwmon driver in iio-sensor-proxy for removal.
> 
>From kernel perspective, it may have been more or less automatic with
the addition of acpi-als support to iio. Either case, isn't it up to
iio-sensor-proxy to decide which kernel ABI it wants to use ?

Guenter
