Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39366 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab3KFRRq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2013 12:17:46 -0500
In-Reply-To: <CAP+Vy9cm0apYAzEEV0mYn=2-Pq88eyZqR5_ERbd-Deto6c0cpg@mail.gmail.com>
References: <CAP+Vy9cm0apYAzEEV0mYn=2-Pq88eyZqR5_ERbd-Deto6c0cpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: About MLX90620 thermal array sensor (IR sensor)
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 06 Nov 2013 17:17:38 +0000
To: Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com>,
	linux-iio@vger.kernel.org
Message-ID: <69adfeb3-ef16-4cd4-a32b-db7be3b1b90b@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Nate

Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com> wrote:
>Hi folks,
>
>I'm working on a 16x4 thermal array sensor from Melexis which parts
>number is MLX90620.
>
>Here is the datasheet of this device:
>http://www.melexis.com/Asset/Datasheet-IR-thermometer-16X4-sensor-array-MLX90620-DownloadLink-6099.aspx
Interesting little device.
>
>This device runs with 4 operation pins including I2C SCL and SDA,
>other two are VCC and ground.
>
>The IC alone cannot operate but needs some sort of resistors and
>electrical parts in form of break out board.
>
>*But there is no change in using I2C and 5V in*
>
>I'd like to ask you for a pointer to make driver name which I want to
>put in IIO framework.
>
>The breakout board name is RM-G212 from RoBoard and the standalone IC
>name is MLX90620.
>
>Which one will be appropriate for the driver name?
mlx... If the breakout board does anything to change the operation it should be represented in terms of regulators or other
 similar parts with perhaps a device tree snippet that others can use.
>
>rm-g212.c ? or mlx90620.c
>
>Sorry to bother you with such a trivial thing, but I thought the
>naming must be important when someone wants to try out his mlx90620
>device on Linux and looking for the driver.
>(And I'm also confused)

Another interesting question is whether array sensors like this should be handled as cameras or whether IIO makes more sense.
If in IIO we need to think about how to handle the array coordinates.

What do others think?
>
>Cheers,
>
>Nate

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
