Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1438047695-5248-1-git-send-email-jasaw@dius.com.au>
References: <1438047695-5248-1-git-send-email-jasaw@dius.com.au>
Date: Tue, 28 Jul 2015 11:16:16 +0300
Message-ID: <CAEnQRZCmTdDXX45D1FbE_kviwHp=Pc+P_8LByxtMgb0fy=Ty6Q@mail.gmail.com>
Subject: Re: [PATCH v2] tools: iio: iio_utils: remove unnecessary define guard
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Joo Aun Saw <jasaw@dius.com.au>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 28, 2015 at 4:41 AM, Joo Aun Saw <jasaw@dius.com.au> wrote:
> From: Joo Aun Saw <jasaw@dius.com.au>
>
> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
> ---
>  tools/iio/iio_utils.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 1dcdf03..e9fbaf8 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -6,9 +6,6 @@
>   * under the terms of the GNU General Public License version 2 as published by
>   * the Free Software Foundation.
>   */
> -#ifndef _IIO_UTILS_H
> -#define _IIO_UTILS_H
> -
>  #include <string.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> @@ -991,4 +988,3 @@ error_free:
>         return ret;
>  }
>
Please also remove the new line at the end of file now.

> -#endif /* _IIO_UTILS_H */
