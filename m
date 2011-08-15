Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:51129 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab1HOQLv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2011 12:11:51 -0400
Message-ID: <4E49472E.90104@cam.ac.uk>
Date: Mon, 15 Aug 2011 17:19:58 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Paul Thomas <pthomas8589@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: [v2] add support for Analog Devices ad7194 a/d converter
References: <1313353117-25140-1-git-send-email-pthomas8589@gmail.com> <4E48EC6D.5090102@cam.ac.uk> <CAD56B7dVPpUB4twdYOdNx-pNMFVuxRANfNOjvqJV0Z357e_qQQ@mail.gmail.com>
In-Reply-To: <CAD56B7dVPpUB4twdYOdNx-pNMFVuxRANfNOjvqJV0Z357e_qQQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/15/11 16:57, Paul Thomas wrote:
> On Mon, Aug 15, 2011 at 2:52 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> On 08/14/11 21:18, Paul Thomas wrote:
>>> This uses the iio sysfs interface, and inculdes gain
>> includes
>>
>> Couple of left over bits from chan_spec conversion that need
>> cleaning up and a that gain attribute wants to be done via the
>> scale_shared chan_info element instead.
> OK, most of that makes sense. I might have more questions latter, but
> one question for now. You say to use the scale_shared for the gain
> (can you point do a good example of this?)  I just want to make sure
> we're on the same page as to what the gain is doing. It's really just
> setting the range of the voltage input I scale the result back down to
> volts. So if the input voltage is 0.2V you get 0.2V Whether you set
> the gain to 1 or 8
Ah, I missed that. In that case, given it's internal only, it should
be IIO_CHAN_INFO_CALIBSCALE_SHARED and you should be setting processed_val
in iio_chan_spec structures and scaling to millivolts not volts
(we may change everything to volts but haven't done it yet).

For a device like this we tend to leave things raw and use the scale attribute
to tell userspace enough to know how to convert it to SI units.  Doesn't
matter so much with devices only being accessed over sysfs (hence fine here)
but you don't want to waste time with conversions when pushing to a buffer.

Jonathan
