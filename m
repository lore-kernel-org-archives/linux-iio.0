Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:56734 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab0JNLO4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2010 07:14:56 -0400
Message-ID: <4CB6E783.8090808@cam.ac.uk>
Date: Thu, 14 Oct 2010 12:20:35 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "greg@kroah.com" <greg@kroah.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	"randy.dunlap@oracle.com" <randy.dunlap@oracle.com>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad7476: fix !CONFIG_IIO_RING_BUFFER build
 issue reported by Randy Dunlap
References: <1287044238-20220-1-git-send-email-michael.hennerich@analog.com> <4CB6D9F8.9090107@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713094373A4C@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713094373A4C@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/10 12:06, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2010-10-14:
>> On 10/14/10 09:17, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> Fix function function decalration
>>> Enable CONFIG_IIO_RING_BUFFER for the ad7476 driver
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>> ---
>>>  drivers/staging/iio/adc/Kconfig  |    3 +++
>>>  drivers/staging/iio/adc/ad7476.h |    4 +---
>>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>> diff --git a/drivers/staging/iio/adc/Kconfig
>>> b/drivers/staging/iio/adc/Kconfig index 81a7d45..acb6767 100644
>>> --- a/drivers/staging/iio/adc/Kconfig
>>> +++ b/drivers/staging/iio/adc/Kconfig
>>> @@ -50,6 +50,9 @@ config AD799X_RING_BUFFER  config AD7476
>>>      tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 and AD7495 ADC
>>>  driver"     depends on SPI
>>> +    select IIO_RING_BUFFER
>>> +    select IIO_SW_RING
>>> +    select IIO_TRIGGER
>>>      help
>>>        Say yes here to build support for Analog Devices
>>>        AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495
>>> diff --git a/drivers/staging/iio/adc/ad7476.h
>>> b/drivers/staging/iio/adc/ad7476.h
>>> index 6e4a85b..b51b49e 100644
>>> --- a/drivers/staging/iio/adc/ad7476.h
>>> +++ b/drivers/staging/iio/adc/ad7476.h
>>> @@ -59,9 +59,7 @@ int ad7476_scan_from_ring(struct ad7476_state
>>> *st); int ad7476_register_ring_funcs_and_init(struct iio_dev
>>> *indio_dev); void ad7476_ring_cleanup(struct iio_dev *indio_dev);
>>> #else /* CONFIG_IIO_RING_BUFFER */
>>
>> If you are selecting the ring buffer (which is fine), then why do you
>> need anything to be in this else?  The buffer will always be there.
>>
>> Maybe I'm missing something?
> Selecting the ringbuffer was a straight way to avoid the configuration
> dependency build issue.
> You're right, this is currently dead code. But I thought I leave it there, until
> reorganization of the ringbuffer include file.
> Once this is done, I'll revert and make the ringbuffer optional again.
Sensible argument, so I'm happy.

>>> -static inline ssize_t ad7476_scan_from_ring(struct device *dev,
>>> -                                         struct device_attribute *attr,
>>> -                                         char *buf)
>>> +static inline int ad7476_scan_from_ring(struct ad7476_state *st)
>>>  {
>>>      return 0;
>>>  }
> 
> Greetings,
> Michael
> 
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

