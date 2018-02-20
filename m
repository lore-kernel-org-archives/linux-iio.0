Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:45766 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeBTO40 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Feb 2018 09:56:26 -0500
Received: by mail-wr0-f180.google.com with SMTP id p104so13858362wrc.12
        for <linux-iio@vger.kernel.org>; Tue, 20 Feb 2018 06:56:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519134383.2505.12.camel@gentoo.org>
References: <1519134383.2505.12.camel@gentoo.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 20 Feb 2018 16:56:24 +0200
Message-ID: <CAEnQRZDssZih0D74jijTQcz-XGa0iT5WOUu3haFJ7Vi8xzLjAw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_GSoC_IIO_Project=3A_Christopher_D=C3=ADaz_Riveros?=
To: =?UTF-8?Q?Christopher_D=C3=ADaz_Riveros?= <chrisadr@gentoo.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Christopher,

The solution looks good! Please do not Cc linux-iio mailing list
for non-coding tasks!

Just send the solutions privately to me.

You have now shown your solution to all your opponents ;)


thanks,
Daniel.


On Tue, Feb 20, 2018 at 3:46 PM, Christopher D=C3=ADaz Riveros
<chrisadr@gentoo.org> wrote:
> Introduction and Task 01 result
>
> Good morning IIO community,
>
> My name is Christopher D=C3=ADaz Riveros, I'm living in Lima, Per=C3=BA. =
I'm
> starting my last semester of studies, "Software development and Systems
> Integration" is the name of the career. Since a couple of months I've
> been trying to contribute in the kernel community, I have a couple of
> trivial fixes already in the main tree. I hope I'll be able to
> contribute here as well and learn more about driver development and
> specially the IIO subsystem.
>
> I have previously worked with Arduino and several kinds of sensors as
> part of my IoT course in the institute.
>
> If there is any other info that you need me to provide, feel free to
> ask please.
>
> Here is the my solution for Task 01:
>
>
> chris@gentoo ~/Repos/linux-next $ grep IIO .config
> # CONFIG_SENSORS_IIO_HWMON is not set
> CONFIG_IIO=3Dy
> CONFIG_IIO_BUFFER=3Dy
> # CONFIG_IIO_BUFFER_CB is not set
> # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
> CONFIG_IIO_KFIFO_BUF=3Dy
> CONFIG_IIO_CONFIGFS=3Dy
> CONFIG_IIO_TRIGGER=3Dy
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2
> CONFIG_IIO_SW_DEVICE=3Dy
> # CONFIG_IIO_SW_TRIGGER is not set
> # CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
> # CONFIG_IIO_ST_ACCEL_3AXIS is not set
> # Hid Sensor IIO Common
> # IIO dummy driver
> CONFIG_IIO_DUMMY_EVGEN=3Dy
> CONFIG_IIO_SIMPLE_DUMMY=3Dy
> CONFIG_IIO_SIMPLE_DUMMY_EVENTS=3Dy
> CONFIG_IIO_SIMPLE_DUMMY_BUFFER=3Dy
> # CONFIG_IIO_ST_GYRO_3AXIS is not set
> # CONFIG_IIO_ST_LSM6DSX is not set
> # CONFIG_IIO_ST_MAGN_3AXIS is not set
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> # CONFIG_IIO_SYSFS_TRIGGER is not set
> # CONFIG_IIO_ST_PRESS is not set
> --
> Christopher D=C3=ADaz Riveros
> Gentoo Linux Developer
> GPG Fingerprint: E517 5ECB 8152 98E4 FEBC  2BAA 4DBB D10F 0FDD 2547
