Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59010 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3KUUGu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Nov 2013 15:06:50 -0500
In-Reply-To: <alpine.LNX.2.00.1311211023190.22082@pobox.suse.cz>
References: <1381267963-14669-1-git-send-email-srinivas.pandruvada@linux.intel.com> <525C6ECA.4020404@kernel.org> <525C6FCE.9060909@linux.intel.com> <525D9047.6060902@kernel.org> <525D8ABF.6000504@linux.intel.com> <525D9AB1.6070709@kernel.org> <alpine.LNX.2.00.1311211023190.22082@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: hid-sensors: Fix power and report state
From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 21 Nov 2013 20:06:45 +0000
To: Jiri Kosina <jkosina@suse.cz>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Message-ID: <0c3f994c-174c-41c9-8cb7-c6dd26ec125e@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Jiri Kosina <jkosina@suse.cz> wrote:
>On Tue, 15 Oct 2013, Jonathan Cameron wrote:
>
>> >>>>> In the original HID sensor specifications all Named array enums
>
>> >>>>> stated to be 0-based. But the most commercial devices
>implemented 
>> >>>>> as 1-based, because of the implementation by one of the major
>OS 
>> >>>>> vendor. To fix this we added a quirk, which required module to
>be 
>> >>>>> recompiled. Instead now added a module parameter, so that it
>can 
>> >>>>> be switched at runtime. By default it will be 1-based to be 
>> >>>>> compatible with majority of devices. This is true for both
>power 
>> >>>>> and report state usage id for hid sensors. Also added defines
>for 
>> >>>>> power on values for D0 to D4 and using it for clarity.
>> >>>>>
>> >>>>> Signed-off-by: Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>
>> >>>> This looks fine but raises a few questions...
>> >>>>
>> >>>> What other options do we have for controlling this?  Are hid
>sensors
>> >>>> chips identifiable? If so can we have a list of chips where it
>is 0 in
>> >>>> the driver.  The module parameter might still be needed to deal
>with new
>> >>>> devices but would be nice to have most work out of the box.
>> >>> We could have quirk based on vendor id/pid. But the problem is
>that once they update FW to be compliant with WIN8, it
>> >>> will not work.
>> >>> So there is no way to distinguish. Since sensor hub is present in
>most of WIN8 convertible devices, the quirk became a
>> >>> new normal.
>> >> Yuck.  You have my sympathies!
>> >>
>> >>>> Got to love it when the quirk becomes the default ;)
>> >>> Unfortunately they don't go back to specification update after
>such change.
>> >> Just to check, is this quirk only hid-sensors related?  Named
>arrays are
>> >> as far as I can see a part of HID in general.
>> > Currently I have information about HID sensors implementation only
>as they are in new in the WIN8. I didn't hear any
>> > complaint about any other HID devices.
>> Jiri, have you seen anything similar to this before.
>> 
>> I am just trying to work out if it should be a Hid quirk or should be
>> handled only in the hid-sensors module.
>
>Sorry for super-late response from me, I have been drowned in other 
>things.
>
>This looks indeed pretty bad. I don't have a strong objection to having
>
>this as a generic HID quirk; the argument being, if this was made
>de-facto 
>Win8-mandated standard, odds are that we'd start seeing a lot of
>devices 
>with this behavior.
>
>So if you decide to take this way, please send the patch to me, I'll
>apply 
>it.
Thanks for the reply Jiri. That was pretty much what I was expecting.

Srinivas, please rework this as a generic his quirk.
>
>Thanks,

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
