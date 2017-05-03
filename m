Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:52362 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbdECItg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 May 2017 04:49:36 -0400
Subject: Re: [PATCH v2] iio: adc: Add support for TI ADC1x8s102
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <c0fa84e3-1016-212f-280c-40bb83706895@siemens.com>
 <CAHp75VcG4qQktEOCXKc2saTNzpWo2sjneA4Afb7rHoEqkP8FtQ@mail.gmail.com>
 <8e6a0016-175a-8374-76f9-8bef1815f66f@siemens.com>
 <CAHp75VeyQ=uU=X3DxcNtVKDqkQV=9wK42nDaxs4ztDBU5iKTRw@mail.gmail.com>
 <395643b8-c5cc-6a50-f424-98b4c5ec339b@siemens.com>
 <CAHp75VeBa8wUX6U+S=QmrLmqrwdMuFg3TCw3nyY62NraZaDrNg@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <920e159a-d082-3879-5d8b-f407c5df5915@metafoo.de>
Date: Wed, 3 May 2017 10:49:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VeBa8wUX6U+S=QmrLmqrwdMuFg3TCw3nyY62NraZaDrNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/2017 10:43 AM, Andy Shevchenko wrote:
>>>>>> +               .owner  = THIS_MODULE,
>>>>>
>>>>> This is redundant I'm pretty sure.
>>>>
>>>> Even in 2017, drivers keep being added that carry such assignments. Can
>>>> you explain when it is needed and when not? Otherwise, I will leave it in.
>>>
>>> The above I'm 100% sure is not needed. It's needed only in cases when
>>> framework / device core doesn't do this for ya.
>>>
>>> In the above case IIRC device core does it once for all.
> 
>> Then this is not consistently filtered out in new driver reviews. I can
>> remove it, of course.
> 
> Please, remove.
> 
> I guess many of new drivers just lack of proper review :-(
> 

The kbuild bot will even send automated patches to remove the owner field if
a patch that has the owner field is merged. So definitely remove it.
