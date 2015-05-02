Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58512 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbEBLCt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2015 07:02:49 -0400
Message-ID: <5544AED5.1080903@kernel.org>
Date: Sat, 02 May 2015 12:02:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rhyland Klein <rklein@nvidia.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com
Subject: Re: [PATCH v2 3/3] staging: iio: light: isl29018: Use standard sysfs
 attributes for scale and integration time
References: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com> <1429212059-13010-4-git-send-email-roberta.dobrescu@gmail.com> <553D41CC.6070702@kernel.org> <553E5DEE.5020001@nvidia.com>
In-Reply-To: <553E5DEE.5020001@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/15 17:03, Rhyland Klein wrote:
> On 4/26/2015 3:51 PM, Jonathan Cameron wrote:
>> On 16/04/15 20:20, Roberta Dobrescu wrote:
>>> This patch refactors the isl29018 driver code in order to use standard
>>> sysfs attributes for scale and integration time.
>>>
>>> ISL29018 light sensor uses four ranges and four ADC's resolutions
>>> which influence the calculated lux. Adc resolution is strongly
>>> connected to integration time and range should be controlled by scale.
>>>
>>> This patch introduces the usage of integration time and scale instead
>>> of adc resolution and range.
>>>
>>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>> Looks good to me,  Applied to the togreg branch of iio.git - initially pushed out
>> as testing.
>>
>> cc'd Rhyland though not heard from him for quite a while.
>>
>> Rhyland, if you are still interested in this driver, give me a shout and I can
>> hold these patches back until you get a chance to look at them.
>>
>> Sorry, forgot to cc you earlier in the discussion!
>>
>> Jonathan
>>
> 
> Its fine, don't hold up patches on my account. I haven't looked at this
> in a while, so don't gate on me :)
> 
> -rhyland

I missed a small issue with some missing brackets in one of the switch statements.
The autobuilder caught it as a formatting issue:
drivers/staging/iio/light/isl29018.c:373:3-4: code aligned with following code on line 377.
I'll send out  a patch in a mo, but as it's trivial am happy to apply it without an ack.

note this isn't actually a bug due to the check being strictly unnecessary anyway, but
it is clearly not as intended!

Jonathan
> 
> 

