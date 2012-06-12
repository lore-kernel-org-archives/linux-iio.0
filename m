Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57226 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab2FLKli (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jun 2012 06:41:38 -0400
Message-ID: <4FD71CDF.40401@cam.ac.uk>
Date: Tue, 12 Jun 2012 11:41:35 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: drop comment about 'real' channels
References: <1339494541-15018-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339494541-15018-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/12/2012 10:49 AM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
Quick response ;)
>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   include/linux/iio/types.h |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 1b073b1..d086736 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -11,7 +11,6 @@
>   #define _IIO_TYPES_H_
>
>   enum iio_chan_type {
> -	/* real channel types */
>   	IIO_VOLTAGE,
>   	IIO_CURRENT,
>   	IIO_POWER,

