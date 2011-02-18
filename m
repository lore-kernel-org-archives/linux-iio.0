Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:59704 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1BRVWc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 18 Feb 2011 16:22:32 -0500
Date: Fri, 18 Feb 2011 13:21:26 -0800
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] Staging: IIO: ADC: New driver for
 AD7606/AD7606-6/AD7606-4
Message-ID: <20110218212126.GA23543@kroah.com>
References: <1297326484-6618-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297326484-6618-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 10, 2011 at 09:28:04AM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This patch adds support for the:
> AD7606/AD7606-6/AD7606-4 8/6/4-Channel Data Acquisition
> system (DAS) with 16-Bit, Bipolar, Simultaneous Sampling ADC.
> 
> Changes since V1:
> IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4: Apply review feedback
> 
> Rename sysfs node oversampling to oversampling_ratio.
> Kconfig: Add GPIOLIB dependency.
> Use range in mV to better match HWMON.
> Rename ad7606_check_oversampling.
> Fix various comments and style.
> Reorder is_visible cases.
> Use new gpio_request_one/array and friends.
> Drop check for SPI max_speed_hz.
> 
> Changes since V2:
> IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4: Apply review feedback
> 
> Documentation: specify unit
> Avoid raise condition in ad7606_scan_direct()
> Check return value of bus ops read_block()
> 
> Changes since V3:
> IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4: Add missing include file
> 
> Add linux/sched.h

It still fails to build here :(

drivers/staging/iio/adc/ad7606_spi.o: In function `init_module':
ad7606_spi.c:(.init.text+0x0): multiple definition of `init_module'
drivers/staging/iio/adc/ad7606_par.o:ad7606_par.c:(.init.text+0x0): first defined here
drivers/staging/iio/adc/ad7606_spi.o: In function `cleanup_module':
ad7606_spi.c:(.exit.text+0x0): multiple definition of `cleanup_module'
drivers/staging/iio/adc/ad7606_par.o:ad7606_par.c:(.exit.text+0x0): first defined here

You need to try your build options better...

thanks,

greg k-h
