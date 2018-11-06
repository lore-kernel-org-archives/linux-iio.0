Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:45399 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFKdu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Nov 2018 05:33:50 -0500
Received: by mail-io1-f65.google.com with SMTP id p83-v6so8020947iod.12
        for <linux-iio@vger.kernel.org>; Mon, 05 Nov 2018 17:11:16 -0800 (PST)
MIME-Version: 1.0
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Mon, 5 Nov 2018 23:11:04 -0200
Message-ID: <CAHd-oW68iJ=m2Woz63bVwnK_cCJi2uF2e0_EVur6DHJLRmKw+A@mail.gmail.com>
Subject: Question about max frequency in ad2s90
To: linux-iio@vger.kernel.org, graf.yang@analog.com,
        jic23@jic23.retrosnub.co.uk,
        Michael Hennerich <Michael.Hennerich@analog.com>
Cc: kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello everyone,

While working on the ad2s90 driver, I had a question about the maximum
frequency set. Any feedback will be much appreciated.

The ad2s90 driver sets its maximum speed to 830000hz (or 0.83Mhz), but
the datasheet [1] specifies a maximum of 2Mhz. Above the max_speed_hz
setup, there's a commentary saying  "need 600ns between CS and the
first falling edge of SCLK", which is also said in the datasheet.

Is max_speed_hz set to 0.83Mhz, not 2Mhz, due to the required minimum
delay of 600ns, somehow? If not:
  1) is 0.83Mhz really correct? and
  2) is the minimum delay of 600ns being respected?

Thanks,
Matheus.

[1] https://www.analog.com/media/en/technical-documentation/data-sheets/AD2S90.pdf
