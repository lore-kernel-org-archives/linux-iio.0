Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:27257
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757270Ab1D1Igi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 28 Apr 2011 04:36:38 -0400
Received: from mail40-ch1 (localhost.localdomain [127.0.0.1])	by
 mail40-ch1-R.bigfish.com (Postfix) with ESMTP id B133114900D2	for
 <linux-iio@vger.kernel.org>; Thu, 28 Apr 2011 08:36:35 +0000 (UTC)
Received: from CH1EHSMHS009.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail40-ch1.bigfish.com (Postfix) with ESMTP id
 65C441A50051	for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2011 08:36:35 +0000
 (UTC)
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Date: Thu, 28 Apr 2011 09:36:27 +0100
Subject: RE: Oddities and how to handle them.
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAEE15A62@LIMKCMBX1.ad.analog.com>
References: <4DB6EF2D.9090704@cam.ac.uk> <4DB7FEE8.3080004@analog.com>
 <4DB82B5C.5070900@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com>
 <4DB8322A.6050207@cam.ac.uk>
In-Reply-To: <4DB8322A.6050207@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-04-27:
> On 04/27/11 16:03, Hennerich, Michael wrote:
>> Jonathan Cameron wrote on 2011-04-27:
>>> On 04/27/11 12:32, Michael Hennerich wrote:
>>>> On 04/26/2011 06:13 PM, Jonathan Cameron wrote:
>>>>> Hi Michael,
>>>>>
>>>>> ade7758 - Complex driver I'm not that keen on touching without a lot
>>>>> of testing support. Don't suppose you want to take this one Michael?
>>>>> (*looks hopeful*) At lease blugeoning it into more or less current
>>>>> interfaces would be a great help. I can do it, but then I suspect
>>>>> I'll break it in a few exciting ways :(
>>>>>
>>>> I can fix building on this one. However I currently don't have
>>>> enough time to fix and document the API.
>>> That's fine.  We won't be pushing any of the energy meter drivers out
>>> of staging for a while yet anyway!
>>>> The buffer scan attribute naming is a bit complicated on this one.
>>>> Do you think we can stick with wform?
>>>> There is some interaction with the WAVEFORM MODE Register. Ideally
>>>> we have enable files for all possible waveform selection
>>>> possibilities, which are numerous, 3 sources (phases)  * 5
>>>> measurement options (Current, Voltage, Active Power, Reactive
>>>> Power and VA). Only one combination can be enabled at a given
>>>> time, since they are exclusive
>>> or.

Hi Jonathan,

For the metering parts I think we need to define a few more channel types.

How about this ones

inSX            S is the apparent power.
inPX            P is the active power.
inQX            Q is the reactive power.
inVX            V is the voltage. (only inX ?)
inVRMSX VRMS is the quadratic mean voltage.
inIX            I is the current.
inIRMSX IRMS is the quadratic mean current.

Since they won't be really popular

How about using a string in iio_chan_type_name_spec

        [IIO_IN_GENERIC] = "in%s",


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


