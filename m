Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57122 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbcKFRzU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 12:55:20 -0500
Subject: Re: [PATCH 7/9] staging: iio: tsl2583: fix issue with changes to
 calibscale and int_time not being set on the chip
To: Brian Masney <masneyb@onstation.org>
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
 <1478177780-28699-8-git-send-email-masneyb@onstation.org>
 <16c8bfcb-469f-9dca-2cf4-460aa8172301@kernel.org>
 <20161106142325.GA13221@basecamp.onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, lars@metafoo.de, pmeerw@pmeerw.net,
        knaack.h@gmx.de, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a1dd64b1-efeb-4fa0-8a2c-8bc7a9b84bb2@kernel.org>
Date: Sun, 6 Nov 2016 17:55:14 +0000
MIME-Version: 1.0
In-Reply-To: <20161106142325.GA13221@basecamp.onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/16 14:23, Brian Masney wrote:
> On Sun, Nov 06, 2016 at 12:03:53PM +0000, Jonathan Cameron wrote:
>> On 03/11/16 12:56, Brian Masney wrote:
>>> When updating the in_illuminance_calibscale and
>>> in_illuminance_integration_time sysfs attributes, these values were not
>>> actually written to the chip. The chip would continue to use the old
>>> parameters. Extracted out tsl2583_set_als_gain() and
>>> tsl2583_set_als_time() functions that are now called when these sysfs
>>> attributes are updated. The chip initialization now calls these these
>>> new functions.
>>>
>>> Rename taos_chip_on() to tsl2583_chip_init() since it is now only called
>>> during device probing and when the power management code wakes the
>>> device back up. tsl2583_chip_init() was refactored to use the new
>>> functions mentioned above.
>>>
>>> Previously, the current chip state was represented as a tristate
>>> (working, suspended, and unknown). The unknown state was not used. The
>>> chip state is now represented with a single boolean value (suspended).
>> Last part should probably have been a separate patch.  Earlier stages could
>> also have been futher broken up I think to make it easier to review.
>>
>> The additional init in the resume path should also protect against suspends
>> which actually cut the power to the chip which is nice.
>>
>> Just enough bits and pieces inline that I'd like you to do another pass
>> on this.
> 
> No problem, I'll split this one up for you. My next patch series will
> also contain a lot of trivial code cleanups, some documentation updates, and
> a request to move the driver out of staging.
Cool
> 
> The device tree documentation
> (Documentation/devicetree/bindings/iio/light/tsl2583.txt) has the
> interrupt-parent and interrupts properties as optional, however the
> driver does not support interrupts. Should I remove these properties from
> the device tree documentation? I can add the code to support the
> interrupts but I am hesistant to add that new code if no one will use it.
> 
> Brian
> 
Leave them there.  Device tree is about documenting the hardware,
not just those bits we get around to using ;)

Obviously we have to document what we use but no problem documenting
other bits!

Jonathan
