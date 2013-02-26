Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx3.haw-public.haw-hamburg.de ([141.22.6.2]:40910 "EHLO
	mx3.haw-public.haw-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751434Ab3BZKhD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Feb 2013 05:37:03 -0500
Message-ID: <512C904A.10703@haw-hamburg.de>
Date: Tue, 26 Feb 2013 11:36:58 +0100
From: Carsten Frank <Carsten.Frank@haw-hamburg.de>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
Subject: Re: driver interface for usb spectrometer (like OceanOptics)
References: <5127353B.1040801@haw-hamburg.de> <512B381C.1030201@metafoo.de>
In-Reply-To: <512B381C.1030201@metafoo.de>
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I have now uploaded the files for one spectrometer to sourceforge 
(documentation is still quite weak) ...

http://sourceforge.net/projects/usbspecdrivers/files/

These spectrometers usually take at least one input parameter which is the
- integration time (float or integer)
others also take:
- gain (integer)
- number of flashes (integer) (which is referred to a xenon flash lamp 
and the number of flashes per spectrum)
- start pixel (integer)
- stop pixel (integer)

Typical output parameters are:
- the integration time (float or integer)
- temperature (char string)
- sensor name (char string)
- serial number (char string)
- a0 to a5 (float or char string) which are the wavelength calibration 
parameters
and of course the spectral information from the CCD line which is usually
- 2048 times 16 bit values delivered as bulk (usually embedded in a 
somewhat larger data stream which contains additional information)

I did look up the IIO API and userspace ABI and I do not see a good fit. 
However,
1. I may be wrong
2. someone already saw a kernel driver for such spectrometers and may 
have an idea for an implementation.

Carsten


On 25.02.2013 11:08, Lars-Peter Clausen wrote:
> On 02/22/2013 10:07 AM, Carsten Frank wrote:
>> Hi all.
>>
>> I have written drivers to access Hamamatsu and Avantes usb-spectrometers
>> which express the the following interfaces:
>> One is located in a subdiretory in the the "/sys/bus/usb/drivers/" tree and
>> the other on can be foud in the /dev/ directory.
>>
>> The first is used to configure the spectrometer (e.g. integration_time,
>> gain, etc.) and used to show information like the temperature or the
>> wavelength calibration parameters.
>>
>> The interface in /dev/ is used to aquire the data from the spectrometer
>> (typically 2048 x 2 bytes).
>>
>> Greg (K-H) suggests that the iio interface may be an option so I would like
>> to get some opinions.
>>
>> Thank you very much in advance,
>>
>> Carsten
> Hi,
>
> I don't think we have any spectrometer devices in IIO yet. But it could be a
> fit, maybe requires some extensions to the current IIO API though. Have you
> looked at the IIO API and userspace ABI to see how your device could fit in
> there?
>
> Also what does the data returned by the spectrometer look like? Usually the
> data returned by an IIO device is in some kind of standardized form, so
> generic applications can be written without having to know the exact data
> layout the device uses.
>
> I'm not an expert on how spectrometers work, what kind of parameters they
> have and what the result of a 'conversion' looks like. Maybe you could give
> a short introduction, this would certainly make it easier to figure out how
> this would fit into IIO.
> A pointer to the sourcecode of the current driver could also be useful.
>
> - Lars
