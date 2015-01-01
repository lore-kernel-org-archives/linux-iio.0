Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:55154 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbbAANvU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 1 Jan 2015 08:51:20 -0500
Message-ID: <54A550CC.8030503@gmx.de>
Date: Thu, 01 Jan 2015 14:51:08 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 07/10] iio: imu: kmx61: Fix device initialization
 when setting trigger state
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com> <1419340953-23161-8-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-8-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel Baluta schrieb am 23.12.2014 um 14:22:
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/imu/kmx61.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 30825cf..5b5be2b 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -1057,8 +1057,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  		goto err_unlock;
>  	}
>  
> -
> -	if (data->acc_dready_trig == trig || data->motion_trig)
> +	if (data->acc_dready_trig == trig || data->motion_trig == trig)
>  		device = KMX61_ACC;
>  	else
>  		device = KMX61_MAG;
> 

