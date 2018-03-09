Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33819 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeCINQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Mar 2018 08:16:34 -0500
Received: by mail-pg0-f68.google.com with SMTP id m19so3538068pgn.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Mar 2018 05:16:34 -0800 (PST)
Date: Fri, 9 Mar 2018 18:46:28 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: kernelnewbies@kernelnewbies.org
Cc: linux-iio@vger.kernel.org
Subject: Compiling kernel with -Wformat-signedness gcc flag
Message-ID: <20180309131628.GA19442@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello everyone,


I just compiled the kernel by passing "-Wformat-signedness" flag

https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

-Wformat-signedness:
If -Wformat is specified, also warn if the format string requires an
unsigned argument and the argument is signed and vice versa.

Now, the C standard says:

"If a conversion specification is invalid, the behavior is undefined.
If any argument is
not the correct type for the corresponding conversion specification, the
behavior is *undefined*."

For eg:

drivers/iio/trigger/stm32-timer-trigger.c:228:24: warning: format ‘%d’
expects argument of type ‘int’, but argument 3 has type ‘unsigned int’
[-Wformat=]
  return sprintf(buf, "%d\n", (unsigned int)freq);
                         ~^     ~~~~~~~~~~~~~~~~~~
			                        %d

What is the rationale for not including/using this flag in the
HOSTCFLAGS in the Makefile ?

-- 
Thanks
Himanshu Jha
