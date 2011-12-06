Return-Path: <jic23@cam.ac.uk>
References: <1323101333-26426-1-git-send-email-lars@metafoo.de> <4EDD3F14.804@kernel.org> <4EDDD956.4080908@metafoo.de>
In-Reply-To: <4EDDD956.4080908@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging:iio:dac: Add AD5380 driver
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 06 Dec 2011 10:25:28 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,Jonathan Cameron <jic23@kernel.org>
CC: Greg Kroah-Hartman <gregkh@suse.de>,Michael Hennerich <michael.hennerich@analog.com>,devel@driverdev.osuosl.org,linux-iio@vger.kernel.org,device-drivers-devel@blackfin.uclinux.org,drivers@analog.com
Message-ID: <caec6f7a-7ea1-49d7-8d58-a2bd2be59d1d@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 12/05/2011 11:00 PM, Jon=
athan Cameron wrote:
>> On 12/05/2011 04:08 PM, Lars-Peter Clausen wrote:
>=
>> This patch adds support for the Analog Devices D5380, AD5381,
>>> AD5382=
, AD5383, AD5384, AD5390, AD5391, AD5392 multi-channel
>>> Digital to Analo=
g Converters.
>>>
>> Lars-Peter
>> 
>> Just got a build warning on this you=
 probably want to check out...
>> 
>> drivers/staging/iio/dac/ad5380.c:150:=
10: warning: Initializer entry
>> defined twice
>> drivers/staging/iio/dac/=
ad5380.c:160:10:   also defined here
>> 
>> Trivial, but good to fix!
>> Jo=
nathan
>
>Yes, especially since this breaks support for the AD5391-5.
>(I a=
lways wonder why my compiler doesn't give me these warnings)
That may have =
come from sparse...
>
>Thanks,
>- Lars
>--
>To unsubscribe from this list: =
send the line "unsubscribe linux-iio" in
>the body of a message to majordom=
o@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo=
-info.html

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my=
 brevity.
