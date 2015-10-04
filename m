Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-225.synserver.de ([212.40.185.225]:1075 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751490AbbJDL5o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 07:57:44 -0400
Message-ID: <56111433.4090904@metafoo.de>
Date: Sun, 04 Oct 2015 13:57:39 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hugo Camboulive <hugo.camboulive@gmail.com>,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org
CC: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: fix comment block coding style issue
References: <1443897168-5591-1-git-send-email-hugo.camboulive@gmail.com>
In-Reply-To: <1443897168-5591-1-git-send-email-hugo.camboulive@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/2015 08:32 PM, Hugo Camboulive wrote:
> This patch to ad7746.c makes the comment block end with a */
> on a separate line.
> 
> Signed-off-by: Hugo Camboulive <hugo.camboulive@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 10fa372..8445ddd 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -531,7 +531,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  		/* CAPDAC Scale = 21pF_typ / 127
>  		 * CIN Scale = 8.192pF / 2^24
>  		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
> -		 * */
> +		 */

Looks good, but while you are at it please also fix the beginning of the
comment. Kernel style multi-line comments look like

/*
 * text
 * more text
 */

So the line with the /* should have any text.

Bonus points if you can also fix all other occurrences of this style error
in the same file.

- Lars

