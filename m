Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:38913 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752261AbcF1JE2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 05:04:28 -0400
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Phil Reid <preid@electromag.com.au>
Subject: multi-planar buffers
Message-ID: <595f2eb9-524d-2bb9-6e74-2cacc155a07c@electromag.com.au>
Date: Tue, 28 Jun 2016 17:04:24 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'm interested in multi-planar buffers for and ADC that does multiple parallel dma transactions.
Raised the question about 6 months ago and it was something for which Lars said support was needed at some point.
At the time he suggested that it was best implemented with the mmap support which still doesn't look to be upstream correct?

The mmap is also of interest to us due to the potential number of channels and high sample rates.
Is the work stalled on getting this into the kernel?

Could someone point me to where the latest mmap code is so I can look at integrating multi-planar buffers into it for our driver.

If there something I can do to help get the mmap code into the kernel as well I'm happy to have a go with a bit of guidance.

Thanks
Phil
