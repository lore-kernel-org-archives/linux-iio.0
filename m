Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38271 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbJaJ3X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 05:29:23 -0400
Subject: Re: [PATCH] iio: lidar: return -EIO on invalid signal
To: Matt Ranostay <mranostay@gmail.com>
References: <1445814438-17163-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563489F0.3000301@kernel.org>
Date: Sat, 31 Oct 2015 09:29:20 +0000
MIME-Version: 1.0
In-Reply-To: <1445814438-17163-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/15 23:07, Matt Ranostay wrote:
> Returning zero from the measurment function has the side effect of
> corrupting the triggered buffer readings, better to use -EIO than a
> zero measurement reading.
When you say 'corrupting' what do you mean?  As far as I can quickly see
it will give a spurious 0 distance when it really means a long distance.
Is that what you are referring to?

Jonathan
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 961f9f99..359beac 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -130,10 +130,10 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>  		if (ret < 0)
>  			break;
>  
> -		/* return 0 since laser is likely pointed out of range */
> +		/* return -EIO since laser is likely pointed out of range */
>  		if (ret & LIDAR_REG_STATUS_INVALID) {
>  			*reg = 0;
> -			ret = 0;
> +			ret = -EIO;
>  			break;
>  		}
>  
> 

