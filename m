Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33171 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934237AbcLTQt6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 11:49:58 -0500
Received: by mail-yb0-f196.google.com with SMTP id 84so259043ybe.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2016 08:49:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1612201720550.9386@pmeerw.net>
References: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com>
 <alpine.DEB.2.02.1612201144140.4422@pmeerw.net> <CAKNHny_yV-FV9smGfrX2wR-T7M5uCk9WWG4xNGBMXrAuwVy2ZA@mail.gmail.com>
 <alpine.DEB.2.02.1612201720550.9386@pmeerw.net>
From: Matthias Klumpp <matthias@tenstral.net>
Date: Tue, 20 Dec 2016 17:49:57 +0100
Message-ID: <CAKNHny9M4uQvk_Xg1f0JL5Ob=PzUBFi8=0G1XVwqdkhR1f4P=g@mail.gmail.com>
Subject: Re: Problems with using IIO buffers
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-12-20 17:30 GMT+01:00 Peter Meerwald-Stadler <pmeerw@pmeerw.net>:
> [...]
>
> this is what I use (Ubuntu, Linux 4.4) and it works; maybe the trigger
> name you use is incorrect?
>
> modprobe iio_trig_sysfs
> modprobe iio_dummy (make sure CONFIG_IIO_SIMPLE_DUMMY_BUFFER is #defined)
> cd /sys/bus/iio/devices/iio_sysfs_trigger
> echo 123 > add_trigger
> cd /sys/bus/iio/devices/trigger0
> cat name # should give sysfstrig123
> cd /sys/bus/iio/devices/iio:device0
> echo sysfstrig123 > trigger/current_trigger
> echo 1 > scan_elements/in_voltage0_en
> echo 1 > buffer/enable

This works now, I think I messed up setting the trigger last time
(selected the wrong name, stupid...).
I now trigger the trigger via `echo 1 > trigger0/trigger_now` and try
to read data from the character device via
`iio_readdev /dev/iio:device0`, with the same result as described in
the first post - refilling the buffer doesn't work and I run into a
timeout.
When trying this with my driver, I see that the data polling function
is not called, and when (using the dummy driver) trying to get data
from the /dev/iio:device0 device without using iio_readdev, I also get
no result.

Clearly, it feels like I am missing something obvious here...

Regards,
    Matthias
