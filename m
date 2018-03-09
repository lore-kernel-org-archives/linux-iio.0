Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:46142 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeCINYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Mar 2018 08:24:20 -0500
Received: by mail-ot0-f176.google.com with SMTP id g97so8621674otg.13
        for <linux-iio@vger.kernel.org>; Fri, 09 Mar 2018 05:24:20 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
In-Reply-To: <20180309131628.GA19442@himanshu-Vostro-3559>
References: <20180309131628.GA19442@himanshu-Vostro-3559>
From: Jeffrey Walton <noloader@gmail.com>
Date: Fri, 9 Mar 2018 08:24:19 -0500
Message-ID: <CAH8yC8nMqgSS1Z10CuY_AwFRy2Vv6b2GfnPOpqU8HhSNoPu-bw@mail.gmail.com>
Subject: Re: Compiling kernel with -Wformat-signedness gcc flag
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 9, 2018 at 8:16 AM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Hello everyone,
>
>
> I just compiled the kernel by passing "-Wformat-signedness" flag
>
> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
>
> -Wformat-signedness:
> If -Wformat is specified, also warn if the format string requires an
> unsigned argument and the argument is signed and vice versa.
>
> Now, the C standard says:
>
> "If a conversion specification is invalid, the behavior is undefined.
> If any argument is
> not the correct type for the corresponding conversion specification, the
> behavior is *undefined*."
>
> For eg:
>
> drivers/iio/trigger/stm32-timer-trigger.c:228:24: warning: format =E2=80=
=98%d=E2=80=99
> expects argument of type =E2=80=98int=E2=80=99, but argument 3 has type =
=E2=80=98unsigned int=E2=80=99
> [-Wformat=3D]
>   return sprintf(buf, "%d\n", (unsigned int)freq);
>                          ~^     ~~~~~~~~~~~~~~~~~~
>                                                 %d
>
> What is the rationale for not including/using this flag in the
> HOSTCFLAGS in the Makefile ?

In the past, it was posited the toolchain should be smart enough to
know when the programmer intended/needed a signed value versus an
unsigned one. Also see
http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-11/msg08325.html.

Jeff
