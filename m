Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45602 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbGSJY5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 05:24:57 -0400
Message-ID: <55AB6CE5.8050505@kernel.org>
Date: Sun, 19 Jul 2015 10:24:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	marex@denx.de, Jean Delvare <jdelvare@suse.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/2] iio: temperature: add mcp98xx driver support
References: <1437275053-16211-1-git-send-email-mranostay@gmail.com>
In-Reply-To: <1437275053-16211-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/15 04:04, Matt Ranostay wrote:
> This changeset adds driver support for the Microchip mcp98xx series of
> temperature sensors.
> 
> This includes temperature reading, and rising/falling threshold events.
Why an IIO driver?  These parts already look to be supported in hwmon by
the lm75 driver.  We need a pretty strong reason to contemplate having
support in both subsystems...
> 
> Matt Ranostay (2):
>   iio: temperature: DT binding doc for mcp98xx
>   iio: temperature: add support for mcp98xx sensors
> 
>  .../bindings/iio/temperature/mcp98xx.txt           |  22 +
>  drivers/iio/temperature/Kconfig                    |  10 +
>  drivers/iio/temperature/Makefile                   |   1 +
>  drivers/iio/temperature/mcp98xx.c                  | 588 +++++++++++++++++++++
>  4 files changed, 621 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/mcp98xx.txt
>  create mode 100644 drivers/iio/temperature/mcp98xx.c
> 

