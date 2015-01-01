Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55771 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbAAMRM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:17:12 -0500
Message-ID: <54A53AC6.9050104@kernel.org>
Date: Thu, 01 Jan 2015 12:17:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Subject: Re: [PATCH 2/2] iio: amplifiers: ad8366: Use right order for type
 specification
References: <1419965144-3988-1-git-send-email-roberta.dobrescu@gmail.com> <1419965144-3988-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965144-3988-3-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/14 18:45, Roberta Dobrescu wrote:
> This patch fixes the following checkpatch.pl warning:
> WARNING: type 'char unsigned' should be specified in [[un]signed]
> [short|int|long|long long] order
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied.
> ---
>  drivers/iio/amplifiers/ad8366.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index fce25a0..c0d364e 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -31,7 +31,7 @@ struct ad8366_state {
>  };
>  
>  static int ad8366_write(struct iio_dev *indio_dev,
> -			unsigned char ch_a, char unsigned ch_b)
> +			unsigned char ch_a, unsigned char ch_b)
>  {
>  	struct ad8366_state *st = iio_priv(indio_dev);
>  	int ret;
> 

