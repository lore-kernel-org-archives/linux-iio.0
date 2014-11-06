Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1046 "EHLO
	smtp-out-023.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751624AbaKFPoo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Nov 2014 10:44:44 -0500
Message-ID: <545B976D.4080303@metafoo.de>
Date: Thu, 06 Nov 2014 16:44:45 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Fabien Proriol <Fabien.Proriol@jdsu.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] 0001-xilinx-xadc-core-Fix-voltage-offset.patch
References: <545B9479.5030700@jdsu.com>
In-Reply-To: <545B9479.5030700@jdsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/2014 04:33 PM, Fabien Proriol wrote:
>   From 3f57e39e3c69476513c00cd5ec45703f58334972 Mon Sep 17 00:00:00 2001
> From: Fabien Proriol <fabien.proriol@jdsu.com>
> Date: Tue, 4 Nov 2014 17:05:59 +0100
> Subject: [PATCH] xilinx-xadc-core: Fix voltage offset
>
> When xilinx-xadc is used with hwmon driver to read voltage, offset used
> for temperature is always apply.
> This patch change the return for IIO_CHAN_INFO_OFFSET to -EINVAL except
> for temperature to avoid offset.

I think we should rather fix iio_channel_read() to check if the channel 
supports the property that we try to read. Other drivers are likely to 
suffer from the same issue and fixing it in a central place fixes them all.

- Lars
