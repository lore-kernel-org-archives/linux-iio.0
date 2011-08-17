Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E4BA7F8.4050500@cam.ac.uk>
Date: Wed, 17 Aug 2011 12:37:28 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: michael.hennerich@analog.com,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [RFC PATCH 0/6] IIO: capacitance ADC cleanup (ad7150)
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk> <4E4B85B8.3010006@analog.com> <4E4B908B.7010805@cam.ac.uk>
In-Reply-To: <4E4B908B.7010805@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/17/11 10:57, Jonathan Cameron wrote:
> On 08/17/11 10:11, Michael Hennerich wrote:
>> On 08/17/2011 10:42 AM, Jonathan Cameron wrote:
>>> Hi All,
>>>
>>> Couple of bits in here that I'll push out into next set of main cleanups.
>>>
>>> Controversial bits (hence RFC) are the introduction of IIO_EV_TYPE_MAG_ADAPTIVE
>>> and IIO_EV_TYPE_THRESH_ADAPTIVE, to handle the 'mean' shifted thresholds
>>> of this device.  I'm far from convinced these are the right way to go,
>>> but best I have come up with just yet.
>>>
>>> Note this series is completely untested.  I haven't even verified that the
>>> new chan spec related bits work right yet (can do that with a dummy driver).
>> Hi Jonathan,
>>
>> I have a EVAL-AD7156EBZ board, so I should be able to test the driver.
>> Can you please push these patches onto your iio-blue git?
>>
> Will do. Have fixed the swab16 requirements I think.
> 
> Branch is capfun. The push included a few other minor bits and bobs
> in the master branch but nothing interesting..
Also, some ad7152 changes in there, but currently non compiling. oops.
