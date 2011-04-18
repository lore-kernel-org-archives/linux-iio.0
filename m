Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:56956 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab1DRNe6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2011 09:34:58 -0400
Message-ID: <4DAC3E78.4060001@cam.ac.uk>
Date: Mon, 18 Apr 2011 14:36:56 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/2] IIO-onwards: ADC: AD7887: Convert to new channel
 registration method.
References: <1303131831-4010-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303131831-4010-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/18/11 14:03, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Convert to new channel registration method
> Update / change license copyright header
> Add missing call to iio_trigger_notify_done()
Looks good.  I wonder if it would make more sense to have the channel
definitions external to the chip_info structure (have a pointer and size
parameter in there.)  That would allow the driver to handle devices with
different numbers of channels.  Right now it's irrelevant though and can
be easily enough fixed when/if it becomes an issue.

Thanks,

Will slot this one into relevant spot in iio-onwards.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad7887.h      |   14 ++--
>  drivers/staging/iio/adc/ad7887_core.c |  123 ++++++++++++++-------------------
>  drivers/staging/iio/adc/ad7887_ring.c |   71 +++-----------------
>  3 files changed, 69 insertions(+), 139 deletions(-)
