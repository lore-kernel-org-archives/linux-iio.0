Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35303 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbaHARR4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Aug 2014 13:17:56 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so3400695lbd.22
        for <linux-iio@vger.kernel.org>; Fri, 01 Aug 2014 10:17:55 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 1 Aug 2014 22:47:54 +0530
Message-ID: <CADYu308E631koBmSDR0VO2OaT+fn-F3qeuC6tNxQFys+f3HYxw@mail.gmail.com>
Subject: IIO: Why cannot open two iio device node file descriptors
 simultaneously ?
From: Aniroop Mathur <aniroop.mathur@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Mr. Jonathan Cameron and IIO Community,
Greetings of the day !! :)

I am Aniroop Mathur working in Sensors kernel and HAL field for last two years
I have one question about IIO, for which i need your support.

I would like to open two file descriptors for IIO device node - /dev/iio:device0
int fd1 = open("/dev/iio:device0",O_RDONLY);
int fd2 = open("/dev/iio:device0",O_RDONLY);

But, only first open call succeeds.
The second open calls fails with error "Device or Resource busy".

In normal input device, we can open as many event node file
descriptors as we like.
int fd1 = open("/dev/input/event1");
int fd2 = open("/dev/input/event1");

Both calls succeeds for input subsystem case.

So, why restriction is present in IIO subsystem ?
Why two iio device nodes cannot be open together ?

Thanks a lot in advance !

Regards,
Aniroop Mathur
