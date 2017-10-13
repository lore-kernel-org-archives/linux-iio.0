Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:53331 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbdJMNtj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Oct 2017 09:49:39 -0400
Received: by mail-wm0-f51.google.com with SMTP id q132so21936959wmd.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Oct 2017 06:49:39 -0700 (PDT)
MIME-Version: 1.0
From: Dmitry Mastykin <mastichi@gmail.com>
Date: Fri, 13 Oct 2017 16:49:37 +0300
Message-ID: <CALieaef=jiHBJKrOY9KAr_PMHbrJhrjc9YQ=q+ukir+Ujg+opw@mail.gmail.com>
Subject: max1363 driver not working with iio_generic_buffer tool
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,
(I'm sorry, the question may be too simple for this mailing list)
I'm working with max1136 via max1363 driver.
I can read raw values via sysfs.
But I cannot use it with iio_generic_buffer.

I enable a channel:
  echo 1 | sudo tee
/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage0_en

and then:
  sudo ./iio_generic_buffer -g -n max1136

returns:
  Failed to enable buffer: Invalid argument

whilst with TI-am335x-adc driver I can read values.
Please suggest me what to try, or may be INDIO_DIRECT_MODE doesn't
suppose work with the buffer?
Thank you very much,
Dmitry Mastykin
