Return-Path: <ldewangan@nvidia.com>
Message-ID: <4FC7809F.9020902@nvidia.com>
Date: Thu, 31 May 2012 20:00:55 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Leed Aguilar <leed.aguilar@ti.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron
	<jic23@kernel.org>
Subject: Re: [PATCH] staging:iio:magnetometer:ak8975: remove 'mode' attribute
References: <1338470063-19227-1-git-send-email-leed.aguilar@ti.com>
In-Reply-To: <1338470063-19227-1-git-send-email-leed.aguilar@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On Thursday 31 May 2012 06:44 PM, Leed Aguilar wrote:
> The raw data reading process (ak8975_read_axis) sets the
> single measurement mode to take a sample and once the
> conversion is completed the device enters into power-down
> mode automatically, therefore there is no need to enable
> a flag for this to happen.
>
> Signed-off-by: Leed Aguilar<leed.aguilar@ti.com>
> Cc: Jonathan Cameron<jic23@kernel.org>
> Cc: Laxman Dewangan<ldewangan@nvidia.com>
> ---

Acked-by: Laxman Dewanagan <ldewangan@nvidia.com>


Looks good to me.

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
