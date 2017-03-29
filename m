Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:51727
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754661AbdC2MlB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 08:41:01 -0400
Date: Wed, 29 Mar 2017 14:40:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: simran singhal <singhalsimran0@gmail.com>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 4/4] iio: light: si1145: Replace
 ternary operator with min macro
In-Reply-To: <1490790791-5694-5-git-send-email-singhalsimran0@gmail.com>
Message-ID: <alpine.DEB.2.20.1703291440070.2989@hadrien>
References: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com> <1490790791-5694-5-git-send-email-singhalsimran0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Wed, 29 Mar 2017, simran singhal wrote:

> Use macro min() to get the minimum of two values for brevity and
> readability.
>
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> ---
>  drivers/iio/light/si1145.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 096034c..e7ad6fb 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -557,7 +557,7 @@ static int si1145_set_chlist(struct iio_dev *indio_dev, unsigned long scan_mask)
>  	data->scan_mask = scan_mask;
>  	ret = si1145_param_set(data, SI1145_PARAM_CHLIST, reg);
>
> -	return ret < 0 ? ret : 0;
> +	return min(ret, 0);

A similar change involving max was already rejected.  ret < 0 is a
standard way of detecting an error, so perhaps leaving that explicitly
present will be preferred.

julia

>  }
>
>  static int si1145_measure(struct iio_dev *indio_dev,
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1490790791-5694-5-git-send-email-singhalsimran0%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
