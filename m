Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48115 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbcDPMbC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 08:31:02 -0400
Subject: Re: [PATCH 02/10] iio: inkern: add a missing space before if
To: Slawomir Stepien <sst@poczta.fm>, knaack.h@gmx.de,
	pmeerw@pmeerw.net
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
 <1460662602-2951-3-git-send-email-sst@poczta.fm>
Cc: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57123084.3050809@kernel.org>
Date: Sat, 16 Apr 2016 13:31:00 +0100
MIME-Version: 1.0
In-Reply-To: <1460662602-2951-3-git-send-email-sst@poczta.fm>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 20:36, Slawomir Stepien wrote:
> This fixes the error reported by checkpatch.pl:
> 
> ERROR: space required before the open parenthesis '('
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
This one is more clear cut!  Thanks for fixing it.

Applied to the togreg branch of iio.git - initially pushed out as testing etc etc.

Jonathan
> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 734a004..2fc7928 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -452,7 +452,7 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>  	if (val2 == NULL)
>  		val2 = &unused;
>  
> -	if(!iio_channel_has_info(chan->channel, info))
> +	if (!iio_channel_has_info(chan->channel, info))
>  		return -EINVAL;
>  
>  	if (chan->indio_dev->info->read_raw_multi) {
> 

