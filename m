Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:47825 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab1BVPJR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2011 10:09:17 -0500
Message-ID: <4D63D1BA.9050309@cam.ac.uk>
Date: Tue, 22 Feb 2011 15:09:46 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: Documentation: iio_utils: Avoid double free()
References: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com> <1297781180-5071-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1297781180-5071-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/15/11 14:46, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> filename is used and freed later
oops.  Thanks for this. Should probably go to stable as well as into staging-next.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 4dc961c..3cf01a5 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -319,7 +319,6 @@ inline int build_channel_array(const char *device_dir,
>  			}
>  			fscanf(sysfsfp, "%u", &current->enabled);
>  			fclose(sysfsfp);
> -			free(filename);
>  			current->scale = 1.0;
>  			current->offset = 0;
>  			current->name = strndup(ent->d_name,

