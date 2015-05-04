Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34772 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbEDJWV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 05:22:21 -0400
Received: by wgso17 with SMTP id o17so143934553wgs.1
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2015 02:22:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430562582-27932-1-git-send-email-jic23@kernel.org>
References: <1430562582-27932-1-git-send-email-jic23@kernel.org>
Date: Mon, 4 May 2015 12:22:20 +0300
Message-ID: <CAEnQRZCcvM6OLqupJuBxYWQLyBbqNEP4qF7rFC+rxF9GZuhiyg@mail.gmail.com>
Subject: Re: [PATCH] iio:prox:sx9500 trivial simplification of return path in
 init function.
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 2, 2015 at 1:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> ---
>  drivers/iio/proximity/sx9500.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index f1e9d734b6b6..323de9510ba5 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -860,10 +860,8 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
>         }
>
>         ret = sx9500_init_compensation(indio_dev);
> -       if (ret < 0)
> -               return ret;
>
> -       return 0;
> +       return ret;
>  }

Or, better directly return sx9500_init_comp...

Daniel.
