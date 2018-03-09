Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:43151 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeCIORC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Mar 2018 09:17:02 -0500
Received: by mail-oi0-f54.google.com with SMTP id a207so7043676oii.10
        for <linux-iio@vger.kernel.org>; Fri, 09 Mar 2018 06:17:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAH8yC8nMqgSS1Z10CuY_AwFRy2Vv6b2GfnPOpqU8HhSNoPu-bw@mail.gmail.com>
References: <20180309131628.GA19442@himanshu-Vostro-3559> <CAH8yC8nMqgSS1Z10CuY_AwFRy2Vv6b2GfnPOpqU8HhSNoPu-bw@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 9 Mar 2018 15:16:40 +0100
Message-ID: <CA+7wUszJLHu-Lm+LcEv+iE=AKyw0nEHsn17n4ziJv9uUjxsRHA@mail.gmail.com>
Subject: Re: Compiling kernel with -Wformat-signedness gcc flag
To: noloader@gmail.com
Cc: Himanshu Jha <himanshujha199640@gmail.com>,
        linux-iio@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jeff,

On Fri, Mar 9, 2018 at 2:24 PM, Jeffrey Walton <noloader@gmail.com> wrote:
> On Fri, Mar 9, 2018 at 8:16 AM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
>> Hello everyone,
>>
>>
>> I just compiled the kernel by passing "-Wformat-signedness" flag
>>
>> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
>>
>> -Wformat-signedness:
>> If -Wformat is specified, also warn if the format string requires an
>> unsigned argument and the argument is signed and vice versa.
>>
>> Now, the C standard says:
>>
>> "If a conversion specification is invalid, the behavior is undefined.
>> If any argument is
>> not the correct type for the corresponding conversion specification, the
>> behavior is *undefined*."
>>
>> For eg:
>>
>> drivers/iio/trigger/stm32-timer-trigger.c:228:24: warning: format =E2=80=
=98%d=E2=80=99
>> expects argument of type =E2=80=98int=E2=80=99, but argument 3 has type =
=E2=80=98unsigned int=E2=80=99
>> [-Wformat=3D]
>>   return sprintf(buf, "%d\n", (unsigned int)freq);
>>                          ~^     ~~~~~~~~~~~~~~~~~~
>>                                                 %d
>>
>> What is the rationale for not including/using this flag in the
>> HOSTCFLAGS in the Makefile ?
>
> In the past, it was posited the toolchain should be smart enough to
> know when the programmer intended/needed a signed value versus an
> unsigned one. Also see
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-11/msg08325.html.

I am not sure this is best example why this flag is not used anymore.
I can see that type-limits is being used. It is even a
-Werror=3Dtype-limits when compiling with W=3D1.

Anyway I see your point, just that the example may be a bit out dated.
