Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57426 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab2EBIdA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 May 2012 04:33:00 -0400
Message-ID: <4FA0F13A.2070304@cam.ac.uk>
Date: Wed, 02 May 2012 09:32:58 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: different data rate in IIO ?
References: <abd67b68b54fc6c88b83c91a200ace5e@mail.gmail.com> <4F9FAAB9.7060003@metafoo.de> <4F9FE357.6050004@cam.ac.uk> <4F9FE632.3040308@metafoo.de> <4F9FEA37.5040107@cam.ac.uk> <4F9FEDC6.8070400@metafoo.de> <4F9FF002.2060900@metafoo.de> <4F9FF82E.80906@cam.ac.uk> <4FA02576.2060607@metafoo.de> <6adea11c-371d-4d73-bb36-f9681db7265d@email.android.com> <4fab27b061c75547b5b02a7f409753f5@mail.gmail.com>
In-Reply-To: <4fab27b061c75547b5b02a7f409753f5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/1/2012 7:28 PM, Ge Gao wrote:
> Thanks for the advice. So it seems everyone agrees that multiple IIO device
> is the way to go. What about the using a flag to indicate which data will
> come like the one below:
> Under IIO architecture, can we have another kind of ring buffer in addition
> to sw_ring
sw_ring is probably dead.  I'm not entirely convinced that we can work 
everything we
want into kfifo, but there is a lot of resistance against another basic 
buffer implementation
in the kernel.   Hence if you did a buffer as you suggest it would 
probably need to be
based on kfifo (which rather tediously will add some significant overhead).
>   and kfifo, such as header to indicate data type(gyro_x, gyro_y,
> gyro_z, accel_x, accel_y, accel_z, compass_x, compass_y, compass_z,
> quaternion_x, quaternion_y, quaternion_z, quaternion_c) followed by actual
> data.
Yes.  See the discussion in my followup to Kerry's email later in the 
thread.  We can
do this, but it comes with a not insignificant cost.  Need real world 
numbers to know
if it is worth paying.
> Also can we have some definition for quaternion? It is an important datum
> for rotation calculation. It contains 4 elements, x, y, z and a constant.
Well drop the constant (get it from sysfs). How many bits for xyz?

And yes, a definition for a quaternion is definitely needed.  Feel free 
to suggest one ;)
>
> Ge
>
>
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> Sent: Tuesday, May 01, 2012 11:05 AM
> To: Lars-Peter Clausen
> Cc: Ge Gao; linux-iio@vger.kernel.org
> Subject: Re: different data rate in IIO ?
>
>
>
> Lars-Peter Clausen<lars@metafoo.de>  wrote:
>
>> On 05/01/2012 04:50 PM, Jonathan Cameron wrote:
>>> On 5/1/2012 3:15 PM, Lars-Peter Clausen wrote:
>>>> On 05/01/2012 04:05 PM, Lars-Peter Clausen wrote:
>>>> [...]
>>>> Ah, seems as if the refcounting infrastructure is already ready for
>>>> use after we have called device_initialize, so the above plan should
>>>> work
>> quite
>>>> well.
>>>> Call device_del in iio_device_unregister and device_put in
>>>> iio_device_free and free the struct in the release callback.
>>> That makes sense given it just splits the two parts of
>> device_unregister
>>> apart.
>>> Don't suppose you want to do the patch?
>> I could write the patch, but I don't have a setup at hand right now
>> where I could test it, so this would have to wait until next week. I
>> wouldn't mind if you took care of it though :)
> I'll aim to do it Saturday....  nothing to test on till then.
>> - Lars
> --
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

