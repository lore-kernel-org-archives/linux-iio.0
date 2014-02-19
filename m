Return-Path: <knaack.h@gmx.de>
Message-ID: <53053609.40806@gmx.de>
Date: Wed, 19 Feb 2014 23:54:01 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC]coding style for NULL pointer checks
References: <5300ACC6.90509@gmx.de> <530109DE.3010607@metafoo.de> <53031C67.8060202@kernel.org>
In-Reply-To: <53031C67.8060202@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron schrieb:
> On 16/02/14 18:56, Lars-Peter Clausen wrote:
>> On 02/16/2014 01:19 PM, Hartmut Knaack wrote:
>>> Hi together,
>>> I noticed, that many pointers in the IIO subsystem are checked for successful allocation in the way of "if (pointer == NULL)" or "if (pointer != NULL)", while in a few cases the form of simply "if (!pointer)" or "if (pointer)" is used. So, is there any interest in having a more consistent style, and if so, for which one?
>>> My personal preference is for the latter one.
>> I think enforcing this is a bit to much nitpicking. So if you clean this up the other pattern will probably appear again in new drivers at some point.
>>
>> Otherwise, if you feel strongly about this, go ahead and send a patch.
> My inclination on this is that there are better things to spend time on
> but as they say scratch the itch if you really want to!
>
> I'd rather have the nice error patch cleanups you've been doing or
> if you are really bored, there are lots of staging drivers in need of
> tendour loving care!
>
> J
Well, never mind then. Do you have some kind of To-Do-List? Otherwise I would get back to my other projects.
Concerning the staging drivers, I miss some motivation to work on device drivers that I don't have the devices for. Therefor I was mainly focusing on the ad799x. So, by the way, which are currently the show-stoppers for the ad799x preventing a move out of staging?
And, are there any plans to provide documentation about the supported IIO devices (similar to hwmon)?

Hartmut
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
