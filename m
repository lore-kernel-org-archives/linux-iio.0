Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:39300 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3GRBsL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 21:48:11 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so3135499obc.10
        for <linux-iio@vger.kernel.org>; Wed, 17 Jul 2013 18:48:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <814feb73-b2b3-4f23-8066-4221b75ac0b9@email.android.com>
References: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com>
	<814feb73-b2b3-4f23-8066-4221b75ac0b9@email.android.com>
Date: Wed, 17 Jul 2013 22:48:10 -0300
Message-ID: <CAP9ODKr4qC3EuRwbx9=dcTMvYjT2sAMTdBBsYs_-Z82rQ0e2DQ@mail.gmail.com>
Subject: Re: ADC setting for differential and single-ended channels
From: Otavio Salvador <otavio@ossystems.com.br>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Mario Goulart <mario@ossystems.com.br>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 17, 2013 at 4:12 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> Otavio Salvador <otavio@ossystems.com.br> wrote:
>>Hello,
>>
>>Mario and I are working at TI ADS124x driver and this chip can be used
>>in two ways:
>>
>>In case of ADS1247:
>>
>> - 2 differential channels
>> - 3 single-ended channels
>>
>>In the first case it take two inputs and the chip returns the
>>difference between them; in the second case it does the same but you
>>must choose one channel to be the negative reference for all the other
>>inputs. This is how we understood the datasheet however the
>>single-ended use is quite confusing on it so we might be wrong.
>>
>>So we'd like to know the best way to handle those cases in the driver.
>>One alternative we discussed is to use two attributes in the dts as:
>>
>> ...
>> #channels = <2>;
>> channels = <0 3
>>                    1 2>;
>>
>>So it'd take two channels. One composed by input 0 and input 3 and
>>another composed by input 1 and input 2.
>>
>>On the another case, we'd use:
>>
>>  ...
>>  #channels = <3>
>>  channels = <0 3
>>                     1 3
>>                     2 3>;
>>
>>So it'd take three channels and all them comparing to input 3.
>>
>>Are we in the right route? Any hints how to better solve this?
>
> Another option is to leave it entirely up to user space.  See max1363 driver where both single ended and differential channels are supported at the same time with care taken in buffered mode.
>
> Not sure if that works for your case?

I think it is nicer to have it set in the dt; we need the dt anyway so
it seems logical to get it setting  the right channel.

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
