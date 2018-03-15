Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cock.li ([185.100.85.212]:42070 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeCOB3x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Mar 2018 21:29:53 -0400
To: linux-iio@vger.kernel.org
From: Tom Lebreux <tomlebreux@cock.li>
Subject: Moving ad2s90 out of staging
Message-ID: <63f2588d-0edd-9115-74a4-d0743fb358c1@cock.li>
Date: Wed, 14 Mar 2018 21:29:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear IIO community,

I plan on working on the ad2s90 resolver driver. I understand that we do not
have hardware to test the drivers, so I will not be adding new features. The
work will be mostly about cleaning up the driver.

1. Clean up CHECK (mutex not commented)

2. Sort include alphabetically

3. Reverse christmas tree ordering 
I saw this in David's plan for the ad2s1200 driver as well as a patch for an
accel driver. However, I did not see this mentionned in
Documentation/process/coding-style.rst. Is this necessary, or even wanted ?

4. Return -EINVAL on spi_read error
Currently, on spi_read error, read_raw still returns IIO_VAL_INT. I believe this
should be returning -EINVAL, as does, for example, the adxrs450 gyro driver.

5. Remove indexed property as there is only 1 channel

6. Use a #define for magic number 830000
This sets the maximum clock speed of the spi driver. I am struggling to find
where this number comes from. Is this number coming from the fact that there
needs 600ns between the CS and the first galling edge (mentionned in the 
comment right above the assigment)? The data sheet specifies the max SCLK input
rate as being 2MHz.

Is this a good plan ? Am I missing anything important ?

This was my first time reading a specification document, learning about
resolvers and resolver-to-digital converters.

>From what I understand, the ad2s90 uses the spi interface to output (only) its
absolute position angle. However, it supports many other outputs, such as A, B
encoding, direction of rotation of input (DIR) and angular velocity of input
signals (VEL). What is used to received these numbers ? Or are they only used
to connect directly to other devices ?

Best regards,

Tom Lebreux
