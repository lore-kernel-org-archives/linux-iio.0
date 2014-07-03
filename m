Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52304 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbaGCU4i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 3 Jul 2014 16:56:38 -0400
Message-ID: <53B5C406.3090802@kernel.org>
Date: Thu, 03 Jul 2014 21:58:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	linux-iio@vger.kernel.org
CC: spk.linux@gmail.com, Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 2/5] iio: ad5624r_spi: Remove redundant variable
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com> <1404369485-1903-2-git-send-email-sachin.kamat@samsung.com> <53B50519.5030903@metafoo.de>
In-Reply-To: <53B50519.5030903@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/14 08:24, Lars-Peter Clausen wrote:
> On 07/03/2014 08:38 AM, Sachin Kamat wrote:
>> By re-arranging the code, 'ret' can be removed from this
>> function.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Barry Song <21cnbao@gmail.com>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

