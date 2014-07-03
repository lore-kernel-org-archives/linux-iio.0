Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52319 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbaGCU5V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 3 Jul 2014 16:57:21 -0400
Message-ID: <53B5C432.3010907@kernel.org>
Date: Thu, 03 Jul 2014 21:59:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	linux-iio@vger.kernel.org
CC: spk.linux@gmail.com,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: [PATCH 3/5] iio: ad5504: Remove redundant variable
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com> <1404369485-1903-3-git-send-email-sachin.kamat@samsung.com> <53B50528.2080304@metafoo.de>
In-Reply-To: <53B50528.2080304@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/14 08:24, Lars-Peter Clausen wrote:
> On 07/03/2014 08:38 AM, Sachin Kamat wrote:
>> By re-arranging the code, 'ret' can be removed from this
>> function.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

