Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60373 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab1HQPXA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 11:23:00 -0400
Message-ID: <4E4BDEBC.3090606@cam.ac.uk>
Date: Wed, 17 Aug 2011 16:31:08 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] IIO: ADC: New driver for AD7190/AD7192/AD7195 4 Channel
 SPI ADC
References: <1313593455-29706-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1313593455-29706-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/17/11 16:04, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> New driver for AD7190/AD7192/AD7195 4.8 kHz, Ultralow Noise, 24-Bit
> Sigma-Delta ADC with PGA
> 
> These devices features a dual use data out ready DOUT/RDY output.
> In order to avoid contentions on the SPI bus, it's necessary to use
> spi bus locking. The DOUT/RDY output must also be wired to an
> interrupt capable GPIO.
> 
> In INDIO_RING_TRIGGERED mode, this driver may block its SPI bus segment
> for an extended period of time.
> 
> Changes since V1:
> 
> Add missing documentation.
> Remove obsoleted include files.
> Fix typos and style issues.
> Fix buffer size.
> Split ad7192_show() into two functions.
> Avoid race condition add mutex.
> Abandon IIO_CHAN macro.
> Reorder elements in ad7192_platform_data.
> Remove driver bus type.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

No merge issues with what I've sent Greg so far so this one should
go in cleanly either before them or after. (all sorts of fun
later on though  - I'll pull it into iio-blue and fix up shortly.)

Thanks,

Jonathan
