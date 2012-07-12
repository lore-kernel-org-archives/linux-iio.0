Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45760 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882Ab2GLTYm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jul 2012 15:24:42 -0400
Message-ID: <4FFF2479.6000801@kernel.org>
Date: Thu, 12 Jul 2012 20:24:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH v5] iio: add adjd_s311 I2C digital color sensor driver
References: <1341955964-17975-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341955964-17975-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/10/2012 10:32 PM, Peter Meerwald wrote:
> sensor has 4 channels (10-bit each, R/G/B and clear), sensitivity
> and gain is controlled in the driver by ext_info integration_time
> and CHAN_INFO_HARDWAREGAIN
> 
> driver supports triggered buffer and IIO_CHAN_INFO_RAW to get the
> sensor data
> 
> v5: address comments by Jonathan Cameron
> * use macro for channel declaration
> * get timestamp right before measurement
> * cleanups
> 
> v4: address comments by Lars-Peter Clausen
> * make sure trigger handler is exited with iio_trigger_notify_done()
>   and IRQ_HANDLED
> * kfree()/kalloc() -> krealloc()
> 
> v3:
> * fix warnings
> 
> v2: address comments by Lars-Peter Clausen
> * buffer allocation now in update_scan_mode instead of in trigger
>   handler
> * simplify trigger code (assume active_scan_mask is not empty, use
>   for_each_set_bit, use iio_push_to_buffer)
> * reorder entry in Makefile and Kconfig
> * fix remove
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

merged to togreg branch and pull request sent.
