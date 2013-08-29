Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36175 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab3H2POw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 11:14:52 -0400
Received: by mail-wi0-f171.google.com with SMTP id hq12so674342wib.10
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2013 08:14:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <278a3118-da34-4ef8-a834-ff6f5ecb2d76@email.android.com>
References: <CA+TH9Vk+Z_iWoouy78Kny7qhVrD+3Z=-4KPjeL_Ju67YwskabA@mail.gmail.com>
	<278a3118-da34-4ef8-a834-ff6f5ecb2d76@email.android.com>
Date: Thu, 29 Aug 2013 17:14:51 +0200
Message-ID: <CA+TH9V=6gx4AzbExON188kQkmR7XyYr4en0pjLWF251-rMsuVQ@mail.gmail.com>
Subject: Re: Advice on mcp3422 driver
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for your reply.

Ok, I understand your points.

So in my case scaling is composed by rawvalue*rates_to_lsb/pga.

So rate is setted by writing sampling frequency, pga is setted writing
in_voltage_scale.

By the way, reading the scale gives a looked up value by a table that
mixes rate_to_lsb and pga to speed up the scale reading.

In this way there is no easy way to know the current pga value, is this legit?

Thank you!

Il giorno giovedì 29 agosto 2013, Jonathan Cameron <jic23@kernel.org>
ha scritto:
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
>
