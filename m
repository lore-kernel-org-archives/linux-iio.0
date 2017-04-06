Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33153 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933835AbdDFOYT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2017 10:24:19 -0400
Received: by mail-oi0-f53.google.com with SMTP id b187so53136680oif.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Apr 2017 07:24:18 -0700 (PDT)
MIME-Version: 1.0
From: George McCollister <george.mccollister@gmail.com>
Date: Thu, 6 Apr 2017 09:24:17 -0500
Message-ID: <CAFSKS=O-CrzxA6RJxrMNR=Vz-dN+zn1B95d+fUbUGcghRQgAjA@mail.gmail.com>
Subject: Digital I/O in IIO
To: "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In many industrial applications it's common to mix digital (binary)
and analog I/O. In many cases digital input modules have change
buffers and sometimes event time stamping capabilities. While the gpio
subsystem can support software timestamping and buffering it doesn't
fit well for many industrial digital applications where the host
process reads buffered digital samples or events from input modules.

Would anyone appose or support the addition of digital channel type or
suggest an alternative path to supporting this use case?

A possible alternative is to use 1 bit for storage and use voltage for
type. For instance a 16 channel 24V DC Input module would present 16
input voltage channels with 1 bit of storage each. 0 would correspond
to 0VDC and 1 to 24VDC.

Cheers,
George McCollister
Software Architect
NovaTech LLC
