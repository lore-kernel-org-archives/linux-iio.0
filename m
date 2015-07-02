Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35854 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbbGBKn2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jul 2015 06:43:28 -0400
Received: by lbbpo10 with SMTP id po10so29358925lbb.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2015 03:43:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALwa49tK0sfmkVb1uRT6C9-BPDD5f6CJCDqyVRK1vA=G3sjuEA@mail.gmail.com>
References: <CALwa49tK0sfmkVb1uRT6C9-BPDD5f6CJCDqyVRK1vA=G3sjuEA@mail.gmail.com>
Date: Thu, 2 Jul 2015 13:43:26 +0300
Message-ID: <CAEnQRZCNatGCdfhzV83yvWXJ_oWUwLa=Zvd8LLsD-ftvyZ5ikA@mail.gmail.com>
Subject: Re: Unit in which generic_buffer.c application gives data for sensors.
From: Daniel Baluta <daniel.baluta@gmail.com>
To: "s.rawat" <imsaurabhrawat@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 2, 2015 at 10:46 AM, s.rawat <imsaurabhrawat@gmail.com> wrote:
> Hi,
> What are the unit in which the generic_buffer.c application gives the
> accelerometer , Gyro and Magnetometer values.
> Thanks in advance !

Hi,

Look for process_scan function in generic_buffer.c. It says:
process_scan() - print out the values in SI units.

Then, look inside IIO ABI file [1] for units associated with _raw attributes.
There you'll find:

* accel - m/s^2
* gyro - rad/s
* magneto - Gauss

thanks,
Daniel.

[1] http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio
