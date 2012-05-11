Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39686 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab2EKHgQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 03:36:16 -0400
Message-ID: <4FACC16B.2060106@cam.ac.uk>
Date: Fri, 11 May 2012 08:36:11 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 3/3] iio: amplifiers: New driver for AD8366 Dual-Digital
 Variable Gain Amplifier
References: <1336559774-21136-1-git-send-email-michael.hennerich@analog.com> <1336559774-21136-3-git-send-email-michael.hennerich@analog.com> <4FAB859F.2060103@kernel.org> <4FACC07A.8080600@analog.com>
In-Reply-To: <4FACC07A.8080600@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/11/2012 8:32 AM, Michael Hennerich wrote:
> On 05/10/2012 11:08 AM, Jonathan Cameron wrote:
>> On 5/9/2012 11:36 AM, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>
>>> Changes since V1:
>>>
>>> Apply review feedback:
>>> Introduce and use IIO_CHAN_INFO_HARDWAREGAIN
>>> Introduce and use Use IIO_VAL_INT_PLUS_MICRO_DB
>>>
>>> Modify out of staging include paths.
>>> Convert to new iio core API naming.
>> For reasons I don't understand thunderbird on windows (yes I'm doing
>> this whilst waiting for something to run at the day job), is wrecking
>> spacing in subtle ways despite being in plain text mode... Grr.
>>
>> Anyhow, my only real comment is that I think we may want a little more
>> value sanity checking in the write_raw function. Not critical as
>> hopefully no one will write anything stupid to that, but nice to lock
>> down anyway if you have the time.
> Hi Jonathan,
>
> Will add a check for val < 0 || val2 < 0.
> If you don't mind I'll target the patch to the out of staging iio folder.
Yes, that would be good.  I'll start discouraging any drivers going into 
staging unless there are unresolved abi issues.
>
> drivers/iio/amplifiers/ad8366.c
>
>>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>> Acked-by: Jonathan Cameron<jic23@kernel.org>
>>
>

