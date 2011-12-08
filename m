Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45376 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1LHUen (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2011 15:34:43 -0500
Message-ID: <4EE11F60.7030100@kernel.org>
Date: Thu, 08 Dec 2011 20:34:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:staging: Fix typo
References: <1323362702-2238-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1323362702-2238-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/2011 04:45 PM, Lars-Peter Clausen wrote:
> Fix a small typo in the iio_modifer enum.
lol. Clearly not one of our more heavily used elements.
Good to catch it though.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/types.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/types.h b/drivers/staging/iio/types.h
> index f1f5ca2..b7d2647 100644
> --- a/drivers/staging/iio/types.h
> +++ b/drivers/staging/iio/types.h
> @@ -35,7 +35,7 @@ enum iio_modifier {
>  	IIO_MOD_Y,
>  	IIO_MOD_Z,
>  	IIO_MOD_X_AND_Y,
> -	IIO_MOD_X_ANX_Z,
> +	IIO_MOD_X_AND_Z,
>  	IIO_MOD_Y_AND_Z,
>  	IIO_MOD_X_AND_Y_AND_Z,
>  	IIO_MOD_X_OR_Y,

