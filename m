Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:54390 "EHLO
	ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267Ab0EYKFO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 May 2010 06:05:14 -0400
Message-ID: <4BFBA15D.2040607@cam.ac.uk>
Date: Tue, 25 May 2010 11:07:25 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: gregkh@suse.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio-utils: fix memory overflow for dynamically allocateded
 memory to hold filename
References: <1274780404-17963-1-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1274780404-17963-1-git-send-email-21cnbao@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/25/10 10:40, Barry Song wrote:
> Signed-off-by: Barry Song <21cnbao@gmail.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Thanks Barry!
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index a4555e6..014f668 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -62,9 +62,8 @@ inline int find_type_by_name(const char *name, const char *type)
>  					1) != 0) {
>  				filename = malloc(strlen(iio_dir)
>  						+ strlen(type)
> -						+ 1
>  						+ numstrlen
> -						+ 1);
> +						+ 6);
>  				if (filename == NULL)
>  					return -ENOMEM;
>  				sprintf(filename, "%s%s%d/name",

