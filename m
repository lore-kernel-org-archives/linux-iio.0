Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:33817 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab1JKPHG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2011 11:07:06 -0400
Message-ID: <4E945B98.8030201@cam.ac.uk>
Date: Tue, 11 Oct 2011 16:07:04 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging:iio: fix removal path to allow correct freeing.
References: <1318259876-7572-1-git-send-email-jic23@cam.ac.uk> <1318259876-7572-2-git-send-email-jic23@cam.ac.uk> <4E932051.2070205@cam.ac.uk> <4E941167.8060403@cam.ac.uk> <4E942E6C.4080001@metafoo.de>
In-Reply-To: <4E942E6C.4080001@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/11 12:54, Lars-Peter Clausen wrote:
> On 10/11/2011 11:50 AM, Jonathan Cameron wrote:
>> On 10/10/11 17:41, Jonathan Cameron wrote:
>>> On 10/10/11 16:17, Jonathan Cameron wrote:
>>>> Fix a dumb lack of consideration of the effect of combining
>>>> the iio_device_unregister and iio_free_device calls into
>>>> one.  There is no valid place to free some of the sysfs
>>>> array elements.
>>> My continued testing indicates another dragon hiding somewhere.
>>> It's of the that lovely type that causes segfaults scattered
>>> all over the kernel.  Will continue tomorrow.
>> One dragon found.  Stupid size of available_scanmasks bug
>> on allocation in max1363.  I'll send a patch out later.
>>
>> Now I can hammer probe and remove without problem.
>>
>> Testing from others of this patch would be welcomed.
>>
>> Jonathan
> 
> It seems to work fine under normal conditions, but I'm wondering if it is
> possible to create a sitution in which we still have reference to the iio
> device pending when we unbind the parent device. In this case
> iio_free_device
> would be called before iio_release_device.
It's possible there is a bug in the core or one of the drivers.
Drivers are responsible for ensuring all pending work is flushed etc.
The core should ensure that if another device has a reference, 
then the relevant module will have been gotten and hence rmmod
will refuse to do anything.

Having said that, we've chased down bugs in the trigger code this
cycle and I suspect there are more in there.  Hence please do point
out any failure cases you come across!

Jonathan
