Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbeHSTeI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:34:08 -0400
Date: Sun, 19 Aug 2018 17:22:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: health: max30102: Mark expected switch
 fall-throughs
Message-ID: <20180819172204.29754098@archlinux>
In-Reply-To: <20180815162349.GA3458@embeddedor.com>
References: <20180815162349.GA3458@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 15 Aug 2018 11:23:49 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I placed the "fall through"
> annotation at the bottom of the case, which is what GCC is expecting
> to find.
> 
> Addresses-Coverity-ID: 1458342 ("Missing break in switch")
> Addresses-Coverity-ID: 1458345 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/health/max30102.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 15ccadc..3e29562 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -282,9 +282,11 @@ static int max30102_read_measurement(struct max30102_data *data,
>  	switch (measurements) {
>  	case 3:
>  		MAX30102_COPY_DATA(2);
> -	case 2: /* fall-through */
> +		/* fall through */
> +	case 2:
>  		MAX30102_COPY_DATA(1);
> -	case 1: /* fall-through */
> +		/* fall through */
> +	case 1:
>  		MAX30102_COPY_DATA(0);
>  		break;
>  	default:
