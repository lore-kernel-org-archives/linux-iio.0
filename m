Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:55428 "EHLO mout02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235AbcGDM0k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 4 Jul 2016 08:26:40 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id BBD91209F7
	for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2016 14:23:33 +0200 (CEST)
Subject: Re: [PATCH v1] drivers:iio:accel:mma8452: removed unwanted return
 statements
To: Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"christoph.muellner@theobroma-systems.com"
	<christoph.muellner@theobroma-systems.com>
References: <KL1PR04MB12050202C107FB05AAB8EAEA80380@KL1PR04MB1205.apcprd04.prod.outlook.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <c6fa0795-b316-2b65-955a-7b0acb92e027@posteo.de>
Date: Mon, 4 Jul 2016 14:23:30 +0200
MIME-Version: 1.0
In-Reply-To: <KL1PR04MB12050202C107FB05AAB8EAEA80380@KL1PR04MB1205.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2016-07-04 um 13:15 schrieb Bijosh Thykkoottathil:
> Removed unwanted return statements from the function
> mma8452_set_freefall_mode.

You could've said "Don't unnecessarily save a return value.", but
whatever :) Thanks for your review!

> 
> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
Reviewed-by: Martin Kepplinger <martink@posteo.de>

> ---
>  drivers/iio/accel/mma8452.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index e225d3c..d4a6d44 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -518,11 +518,7 @@ static int mma8452_set_freefall_mode(struct mma8452_data *data, bool state)
>  		val |= MMA8452_FF_MT_CFG_OAE;
>  	}
>  
> -	val = mma8452_change_config(data, chip->ev_cfg, val);
> -	if (val)
> -		return val;
> -
> -	return 0;
> +	return mma8452_change_config(data, chip->ev_cfg, val);
>  }
>  
>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
> 

