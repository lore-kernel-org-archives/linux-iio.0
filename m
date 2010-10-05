Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:56097 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab0JEPA5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Oct 2010 11:00:57 -0400
Message-ID: <4CAB3EF6.70806@cam.ac.uk>
Date: Tue, 05 Oct 2010 16:06:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: iio: ring_generic: provide IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT
References: <1286283606-6849-1-git-send-email-michael.hennerich@analog.com> <4CAB2FA3.6030005@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917712F0DB8AD8B@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712F0DB8AD8B@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/10 15:11, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2010-10-05:
>> On 10/05/10 14:00, Michael Hennerich wrote:
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Send it to Greg with the first user... Also need to update the
>> documentation in sysfs-bus-iio to cover this, but that can be a
>> separate patch.
>>
>> Jonathan
> 
> Hi Jonathan,
> 
> I wonder why the documentation is specific to accel?
> I think that can be many things...
Simply because the format of those file doesn't (I think) allow for
a variable in the name and as you say there are lots of sensor types.

Hence if I did it as a [accel|magn| etc] I'd end up with a very very long
line.

It appears that those file were created by Greg KH (according to git blame
on the readme) 

So Greg, if you are the person to ask (if not please suggest who is!)...

In the sysfs abi docs, we have been rather fast and loose with the formatting
and Michael's question in this email motivated me to ask for some guidance.

We have an awful lot of possible sysfs attributes to document.
So far we have been using [] to indicate optional elements in naming (explained
in the description). (e.g. accel[_x]_type )

A lot of the file sysfs-bus-iio uses only accel as an example whereas the
attributes equally exist for all the other types (e.g. magn, gyro, illuminance etc).

In discussions on list we have been using <type> to indicate a variable which can
take any of the channel types, but I don't know if it is valid to use this in
the abi files.  That is, can we define some variable that takes a set of values
just once for the file and then use <type> in the naming to indicate replacement
with one of the set?

Another option would be to have multiple what lines. e.g.

What:  accel_[x|y|z]_type
What:  gyro_[x|y|z]_type
What:  magn_[x|y|z]_type

etc.

The approach of just doing it for accel has caused a number of people to miss
certain definitions so far so we need to work out some want of making this clearer
preferably without obliging people to have sections like the following

What: gyro_[x|y|z]_type
...
Description:
	Equivalent of accel_[x|y|z]_type but for gyroscope channels.

Thanks,

Jonathan


> 
> What:           /sys/.../device[n]/buffer/scan_elements/accel[_x0]_type
> KernelVersion:  2.6.37
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Description of the scan element data storage within the buffer
>                 and hence the form in which it is read from userspace.
>                 Form is [s|u]bits/storagebits.  s or u specifies if signed
>                 (2's complement) or unsigned. bits is the number of bits of
>                 data and storagebits is the space (after padding) that it
>                 occupies in the buffer.  Note that some devices will have
>                 additional information in the unused bits so to get a clean
>                 value, the bits value must be used to mask the buffer output
>                 value appropriately.  The storagebits value also specifies the
>                 data alignment.  So s48/64 will be a signed 48 bit integer
>                 stored in a 64 bit location aligned to a a64 bit boundary.
>                 For other storage combinations this attribute will be extended
>                 appropriately.
> 
> 
> 
> 
> 
> Greetings,
> Michael
> 
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

