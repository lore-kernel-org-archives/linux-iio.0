Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34437 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbbIEXeX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 5 Sep 2015 19:34:23 -0400
Subject: Re: [PATCH 02/18] staging: iio: hmc5843: Export missing SPI module
 alias information
To: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-3-git-send-email-javier@osg.samsung.com>
 <55D8B875.3060200@kernel.org> <55E4DE8D.9070109@osg.samsung.com>
 <55EB18D5.6060204@kernel.org>
Cc: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hartmut Knaack <knaack.h@gmx.de>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <55EB7BF9.8040902@osg.samsung.com>
Date: Sun, 6 Sep 2015 01:34:17 +0200
MIME-Version: 1.0
In-Reply-To: <55EB18D5.6060204@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

On 09/05/2015 06:31 PM, Jonathan Cameron wrote:
> On 01/09/15 00:09, Javier Martinez Canillas wrote:
>> Hello Jonathan,
>>
>> On 08/22/2015 07:59 PM, Jonathan Cameron wrote:
>>> On 20/08/15 08:07, Javier Martinez Canillas wrote:
>>>> The SPI core always reports the MODALIAS uevent as "spi:<modalias>"
>>>> regardless of the mechanism that was used to register the device
>>>> (i.e: OF or board code) and the table that is used later to match
>>>> the driver with the device (i.e: SPI id table or OF match table).
>>>>
>>>> So drivers needs to export the SPI id table and this be built into
>>>> the module or udev won't have the necessary information to autoload
>>>> the needed driver module when the device is added.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>> Applied to the togreg branch of iio.git.
>>>
>>> This is too late for the upcoming merge window so it will be queued up for
>>> the next one.
>>>
>>
>> IMHO this patch and "[PATCH 01/18] iio: Export SPI module alias
>> information in missing drivers" [0] are fixing broken module
>> autoloading which are bugs so are material for the 4.3 -rc cycle.
> 
> It's a corner case.  Could also be argued that this isn't
> a bug but rather a case of a feature (autoprobing) being added
> that wasn't supported before.  It's not obligatory to support
> autoloading (even if we would normally aim to do so).
> 
> I'm happy enough for a request to apply these to stable occurs
> after they hit Linus' tree (as a trivial backport) but I don't
> think they really deserve being sent on as fixes.
> 
> Of course, I might be missing something that means something is
> actually broken, as opposed to not present.
>

Well, as a user I would expect that if I have a driver built-in
and it works, building it as a module will also work so I think
module autoload it's a bugfix and not a new feature.

And the patch is trivial and won't cause any issues so I don't
see why it can't be -rc material.

But of course is up to you, git log shows me that these drivers
have been since v3.10 so it seems that nobody cared anyways.
 
> Jonathan
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
