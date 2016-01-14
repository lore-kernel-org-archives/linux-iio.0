Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33682 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971AbcANQxs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jan 2016 11:53:48 -0500
Date: Thu, 14 Jan 2016 10:51:33 -0600
From: Michael Welling <mwelling@ieee.org>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, lucas.demarchi@intel.com,
	eibach@gdsys.de, linux@roeck-us.net
Subject: Re: [PATCH] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160114165133.GA20246@deathstar>
References: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 14, 2016 at 06:25:08PM +0200, Daniel Baluta wrote:
> The driver has sysfs readings with runtime PM support for power saving.
> It also offers buffer support that can be used together with IIO software
> triggers.
>

It should be noted that the hwmon driver subsystem has support for this device.

http://lxr.free-electrons.com/source/drivers/hwmon/ads1015.c

The driver could likely be removed if this is accepted into iio.
The hwmon subsystem has an iio wrapper driver.

http://lxr.free-electrons.com/source/drivers/hwmon/iio_hwmon.c

The only hurdle is adding support for the ads1115 before removing the other driver.

