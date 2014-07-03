Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52391 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432AbaGCU7S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 3 Jul 2014 16:59:18 -0400
Message-ID: <53B5C4A7.70508@kernel.org>
Date: Thu, 03 Jul 2014 22:01:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	linux-iio@vger.kernel.org
CC: spk.linux@gmail.com, Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 5/5] iio: xilinx-xadc: Remove unused variable
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com> <1404369485-1903-5-git-send-email-sachin.kamat@samsung.com> <53B5056B.8070801@metafoo.de>
In-Reply-To: <53B5056B.8070801@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/14 08:25, Lars-Peter Clausen wrote:
> On 07/03/2014 08:38 AM, Sachin Kamat wrote:
>> 'offset’ is not used in the function. Remove it.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Lars-Peter Clauen <lars@metafoo.de>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
Applied to the togreg branch of iio.git

Thanks,

