Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:36038 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab0EXLnM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2010 07:43:12 -0400
Message-ID: <4BFA66D5.90009@cam.ac.uk>
Date: Mon, 24 May 2010 12:45:25 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: gregkh@suse.de, linux-iio@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org
Subject: Re: [PATCH v2] iio-utils: fix memory overflow fordynamically allocateded
 memory to hold filename
References: <1274695824-27090-1-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1274695824-27090-1-git-send-email-21cnbao@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/24/10 11:10, Barry Song wrote:
> Signed-off-by: Barry Song <21cnbao@gmail.com>
Nack - see below.
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index a4555e6..6411bf9 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -64,7 +64,8 @@ inline int find_type_by_name(const char *name, const char *type)
>  						+ strlen(type)
>  						+ 1
>  						+ numstrlen
> -						+ 1);
> +						+ 1
> +						+ IIO_MAX_NAME_LENGTH);
The filename in question will be something like
/sys/bus/iio/device0/name

IIO_MAX_NAME_LENGTH refers to the contents of that file, not the name of the file.

So, I agree there is a bug here, the right fix is to make that buffer the
length to take the string we write into it in:

sprintf(filename, "%s%s%d/name",
                  iio_dir,
                  type,
                  number);
So, strlen(iio_dir)+strlen(type)+numstrlen + 6;

(the 6 is from 5 for the /name and 1 for the trailing null character).

We could make life easiser and use asprintf to do the allocation at time
of usage, though that would make our usespace example non standard c
(those functions are a gnu extension according to the man page).

Good spot on the bug.  Thanks!

Jonathan
>  				if (filename == NULL)
>  					return -ENOMEM;
>  				sprintf(filename, "%s%s%d/name",

