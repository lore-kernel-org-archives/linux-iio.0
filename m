Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47681 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974Ab1FHOE1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2011 10:04:27 -0400
Message-ID: <4DEF834F.9010904@cam.ac.uk>
Date: Wed, 08 Jun 2011 15:12:31 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI
 ADC
References: <1307461550-11619-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1307461550-11619-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/11 16:45, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> New driver for AD7792/AD7793 3-Channel, Low Noise,
> Low Power, 16-/24-Bit Sigma-Delta ADC with On-Chip In-Amp
> and Reference.
> 
> The AD7792/AD7793 features a dual use data out ready DOUT/RDY output.
> In order to avoid contentions on the SPI bus, it's necessary to use
> spi bus locking. The DOUT/RDY output must also be wired to an
> interrupt capable GPIO.
> 
> In INDIO_RING_TRIGGERED mode, this driver may block its SPI bus segment
> for an extended period of time.
> 
> Changes since V1:
> 
> Use bool where applicable.
> Use data buffer that lives in their own cache line.
> Restructure ad7793_calibrate_all to use an array.
> Use msleep.
> Query REG_ID instead of doing a write/read This is a test.
> Add support for unipolar mode.
> Drop range attribute in favor of write scale.
> Add proper locking.
> Use new validate_trigger callbacks.
> Use IIO_IN_DIFF for differential channels.
> Change attribute naming.
> Use available_scan_masks.
> Some other miscellaneous cleanup (none functional changes).
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
