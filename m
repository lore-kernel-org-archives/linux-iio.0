Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:35174 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaGaRHY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jul 2014 13:07:24 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so2335353lam.14
        for <linux-iio@vger.kernel.org>; Thu, 31 Jul 2014 10:07:22 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 31 Jul 2014 22:37:22 +0530
Message-ID: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>
Subject: IIO: Why cannot open two iio device node file descriptors
 simultaneously ?
From: Aniroop Mathur <aniroop.mathur@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear IIO Community,
Greetings !!

I am Aniroop Mathur working in Sensors kernel and HAL field.
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

Thanks in advance !
