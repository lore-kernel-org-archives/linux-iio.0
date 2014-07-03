Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52379 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432AbaGCU67 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 3 Jul 2014 16:58:59 -0400
Message-ID: <53B5C495.30803@kernel.org>
Date: Thu, 03 Jul 2014 22:01:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	linux-iio@vger.kernel.org
CC: spk.linux@gmail.com,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: [PATCH 4/5] iio: ad5686: Remove redundant variable
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com> <1404369485-1903-4-git-send-email-sachin.kamat@samsung.com> <53B50557.5010302@metafoo.de>
In-Reply-To: <53B50557.5010302@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/14 08:25, Lars-Peter Clausen wrote:
> On 07/03/2014 08:38 AM, Sachin Kamat wrote:
>> ‘regdone’ is not used in the function. Remove it.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
Applied to the togreg branch of iio.git

Thanks,
