Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:48327 "EHLO
	ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759756Ab0I0Q33 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2010 12:29:29 -0400
Message-ID: <4CA0C7AB.8060905@cam.ac.uk>
Date: Mon, 27 Sep 2010 17:34:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: matthias <mensch0815@googlemail.com>
CC: linux-iio@vger.kernel.org, m_brugger@web.de, drivers@analog.com
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>	<4C94B4A6.2060001@cam.ac.uk> <AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com>
In-Reply-To: <AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/10 16:48, matthias wrote:
> Hi Jonathan,
> 
> sorry for not answering yet. I was on vacation and next week I won't
> be able to test the driver. Will try to do it asap....
> 
> Matthias

Hi Matthias,

I'm afraid quite a bit has changed over the last few weeks. Feel free to test
this patch set.  The changes since then are merely renames of a couple of
attributes and a lot of stuff for event handling that doesn't effect this
driver.

If not, I'm hosting a *temporary* git tree with all my various queued up changes
at:

http://git.kernel.org/?p=linux/kernel/git/jic23/iio_temp.git

Seems excessive to post this set again until I hear back from you!

Thanks,

Jonathan

p.s. Switched to drivers@analog.com address as that now seems to work.

> 
> 2010/9/18 Jonathan Cameron <jic23@cam.ac.uk>:
>> On 09/06/10 16:16, Jonathan Cameron wrote:
>>> Mainly a rebase, but a couple of attribute naming fixes as well.
>>>
>>> Note I don't have one of these so if anyone could test that would
>>> be great!
>>>
>>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>
>>> Jonathan Cameron (2):
>>>   staging:iio:adis16260 add id table support
>>>   staging:iio:adis16260 add suppport for adis16255 and adis16250.
>>>
>>>  drivers/staging/iio/gyro/Kconfig                   |    8 +-
>>>  drivers/staging/iio/gyro/adis16260.h               |    3 +
>>>  drivers/staging/iio/gyro/adis16260_core.c          |  139 ++++++++++++++------
>>>  drivers/staging/iio/gyro/adis16260_platform_data.h |   19 +++
>>>  drivers/staging/iio/gyro/gyro.h                    |    9 ++
>>>  5 files changed, 136 insertions(+), 42 deletions(-)
>>>  create mode 100644 drivers/staging/iio/gyro/adis16260_platform_data.h
>>>
>>>
>> Whilst I haven't tested these (don't have the hardware) I don't think there
>> is anything controversial, so my intent is to push these to Greg before the
>> next merge window.  This is primarily to remove the duplication we currently
>> have with two drivers that effectively cover the same parts.
>>
>> Thanks,
>>
>> Jonathan
>>
> 
> 
> 

