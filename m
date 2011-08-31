Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:35013 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab1HaLHk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:07:40 -0400
Message-ID: <4E5E17EA.40907@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:15:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 09/12] iio: core: fix IIO_EVENT_CODE_EXTRACT_DIR definition
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-9-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-9-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
>
Gah and good spot. I'll merge that one down into the patch that introduced it
with appropriate comment.
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/sysfs.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
> index d98d12d..8de6a65 100644
> --- a/drivers/staging/iio/sysfs.h
> +++ b/drivers/staging/iio/sysfs.h
> @@ -146,7 +146,7 @@ enum iio_event_direction {
>  	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
>  
>  #define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
> -#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xFF)
> +#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 47) & 0xFF)
>  #define IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(mask) ((mask >> 32) & 0xFF)
>  
>  /* Event code number extraction depends on which type of event we have.

