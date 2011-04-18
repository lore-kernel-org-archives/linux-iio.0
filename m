Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55087 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab1DRKBZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2011 06:01:25 -0400
Message-ID: <4DAC0C6A.7000105@cam.ac.uk>
Date: Mon, 18 Apr 2011 11:03:22 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 1/1] IIO: DAC: New driver for AD5791/AD5781 High Resolution
 Voltage Output DACs
References: <1302783984-26300-1-git-send-email-michael.hennerich@analog.com> <4DA87440.6000609@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771375475E5F5@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771375475E5F5@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/18/11 09:27, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-04-15:
>> On 04/14/11 13:26, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>> Yikes. That union stuff for the transfers is ugly. Having said that I
>> can't immediately see a better way of doing it.
>> Otherwise another nice clean an easy to read driver. Thanks, I don't
>> think I've overly broken anything in here with the recent changes.
>> The only acception is adding a 0 parameter to iio_allocate_device.
>>
>> That kind of depends on when Greg picks up the last set I sent him.
>>
>> The other cleanup that applies here is to set indio_dev->name and get
>> rid of the explicit name attribute.  Can do that one later though as
>> it will still work as is.  Just saves a few lines of code.
> 
> I've sent Greg the driver.
> Hope he gets the ordering right on how this one interferes with your
> [PATCH 4/8] set.
Fingers crossed.
> 
> As for you your [PATCH x/70] set feel free to add my Acked-by on the
> relevant patches. How do you want to handle these?
> When do you want to send it on to Greg?
Not for a few days. Need to do some work on the day job :)
> 
> In case you want to wait for a few days, I test a few devices and
> send you some patches, that moves the missing ones over to the new
> channel registration method.
That would be excellent.
> I'll do that on top of your todays iio-onwards.
Cool. I'll slot those into the series in the appropriate places, so it'll
be rebased from time to time.

I have another small series that cleans up the buffer allocation and handling
code, but I'll hold adding that to the tree for now as it involves some
minor interfaces changes in some of the drivers you'll be adding the chan_spec
stuff to.

Thanks

Jonathan
> 
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

