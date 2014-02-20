Return-Path: <lars@metafoo.de>
Message-ID: <530653D5.8010404@metafoo.de>
Date: Thu, 20 Feb 2014 20:13:25 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Subject: Re: [RFC]coding style for NULL pointer checks
References: <5300ACC6.90509@gmx.de> <530109DE.3010607@metafoo.de> <53031C67.8060202@kernel.org> <53053609.40806@gmx.de> <53064FA8.9060104@kernel.org>
In-Reply-To: <53064FA8.9060104@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/20/2014 07:55 PM, Jonathan Cameron wrote:
> On 19/02/14 22:54, Hartmut Knaack wrote:
>> Jonathan Cameron schrieb:
>>> On 16/02/14 18:56, Lars-Peter Clausen wrote:
>>>> On 02/16/2014 01:19 PM, Hartmut Knaack wrote:
>>>>> Hi together,
>>>>> I noticed, that many pointers in the IIO subsystem are checked for
>>>>> successful allocation in the way of "if (pointer == NULL)" or "if (pointer
>>>>> != NULL)", while in a few cases the form of simply "if (!pointer)" or "if
>>>>> (pointer)" is used. So, is there any interest in having a more consistent
>>>>> style, and if so, for which one?
>>>>> My personal preference is for the latter one.
>>>> I think enforcing this is a bit to much nitpicking. So if you clean this up
>>>> the other pattern will probably appear again in new drivers at some point.
>>>>
>>>> Otherwise, if you feel strongly about this, go ahead and send a patch.
>>> My inclination on this is that there are better things to spend time on
>>> but as they say scratch the itch if you really want to!
>>>
>>> I'd rather have the nice error patch cleanups you've been doing or
>>> if you are really bored, there are lots of staging drivers in need of
>>> tendour loving care!
>>>
>>> J
>> Well, never mind then. Do you have some kind of To-Do-List?
> Saddly I / we are never quite that organised.  Tends to be mostly take
> a nice cleanup that was applied to a driver and propagate it across similar
> parts.  One outstanding one right now is to use the shared_by infomask
> elements recently introduced (by_dir and by_all) to get rid of as many
> hand specified attributes as possible.  The other big helpful thing
> is to review other peoples submissions.
>> Otherwise I would get back to my other projects.
> That's fair enough.  Nice to have some variety!
>> Concerning the staging drivers, I miss some motivation to work on
>> device drivers that I don't have the devices for.
> That's fair enough.  Strangely I can't remember when I last did any
> work on a device I actually own ;)  Still have a quite a few here
> somewhere that don't have drivers, but need to get the soldering iron out
> and never seem to get time.
>> Therefor I was  mainly focusing on the ad799x. So, by the way, which are
>> currently the show-stoppers for the ad799x preventing a move out of staging?
> None that I know of, other than a final review.  Sounds like Lars is happy which
> is always a good sign.
>> And, are there any plans to provide documentation about the supported IIO
>> devices (similar to hwmon)?
> Err. we tried this for a bit on the iio-utils wiki page, but rapidly got
> left behind.
>
> I guess it might be a useful resource if anyone fancies maintaining it?

For the ADI drivers we actually do have quite a bit of documentation. But it is 
not in the kernel tree, but on our wiki: 
http://wiki.analog.com/resources/tools-software/linux-drivers-all

- Lars
