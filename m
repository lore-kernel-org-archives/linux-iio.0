Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbdJNR3x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Oct 2017 13:29:53 -0400
Date: Sat, 14 Oct 2017 18:29:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Drop duplicate forward declaration
Message-ID: <20171014182950.41f1a61d@archlinux>
In-Reply-To: <e46d722561e1d2288ff8f421332c0499e38a2dcb.1507651877.git.lukas@wunner.de>
References: <e46d722561e1d2288ff8f421332c0499e38a2dcb.1507651877.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 10 Oct 2017 18:15:34 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> Commit 5f420b42079c ("staging:iio: Add extended IIO channel info") added
> a forward declaration for struct iio_dev to <linux/iio/iio.h> but forgot
> to remove an existing forward declaration further down originating from
> commit 7ae8cf627558 ("staging: iio: chrdev.h rationalization").
> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  include/linux/iio/iio.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 50cae85..20b6134 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -365,7 +365,6 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
>  #define INDIO_MAX_RAW_ELEMENTS		4
>  
>  struct iio_trigger; /* forward declaration */
> -struct iio_dev;
>  
>  /**
>   * struct iio_info - constant information about device

