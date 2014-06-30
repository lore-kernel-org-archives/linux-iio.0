Return-Path: <lars@metafoo.de>
Message-ID: <53B11C56.5060808@metafoo.de>
Date: Mon, 30 Jun 2014 10:14:14 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
CC: kristina.martsenko@gmail.com
Subject: Re: [PATCH 6/7] iio: imu: adis16400 switch sampling frequency attr
 to core support.
References: <1403467186-26639-1-git-send-email-jic23@kernel.org> <1403467186-26639-7-git-send-email-jic23@kernel.org> <53B03275.9020805@gmx.de>
In-Reply-To: <53B03275.9020805@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/29/2014 05:36 PM, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> By using the info_mask_shared_by_all element of the channel spec, access
>> to the sampling frequency becomes available to in kernel users of the
>> driver.  It also shortens and simplifies the code.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>

Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
