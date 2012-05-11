Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:23574
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425Ab2EKHcL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 03:32:11 -0400
Message-ID: <4FACC07A.8080600@analog.com>
Date: Fri, 11 May 2012 09:32:10 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 3/3] iio: amplifiers: New driver for AD8366 Dual-Digital
 Variable Gain Amplifier
References: <1336559774-21136-1-git-send-email-michael.hennerich@analog.com> <1336559774-21136-3-git-send-email-michael.hennerich@analog.com> <4FAB859F.2060103@kernel.org>
In-Reply-To: <4FAB859F.2060103@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/10/2012 11:08 AM, Jonathan Cameron wrote:
> On 5/9/2012 11:36 AM, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
>>
>> Changes since V1:
>>
>> Apply review feedback:
>> 	Introduce and use IIO_CHAN_INFO_HARDWAREGAIN
>> 	Introduce and use Use IIO_VAL_INT_PLUS_MICRO_DB
>>
>> Modify out of staging include paths.
>> Convert to new iio core API naming.
> For reasons I don't understand thunderbird on windows (yes I'm doing
> this whilst waiting for something to run at the day job), is wrecking
> spacing in subtle ways despite being in plain text mode...  Grr.
>
> Anyhow, my only real comment is that I think we may want a little more
> value sanity checking in the write_raw function.  Not critical as
> hopefully no one will write anything stupid to that, but nice to lock
> down anyway if you have the time.
Hi Jonathan,

Will add a check for val < 0 || val2 < 0.
If you don't mind I'll target the patch to the out of staging iio folder.

drivers/iio/amplifiers/ad8366.c

>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron<jic23@kernel.org>
>

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


