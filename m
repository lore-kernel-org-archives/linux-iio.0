Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25871 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755025AbbDINoM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 9 Apr 2015 09:44:12 -0400
Message-ID: <5526823A.6070404@intel.com>
Date: Thu, 09 Apr 2015 16:44:26 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Subject: Re: [RFC PATCH 2/2] iio: light: Add support for LTR559 chip
References: <1427798235-29602-1-git-send-email-daniel.baluta@intel.com> <1427798235-29602-3-git-send-email-daniel.baluta@intel.com> <552680FF.3060604@kernel.org>
In-Reply-To: <552680FF.3060604@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 04/09/2015 04:39 PM, Jonathan Cameron wrote:
> On 31/03/15 11:37, Daniel Baluta wrote:
>> This device is register compatible with LTR501, with a minor difference for
>> ALS control register as showed below:
>>
>> ALS Control register for LTR501:
>>
>>      7      6      5      4      3      2      1      0
>> +------+------+------+------+------+------+------+------+
>> |                           |      |      |             |
>> |        Reserved           | Gain |  SW  |    ALS Mode |
>> |                           |      | Reset|             |
>> +------+------+------+------+------+------+------+------+
>>
>> ALS Control register for LTR559:
>>
>>      7      6      5      4      3      2      1      0
>> +------+------+------+------+------+------+------+------+
>> |                    |                    |      |      |
>> |     Reserved       |        Gain        |  SW  | ALS  |
>> |                    |                    | Reset| Mode |
>> +------+------+------+------+------+------+------+------+
>>
>> We handle this difference by introducing ltr501_chip_info.
>>
>> Datasheet for LTR559 is at:
>> http://optoelectronics.liteon.com/upload/download/DS86-2013-0003/S_110_LTR-559ALS-01_DS_V1.pdf
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> Looks good to me.  Let us know when you've tested it ;)
> Anyhow, one comment inline.  It 'think' you can end up with a device probing
> succesfully with no known name...

Good point.

thanks,
Daniel.

<snip>

>> -	indio_dev->name = LTR501_DRV_NAME;
>> +	indio_dev->name = name;
> Can name still be NULL?  Needs a default value that makes sense.
>>   	indio_dev->modes = INDIO_DIRECT_MODE;

I will fix this and sync with Sathya for the LTR301 support.

thanks,
Daniel.
