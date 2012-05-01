Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:61477 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756039Ab2EANc7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 May 2012 09:32:59 -0400
Message-ID: <4F9FE632.3040308@metafoo.de>
Date: Tue, 01 May 2012 15:33:38 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Ge Gao <ggao@invensense.com>, linux-iio@vger.kernel.org
Subject: Re: different data rate in IIO ?
References: <abd67b68b54fc6c88b83c91a200ace5e@mail.gmail.com> <4F9FAAB9.7060003@metafoo.de> <4F9FE357.6050004@cam.ac.uk>
In-Reply-To: <4F9FE357.6050004@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/2012 03:21 PM, Jonathan Cameron wrote:
> On 5/1/2012 10:19 AM, Lars-Peter Clausen wrote:
>> On 04/30/2012 10:03 PM, Ge Gao wrote:
>>> Dear all,
>>> I am currently developing a driver for a chip that has gyro,
>>> accelerometer and compass sensor together and these sensor data could
>>> come
>>> at different rate. There could be more data coming from this chip
>>> because
>>> this chip has on-chip CPU to do some data processing. The IIO
>>> subsystem is
>>> in some sense "fixed" once "enable" is 1. "Fixed" means the element and
>>> sequence inside ring buffer is fixed. For example, if MPU9150,
>>> which is a 9-axis chip, containing gyro, accelerometer and compass, is
>>> developed, the
>>> ring buffer would have byte_per_datum of 32 bytes(6 + 6 + 6  = 18; 18
>>> rounding up to 24; and 24 plus timestamp) if all sensors and all axis
>>> are
>>> enabled . So every data packet should contain this amount of data no
>>> matter what. If I have gyro running at 200 HZ, accelerometer running at
>>> 100Hz and compass running at 50 Hz, this will have problems. Because I
>>> can't provide accelerometer data and compass data for each packet. Some
>>> packets could miss data. I have to fake data for these packets,
>>> either by
>>> repeating or other non-standard ways.  Is this supposed to be?
>>> Because we
>>> could have other data item which is even slower(10HZ quaternion data,
>>> for
>>> example). This way, it will be more trouble. Because each data
>>> element has
>>> different rate, while IIO needs them at the same rate.
>>>                  The best way is to have a header for each packet to
>>> indicate what packet it is. But this way seems to violate the design
>>> goal
>>> of IIO.  That would be more like input subsystem because input subsystem
>>> uses different code type to distinguish different type of data thus
>>> allowing different data type mixed together. If such driver is written,
>>> all files under "scan_element" would be meaningless and useless.
>>>     I got some suggestions about using multiple IIO devices in one
>>> driver because one IIO device can only has one ring buffer. It could
>>> be OK
>>> to handle this. However, since IIO device allocation is to allocate the
>>> private data directly along with IIO device, it seems one IIO driver can
>>> only have one IIO device. Could IIO kernel accept such practice that one
>>> IIO
>>> driver has more than one IIO device? Or could there be some changes in
>>> the IIO code such that such scenario is taken care of in the future?
>> The multiple IIO devices approach was the first that came to my mind
>> while
>> reading your message. For the private data for these IIO devices you
>> could just
>> allocate the space for one pointer and let it point to your real
>> driver data.
> Either that or don't use iio_priv at all.  Embed the iio_dev structures
> in a containing structure.
> To do this would need the addition of some in place setup functions in
> the core that do
> the non allocation bits of iio_device_alloc and iio_device_free. 

I just wanted to write that this will get you into trouble in regard to the
'struct device' lifetime expectancies. But then I realized that we do have the
same problem already. We free the device in iio_device_free, but this will
cause might cause a use after free if something still holds a reference to the
device at this point. We should free the struct in iio_dev_release.

- Lars
