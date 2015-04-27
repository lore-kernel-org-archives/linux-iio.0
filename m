Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9591 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbD0QD7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2015 12:03:59 -0400
Message-ID: <553E5DEE.5020001@nvidia.com>
Date: Mon, 27 Apr 2015 12:03:58 -0400
From: Rhyland Klein <rklein@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	<linux-iio@vger.kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<daniel.baluta@intel.com>
Subject: Re: [PATCH v2 3/3] staging: iio: light: isl29018: Use standard sysfs
 attributes for scale and integration time
References: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com> <1429212059-13010-4-git-send-email-roberta.dobrescu@gmail.com> <553D41CC.6070702@kernel.org>
In-Reply-To: <553D41CC.6070702@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/26/2015 3:51 PM, Jonathan Cameron wrote:
> On 16/04/15 20:20, Roberta Dobrescu wrote:
>> This patch refactors the isl29018 driver code in order to use standard
>> sysfs attributes for scale and integration time.
>>
>> ISL29018 light sensor uses four ranges and four ADC's resolutions
>> which influence the calculated lux. Adc resolution is strongly
>> connected to integration time and range should be controlled by scale.
>>
>> This patch introduces the usage of integration time and scale instead
>> of adc resolution and range.
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> Looks good to me,  Applied to the togreg branch of iio.git - initially pushed out
> as testing.
> 
> cc'd Rhyland though not heard from him for quite a while.
> 
> Rhyland, if you are still interested in this driver, give me a shout and I can
> hold these patches back until you get a chance to look at them.
> 
> Sorry, forgot to cc you earlier in the discussion!
> 
> Jonathan
> 

Its fine, don't hold up patches on my account. I haven't looked at this
in a while, so don't gate on me :)

-rhyland


-- 
nvpublic
