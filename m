Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <4CC413F8.1030908@cam.ac.uk>
References: <1287830963-18377-1-git-send-email-vapier@gentoo.org>
 <4CC320D2.6030300@cam.ac.uk> <AANLkTim+czzJ__zuMCpjv4nV6rOJ9n50_4MR2VkQk6T_@mail.gmail.com>
 <4CC413F8.1030908@cam.ac.uk>
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 24 Oct 2010 11:58:00 -0400
Message-ID: <AANLkTinbc9-Vibzf1Vy1bZ1WcjerLEtMEfoqCteSfO3G@mail.gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 1/3] staging: iio: new adis16201 driver
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 24, 2010 at 07:09, Jonathan Cameron wrote:
> On 10/23/10 21:32, Mike Frysinger wrote:
>> On Sat, Oct 23, 2010 at 13:52, Jonathan Cameron wrote:
>>> On 10/23/10 11:49, Mike Frysinger wrote:
>>>> From: Barry Song <barry.song@analog.com>
>>>>
>>>> IIO driver for dual Axis Accelerometer/inclinometer adis16201 parts.
>>>
>>> Please check these for building against staging next. =C2=A0There have =
been
>>> a couple of cleanup and abi fix series merged since the tree you are
>>> working against (at least I'm guessing that's what causes...
>>
>> testing against current mainline
>
> Unfortunately that isn't where they are going to merge. =C2=A0The change
> required won't be huge, but Greg isn't going to take them if they
> don't merge cleanly.

they merge cleanly, they just dont compile :p.  what tree exactly
contains these changes you're referring to ?
-mike
