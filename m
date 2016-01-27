Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35695 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbcA0RXv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jan 2016 12:23:51 -0500
In-Reply-To: <CAEnQRZBb5xK0=i1=Dwhcdkj1baSg4LGgFwzP8uQfeV29M+Cypg@mail.gmail.com>
References: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com> <569A3299.3@kernel.org> <CAEnQRZBb5xK0=i1=Dwhcdkj1baSg4LGgFwzP8uQfeV29M+Cypg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: adc: Add TI ADS1015 ADC driver support
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 27 Jan 2016 17:23:39 +0000
To: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Message-ID: <DFB2F2D5-3791-4820-98F9-A425E7C95DA5@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 27 January 2016 16:31:42 GMT+00:00, Daniel Baluta <daniel.baluta@intel.com> wrote:
>On Sat, Jan 16, 2016 at 2:07 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> On 14/01/16 16:25, Daniel Baluta wrote:
>>> The driver has sysfs readings with runtime PM support for power
>saving.
>>> It also offers buffer support that can be used together with IIO
>software
>>> triggers.
>>>
>>> Datasheet can be found here:
>>>       http://www.ti.com.cn/cn/lit/ds/symlink/ads1015.pdf
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>
>Thanks for the feedback! Few questions below.
>
>
>> The hwmon compatibility stuff has been covered by others so I'll just
>assume
>> you'll sort that out :)
>>
>> Various bits and bobs inline.
>
>Do you think it is worth to have both of the drivers in parallel for a
>period until
>we figure out that everything is correct? The IIO config symbol can be
>enabled
>only hwmon symbol is not enabled?
>
Yes. (That was easy)
><snip>
>
>>> +struct ads1015_data {
>> I was a little suprised to see both the i2c_client and regmap in
>here...
>> Could use regmap_get_device for most if not all uses in here of the
>> client pointer..
>
>That's a good point. Anyhow, there is no single instance of
>regmap_get_device
>in the IIO tree. I counted at least 4 drivers where we could use it.
>Do you think
>is there a great benefit from using it?
I only came across it here by thinking surely there was a better way!

>
>This will be a nice change for Linux kernel outreachy applicants :).
>I'm sure they will
>love to work on it.
Cool.
>
>>> +     struct i2c_client *client;
>>> +     struct regmap *regmap;
>> You only use buffer[0] that I can see...
>
>The rest should be for the timestamp and I will fix it :).
>
><snip>
>
>thanks,
>Daniel.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
