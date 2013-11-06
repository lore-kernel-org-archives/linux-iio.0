Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:53009 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239Ab3KFKR2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2013 05:17:28 -0500
Received: by mail-la0-f53.google.com with SMTP id eh20so5345921lab.12
        for <linux-iio@vger.kernel.org>; Wed, 06 Nov 2013 02:17:27 -0800 (PST)
MIME-Version: 1.0
From: Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com>
Date: Wed, 6 Nov 2013 19:16:46 +0900
Message-ID: <CAP+Vy9cm0apYAzEEV0mYn=2-Pq88eyZqR5_ERbd-Deto6c0cpg@mail.gmail.com>
Subject: About MLX90620 thermal array sensor (IR sensor)
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi folks,

I'm working on a 16x4 thermal array sensor from Melexis which parts
number is MLX90620.

Here is the datasheet of this device:
http://www.melexis.com/Asset/Datasheet-IR-thermometer-16X4-sensor-array-MLX90620-DownloadLink-6099.aspx

This device runs with 4 operation pins including I2C SCL and SDA,
other two are VCC and ground.

The IC alone cannot operate but needs some sort of resistors and
electrical parts in form of break out board.

*But there is no change in using I2C and 5V in*

I'd like to ask you for a pointer to make driver name which I want to
put in IIO framework.

The breakout board name is RM-G212 from RoBoard and the standalone IC
name is MLX90620.

Which one will be appropriate for the driver name?

rm-g212.c ? or mlx90620.c

Sorry to bother you with such a trivial thing, but I thought the
naming must be important when someone wants to try out his mlx90620
device on Linux and looking for the driver.
(And I'm also confused)

Cheers,

Nate

-- 
=
Dongsoo Nathaniel Kim
Linux kernel, media device S/W engineer / Ph.D Student
Dept. of Computer Science, KAIST
Real-time & Embedded Systems Lab.
