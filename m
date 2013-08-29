Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:64625 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab3H2MgJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 08:36:09 -0400
Received: by mail-we0-f179.google.com with SMTP id t58so362407wes.38
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2013 05:36:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <278a3118-da34-4ef8-a834-ff6f5ecb2d76@email.android.com>
References: <CA+TH9Vk+Z_iWoouy78Kny7qhVrD+3Z=-4KPjeL_Ju67YwskabA@mail.gmail.com>
 <278a3118-da34-4ef8-a834-ff6f5ecb2d76@email.android.com>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Thu, 29 Aug 2013 14:35:27 +0200
Message-ID: <CA+TH9V=+X7s9RcshQ2u5aZATXOWt+VdscYzN0XLHmBHRhR9pmw@mail.gmail.com>
Subject: Re: Advice on mcp3422 driver
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for your reply.

Ok, I understand your points.

So in my case scaling is composed by rawvalue*rates_to_lsb/pga, rate
is setted by writing sampling frequency, pga is setted writing
in_voltage_scale.

2013/8/29 Jonathan Cameron <jic23@kernel.org>:
> Firstly keep this sort Of question on the list as it acts as a reference for others.
>
> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
>>Hi Jonathan,
>>
>>I carefully read your last email and I have some doubts that I want to
>>share with you.
>>I carefully read the documentation and I read the source code for the
>>most
>>other adc drivers, but really cannot understand how it works the
>>raw/scale
>>duo.
>>
> >From my understanding I have to read the raw vale, read the scale
>>value,
>>make some math and have a final value.
> Yes. That is correct
>>
>>So for the mcp3422 I should use rates_to_lsb as base and pga as a
>>multiplier.
>>I can select rates_to_lsb via sampling rate (because they are coupled)
>>and select pga via in_voltageX_scale read/write operations.
>>
>>So what I have now is wrong, because I'm applying math in scale read,
>>instead that should be done from userspace.
>
> The point is that scale should only change as a result of user intervention and so is considered a slow interface. The raw readings are a the fast path hence we keep that to the minimum. Note your scale maths can be implemented as a const lookup table.
> I would be tempted to do it that way both for speed (not crucial) and simplicity of code.
> Putting a comment in to explain the maths would make it clear where the magic numbers come from.
>
> You are right in that it would be nice to do this in user space but it is very difficult to come up with a clean abi that works in all cases!
>>
>>Am I wrong?
>>
>>Can you point me to a documentation to understand better?
> Err. Nope our documentation is awful unfortunately.
>>
>>Thank you!
>
> --
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
