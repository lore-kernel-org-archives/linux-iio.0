Return-Path: <lars@metafoo.de>
Message-ID: <529E3B01.5070602@metafoo.de>
Date: Tue, 03 Dec 2013 21:11:45 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 14/15] staging:iio:ad9832: Mark transfer buffers as __be16
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-14-git-send-email-lars@metafoo.de> <5299C882.8020509@kernel.org> <529DB20A.6050500@metafoo.de> <c7a6d755-a2e3-4180-a690-d97434e32db7@email.android.com> <529E3A96.4060503@kernel.org>
In-Reply-To: <529E3A96.4060503@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 12/03/2013 09:09 PM, Jonathan Cameron wrote:
> On 12/03/13 14:56, Jonathan Cameron wrote:
>>
>>
>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 11/30/2013 12:14 PM, Jonathan Cameron wrote:
>>>> On 11/25/13 12:42, Lars-Peter Clausen wrote:
>>>>> Fixes the following warnings from sparse:
>>>>> 	drivers/staging/iio/frequency/ad9832.c:43:26: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:43:26:    expected unsigned
>>> short [unsigned] [short] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:43:26:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:46:26: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:46:26:    expected unsigned
>>> short [unsigned] [short] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:46:26:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:49:26: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:49:26:    expected unsigned
>>> short [unsigned] [short] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:49:26:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:52:26: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:52:26:    expected unsigned
>>> short [unsigned] [short] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:52:26:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:65:27: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:65:27:    expected unsigned
>>> short [unsigned] [short] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:65:27:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:68:27: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:68:27:    expected unsigned
>>> short [unsigned] [short] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:68:27:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:107:26: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:107:26:    expected unsigned
>>> short [unsigned] data
>>>>> 	drivers/staging/iio/frequency/ad9832.c:107:26:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:120:26: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:120:26:    expected unsigned
>>> short [unsigned] data
>>>>> 	drivers/staging/iio/frequency/ad9832.c:120:26:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:133:26: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:133:26:    expected unsigned
>>> short [unsigned] data
>>>>> 	drivers/staging/iio/frequency/ad9832.c:133:26:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:144:26: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:144:26:    expected unsigned
>>> short [unsigned] data
>>>>> 	drivers/staging/iio/frequency/ad9832.c:144:26:    got restricted
>>> __be16 [usertype] <noident>
>>>>> 	drivers/staging/iio/frequency/ad9832.c:277:18: warning: incorrect
>>> type in assignment (different base types)
>>>>> 	drivers/staging/iio/frequency/ad9832.c:277:18:    expected unsigned
>>> short [unsigned] data
>>>>> 	drivers/staging/iio/frequency/ad9832.c:277:18:    got restricted
>>> __be16 [usertype] <noident>
>>>>>
>>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> Applied to the togreg branch of iio.git
>>>
>>> Thanks, for taking care of the patches. Somehow this one and the ad9834
>>> didn't make it. Shall I resend?
>>>
>> Oops I probably got distracted. Don't worry about the resending. I will track them down.
> Both have now 'actually' been applied and pushed out.

thanks.
