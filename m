Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15182 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcDQRA0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 13:00:26 -0400
Message-ID: <5713BE7B.2030408@nvidia.com>
Date: Sun, 17 Apr 2016 22:18:59 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <corbet@lwn.net>,
	<knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: core: Add devm_ APIs for iio_channel_{get,release}
References: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com> <57137AD1.5030902@kernel.org>
In-Reply-To: <57137AD1.5030902@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Sunday 17 April 2016 05:30 PM, Jonathan Cameron wrote:
> On 06/04/16 11:31, Laxman Dewangan wrote:
>> Some of kernel driver uses the IIO framework to get the sensor
>> value via ADC or IIO HW driver. The client driver get iio channel
>> by iio_channel_get() and release it by calling iio_channel_release().
>>
>> Add resource managed version (devm_*) of these APIs so that if client
>> calls the devm_iio_channel_get() then it need not to release it explicitly,
>> it can be done by managed device framework when driver get un-binded.
>>
>> This reduces the code in error path and also need of .remove callback in
>> some cases.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Applied to the togreg branch of iio.git.
> I guess the thermal driver use case will hit a cycle or so behind this.
>

Thanks for applying this.

Yes, thermal driver will use this in future release. This is to avoid 
any syncup between subsystem.

