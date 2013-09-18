Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-213.synserver.de ([212.40.185.213]:1397 "EHLO
	smtp-out-213.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3IRHVG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 03:21:06 -0400
Message-ID: <523954C0.5000500@metafoo.de>
Date: Wed, 18 Sep 2013 09:22:40 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: iio: adis16400 scan mask question
References: <alpine.DEB.2.01.1309172323201.9630@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1309172323201.9630@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/17/2013 11:29 PM, Peter Meerwald wrote:
> Hello,
> 
> why the following code in drivers/iio/imu/adis16400_core.c?
> 
> static const unsigned long adis16400_burst_scan_mask[] = {
> 	~0UL,
> 	0,
> };
> 
> [...]
> 
> if (!(st->variant->flags & ADIS16400_NO_BURST))
> 		indio_dev->available_scan_masks = adis16400_burst_scan_mask;
> 
> 
> isn't the all-1 scan mask the same as not applying any scan mask?

A scan mask where all bits are set means that sampling can only be done with
all channels enabled at once. Userspace can still only select a subset of
these channels and the kernel will take care of properly demuxing the stream.

- Lars
