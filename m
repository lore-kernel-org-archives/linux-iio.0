Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38691 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbG2E2b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 00:28:31 -0400
MIME-Version: 1.0
In-Reply-To: <1437364640-7470-1-git-send-email-mranostay@gmail.com>
References: <1437364640-7470-1-git-send-email-mranostay@gmail.com>
Date: Tue, 28 Jul 2015 21:28:30 -0700
Message-ID: <CAKzfze8tccxiWTcx4DWocdnm4M=W-5fToK-ABELW-JrdKtq-iA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] iio: light: add support for APDS9660 sensor
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Matt Ranostay <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan,

Does this solve the issues in v3 minus the apds9960_regfield_init() cleanup?


Thanks,

Matt

On Sun, Jul 19, 2015 at 8:57 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> This patchset adds support for the APDS9960 ALS + proximity + gesture
> sensor.
>
> Included support for the various adjustable settings and controls:
>  * Falling and rising ALS + proximity thresholds events
>  * Gain controls
>  * ALS time integration
>
> Changes from v3:
>  * Added interrupt client mode document reference in DT bindings
>  * Add missing dep for CONFIG_REGMAP_I2C in respective Kconfig
>  * Changed from iio_trigger_poll_chained() to irq_work queue
>  * Changed channel masks to prevent channels that can't be polled from
>    having sysfs entries
>  * Renamed regmap_field declarations with apds9660_* prefix
>  * Added available channel masks and removed unneeded buffer copy in
>    poll function
>  * Remove unneeded default regmap values in apds9960_reg_defaults
>  * Clear interrupts from ALS and proximity sensor seperately to avoid
>    race condition
>  * Changed max threshold values to a macro define, and prevent values
>    less than 0
>  * Avoid needlessly checking the APDS9960_REG_GFLVL value until we read
>    all the FIFO from the count value. Note this can save up to 32
>    superfluous i2c reads per gesture engine entry
>
> Matt Ranostay (2):
>   iio: light: DT binding docs for APDS9960 driver
>   iio: light: add APDS9960 ALS + promixity driver
>
>  .../ABI/testing/sysfs-bus-iio-light-apds9960       |    7 +
>  .../devicetree/bindings/iio/light/apds9960.txt     |   22 +
>  drivers/iio/light/Kconfig                          |   13 +
>  drivers/iio/light/Makefile                         |    1 +
>  drivers/iio/light/apds9960.c                       | 1191 ++++++++++++++++++++
>  5 files changed, 1234 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
>  create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
>  create mode 100644 drivers/iio/light/apds9960.c
>
> --
> 1.9.1
>
