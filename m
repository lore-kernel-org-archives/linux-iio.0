Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43221 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbFBWQb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2015 18:16:31 -0400
In-Reply-To: <000f01d09d6b$64f12090$2ed361b0$@capellamicro.com>
References: <1432886683-7467-1-git-send-email-ktsai@capellamicro.com> <alpine.DEB.2.02.1505291042520.16730@pmeerw.net> <556C3667.9030203@kernel.org> <000f01d09d6b$64f12090$2ed361b0$@capellamicro.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [PATCH 1/1] iio: Add iio_mod_light_uva, iio_mod_light_uvb, and iio_mod_light_uvc.
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 02 Jun 2015 23:16:23 +0100
To: Kevin Tsai <ktsai@capellamicro.com>,
	'Jonathan Cameron' <jic23@kernel.org>,
	'Peter Meerwald' <pmeerw@pmeerw.net>
CC: 'Hartmut Knaack' <knaack.h@gmx.de>,
	'Lars-Peter Clausen' <lars@metafoo.de>,
	'Irina Tirdea' <irina.tirdea@intel.com>,
	'Daniel Baluta' <daniel.baluta@intel.com>,
	'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
	'Reyad Attiyat' <reyad.attiyat@gmail.com>,
	linux-iio@vger.kernel.org
Message-ID: <2B54F500-4F9E-4944-B92A-BFA56BFA5C52@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 2 June 2015 20:36:15 BST, Kevin Tsai <ktsai@capellamicro.com> wrote:
>
>UVA is the wavelength from 315nm to 400 nm (from Wikipedia).  Should we
>need
>to define the min/max wavelength?
Not for this case but we probably need a more generic way of defining wavelengths detected as many sensors aren't as conveniently defined.
>
>Can I use "mW/cm^2" as the unit of intensity?
W/m^2 would at least be less random even if the other unit is more common in datasheets!
>
>Kevin
>
>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@kernel.org] 
>Sent: Monday, June 01, 2015 3:40 AM
>To: Peter Meerwald; Kevin Tsai
>Cc: Hartmut Knaack; Lars-Peter Clausen; Irina Tirdea; Daniel Baluta;
>Srinivas Pandruvada; Reyad Attiyat; linux-iio@vger.kernel.org
>Subject: Re: [PATCH 1/1] iio: Add iio_mod_light_uva, iio_mod_light_uvb,
>and
>iio_mod_light_uvc.
>
>On 29/05/15 09:47, Peter Meerwald wrote:
>> On Fri, 29 May 2015, Kevin Tsai wrote:
>> 
>>> Add Ultraviolet(UV) support:
>>> UVA: 315 ~ 400 nm
>>> UVB: 280 ~ 315 nm
>>> UVC: 100 ~ 280 nm
>> 
>> for what sensor chip do you intend this addition?
>> 
>> I'm working on support for the Si1132 which exposes an UV Index 
>> measure, see 
>> http://www.silabs.com/Support%20Documents/TechnicalDocs/Si1132.pdf
>> 
>> I just want to bring it up so we can plan how to support UV...
>We did (long long ago in a galaxy far away) discuss a more general way
>of
>representing light sensors of all types...
>
>The thought was to have additional infomask elements describing the
>frequency range being detected.  It's irritating complex in many cases,
>but
>some rough limits (like 3db points or similar) might be normally
>fine...
>
>We could still keep the types as a generic indicator, but include more
>specifics.
>
>E.g.
>
>in_intensity0_uva_raw
>in_intensity0_uva_min_wavelength
>in_intensity0_uva_max_wavelength
>with units in m (just to stretch our units system ;)
>
>So what other light sensors do people have access to?
>(I have x-ray ones :) though they are all analog.
>With and without various scintilators to make it more complex.
>
>Jonathan
>>  
>>> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
>>> ---
>>>  drivers/iio/industrialio-core.c | 3 +++  
>>> include/uapi/linux/iio/types.h  | 3 +++
>>>  tools/iio/iio_event_monitor.c   | 6 ++++++
>>>  3 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/iio/industrialio-core.c 
>>> b/drivers/iio/industrialio-core.c index 3524b0d..ecbdd1e 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -89,6 +89,9 @@ static const char * const iio_modifier_names[] = {
>>>  	[IIO_MOD_LIGHT_RED] = "red",
>>>  	[IIO_MOD_LIGHT_GREEN] = "green",
>>>  	[IIO_MOD_LIGHT_BLUE] = "blue",
>>> +	[IIO_MOD_LIGHT_UVA] = "uva",
>>> +	[IIO_MOD_LIGHT_UVB] = "uvb",
>>> +	[IIO_MOD_LIGHT_UVC] = "uvc",
>>>  	[IIO_MOD_QUATERNION] = "quaternion",
>>>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>>>  	[IIO_MOD_TEMP_OBJECT] = "object",
>>> diff --git a/include/uapi/linux/iio/types.h 
>>> b/include/uapi/linux/iio/types.h index 2f8b117..5c99090 100644
>>> --- a/include/uapi/linux/iio/types.h
>>> +++ b/include/uapi/linux/iio/types.h
>>> @@ -72,6 +72,9 @@ enum iio_modifier {
>>>  	IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z,
>>>  	IIO_MOD_I,
>>>  	IIO_MOD_Q,
>>> +	IIO_MOD_LIGHT_UVA,
>>> +	IIO_MOD_LIGHT_UVB,
>>> +	IIO_MOD_LIGHT_UVC,
>>>  };
>>>  
>>>  enum iio_event_type {
>>> diff --git a/tools/iio/iio_event_monitor.c 
>>> b/tools/iio/iio_event_monitor.c index 427c271..46dd27f 100644
>>> --- a/tools/iio/iio_event_monitor.c
>>> +++ b/tools/iio/iio_event_monitor.c
>>> @@ -88,6 +88,9 @@ static const char * const iio_modifier_names[] = {
>>>  	[IIO_MOD_LIGHT_RED] = "red",
>>>  	[IIO_MOD_LIGHT_GREEN] = "green",
>>>  	[IIO_MOD_LIGHT_BLUE] = "blue",
>>> +	[IIO_MOD_LIGHT_UVA] = "uva",
>>> +	[IIO_MOD_LIGHT_UVB] = "uvb",
>>> +	[IIO_MOD_LIGHT_UVC] = "uvc",
>>>  	[IIO_MOD_QUATERNION] = "quaternion",
>>>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>>>  	[IIO_MOD_TEMP_OBJECT] = "object",
>>> @@ -156,6 +159,9 @@ static bool event_is_known(struct iio_event_data
>*event)
>>>  	case IIO_MOD_LIGHT_RED:
>>>  	case IIO_MOD_LIGHT_GREEN:
>>>  	case IIO_MOD_LIGHT_BLUE:
>>> +	case IIO_MOD_LIGHT_UVA:
>>> +	case IIO_MOD_LIGHT_UVB:
>>> +	case IIO_MOD_LIGHT_UVC:
>>>  	case IIO_MOD_QUATERNION:
>>>  	case IIO_MOD_TEMP_AMBIENT:
>>>  	case IIO_MOD_TEMP_OBJECT:
>>>
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
