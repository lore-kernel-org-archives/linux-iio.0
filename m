Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54987 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbaEYLJU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 25 May 2014 07:09:20 -0400
Message-ID: <5381CFC6.6050307@kernel.org>
Date: Sun, 25 May 2014 12:11:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] fix format string msimatch in staging/iio/Documentation/iio_utils.h
References: <1400937951-31693-1-git-send-email-toralf.foerster@gmx.de>
In-Reply-To: <1400937951-31693-1-git-send-email-toralf.foerster@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/14 14:25, Toralf Förster wrote:
> spotted by cppcheck
>
> Signed-off-by: Toralf Förster <toralf.foerster@gmx.de>
Applied to the togreg branch of iio.git.

Thanks,
> ---
>   drivers/staging/iio/Documentation/iio_utils.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 2064839..a9cfc06 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -318,7 +318,7 @@ inline int build_channel_array(const char *device_dir,
>   				free(filename);
>   				goto error_close_dir;
>   			}
> -			fscanf(sysfsfp, "%u", &ret);
> +			fscanf(sysfsfp, "%i", &ret);
>   			if (ret == 1)
>   				(*counter)++;
>   			fclose(sysfsfp);
> @@ -350,7 +350,7 @@ inline int build_channel_array(const char *device_dir,
>   				ret = -errno;
>   				goto error_cleanup_array;
>   			}
> -			fscanf(sysfsfp, "%u", &current_enabled);
> +			fscanf(sysfsfp, "%i", &current_enabled);
>   			fclose(sysfsfp);
>
>   			if (!current_enabled) {
>

