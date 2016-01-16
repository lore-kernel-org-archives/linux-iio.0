Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53551 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbcAPM5F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 07:57:05 -0500
Subject: Re: [PATCH] iio: light: acpi-als: Report data as processed rather
 than raw
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
References: <1452180105-9584-1-git-send-email-gabriele.mzt@gmail.com>
 <569135DC.2090400@kernel.org> <201601091827.50571.marex@denx.de>
 <56940003.2040209@kernel.org>
 <CABFtUbRT2bWsUCn6sCxytZDoAV5hC9rojpJUwXJrt2EEXyCSVA@mail.gmail.com>
Cc: Marek Vasut <marex@denx.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Martin_Li=c5=a1ka?= <marxin.liska@gmail.com>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A3E20.9080707@kernel.org>
Date: Sat, 16 Jan 2016 12:57:04 +0000
MIME-Version: 1.0
In-Reply-To: <CABFtUbRT2bWsUCn6sCxytZDoAV5hC9rojpJUwXJrt2EEXyCSVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/16 15:27, Gabriele Mazzotta wrote:
> 2016-01-11 20:18 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
>> On 09/01/16 17:27, Marek Vasut wrote:
>>> On Saturday, January 09, 2016 at 05:31:24 PM, Jonathan Cameron wrote:
>>>> On 07/01/16 15:21, Gabriele Mazzotta wrote:
>>>>> As per the ACPI specification (Revision 5.0) [1], the data coming
>>>>> from the sensor represent the ambient light illuminance reading
>>>>> expressed in lux. Use IIO_CHAN_INFO_PROCESSED instead of
>>>>> IIO_CHAN_INFO_RAW to signify that the data are pre-processed.
>>>>>
>>>>> [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
>>>>>
>>>>> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
>>>>
>>>> Hm. Whilst it's a fix in a sense, the original didn't really 'break'
>>>> the ABI so I worry a little that this change may break others.
>>>> Irritating as it is, perhaps we should keep the _RAW and add _PROCESSED
>>>> (which will then be exactly the same value).
>>>> We'll also then need a comment in the code, that leaving the _RAW
>>>> elements was for ABI compatibility.
>>>>
>>>> What do others think?
>>>
>>> I'm not an IIO guru, but this does sound sensible. Do you know if any userland
>>> code which actually uses the ACPI ALS already ?
>> It's more than likely as Gnome at least supports using them to control screen
>> brightness.  Hopefully that code is able to cope with the correct ABI though as
>> well as the old one.  Anyhow, we seem to have a reasonable consensus.
> 
> I looked into this and Gnome uses iio-proxy-sensor to handle iio
> devices. As of now it, only looks for in_illuminance_input, so it
> currently doesn't work with acpi-als. I've also found a bug report [1]
> of an acpi-als user stating the same.
> 
> [1] https://github.com/hadess/iio-sensor-proxy/issues/46
Good fine. I'll apply this as a fix in that case and mark it for stable.

Jonathan
> 
>> Gabriele, are you happy to do a version of the patch with the _RAW version
>> left along side your _PROCESSED version and a comment saying that it is for
>> compatibility only?
>>
>> Jonathan
>>>
>>> Best regards,
>>> Marek Vasut
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

