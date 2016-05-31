Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:40908 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162134AbcEaI5M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 31 May 2016 04:57:12 -0400
Subject: Re: [PATCH v2 6/7] iio: inv_mpu6050: Reformat sample for active scan
 mask
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1463582011.git.leonard.crestez@intel.com>
 <7df4b331d35e3e6a19d13ccbcb5d12f0347b660c.1463582011.git.leonard.crestez@intel.com>
 <14d4a757-f60a-40c0-03b4-c36d1b22d30e@kernel.org>
 <49c4a235-29fd-aa55-d9d2-8ead5cefd737@intel.com>
 <4EB54DBB-A77A-4BC5-8960-5CE9EB1B5DF2@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
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
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <3169df0b-78d8-a35c-bd31-f2d4e7e17bde@intel.com>
Date: Tue, 31 May 2016 11:56:51 +0300
MIME-Version: 1.0
In-Reply-To: <4EB54DBB-A77A-4BC5-8960-5CE9EB1B5DF2@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/31/2016 12:42 AM, Jonathan Cameron wrote:
> On 30 May 2016 14:44:41 BST, Crestez Dan Leonard <leonard.crestez@intel.com> wrote:
>> On 05/29/2016 06:47 PM, Jonathan Cameron wrote:
>>> On 18/05/16 16:00, Crestez Dan Leonard wrote:
>>>> Right now it is possible to only enable some of the x/y/z channels,
>> for
>>>> example you can enable accel_z without x or y but if you actually do
>>>> that what you get is actually only the x channel.
>>>>
>>>> Fix this by reformatting the hardware sample to only include the
>>>> requested channels.
>>> As it stands here there is no benefit in doing this over using the
>> core
>>> demux. In fact it's considerably less efficient (fair enough that you
>>> are keeping it simple in the first instance).
>>> The patch description should make that clear.
>>
>> Why is it less efficient? All it really does is a bunch of memcpy.
> 
> Not doing agglomeration of neighbouring copies (iirc) not git either set of code to
> hand!

You're right about that. But the total data rate is still very low.

>>> I'd definitely like to see simple extension of that option to handle
>>> a callback to get the nearest scanmask that is possible (as an
>> alternative
>>> to the static scan_masks_available list.)
>>>
>>> This only gets interesting if we are dealing with the unaligned case
>> and for
>>> these parts that only kicks in I think if the slave devices have say
>> 3 bytes in
>>> their data type.  
>>
>> But I want to deal with the unaligned case because it's better than
>> introducing odd validations on slave channels. If I added an extension
>> to get the nearest scanmask I would have to remove it in PATCH 7.
> Hmm I must have misread that. Though you were only supporting 16 bit channels
>  for aux sensors.

That was in a previous version, I dropped that limitation now.

> Then for now can we give this a slightly less generic name. I am not happy
>  enough that we want this in the core 'yet'. 
> Easy to rename later if it makes sense.

Ok, I will rename these functions to start with inv_mpu_* instead of iio_*.

In theory it would be interesting to refactor the iio demuxing code to
support this but then this patch serios would grow even more complicated.

-- 
Regards,
Leonard
