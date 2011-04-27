Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Wed, 27 Apr 2011 16:03:45 +0100
Subject: RE: Oddities and how to handle them.
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com>
References: <4DB6EF2D.9090704@cam.ac.uk> <4DB7FEE8.3080004@analog.com>
 <4DB82B5C.5070900@cam.ac.uk>
In-Reply-To: <4DB82B5C.5070900@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-04-27:
> On 04/27/11 12:32, Michael Hennerich wrote:
>> On 04/26/2011 06:13 PM, Jonathan Cameron wrote:
>>> Hi Michael,

>>> ade7758 - Complex driver I'm not that keen on touching without a lot
>>> of testing support. Don't suppose you want to take this one Michael?
>>> (*looks hopeful*) At lease blugeoning it into more or less current
>>> interfaces would be a great help. I can do it, but then I suspect I'll
>>> break it in a few exciting ways :(
>>>
>> I can fix building on this one. However I currently don't have
>> enough time to fix and document the API.
> That's fine.  We won't be pushing any of the energy meter drivers out
> of staging for a while yet anyway!
>> The buffer scan attribute naming is a bit complicated on this one.
>> Do you think we can stick with wform?
>> There is some interaction with the WAVEFORM MODE Register. Ideally
>> we have enable files for all possible waveform selection
>> possibilities, which are numerous, 3 sources (phases)  * 5
>> measurement options (Current, Voltage, Active Power, Reactive Power
>> and VA). Only one combination can be enabled at a given time, since
>> they are exclusive
> or.
> That sounds right.  One _en attribute per combination.  Probably need
> to clarify the documentation to say that any of these attributes can
> effect any other and userspace should check all values after it has
> configured what it wants.

I guess with the new channel registration I need to use
indio_dev->available_scan_masks for this. And the user has to explicitly
disable the enabled channel and then enable the targeted one...


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
