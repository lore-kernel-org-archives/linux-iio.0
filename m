Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-252.synserver.de ([212.40.185.252]:1076 "EHLO
	smtp-out-252.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbaF3IOx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jun 2014 04:14:53 -0400
Message-ID: <53B11C47.1070401@metafoo.de>
Date: Mon, 30 Jun 2014 10:13:59 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: kristina.martsenko@gmail.com
Subject: Re: [PATCH 7/7] iio: imu: adis16480 switch sampling frequency attr
 to core support
References: <1403467186-26639-1-git-send-email-jic23@kernel.org> <1403467186-26639-8-git-send-email-jic23@kernel.org> <53B034C6.8090805@gmx.de>
In-Reply-To: <53B034C6.8090805@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/29/2014 05:46 PM, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> By using the info_mask_shared_by_all element of the channel spec, access
>> to the sampling frequency becomes available to in kernel users of the
>> driver.  It also shortens and simplifies the code.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>

Sorry for the dealy. Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

