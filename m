Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48291 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbbGSPYd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 11:24:33 -0400
Date: Sun, 19 Jul 2015 08:24:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, marex@denx.de,
	Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 0/2] iio: temperature: add mcp98xx driver support
Message-ID: <20150719152429.GA3729@roeck-us.net>
References: <1437275053-16211-1-git-send-email-mranostay@gmail.com>
 <55AB6CE5.8050505@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55AB6CE5.8050505@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 19, 2015 at 10:24:53AM +0100, Jonathan Cameron wrote:
> On 19/07/15 04:04, Matt Ranostay wrote:
> > This changeset adds driver support for the Microchip mcp98xx series of
> > temperature sensors.
> > 

MCP98xx is pretty a pretty far reaching claim. This could also be MCP9804
or MCP9843, which are JC42 compatible sensor chips and supported by the jc42
driver. Does the new driver claim to support those as well ?

Guenter

> > This includes temperature reading, and rising/falling threshold events.
> Why an IIO driver?  These parts already look to be supported in hwmon by
> the lm75 driver.  We need a pretty strong reason to contemplate having
> support in both subsystems...
> > 
> > Matt Ranostay (2):
> >   iio: temperature: DT binding doc for mcp98xx
> >   iio: temperature: add support for mcp98xx sensors
> > 
> >  .../bindings/iio/temperature/mcp98xx.txt           |  22 +
> >  drivers/iio/temperature/Kconfig                    |  10 +
> >  drivers/iio/temperature/Makefile                   |   1 +
> >  drivers/iio/temperature/mcp98xx.c                  | 588 +++++++++++++++++++++
> >  4 files changed, 621 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/mcp98xx.txt
> >  create mode 100644 drivers/iio/temperature/mcp98xx.c
> > 
> 
