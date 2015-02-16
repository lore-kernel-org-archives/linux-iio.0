Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 16 Feb 2015 20:30:33 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Irina Tirdea <irina.tirdea@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
    Adriana Reus <adriana.reus@intel.com>
Subject: Re: [PATCH v2 0/2] bmg160 driver optimizations
In-Reply-To: <1424110450-16398-1-git-send-email-irina.tirdea@intel.com>
Message-ID: <alpine.DEB.2.02.1502162029540.26763@pmeerw.net>
References: <1424110450-16398-1-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Adds optimization of i2c transactions in trigger handler and
> usage of available_scan_masks for bmg160.

same concerns as with bmc150 and kxcjk-1013
 
> Changes in v2:
>  - fallback to i2c word transactions if i2c block transactions are not supported
>  - use available_scan_masks to let the iio core choose the values selected
> by the user instead of doing the check in the driver's interrupt handler
>  - check functionality for i2c byte and word read
> 
> Irina Tirdea (2):
>   iio: gyro: bmg160: use available_scan_masks
>   iio: gyro: bmg160: optimize i2c transfers in trigger handler
> 
>  drivers/iio/gyro/bmg160.c | 50 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
