Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37703 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbC2LAC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2015 07:00:02 -0400
Message-ID: <5517DB2E.8060903@kernel.org>
Date: Sun, 29 Mar 2015 11:59:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: Fengguang Wu <fengguang.wu@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	kbuild-all@01.org
Subject: Re: [iio:testing 10/10] ERROR: "__divdi3" [drivers/iio/accel/bmc150-accel.ko]
 undefined!
References: <201503282121.NkeMOw9e%fengguang.wu@intel.com>	<5516B838.2040004@jic23.retrosnub.co.uk> <CAE1zot+PyXFOxP-EoYCjPgJ5T8eMKQPcAwVRjBmrpKwcDtbbrA@mail.gmail.com>
In-Reply-To: <CAE1zot+PyXFOxP-EoYCjPgJ5T8eMKQPcAwVRjBmrpKwcDtbbrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/03/15 00:15, Octavian Purdila wrote:
> On 28 Mar 2015 16:18, "Jonathan Cameron" <jic23@jic23.retrosnub.co.uk> wrote:
>>
>> On 28/03/15 13:02, kbuild test robot wrote:
>>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
>>> head:   5e02849a682600c1663a333f95f0388d1c536108
>>> commit: 5e02849a682600c1663a333f95f0388d1c536108 [10/10] iio: bmc150_accel: add support for hardware fifo
>>> config: m68k-allmodconfig (attached as .config)
>>> reproduce:
>>>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>>   chmod +x ~/bin/make.cross
>>>   git checkout 5e02849a682600c1663a333f95f0388d1c536108
>>>   # save the attached .config to linux build tree
>>>   make.cross ARCH=m68k
>>>
>>> All error/warnings:
>>>
>>>>> ERROR: "__divdi3" [drivers/iio/accel/bmc150-accel.ko] undefined!
>> Oops, missed that.  I think we can use a simple do_div for computing the sample_period
>> (which included 64bit / 8 bit).
>>
>> Will push out a patch to the testing branch to see if they autobuilders are
>> happy with it then fix up the driver properly if they are.
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index c639489671bb..d5e103b208ba 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -1002,7 +1002,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>>          * To avoid this issue we compute the actual sample period ourselves
>>          * based on the timestamp delta between the last two flush operations.
>>          */
>> -       sample_period = (data->timestamp - data->old_timestamp) / count;
>> +       sample_period = (data->timestamp - data->old_timestamp);
>> +       do_div(sample_period, count);
>>         tstamp = data->timestamp - (count - 1) * sample_period;
>>
>>         if (samples && count > samples)
>>
> 
> Oops, sorry about this Jonathan and thank you for fixing it so quickly.
Except I just changed it from a build fail to a warning.  I think for do_div it
needs to be uint64 so just pushed that build test out.


All warnings:

   drivers/iio/accel/bmc150-accel.c: In function '__bmc150_accel_fifo_flush':
>> drivers/iio/accel/bmc150-accel.c:1006:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]

vim +1006 drivers/iio/accel/bmc150-accel.c

> 
> One more thing, I marked the new sysfs entries for 4.2, but it seems
> that these might make it in 4.1. Should I send a patch to correct
> this?
>
