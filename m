Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32844 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdEPQjg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 May 2017 12:39:36 -0400
Subject: Re: [PATCH] iio: tsl2583: add runtime power management support
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        jbrenner@taosinc.com
References: <20170425080633.27464-1-masneyb@onstation.org>
 <59c35132-3c37-518e-cd57-2cde8584d60b@kernel.org>
 <20170514200834.GA10274@607924cbbc93>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <830d61f5-cb89-17f4-7cee-765ad85198bd@kernel.org>
Date: Tue, 16 May 2017 17:39:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170514200834.GA10274@607924cbbc93>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/05/17 21:08, Brian Masney wrote:
> On Wed, Apr 26, 2017 at 06:16:34AM +0100, Jonathan Cameron wrote:
>> On 25/04/17 09:06, Brian Masney wrote:
>>> This patch adds runtime power management support to the tsl2583 driver.
>>> The device is powered off after two seconds of inactivity. Verified that
>>> the driver still functions correctly using a TSL2581 hooked up to a
>>> Raspberry Pi 2.
>>>
>>> Signed-off-by: Brian Masney <masneyb@onstation.org>
>> Looks fine to me. Not being a particular expert in the runtime pm code
>> I'd like to let it sit on the list for a little while in the hope of
>> a bit of confirmation from those more knowledgeable about this than me.
>>
>> Give me a poke if I haven't picked it up in the next week or two.
> 
> Hi Jonathan,
> 
> This is a friendly reminder to pick up this patch the next time that you
> work on your queue.
> 
> Thanks,
> 
> Brian
> 
Done. Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to paly with it.

Thanks,

Jonathan
