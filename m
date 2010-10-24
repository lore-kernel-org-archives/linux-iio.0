Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54602 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0JXSh6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 14:37:58 -0400
Message-ID: <4CC47E66.4070809@cam.ac.uk>
Date: Sun, 24 Oct 2010 19:43:50 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: Greg KH <gregkh@suse.de>, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [Device-drivers-devel] [PATCH 1/3] staging: iio: new adis16201
 driver
References: <1287830963-18377-1-git-send-email-vapier@gentoo.org> <4CC320D2.6030300@cam.ac.uk> <AANLkTim+czzJ__zuMCpjv4nV6rOJ9n50_4MR2VkQk6T_@mail.gmail.com> <4CC413F8.1030908@cam.ac.uk> <AANLkTinbc9-Vibzf1Vy1bZ1WcjerLEtMEfoqCteSfO3G@mail.gmail.com> <4CC479C0.9030607@cam.ac.uk> <AANLkTikuRJWN5OtVK4ysvEpsU6f9gfo6v3O+Zpp81v0D@mail.gmail.com>
In-Reply-To: <AANLkTikuRJWN5OtVK4ysvEpsU6f9gfo6v3O+Zpp81v0D@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/10 19:22, Mike Frysinger wrote:
> On Sun, Oct 24, 2010 at 14:24, Jonathan Cameron wrote:
>> On 10/24/10 16:58, Mike Frysinger wrote:
>>> On Sun, Oct 24, 2010 at 07:09, Jonathan Cameron wrote:
>>>> Unfortunately that isn't where they are going to merge.  The change
>>>> required won't be huge, but Greg isn't going to take them if they
>>>> don't merge cleanly.
>>>
>>> they merge cleanly, they just dont compile :p.  what tree exactly
>>> contains these changes you're referring to ?
>>>
>> either linux-next or staging-next branch of
>> http://git.kernel.org/?p=linux/kernel/git/gregkh/staging-next-2.6.git;a=summary
>>
>> The all went in a few weeks back.
> 
> i guess the trouble is that that tree is labeled as "junk tree, please
> ignore".  maybe gregkh can fix the labeling of his trees to reflect
> reality.
> 
>> Personally I just work against Gregs staging-next tree.
> 
> our current development tends to focus on current release since that
> is what we are pushing to customers.  i know this doesnt properly
> reflect the merging process, but it's what we have resources for
> today.
Sure. I know the feeling.  Hopefully IIO will be generally more stable
now the vast majority of dodgy corners effecting the driver core interface
have been cleaned up ;)  In this case for most drivers, the switch over
is a 5 minute job.  Admittedly that's a fair time given the number you have
sent on this time round though so you have my sympathy!

Bits where they never conformed to the abi are more of an issue, but we can
pin those down in tree.

Jonathan

> -mike
> 

