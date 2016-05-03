Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36570 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291AbcECSyF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2016 14:54:05 -0400
Subject: Re: Regression in inv_mpu6050: 4.6.0-rc5
To: Jonathan Cameron <jic23@kernel.org>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Michael Welling <mwelling@ieee.org>, mranostay@gmail.com
References: <20160426232651.099a18d7@lxorguk.ukuu.org.uk>
 <20160426230755.GA6235@deathstar>
 <20160427165613.4d464792@lxorguk.ukuu.org.uk>
 <e65623b5-44bc-b329-b718-c00aaa0b4805@kernel.org>
Cc: linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org
From: Crestez Dan Leonard <cdleonard@gmail.com>
Message-ID: <5728F3CD.3000801@gmail.com>
Date: Tue, 3 May 2016 21:54:05 +0300
MIME-Version: 1.0
In-Reply-To: <e65623b5-44bc-b329-b718-c00aaa0b4805@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/2016 10:58 PM, Jonathan Cameron wrote:
> On 27/04/16 16:56, One Thousand Gnomes wrote:
>> On Tue, 26 Apr 2016 18:07:55 -0500
>> Michael Welling <mwelling@ieee.org> wrote:
>>
>>> On Tue, Apr 26, 2016 at 11:26:51PM +0100, One Thousand Gnomes wrote:
>>>>
>>>> This now causes us to crash and burn on the ASUS T100TA Baytrail/T
>>>> platforms
>>>>  
>>>
>>> I believe this regression has already been patched.
>>>
>>> Check the latest commits in linux-next.
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>>>
>>> See if the latest patches fix your issue.
>>
>> It does - as this is a regression can we please get those fixes into the
>> next -rc ?
>>
> I'm afraid I'm lost in this one - which patch caused the regression and
> which one fixed it?  The only patches I can immediately see in next
> both introduce and then squish a similar bug, but neither of them
> has hit Linus' tree yet.
> 
> Or are we dealing with what was fixed in:
> c816d9e7 iio: imu: mpu6050: fix possible NULL dereferences
> I had understood that one as more hypothetical than real...
> 
> Unfortunately I'm travelling and I suspect that means this will only get
> in just after the release (so for 4.6.1) once I've confirmed which fixes
> we actually need to backport.
> 
Commit
    c816d9e7: iio: imu: mpu6050: fix possible NULL dereferences
Fixes:
    33da559f: iio: imu: mpu6050: add mpu6500 register settings

As far as I can tell this crash will always happen when the device is
probed via ACPI.

-- 
Regards,
Leonard
