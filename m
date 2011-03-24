Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:34930 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1CXRCx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2011 13:02:53 -0400
Message-ID: <4D8B7989.7020003@cam.ac.uk>
Date: Thu, 24 Mar 2011 17:04:09 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: ADC: New driver for the AD7880 / AD7781 24-bit Sigma-Delta
 ADC
References: <1300981937-8675-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1300981937-8675-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/24/11 15:52, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Changes since v1:
> 
> IIO: ADC: AD7780: Apply review feedback
> 
> Abort probe() with error in case platform_data is not present.
> Add comment explaining power down reset (PDRST) GPIO handling
> and dual function DOUT/RDY interrupt usage.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

...
