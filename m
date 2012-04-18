Return-Path: <jic23@kernel.org>
Message-ID: <4F8EB784.6090702@kernel.org>
Date: Wed, 18 Apr 2012 13:45:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Getz, Robin" <robin.getz@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Marten Svanfeldt <marten@intuitiveaerial.com>
Subject: Re: [PATCH v3] staging:iio: trigger: Add hrtimer trigger
References: <1334581381-18161-1-git-send-email-lars@metafoo.de> <4a3800e1-986a-4801-87a4-f0246425c87f@email.android.com> <4F8C4F17.5040101@metafoo.de> <201204180758.34751.robin.getz@analog.com>
In-Reply-To: <201204180758.34751.robin.getz@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 4/18/2012 12:58 PM, Getz, Robin wrote:
> On Mon 16 Apr 2012 12:55, Lars-Peter Clausen pondered:
>> On 04/16/2012 06:17 PM, Jonathan Cameron wrote:
>>> Lars-Peter Clausen<lars@metafoo.de>  wrote:
>>>> From: Marten Svanfeldt<marten@intuitiveaerial.com>
>>>>
>>>> This patch adds a IIO trigger driver which uses a highres timer to
>>>> provide a
>>>> frequency based trigger.
>>> Fine as it stands but same issue arises as we had with userspace trigger
>>> still.  What are we doing registering a pure software element not
>>> associated to any specific hardware via a platform device.  Why not do it
>>> on userspace asking for one as we do with the sysfs file based trigger?
>> I suppose this is a general question how we want to mange our triggers in
>> general. None of the other existing trigger drivers does direct IO access
>> and just use existing infrastructure. They could all be easily be
>> instantiated by writing a string or number to a sysfs file. So where do we
>> draw the line?
Fair point.  Personally I'd go for whether it is about explicit hardware 
or not.  So gpio / general
interrupt makes sense in platform code.  I suspect we'll kill off the 
RTC one anyway on the way
out of staging.
> Isn't there an issue of accuracy? the timing accuracy of sysfs/userspace is
> non-existant with respect to what you need to do in most of these cases.
I'm not suggesting there is any problem with having a hrtimer based 
trigger (in fact
I am throughly in favour!) its just a question of whether it should be 
registered in the
board file / device tree or done via a magic string write as Lars-Peter 
mentions above
(which is what we do the sysfs file based trigger precisely because 
there was a pretty
strong feeling against implying non existent hardware...)
