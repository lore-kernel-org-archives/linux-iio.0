Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60467 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbaCOPqt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Mar 2014 11:46:49 -0400
Message-ID: <53247623.2060808@kernel.org>
Date: Sat, 15 Mar 2014 15:47:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging:iio: Move ad799x driver out of staging
References: <1394447484-29334-1-git-send-email-lars@metafoo.de> <1394447484-29334-2-git-send-email-lars@metafoo.de> <531E3BE5.3090603@gmx.de>
In-Reply-To: <531E3BE5.3090603@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/14 22:25, Hartmut Knaack wrote:
> Lars-Peter Clausen schrieb:
>> The driver is now at a reasonable quality level. Move it out of staging.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   drivers/iio/adc/Kconfig                                     | 11 +++++++++++
>>   drivers/iio/adc/Makefile                                    |  1 +
>>   drivers/{staging/iio/adc/ad799x_core.c => iio/adc/ad799x.c} |  0
>>   drivers/staging/iio/adc/Kconfig                             | 11 -----------
>>   drivers/staging/iio/adc/Makefile                            |  3 ---
>>   5 files changed, 12 insertions(+), 14 deletions(-)
>>   rename drivers/{staging/iio/adc/ad799x_core.c => iio/adc/ad799x.c} (100%)
>>
>>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
>
Applied to the togreg branch of iio.git
As ever it'll go out first as testing for autobuilders to play football with
it.
