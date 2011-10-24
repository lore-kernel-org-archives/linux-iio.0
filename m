Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:33011 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759Ab1JXL5A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 07:57:00 -0400
Message-ID: <4EA55294.6010105@cam.ac.uk>
Date: Mon, 24 Oct 2011 12:57:08 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:iio_utils.h: Add missing include
References: <1319457376-16397-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319457376-16397-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/11 12:56, Lars-Peter Clausen wrote:
> iio_utils.h uses opendir and friends which need dirent.h
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 75938b2..dbbad8a 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -13,6 +13,7 @@
>  #include <ctype.h>
>  #include <stdio.h>
>  #include <stdint.h>
> +#include <dirent.h>
>  
>  #define IIO_MAX_NAME_LENGTH 30
>  

