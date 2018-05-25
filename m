Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:40049 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966645AbeEYQBv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 May 2018 12:01:51 -0400
Received: by mail-wm0-f44.google.com with SMTP id x2-v6so8546322wmh.5
        for <linux-iio@vger.kernel.org>; Fri, 25 May 2018 09:01:51 -0700 (PDT)
Received: from denali (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id f10-v6sm6217780wmc.0.2018.05.25.09.01.49
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 09:01:49 -0700 (PDT)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: linux-iio@vger.kernel.org
Subject: isl29501 and multiple calibration registers
Date: Fri, 25 May 2018 18:01:48 +0200
Message-ID: <87a7snd8r7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Hello,

I'm currently working on a driver for the ISL29501 Time of Flight
sensor[1] that I hope to publish soon. This sensor has many calibration
and corrections registers (crosstalk_i, crosstalk_q, crosstalk_gain,
phase_temp_correction ...).

I would like to make all those registers accessible from userspace but
iio_chan_info_enum has no matching elements for most of those registers
which are very specific to this sensor.

Any idea how could I proceed to make those registers accessible?

Thanks in advance,

Mathieu

[1]: https://www.intersil.com/content/dam/intersil/documents/isl2/isl29501.pdf
