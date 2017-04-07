Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33066 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbdDGGNV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Apr 2017 02:13:21 -0400
Received: by mail-vk0-f54.google.com with SMTP id d188so64005432vka.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Apr 2017 23:13:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJCx=g=E-4i=S+a0euYa8zJd=A2+zH8DgvngQPCF5vydzs+Cww@mail.gmail.com>
References: <20170327100646.GA8128@project> <2bec8c26-f33c-d331-aa97-047871b4cc57@kernel.org>
 <CACRpkdb06PcUwC_zRThLXcw=haiDzuqP-gsVjchNnSWkootT0Q@mail.gmail.com>
 <20170402172949.GA1479@project> <CAJCx=g=E-4i=S+a0euYa8zJd=A2+zH8DgvngQPCF5vydzs+Cww@mail.gmail.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 6 Apr 2017 23:13:18 -0700
Message-ID: <CAJCx=gnBZ3QbqftmuMOKuPKJ5+QBUjq41MireL4_8E0PM3LXiA@mail.gmail.com>
Subject: Re: [PATCH] IIO: bmp280-core.c: fix error in humidity calculation
To: Andreas Klinger <ak@it-klinger.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Aniroop Mathur <a.mathur@samsung.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 3, 2017 at 11:16 PM, Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
> On Sun, Apr 2, 2017 at 10:29 AM, Andreas Klinger <ak@it-klinger.de> wrote:
>> Linus Walleij <linus.walleij@linaro.org> schrieb am Sun, 02. Apr 16:56:
>>> On Sun, Apr 2, 2017 at 11:32 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> > On 27/03/17 11:06, Andreas Klinger wrote:
>>> >> While calculating the compensation of the humidity there are negative
>>> >> values interpreted as unsigned because of unsigned variables used.
>>> >> These values need to be casted to signed as indicated by the documentation
>>> >> of the sensor.
>>> >>
>>> >> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
>>> >
>>> > Looks superficially right to me, but would like an Ack from Linus Walleij.
>>>
>>> I didn't work on these calculations, only infrastructure for the driver
>>> but FWIW:
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> Matt Ranostay @Intel is the person you probably want to ACK it though,
>>> he added the humidity calculations :)
>>
>> It just turned out that there must be another error in the calculation. I'll fix
>> and test it first.
>>
>> When i'm done i'll send a new version of the patch.
>>
>
> Ok will hold off till review till the next patchset... BTW this
> datasheet's calculations made my eyes bleed so it is quiet likely it
> has bugs...

Hmm the datatypes you are casting to s32 are already signed
integers...  Interested in what you found on what the actual bug is.

>
> Thanks,
>
> Matt
>
>> Andreas
>>
>>>
>>> Yours,
>>> Linus Walleij
>>
>> --
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
