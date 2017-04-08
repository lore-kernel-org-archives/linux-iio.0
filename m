Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35178 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbdDHGNr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 02:13:47 -0400
Received: by mail-qk0-f171.google.com with SMTP id f133so60902346qke.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Apr 2017 23:13:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AD6B3C1C-0A2A-4941-86E6-D2AFB6446E18@sense.com>
References: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com>
 <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com> <CAN_72e0u+fgOB9TmvP55pDLOC1Z9vGYnNj5Zpogc1b-K7xW7WA@mail.gmail.com>
 <AD6B3C1C-0A2A-4941-86E6-D2AFB6446E18@sense.com>
From: Pavel Roskin <plroskin@gmail.com>
Date: Fri, 7 Apr 2017 23:13:46 -0700
Message-ID: <CAN_72e3-Zzr7b9sLfKk1EGeAYwb03=UrJsGpLOGbR4C-QjOtLw@mail.gmail.com>
Subject: Re: Raw data block input: is IIO a good choice?
To: Jonah Petri <jonah@sense.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonah, I appreciate your advice.

I'm still considering using IIO, as I would need some ways to
configure the hardware (set interrupt watermark, set some other
configuration registers). But it's good to understand why the
resulting driver would be unlike all others.

Pavel
