Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49494 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbaGGJBM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 7 Jul 2014 05:01:12 -0400
Message-ID: <53BA625B.9090901@kernel.org>
Date: Mon, 07 Jul 2014 10:03:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: kristina.martsenko@gmail.com
Subject: Re: [PATCH 5/7] iio: adis: Switch sampling frequency attr to core
 support.
References: <1403467186-26639-1-git-send-email-jic23@kernel.org> <1403467186-26639-6-git-send-email-jic23@kernel.org> <53B0305D.3030406@gmx.de> <53B12467.5080107@metafoo.de>
In-Reply-To: <53B12467.5080107@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/14 09:48, Lars-Peter Clausen wrote:
> On 06/29/2014 05:27 PM, Hartmut Knaack wrote:
>> Jonathan Cameron schrieb:
>>> By using the info_mask_shared_by_all element of the channel spec, acce
>>> to the sampling frequency becomes available to in kernel users of the
>>> driver.  It also shortens and simplifies the code.
>>>
>>> This particular conversion was made more complicated by the shared library
>>> and the fact that a number of the drivers do not actually have support for
>>> setting or reading the sampling frequency.  The hardware, in those cases
>>> investigated supports it. It's just never been implemented.
>>>
>>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
>
> Thanks.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

