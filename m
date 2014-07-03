Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51773 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbaGCUpm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 3 Jul 2014 16:45:42 -0400
Message-ID: <53B5C175.30502@kernel.org>
Date: Thu, 03 Jul 2014 21:47:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	linux-iio@vger.kernel.org
CC: spk.linux@gmail.com
Subject: Re: [PATCH 1/5] iio: adis16400: Remove unused variable
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com> <53B50509.4070103@metafoo.de>
In-Reply-To: <53B50509.4070103@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/14 08:23, Lars-Peter Clausen wrote:
> On 07/03/2014 08:38 AM, Sachin Kamat wrote:
>> 'rx' is not used in this function. Remove it.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
Applied to the togreg branch of iio.git

Thanks,

J

