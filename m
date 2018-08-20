Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:57178 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTVP3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Aug 2018 17:15:29 -0400
Date: Mon, 20 Aug 2018 18:58:45 +0100
In-Reply-To: <8f7def1e-97d7-b8b4-bc5d-09d9478998f6@gmail.com>
References: <20180817190319.13119-1-dpfrey@gmail.com> <20180817190319.13119-2-dpfrey@gmail.com> <20180818110323.GB24920@himanshu-Vostro-3559> <20180819164706.4eab1634@archlinux> <8f7def1e-97d7-b8b4-bc5d-09d9478998f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v3 1/7] iio: chemical: bme680: use clamp macro
To: David Frey <dpfrey@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>
CC: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <DE3344BA-9619-4F03-982B-EC3ED547E5AC@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 20 August 2018 18:18:54 BST, David Frey <dpfrey@gmail.com> wrote:
>On 8/19/2018 8:47 AM, Jonathan Cameron wrote:
>> On Sat, 18 Aug 2018 16:33:23 +0530
>> Himanshu Jha <himanshujha199640@gmail.com> wrote:
>> 
>>> On Fri, Aug 17, 2018 at 12:03:13PM -0700, David Frey wrote:
>>>> Signed-off-by: David Frey <dpfrey@gmail.com>  
>>>
>>> Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
>>> Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
>> Applied to the togreg branch of iio.git and pushed out as testing
>> for the autobuilders to play with it.
>
>Hi,

Hi brief as I am on my phone.
>
>I'm trying to understand the linux-iio mailing list workflow a bit
>better.  I have
>git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git as my "iio"
>remote in my Linux kernel repository.  From that remote, I can see
>remotes/iio/togreg.  When I do a "git fetch", the togreg branch hasn't
>been updated.  Did Jonathan mean that he applied the patch to the
>togreg
>branch in his local repository, but hasn't yet pushed it to the one
>that
>I have listed above?

Exactly, the point of that is to distinguish between patches that are taking a different path.
Mostly this is just those applied to the fixes-togreg branch.

>  Are the "autobuilders" specific to IIO?  

Nope. This is referring mainly to the 0day builders intel provide to the community.

https://01.org/lkp/documentation/0-day-test-service

>Is this
>infrastructure publicly accessible or is it only available to specific
>users?  If it's public, where can I view it/learn more about it?

As above. It will sometimes pick directly from the mailing lists bit not always.  

You can also send patches to it for testing as that page describes.

For trees that feed into mainline, you can request the whole tree is monitored so 
for example I get a report of what tests have run and potential issues a few hours after I push
 things to the testing branch.  Typically builds a few hundred configs in that time and keeps going afterwards if resources allow.

The move to pushing out a togreg branch publicly is a manual step that I can only do when
on my development machine and which I forget sometimes.  Given reports were good when I got
 them today, I will probably push togreg out soonish.

Oday is great.  Other services such as kernel ci run on smaller numbers of trees and do boot
 tests as well. Mostly not so relevant for IIO though as we tend to need a bit more than a
 boot.  I always meant to do a city test rig for a few boards and devices specific to IIO but it
 would only be of limited use due to the huge number of devices we have supported.

Jonathan

>
>Thanks,
>David

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
