Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751122AbeETNz3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 09:55:29 -0400
Date: Sun, 20 May 2018 14:55:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools: iio: iio_generic_buffer: fix types to
 match
Message-ID: <20180520145524.092a1d5d@archlinux>
In-Reply-To: <20180518001446.15607-1-mkelly@xevo.com>
References: <20180518001446.15607-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 May 2018 17:14:45 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> Several types are mismatched and causing implicit conversions.  Fix them
> up so the types match.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
Whilst I find it hard to care much about these, there might be a possible
bug as a result, so fair enough to clean them up.

Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan
> ---
>  tools/iio/iio_generic_buffer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index f0c6f54a8b2f..aa765c11992b 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -334,7 +334,10 @@ int main(int argc, char **argv)
>  	unsigned long timedelay = 1000000;
>  	unsigned long buf_len = 128;
>  
> -	int ret, c, i, j, toread;
> +	ssize_t i;
> +	unsigned long j;
> +	unsigned long toread;
> +	int ret, c;
>  	int fp = -1;
>  
>  	int num_channels = 0;

