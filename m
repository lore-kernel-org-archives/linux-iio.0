Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55769 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab2FAIAy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jun 2012 04:00:54 -0400
Message-ID: <4FC876B2.7080501@kernel.org>
Date: Fri, 01 Jun 2012 09:00:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Laxman Dewangan <ldewangan@nvidia.com>
CC: Leed Aguilar <leed.aguilar@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging:iio:magnetometer:ak8975: remove 'mode' attribute
References: <1338470063-19227-1-git-send-email-leed.aguilar@ti.com> <4FC7809F.9020902@nvidia.com>
In-Reply-To: <4FC7809F.9020902@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/31/2012 3:30 PM, Laxman Dewangan wrote:
> On Thursday 31 May 2012 06:44 PM, Leed Aguilar wrote:
>> The raw data reading process (ak8975_read_axis) sets the
>> single measurement mode to take a sample and once the
>> conversion is completed the device enters into power-down
>> mode automatically, therefore there is no need to enable
>> a flag for this to happen.
>>
>> Signed-off-by: Leed Aguilar<leed.aguilar@ti.com>
>> Cc: Jonathan Cameron<jic23@kernel.org>
>> Cc: Laxman Dewangan<ldewangan@nvidia.com>
>> ---
>
> Acked-by: Laxman Dewanagan <ldewangan@nvidia.com>
Acked-by: Jonathan Cameron <jic23@kernel.org

Please send a copy with the acks to GregKH@linuxfoundation.org
>
>
> Looks good to me.
>
> ----------------------------------------------------------------------------------- 
>
> This email message is for the sole use of the intended recipient(s) 
> and may contain
> confidential information.  Any unauthorized review, use, disclosure or 
> distribution
> is prohibited.  If you are not the intended recipient, please contact 
> the sender by
> reply email and destroy all copies of the original message.
> ----------------------------------------------------------------------------------- 
>

