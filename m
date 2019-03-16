Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E5C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 18:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A14D206BA
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 18:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCPSdw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:33:52 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46092 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPSdw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Mar 2019 14:33:52 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5937A9E6A65;
        Sat, 16 Mar 2019 18:33:49 +0000 (GMT)
Date:   Sat, 16 Mar 2019 18:33:48 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: Debugging 3D sensor on Lenovo YOGA 700-11ISK
Message-ID: <20190316183348.76573887@archlinux>
In-Reply-To: <eb33acca-f48d-a689-c5e7-6f9b66f50caf@ozlabs.ru>
References: <eb33acca-f48d-a689-c5e7-6f9b66f50caf@ozlabs.ru>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


+CC bastien and (guessing it is a HID sensor) Srinivas.
On Sat, 16 Mar 2019 20:16:39 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Hi!
> 
> I got a quite old Lenovo YOGA 700-11ISK with flip screen and run
> fedora29 on it. I found that gnome3 cannot properly detect the screen
> orientation and the screen keeps rotating non stop.
> 
> I opened an issue agains iio-sensor-proxy, not much luck there.
> https://github.com/hadess/iio-sensor-proxy/issues/220
> 
> I resumed my debugging and the situation seems improving.
> 
> The yoga is running fedora29 v4.20.14. The fedora's iio-sensor-proxy
> still has this problem and so does the iio-sensor-proxy upstream version.
> 
> Then I commented out &iio_buffer_accel to make &iio_poll_accel work -
> and things worked nicely. I looked in sysfs and in_accel_?_raw seem to
> have correct values (same as in the first log below, give or take), all
> good. Recorded some debug from iio-sensor-proxy:
> 
> Accel read from IIO on 'accel_3d': -39, -937, -378 (scale 0.009807)
> Accel sent by driver (quirk applied): -39, -937, -378 (scale: 0.009807)
> Emitted orientation changed: from undefined to normal
> No new data available on 'iio:device3'
> Accel read from IIO on 'accel_3d': -39, -933, -371 (scale 0.009807)
> Accel sent by driver (quirk applied): -39, -933, -371 (scale: 0.009807)
> No new data available on 'iio:device3'
> Accel read from IIO on 'accel_3d': -39, -933, -367 (scale 0.009807)
> Accel sent by driver (quirk applied): -39, -933, -367 (scale: 0.009807)
> 
> This is the good log, gnome works fine.
> 
> 
> Then I recorded debug with the buffer driver enabled:
> 
> rocess_scan_1: channel_index: 0, chan_name: in_accel_x,
> channel_data_index: 0 location: 0
> process_scan_1: channel_index: 1, chan_name: in_accel_y,
> channel_data_index: 1 location: 4
> process_scan_1: channel_index: 2, chan_name: in_accel_z,
> channel_data_index: 2 location: 8
> Accel read from IIO on 'iio:device4': -15, -898, -375 (scale 0.009807)
> Accel sent by driver (quirk applied): -15, -898, -375 (scale: 0.009807)
> Emitted orientation changed: from undefined to normal
> No new data available on 'iio:device3'
> process_scan_1: channel_index: 0, chan_name: in_accel_x,
> channel_data_index: 0 location: 0
> process_scan_1: channel_index: 1, chan_name: in_accel_y,
> channel_data_index: 1 location: 4
> process_scan_1: channel_index: 2, chan_name: in_accel_z,
> channel_data_index: 2 location: 8
> Accel read from IIO on 'iio:device4': 20774, 27203, 0 (scale 0.009807)
> Accel sent by driver (quirk applied): 20774, 27203, 0 (scale: 0.009807)
> Emitted orientation changed: from normal to left-up
> No new data available on 'iio:device3'
> process_scan_1: channel_index: 0, chan_name: in_accel_x,
> channel_data_index: 0 location: 0
> process_scan_1: channel_index: 1, chan_name: in_accel_y,
> channel_data_index: 1 location: 4
> process_scan_1: channel_index: 2, chan_name: in_accel_z,
> channel_data_index: 2 location: 8
> Accel read from IIO on 'iio:device4': -31, -929, -398 (scale 0.009807)
> Accel sent by driver (quirk applied): -31, -929, -398 (scale: 0.009807)
> Emitted orientation changed: from left-up to normal
> No new data available on 'iio:device3'
> process_scan_1: channel_index: 0, chan_name: in_accel_x,
> channel_data_index: 0 location: 0
> process_scan_1: channel_index: 1, chan_name: in_accel_y,
> channel_data_index: 1 location: 4
> process_scan_1: channel_index: 2, chan_name: in_accel_z,
> channel_data_index: 2 location: 8
> Accel read from IIO on 'iio:device4': -14345, -32024, 12738 (scale 0.009807)
> Accel sent by driver (quirk applied): -14345, -32024, 12738 (scale:
> 0.009807)
> 
> So it is good reading, bad reading, good reading, bad reading, and gnome
> rotates the screen non stop. No wonder gnome3 goes crazy.
> 
> I would debug further and even come up with a fix but I failed to find
> quickly where there reads are handled in the kernel, and what defines
> these in_accel_?_raw files in sysfs, tried grepping - nothing. Any pointers?

The raw files are built by the IIO core to call the read_raw callback in the
each driver.  The path for buffered data is very different. Ultimately
it goes through a call to iio_push_to_buffers.

> 
> 
> Also, how do I identify my particular 3d sensor? Or it is the same model
> everywhere? Or it is the driver for all of them?
Lots an lots and lots of drivers ;)   But in laptops they are often
hid-sensors, or at least there is a little microcontroller that handles
the different streams and reformats them as hid sensor records.

> 
> Here is dmesg | grep i2c:

First of all, let us check the device. I'm going to guess it's a hid
sensor of some type.
Could you cat
/sys/bus/iio/devices/iio\:device0/name

When iio-sensor-proxy is running (or after you've killed it) check
what the values in the various files in
/sys/bus/iio/devices/iio\:device0/scan_elements/* 
are.  One thought is we have some unexpected channels enabled and
the code is thinking they are acceleration when they aren't.

> 
> [root@aikyoga iio:device4]# dmesg | egrep '(i2c|iio)'
> [    5.389867] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply vdd not
> found, using dummy regulator
> [    5.389893] i2c_hid i2c-ITE8350:00: Linked as a consumer to regulator.0
> [    5.389896] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply vddl not
> found, using dummy regulator
> [    5.502896] hid-generic 0018:048D:8350.0002: hidraw1: I2C HID v1.00
> Device [ITE8350:00 048D:8350] on i2c-ITE8350:00
> [    5.528455] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00 supply vdd not
> found, using dummy regulator
> [    5.528485] i2c_hid i2c-SYNA2B23:00: Linked as a consumer to regulator.0
> [    5.528489] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00 supply vddl not
> found, using dummy regulator
> [    5.543440] input: SYNA2B23:00 06CB:2714 Mouse as
> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-SYNA2B23:00/0018:06CB:2714.0003/input/input13
> [    5.543690] hid-generic 0018:06CB:2714.0003: input,hidraw2: I2C HID
> v1.00 Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
> [    6.053237] input: Synaptics TM2714-002 as
> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-SYNA2B23:00/0018:06CB:2714.0003/input/input16
> [    6.053444] hid-rmi 0018:06CB:2714.0003: input,hidraw1: I2C HID v1.00
> Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
> 
> Thanks!
> 
> 

