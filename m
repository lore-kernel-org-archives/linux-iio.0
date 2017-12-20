Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34895 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754664AbdLTPm3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Dec 2017 10:42:29 -0500
Received: by mail-lf0-f65.google.com with SMTP id j124so24548849lfg.2
        for <linux-iio@vger.kernel.org>; Wed, 20 Dec 2017 07:42:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com> <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 20 Dec 2017 16:41:46 +0100
Message-ID: <CAKv63uscGw61r3Dezf_4-YXo-0JfuFpcuWa5gQa9Uo4J6b5+SA@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
To: David Laight <David.Laight@aculab.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Ian Abbott <abbotti@mev.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20 December 2017 at 15:39, David Laight <David.Laight@aculab.com> wrote:
> From: Crt Mori
>> Sent: 20 December 2017 14:20
>>
>> There is no option to perform 64bit integer sqrt on 32bit platform.
>> Added stronger typed int_sqrt64 enables the 64bit calculations to
>> be performed on 32bit platforms. Although int_sqrt() is a rough
>> approximation, the same algorithm is used in int_sqrt64() as good
>> enough on 32bit platform.
>
> The algorithm used gives an exact (rounded down) square root,
> not an approximation.
>

OK, noted. This is from new changed function indeed - will change in v11.

> With minor changes it ought to be possible to remove most of the
> 64bit arithmetic and shifts.
>
> If you care about performance then using 32 bit maths will be much faster.
>

I need precision not the performance. That is why I would like to
leave int_sqrt as one for good performance while my will be used when
you require a precision.

>         David
>
