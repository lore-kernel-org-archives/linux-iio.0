Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-42.csi.cam.ac.uk ([131.111.8.142]:56487 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759571Ab3BZQNp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Feb 2013 11:13:45 -0500
Message-ID: <512CDF35.8070204@jic23.retrosnub.co.uk>
Date: Tue, 26 Feb 2013 16:13:41 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Carsten Frank <Carsten.Frank@haw-hamburg.de>
CC: linux-iio@vger.kernel.org
Subject: Re: driver interface for usb spectrometer (like OceanOptics)
References: <5127353B.1040801@haw-hamburg.de> <512B381C.1030201@metafoo.de> <512C904A.10703@haw-hamburg.de>
In-Reply-To: <512C904A.10703@haw-hamburg.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/02/13 10:36, Carsten Frank wrote:
> Hi,
>
> I have now uploaded the files for one spectrometer to sourceforge
> (documentation is still quite weak) ...
>
> http://sourceforge.net/projects/usbspecdrivers/files/
>
> These spectrometers usually take at least one input parameter which is the
> - integration time (float or integer)
> others also take:
> - gain (integer)
> - number of flashes (integer) (which is referred to a xenon flash lamp
> and the number of flashes per spectrum)
> - start pixel (integer)
> - stop pixel (integer)
>
> Typical output parameters are:
> - the integration time (float or integer)
> - temperature (char string)
> - sensor name (char string)
> - serial number (char string)
> - a0 to a5 (float or char string) which are the wavelength calibration
> parameters
> and of course the spectral information from the CCD line which is usually
> - 2048 times 16 bit values delivered as bulk (usually embedded in a
> somewhat larger data stream which contains additional information)
>
> I did look up the IIO API and userspace ABI and I do not see a good fit.
> However,
> 1. I may be wrong
My gut feeling is that there 'ought to be a better option'.  It almost 
looks like a line scan camera, but then they aren't particularly well 
supported (from what I recall).

Having said that, if there isn't a better option then IIO does define
interfaces that would allow you to handle such a dataflow.  Two options
occur to me.

1) Treat all the 'pixels' as individual adc channels and the whole
thing as a scan.  This is going to result in a seriously large pile
of attributes in sysfs, so probably isn't feasible.

2) Treat the device as one adc that happens to take 2048 readings
every time it is 'triggered' and have wavelength parameters as 
appropriately defined attributes of this channel.  If you did that
I can see we would benefit from support for describing just how
many samples are taken per trigger. (makes sense in other cases rather
than just here - I have normal adc's that will do this sort of capture).

If you handled this in IIO I think you'd have to have a matched chunk
of userspace code that knows rather a lot about the sensor.  Normally
we'd do a our best to avoid this and as such I suspect that
these devices really deserve a more specific home.

What sort of sampling rate are we talking about and it is something
you would run continuously or would you just be polling for a reading?

Having said all of this, whilst these are some of the more interesting
sensors we have dealt with, I'm happy to work with you on the IIO 
interface extensions needed etc if you decide IIO is the way to go.
Jonathan


> 2. someone already saw a kernel driver for such spectrometers and may
> have an idea for an implementation.
>
> Carsten
>
>
> On 25.02.2013 11:08, Lars-Peter Clausen wrote:
>> On 02/22/2013 10:07 AM, Carsten Frank wrote:
>>> Hi all.
>>>
>>> I have written drivers to access Hamamatsu and Avantes usb-spectrometers
>>> which express the the following interfaces:
>>> One is located in a subdiretory in the the "/sys/bus/usb/drivers/"
>>> tree and
>>> the other on can be foud in the /dev/ directory.
>>>
>>> The first is used to configure the spectrometer (e.g. integration_time,
>>> gain, etc.) and used to show information like the temperature or the
>>> wavelength calibration parameters.
>>>
>>> The interface in /dev/ is used to aquire the data from the spectrometer
>>> (typically 2048 x 2 bytes).
>>>
>>> Greg (K-H) suggests that the iio interface may be an option so I
>>> would like
>>> to get some opinions.
>>>
>>> Thank you very much in advance,
>>>
>>> Carsten
>> Hi,
>>
>> I don't think we have any spectrometer devices in IIO yet. But it
>> could be a
>> fit, maybe requires some extensions to the current IIO API though.
>> Have you
>> looked at the IIO API and userspace ABI to see how your device could
>> fit in
>> there?
>>
>> Also what does the data returned by the spectrometer look like?
>> Usually the
>> data returned by an IIO device is in some kind of standardized form, so
>> generic applications can be written without having to know the exact data
>> layout the device uses.
>>
>> I'm not an expert on how spectrometers work, what kind of parameters they
>> have and what the result of a 'conversion' looks like. Maybe you could
>> give
>> a short introduction, this would certainly make it easier to figure
>> out how
>> this would fit into IIO.
>> A pointer to the sourcecode of the current driver could also be useful.
>>
>> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

