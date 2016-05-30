Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40353 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161768AbcE3Vmi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 May 2016 17:42:38 -0400
In-Reply-To: <49c4a235-29fd-aa55-d9d2-8ead5cefd737@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com> <7df4b331d35e3e6a19d13ccbcb5d12f0347b660c.1463582011.git.leonard.crestez@intel.com> <14d4a757-f60a-40c0-03b4-c36d1b22d30e@kernel.org> <49c4a235-29fd-aa55-d9d2-8ead5cefd737@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2 6/7] iio: inv_mpu6050: Reformat sample for active scan mask
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 30 May 2016 22:42:30 +0100
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <ggao@invensense.com>, Peter Rosin <peda@axentia.se>,
	linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Message-ID: <4EB54DBB-A77A-4BC5-8960-5CE9EB1B5DF2@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 30 May 2016 14:44:41 BST, Crestez Dan Leonard <leonard.crestez@intel.com> wrote:
>On 05/29/2016 06:47 PM, Jonathan Cameron wrote:
>> On 18/05/16 16:00, Crestez Dan Leonard wrote:
>>> Right now it is possible to only enable some of the x/y/z channels,
>for
>>> example you can enable accel_z without x or y but if you actually do
>>> that what you get is actually only the x channel.
>>>
>>> Fix this by reformatting the hardware sample to only include the
>>> requested channels.
>> As it stands here there is no benefit in doing this over using the
>core
>> demux. In fact it's considerably less efficient (fair enough that you
>> are keeping it simple in the first instance).
>> The patch description should make that clear.
>
>Why is it less efficient? All it really does is a bunch of memcpy.

Not doing agglomeration of neighbouring copies (iirc) not git either set of code to
hand!

>
>> I'd definitely like to see simple extension of that option to handle
>> a callback to get the nearest scanmask that is possible (as an
>alternative
>> to the static scan_masks_available list.)
>> 
>> This only gets interesting if we are dealing with the unaligned case
>and for
>> these parts that only kicks in I think if the slave devices have say
>3 bytes in
>> their data type.  
>
>But I want to deal with the unaligned case because it's better than
>introducing odd validations on slave channels. If I added an extension
>to get the nearest scanmask I would have to remove it in PATCH 7.
Hmm I must have misread that. Though you were only supporting 16 bit channels
 for aux sensors.

Then for now can we give this a slightly less generic name. I am not happy
 enough that we want this in the core 'yet'. 
Easy to rename later if it makes sense.

Thanks

Jonathan 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
