Return-Path: <holler@ahsoftware.de>
Message-ID: <50CC6F18.9060404@ahsoftware.de>
Date: Sat, 15 Dec 2012 13:37:44 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Lars-Peter Clausen <lars@metafoo.de>, rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 srinivas pandruvada <srinivas.pandruvada@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4 v2] iio: hid-sensors: respect CONFIG_IIO_TRIGGER
References: <50C73AFC.1050904@jic23.retrosnub.co.uk> <1355250106-3114-1-git-send-email-holler@ahsoftware.de> <50CC56F3.1020907@kernel.org>
In-Reply-To: <50CC56F3.1020907@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Am 15.12.2012 11:54, schrieb Jonathan Cameron:
> On 12/11/2012 06:21 PM, Alexander Holler wrote:
>> Not much to say, without that change, hid-sensor-trigger will be
>> always compiled if HID_SENSOR_IIO_COMMON is selected which fails if
>> CONFIG_IIO_TRIGGER is not set because CONFIG_IIO_CONSUMERS_PER_TRIGGER
>> will not be defined.
>>
>> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
>
> Not sure what tree this was against as it is needs some fixing up for
> staging-next and currently mainline.  Ah well fixed up and added to togreg
> branch of

Should have been 3.7(-rcN).

>
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>
> Please check I haven't messed it up.

Still looks like what I have here.

Thanks,

Alexander
