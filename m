Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35754 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcCERtT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 12:49:19 -0500
Date: Sat, 5 Mar 2016 20:49:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matt Ranostay <matt.ranostay@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: mpu6050: fix possible NULL dereferences
Message-ID: <20160305174907.GY5273@mwanda>
References: <1456975092-17992-1-git-send-email-matt.ranostay@intel.com>
 <56DB1AF8.6010907@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56DB1AF8.6010907@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 05, 2016 at 05:44:24PM +0000, Jonathan Cameron wrote:
> On 03/03/16 03:18, Matt Ranostay wrote:
> > Fix possible null dereferencing of i2c and spi driver data.
> Is there actually a way of making this happen?  Far as I know
> both i2c and spi should always provide an appropriate value...
> Is it the absence of a dt match table that is causing the issue?
> 

The original issue was a static checker warning of inconsistent NULL
checks.  I don't know if it can actually be NULL.

regards,
dan carpenter

