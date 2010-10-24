Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <4CC479C0.9030607@cam.ac.uk>
References: <1287830963-18377-1-git-send-email-vapier@gentoo.org>
 <4CC320D2.6030300@cam.ac.uk> <AANLkTim+czzJ__zuMCpjv4nV6rOJ9n50_4MR2VkQk6T_@mail.gmail.com>
 <4CC413F8.1030908@cam.ac.uk> <AANLkTinbc9-Vibzf1Vy1bZ1WcjerLEtMEfoqCteSfO3G@mail.gmail.com>
 <4CC479C0.9030607@cam.ac.uk>
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 24 Oct 2010 14:22:11 -0400
Message-ID: <AANLkTikuRJWN5OtVK4ysvEpsU6f9gfo6v3O+Zpp81v0D@mail.gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 1/3] staging: iio: new adis16201 driver
To: Jonathan Cameron <jic23@cam.ac.uk>, Greg KH <gregkh@suse.de>
Cc: linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 24, 2010 at 14:24, Jonathan Cameron wrote:
> On 10/24/10 16:58, Mike Frysinger wrote:
>> On Sun, Oct 24, 2010 at 07:09, Jonathan Cameron wrote:
>>> Unfortunately that isn't where they are going to merge. =C2=A0The chang=
e
>>> required won't be huge, but Greg isn't going to take them if they
>>> don't merge cleanly.
>>
>> they merge cleanly, they just dont compile :p. =C2=A0what tree exactly
>> contains these changes you're referring to ?
>>
> either linux-next or staging-next branch of
> http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/staging-next-2.6.git;a=
=3Dsummary
>
> The all went in a few weeks back.

i guess the trouble is that that tree is labeled as "junk tree, please
ignore".  maybe gregkh can fix the labeling of his trees to reflect
reality.

> Personally I just work against Gregs staging-next tree.

our current development tends to focus on current release since that
is what we are pushing to customers.  i know this doesnt properly
reflect the merging process, but it's what we have resources for
today.
-mike
