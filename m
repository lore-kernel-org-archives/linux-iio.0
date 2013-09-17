Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56827 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab3IQV3V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 17 Sep 2013 17:29:21 -0400
Date: Tue, 17 Sep 2013 23:29:20 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org
Subject: iio: adis16400 scan mask question
Message-ID: <alpine.DEB.2.01.1309172323201.9630@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

why the following code in drivers/iio/imu/adis16400_core.c?

static const unsigned long adis16400_burst_scan_mask[] = {
	~0UL,
	0,
};

[...]

if (!(st->variant->flags & ADIS16400_NO_BURST))
		indio_dev->available_scan_masks = adis16400_burst_scan_mask;


isn't the all-1 scan mask the same as not applying any scan mask?

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
