Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:56302 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237AbbBPT1Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 16 Feb 2015 14:27:25 -0500
Date: Mon, 16 Feb 2015 20:27:22 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Irina Tirdea <irina.tirdea@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Adriana Reus <adriana.reus@intel.com>
Subject: Re: [PATCH 0/2] bmc150-accel driver optimizations
In-Reply-To: <1424110621-16571-1-git-send-email-irina.tirdea@intel.com>
Message-ID: <alpine.DEB.2.02.1502162026470.26763@pmeerw.net>
References: <1424110621-16571-1-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Adds optimization of i2c transactions in trigger handler and
> usage of available_scan_masks for bmc150-accel.

same comments as for kxcjk-1013, this changes the capabilities of the 
driver
 
> Irina Tirdea (2):
>   iio: accel: bmc150: use available_scan_masks
>   iio: accel: bmc150: optimize i2c transfers in trigger handler
> 
>  drivers/iio/accel/bmc150-accel.c | 49 +++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
