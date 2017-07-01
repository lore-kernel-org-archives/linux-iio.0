Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbdGARkc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 13:40:32 -0400
Date: Sat, 1 Jul 2017 18:40:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gaurav Gupta <gauragup@cisco.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] iio: core: Fix mapping of iio channels to entry numbers
Message-ID: <20170701184028.0a2f9511@kernel.org>
In-Reply-To: <20170627164601.GA30866@sjc-ads-988.cisco.com>
References: <20170627164601.GA30866@sjc-ads-988.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 27 Jun 2017 09:46:01 -0700
Gaurav Gupta <gauragup@cisco.com> wrote:

> When adding maps to the list, they were added using list_add, which adds
> them in LIFO order. When parsing using iio_channel_get_all(), these
> elements are hence returned in reverse order. As a result, the iio_hwmon
> mapping maps the first entry to the last channel and so on.
> 
> Signed-off-by: Gaurav Gupta <gauragup@cisco.com>
Gah.  This is one of those nasty cases where I clearly messed up a
long time ago, but unfortunately it's become user space ABI.

So looking for general opinions on whether we can fix this one
or not.  I can't immediately think of a clean way to tidy this up.

So do we think people will notice if we fix this?

Jonathan
> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 7a13535..9b0715c 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -44,7 +44,7 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  		}
>  		mapi->map = &maps[i];
>  		mapi->indio_dev = indio_dev;
> -		list_add(&mapi->l, &iio_map_list);
> +		list_add_tail(&mapi->l, &iio_map_list);
>  		i++;
>  	}
>  error_ret:

