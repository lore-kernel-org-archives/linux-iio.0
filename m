Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49462 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbaGGJAc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 7 Jul 2014 05:00:32 -0400
Message-ID: <53BA6233.4040407@kernel.org>
Date: Mon, 07 Jul 2014 10:02:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: kristina.martsenko@gmail.com
Subject: Re: [PATCH 7/7] iio: imu: adis16480 switch sampling frequency attr
 to core support
References: <1403467186-26639-1-git-send-email-jic23@kernel.org> <1403467186-26639-8-git-send-email-jic23@kernel.org> <53B034C6.8090805@gmx.de> <53B11C47.1070401@metafoo.de>
In-Reply-To: <53B11C47.1070401@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/14 09:13, Lars-Peter Clausen wrote:
> On 06/29/2014 05:46 PM, Hartmut Knaack wrote:
>> Jonathan Cameron schrieb:
>>> By using the info_mask_shared_by_all element of the channel spec, access
>>> to the sampling frequency becomes available to in kernel users of the
>>> driver.  It also shortens and simplifies the code.
>>>
>>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
>
> Sorry for the dealy. Thanks.
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
Applied to the togreg branch of iio.git

Thanks,

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

