Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>
Date: Tue, 5 Oct 2010 15:11:59 +0100
Subject: RE: [PATCH] staging: iio: ring_generic: provide
 IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F0DB8AD8B@LIMKCMBX1.ad.analog.com>
References: <1286283606-6849-1-git-send-email-michael.hennerich@analog.com>
 <4CAB2FA3.6030005@cam.ac.uk>
In-Reply-To: <4CAB2FA3.6030005@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-10-05:
> On 10/05/10 14:00, Michael Hennerich wrote:
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>
> Send it to Greg with the first user... Also need to update the
> documentation in sysfs-bus-iio to cover this, but that can be a
> separate patch.
>
> Jonathan

Hi Jonathan,

I wonder why the documentation is specific to accel?
I think that can be many things...

What:           /sys/.../device[n]/buffer/scan_elements/accel[_x0]_type
KernelVersion:  2.6.37
Contact:        linux-iio@vger.kernel.org
Description:
                Description of the scan element data storage within the buf=
fer
                and hence the form in which it is read from userspace.
                Form is [s|u]bits/storagebits.  s or u specifies if signed
                (2's complement) or unsigned. bits is the number of bits of
                data and storagebits is the space (after padding) that it
                occupies in the buffer.  Note that some devices will have
                additional information in the unused bits so to get a clean
                value, the bits value must be used to mask the buffer outpu=
t
                value appropriately.  The storagebits value also specifies =
the
                data alignment.  So s48/64 will be a signed 48 bit integer
                stored in a 64 bit location aligned to a a64 bit boundary.
                For other storage combinations this attribute will be exten=
ded
                appropriately.





Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
