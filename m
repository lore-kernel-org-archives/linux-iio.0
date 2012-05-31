Return-Path: <ldewangan@nvidia.com>
Message-ID: <4FC732DF.7070509@nvidia.com>
Date: Thu, 31 May 2012 14:29:11 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Leed Aguilar <leed.aguilar@ti.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging:iio:magnetometer:ak8975: set power-down mode
 after reading fuse ROM data
References: <1338429137-27059-1-git-send-email-leed.aguilar@ti.com> <4FC71C06.6080403@kernel.org>
In-Reply-To: <4FC71C06.6080403@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On Thursday 31 May 2012 12:51 PM, Jonathan Cameron wrote:
> Sounds sensible, but I don't have one of these so cc'ing Laxman
>> Fuse ROM data access mode is the only mode which does not
>> transition to power-down mode automatically.
>>
>> As per the AK8975 data sheet, it is recomended to set the
>> power-down mode first before attempting to change into
>> another mode.

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

I verified from datasheet that this is correct change.

Thanks,
Laxman


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
