Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:45052 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759555Ab2EIOUQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 10:20:16 -0400
Message-ID: <4FAA7D1C.6060401@cam.ac.uk>
Date: Wed, 09 May 2012 15:20:12 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>,
	linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Subject: Re: iio: v2, add support for HMC5883/HMC5883L to HMC5843 driver
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net> <CAM=Q2cuuki_4jJoCdLOrdHVVk-yKSOyaLL3dcbY_SzxJXvt8Kg@mail.gmail.com> <alpine.DEB.2.01.1205091524570.5308@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1205091524570.5308@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/9/2012 2:33 PM, Peter Meerwald wrote:
> Hello,
>
>>> the driver has a severe limitation: X/Y/Z must ALL be read to allow new
>>> data to become available (the device goes into a locked state until all
>>> are read)
>> Thats a limitation comming from the data sheet right?
> yes, it affects all devices (hmc5843/5883/5883l)
>
>> Are you suggesting a read all and report only requested?
>> to work round that.
> probably yes
>
> I brought it up to see if there are ideas for a solution; maybe the issue
> is more common and this should be solved at iio core level?
>
> with individual reads for X/Y/Z there is no guarantee that all values come
> from the same measurement cycle ('atomic read')
>
> the hmc58x3 'solves' this with the lock logic and introduces another issue
>
> maybe iio should only allow reads to all data elements at once?
If you need to do that, use buffered access rather than sysfs.  Anything 
else
makes for fiddly and hard to generalize interfaces I'm afraid.

It is indeed a common situation.  Actually I much prefer this to the 
alternative
of getting an inconsistent set depending on precise read times.

Jonathan
