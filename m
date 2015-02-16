Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 16 Feb 2015 20:14:09 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Irina Tirdea <irina.tirdea@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
    Adriana Reus <adriana.reus@intel.com>
Subject: Re: [PATCH 0/2] kxcjk-1013 driver optimizations
In-Reply-To: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
Message-ID: <alpine.DEB.2.02.1502162011090.26763@pmeerw.net>
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Adds optimization of i2c transactions in trigger handler and
> usage of available_scan_masks for kxcjk-1013.

the 'optimization' changes the capabilities of the driver, reading 
individual channel is not possible anymore

> Adriana Reus (2):
>   iio: accel: kxcjk-1013: use available_scan_masks
>   iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler
> 
>  drivers/iio/accel/kxcjk-1013.c | 50 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
