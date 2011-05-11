Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:51031 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab1EKPuP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2011 11:50:15 -0400
Message-ID: <4DCA7DBB.5010602@cam.ac.uk>
Date: Wed, 11 May 2011 13:14:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/2] IIO-work: iio.h: add missing address in IIO_CHAN
References: <1305115119-8850-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305115119-8850-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/11/11 12:58, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> add missing address in IIO_CHAN
Yikes.

Thanks - will merge into the original patch.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/iio.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 92609ee..d9f2692 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -136,6 +136,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>  	  .extend_name = _name,						\
>  	  .channel = _chan,						\
>  	  .channel2 = _chan2,						\
> +	  .address = _address,						\
>  	  .info_mask = _inf_mask,					\
>  	  .scan_index = _si,						\
>  	  .scan_type = _stype,						\

