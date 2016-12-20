Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:34032 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932609AbcLTQaX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Dec 2016 11:30:23 -0500
Date: Tue, 20 Dec 2016 17:30:21 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matthias Klumpp <matthias@tenstral.net>
cc: linux-iio@vger.kernel.org
Subject: Re: Problems with using IIO buffers
In-Reply-To: <CAKNHny_yV-FV9smGfrX2wR-T7M5uCk9WWG4xNGBMXrAuwVy2ZA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1612201720550.9386@pmeerw.net>
References: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com> <alpine.DEB.2.02.1612201144140.4422@pmeerw.net> <CAKNHny_yV-FV9smGfrX2wR-T7M5uCk9WWG4xNGBMXrAuwVy2ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> >> I am having troubles getting buffers to work with IIO. Querying raw
> >> data from devices works well via sysfs, but buffered input from ADCs
> >> does not work.
> >
> > how do you setup the buffer from userspace? see e.g.
> > http://events.linuxfoundation.org/sites/events/files/slides/lceu15_baluta.pdf,
> > page 21
> 
> I used what iio_readdev does, but setting up the buffer manually on
> sysfs (using a sysfs trigger as current_trigger), I get
> "echo: write error: Invalid argument" when trying to enable the buffer
> (writing 1 to buffer/enable).
> 
> I tried this on the iio_dummy module, enabling the in_voltage0 channel.

this is what I use (Ubuntu, Linux 4.4) and it works; maybe the trigger 
name you use is incorrect?

modprobe iio_trig_sysfs
modprobe iio_dummy (make sure CONFIG_IIO_SIMPLE_DUMMY_BUFFER is #defined)
cd /sys/bus/iio/devices/iio_sysfs_trigger
echo 123 > add_trigger
cd /sys/bus/iio/devices/trigger0
cat name # should give sysfstrig123
cd /sys/bus/iio/devices/iio:device0
echo sysfstrig123 > trigger/current_trigger
echo 1 > scan_elements/in_voltage0_en
echo 1 > buffer/enable

regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
