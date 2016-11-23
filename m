Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:53893 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755876AbcKWRZG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 12:25:06 -0500
Message-ID: <1479921689.16940.9.camel@hadess.net>
Subject: acpi-als taking over from hwmon for light sensor support?
From: Bastien Nocera <hadess@hadess.net>
To: linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Date: Wed, 23 Nov 2016 18:21:29 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey,

I did some work on iio-sensor-proxy[1] those past couple of days, and
tested it on a MacBook Pro.

Before that, I had written a (user-space) driver to access the hwmon
driver's "light" value, so I was a bit surprised when I saw that iio-
sensor-proxy was accessing the light sensor through acpi-als's IIO
driver instead of through the hwmon driver.

I looked through the hwmon, iio and applesmc.c logs, and couldn't find
any information about how the move from one to the other. Does anyone
know?

I'm asking because the applesmc.c hwmon driver is the only one with
support for the "light" property, and if that's not used anymore, I
might as well remove that code now (or schedule to remove it).

Cheers
