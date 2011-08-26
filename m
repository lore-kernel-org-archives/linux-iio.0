Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:58661 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1HZL54 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 07:57:56 -0400
Message-ID: <4E578C2E.4010002@cam.ac.uk>
Date: Fri, 26 Aug 2011 13:06:06 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: imu: adis16400: Avoid null pointer dereference
References: <1314348200-11112-1-git-send-email-michael.hennerich@analog.com> <4E57655D.4060303@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E6F62D45@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E6F62D45@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/26/11 12:40, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-08-26:
>> On 08/26/11 09:43, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> Not sure if this is a proper fix. However it should do the trick.
>>> ring->scan_maks is allocated in iio_ring_buffer_register() which called
>>> after adis16400_configure_ring. So the time this pointer dereference
>>> takes place scan_mask is uninitialized.
>> Dratt missed that one.  This definitely isn't the right fix as it will
>> get wiped out when that element is initialized.
>>
>> Mostly I fixed equivalents elsewhere by not setting a default. After all
>> user space shouldn't be relying on any particular set of channels being
>> enable anyway.  Do we have a good reason to not just remove it here?
> 
> Feel free to remove it - I don't have a good reason other than convenience...
Added to the patch that scraps the rest of these and pushed out to iio-blue.git
> 
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>> ---
>>>  drivers/staging/iio/imu/adis16400_ring.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>> diff --git a/drivers/staging/iio/imu/adis16400_ring.c
>>> b/drivers/staging/iio/imu/adis16400_ring.c index 1a47d07..f6d50be
>>> 100644 --- a/drivers/staging/iio/imu/adis16400_ring.c +++
>>> b/drivers/staging/iio/imu/adis16400_ring.c @@ -191,7 +191,7 @@ int
>>> adis16400_configure_ring(struct iio_dev
>> *indio_dev)
>>>      ring->setup_ops = &adis16400_ring_setup_ops;
>>>      ring->owner = THIS_MODULE;
>>>      /* Set default scan mode - assumes single long is big enough */
>>> -    *ring->scan_mask = st->variant->default_scan_mask;
>>> +    ring->scan_mask = &st->variant->default_scan_mask;
>>>      ring->scan_count = hweight_long(st->variant->default_scan_mask);
>>>
>>>      indio_dev->pollfunc =
>> iio_alloc_pollfunc(&iio_pollfunc_store_time,
>>
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

