Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:56975 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbbAANvq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 1 Jan 2015 08:51:46 -0500
Message-ID: <54A550E7.7040808@gmx.de>
Date: Thu, 01 Jan 2015 14:51:35 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 08/10] iio: imu: kmx61: Remove unnecessary REG_INS1 read
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com> <1419340953-23161-9-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-9-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel Baluta schrieb am 23.12.2014 um 14:22:
> Useful in the debugging phase, not needed now.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/imu/kmx61.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 5b5be2b..eb3900e 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -1196,8 +1196,6 @@ ack_intr:
>  	if (ret < 0)
>  		dev_err(&data->client->dev, "Error reading reg_inl\n");
>  
> -	ret = i2c_smbus_read_byte_data(data->client, KMX61_REG_INS1);
> -
>  	return IRQ_HANDLED;
>  }
>  
> 

