Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:44501 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab1HQJtY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 05:49:24 -0400
Message-ID: <4E4B908B.7010805@cam.ac.uk>
Date: Wed, 17 Aug 2011 10:57:31 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [RFC PATCH 0/6] IIO: capacitance ADC cleanup (ad7150)
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk> <4E4B85B8.3010006@analog.com>
In-Reply-To: <4E4B85B8.3010006@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/17/11 10:11, Michael Hennerich wrote:
> On 08/17/2011 10:42 AM, Jonathan Cameron wrote:
>> Hi All,
>>
>> Couple of bits in here that I'll push out into next set of main cleanups.
>>
>> Controversial bits (hence RFC) are the introduction of IIO_EV_TYPE_MAG_ADAPTIVE
>> and IIO_EV_TYPE_THRESH_ADAPTIVE, to handle the 'mean' shifted thresholds
>> of this device.  I'm far from convinced these are the right way to go,
>> but best I have come up with just yet.
>>
>> Note this series is completely untested.  I haven't even verified that the
>> new chan spec related bits work right yet (can do that with a dummy driver).
> Hi Jonathan,
> 
> I have a EVAL-AD7156EBZ board, so I should be able to test the driver.
> Can you please push these patches onto your iio-blue git?
> 
Will do. Have fixed the swab16 requirements I think.

Branch is capfun. The push included a few other minor bits and bobs
in the master branch but nothing interesting..



