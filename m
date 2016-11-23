Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44829 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932792AbcKWRiO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Nov 2016 12:38:14 -0500
Message-ID: <1479922686.5115.2.camel@chaos.suse>
Subject: Re: acpi-als taking over from hwmon for light sensor support?
From: Jean Delvare <jdelvare@suse.de>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Date: Wed, 23 Nov 2016 18:38:06 +0100
In-Reply-To: <1479921689.16940.9.camel@hadess.net>
References: <1479921689.16940.9.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On mer., 2016-11-23 at 18:21 +0100, Bastien Nocera wrote:
> Hey,
> 
> I did some work on iio-sensor-proxy[1] those past couple of days, and
> tested it on a MacBook Pro.
> 
> Before that, I had written a (user-space) driver to access the hwmon
> driver's "light" value, so I was a bit surprised when I saw that iio-
> sensor-proxy was accessing the light sensor through acpi-als's IIO
> driver instead of through the hwmon driver.
> 
> I looked through the hwmon, iio and applesmc.c logs, and couldn't find
> any information about how the move from one to the other. Does anyone
> know?
> 
> I'm asking because the applesmc.c hwmon driver is the only one with
> support for the "light" property, and if that's not used anymore, I
> might as well remove that code now (or schedule to remove it).

Light sensors are out of scope of hwmon, they have nothing to do with
hardware monitoring.

-- 
Jean Delvare
SUSE L3 Support

