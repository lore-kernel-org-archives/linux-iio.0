Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58812 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755179AbcIJQ0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 12:26:49 -0400
Subject: Re: [PATCH] iio: accel: sca3000_core: Fix superfluous indent white
 space
To: Ico Doornekamp <ico@pruts.nl>
References: <20160909174414.31002-1-ico@pruts.nl>
 <95f27ba9-d54c-3dad-6b33-217010ce55bd@kernel.org>
 <1473522932-sup-4169@pruts.nl>
Cc: linux-iio <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <50ce9913-92cc-8e1b-f8eb-2faec769622a@kernel.org>
Date: Sat, 10 Sep 2016 17:26:45 +0100
MIME-Version: 1.0
In-Reply-To: <1473522932-sup-4169@pruts.nl>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/09/16 17:01, Ico Doornekamp wrote:
> * On 2016-09-10 16:57:18 +0200, Jonathan Cameron wrote:
>  
>> Clifton Barnes sent a patch for this a few weeks ago and
>> I have already applied that patch.
> 
> Oh, so I'm probably working from the wrong tree, linux-next seems to be
> behind on this; does linux-iio have its own git tree somewhere?
Yes
https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/

Most recent branch if normally 'testing' which is there for the
various automated build tests to report on.

Path to linux next is that I have to send Greg KH a pull request
(will be doing one tomorrow probably) and then he pulls it into
staging-next which is pulled into linux-next.
> 
> (I'm sorry if I'm generating noise on the list here. As is probably
> obvious, I'm here because of the The Eudyptula Challenge [1]; the
> current task being to fix a style violation somewhere in the staging
> tree. Since IIO is the single part of the staging tree I actually use in
> real life, I though this might be the right place for me to come to.
Cool
> Too bad for me that there's not much style issues in the IIO tree
> though)
Largely because others have been here before you and picked off the
low hanging fruit.  All our remaining staging drivers have been there
a 'long' time!
> 
> 1. http://eudyptula-challenge.org/
Don't worry about it!   We are always happy to help out people who
are just getting started.

If you want to try something a little more 'meaty' take a staging
driver and play spot the ABI that is either 'wrong' or not yet
documented under

Documentation/ABI/testing/sysfs-bus-iio*

If it's obviously not covered by the ABI docs then post a documentation
patch.  This often kicks off a discussion on what the interface
'should' be ;)

Another good one is to find things in staging drivers that we now
have IIO_INFO_* elements for.

For example in sca3000 I see there is an explicit attribute defined that
could be replaced by IIO_INFO_SAMPLING_FREQUENCY being added in the
relevant masks and appropriate sections added to the read_raw
and write_raw callbacks.

Not a trivial job, but not too hard to figure out perhaps?

+ a good step up from white space patches.

Guess maybe that needs to be a bit later if you are ploughing through
the eudyptula-challenge (though that didn't exist when I got started
so I don't know what order they do stuff in!)

Jonathan


