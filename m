Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35837 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068AbcETN4Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 May 2016 09:56:16 -0400
MIME-Version: 1.0
In-Reply-To: <d6c4ef1cf8ed00ddd930d2e80654e5d7@jic23.retrosnub.co.uk>
References: <CADRpq-CwYpwvwST3+ZHyyn6pquxndC5GJWDKZK7zR8cff_Ky-Q@mail.gmail.com>
	<3E7E6B30-8926-4C0F-ADA6-2750C2A748B5@jic23.retrosnub.co.uk>
	<d6c4ef1cf8ed00ddd930d2e80654e5d7@jic23.retrosnub.co.uk>
Date: Fri, 20 May 2016 15:56:15 +0200
Message-ID: <CADRpq-AKo1dyRizc6+tB4rr3NBwYiQhnNzOeCf56TWR+9TXf0w@mail.gmail.com>
Subject: Re: Drivers for Bitland Dual Accelerometer
From: Lasse Schuirmann <lasse.schuirmann@gmail.com>
To: jic23@jic23.retrosnub.co.uk
Cc: linux-iio@vger.kernel.org, linux-iio-owner@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20 May 2016 at 15:53,  <jic23@jic23.retrosnub.co.uk> wrote:
> On 19.05.2016 22:12, Jonathan Cameron wrote:
>>
>> On 19 May 2016 19:14:52 BST, Lasse Schuirmann
>> <lasse.schuirmann@gmail.com> wrote:
>>>
>>> Hi,
>>>
>>> I'm trying to use Linux on a Lenovo Yoga 300 and can't get the
>>> accelerometer running. It was suggested at
>>>
>>> https://github.com/hadess/iio-sensor-proxy/issues/83#issuecomment-220399560
>>> that I contact this mailing list as no driver seems to exist yet.
>>>
>>> The device in question is an accelerometer from "Bitland Corporation"
>>> with the APCI ID "DUAL250E".
>>>
>>> Windows drivers seem to be available at
>>> http://driverlibs.com/download/Dual-Accelerometer.
>>>
>>> I wonder if somebody possibly has the same problem and/or would be
>>> interested in helping getting this to work.
>>>
>>> Sincerely,
>>>
>>> Lasse Schuirmann
>>
>>
>> Hmm long shot but any idea if it could be a rebadged bma250e which is a
>> Bosch
>>  sensortech part? Not sure what the dual bit would be about though.
>>
>> Digging in those windows drivers may give us more info.  They are on
>> lenovos
>>  website as well.
>>
>> On phone right now but will have a look tomorrow.
>>
>
> Hmm. The driver in question is based on Microsoft's example accelerometer
> driver
> for an ADXL345.
>
> https://msdn.microsoft.com/en-us/library/windows/hardware/dn760713(v=vs.85).aspx
>
> Not sure this is going to get us much further though...
>
> No usefully named function names that I can get out of the
> DualSPDAccelerometer.dll
> Not sure where to go next on reverse engineering this.  Are you willing to
> open things up to take a look at what is on the board?

This is not my device so I can't say definitely but I may well be able
to open it up once if you tell me what you're looking for as I'm not
much of a hardware person.

> Few times I've gotten involved with doing this it's always been a case of
> getting
> some probes on the chip.  There probably are other ways of doing it but
> I've no idea how in windows!
>
> My gut feeling is that Bitland don't make Mems devices so are getting it
> from
> someone else.  Could be wrong, but it's someway from what their core
> business
> seems to be (putting generic stuff together to make machines for other
> people).
>
> Jonathan
