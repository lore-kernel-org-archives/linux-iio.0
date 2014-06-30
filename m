Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-004.synserver.de ([212.40.185.4]:1070 "EHLO
	smtp-out-003.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754859AbaF3Isk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jun 2014 04:48:40 -0400
Message-ID: <53B12467.5080107@metafoo.de>
Date: Mon, 30 Jun 2014 10:48:39 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: kristina.martsenko@gmail.com
Subject: Re: [PATCH 5/7] iio: adis: Switch sampling frequency attr to core
 support.
References: <1403467186-26639-1-git-send-email-jic23@kernel.org> <1403467186-26639-6-git-send-email-jic23@kernel.org> <53B0305D.3030406@gmx.de>
In-Reply-To: <53B0305D.3030406@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/29/2014 05:27 PM, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> By using the info_mask_shared_by_all element of the channel spec, acce
>> to the sampling frequency becomes available to in kernel users of the
>> driver.  It also shortens and simplifies the code.
>>
>> This particular conversion was made more complicated by the shared library
>> and the fact that a number of the drivers do not actually have support for
>> setting or reading the sampling frequency.  The hardware, in those cases
>> investigated supports it. It's just never been implemented.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

