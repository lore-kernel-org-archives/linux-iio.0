Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45101 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbcAXOtG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 09:49:06 -0500
Subject: Re: [PATCH] Staging: iio: adc: fix indent on break statement
To: Colin King <colin.king@canonical.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
References: <1453577590-12177-1-git-send-email-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A4E45D.5090900@kernel.org>
Date: Sun, 24 Jan 2016 14:49:01 +0000
MIME-Version: 1.0
In-Reply-To: <1453577590-12177-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/01/16 19:33, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Fix indent warning when building with gcc 6:
> drivers/staging/iio/adc/ad7192.c:239:4: warning: statement is indented
>   as if it were guarded by... [-Wmisleading-indentation]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 9221103..92f2b72 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -236,7 +236,7 @@ static int ad7192_setup(struct ad7192_state *st,
>  			st->mclk = pdata->ext_clk_hz;
>  		else
>  			st->mclk = AD7192_INT_FREQ_MHZ;
> -			break;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		goto out;
> 

