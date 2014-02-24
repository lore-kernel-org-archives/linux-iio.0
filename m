Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:44942 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbaBXQXX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2014 11:23:23 -0500
Received: by mail-wi0-f171.google.com with SMTP id cc10so3286748wib.16
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2014 08:23:22 -0800 (PST)
Date: Mon, 24 Feb 2014 16:23:17 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ge Gao <GGao@invensense.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: imu: inv_mpu6050: Add basic support for mpu9150
Message-ID: <20140224162317.GG15847@lee--X1>
References: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <52F623AA.6020905@kernel.org>
 <E7747D604FBC9F43A71AA431AFF44762104C3FB8@IUSEXCH01.invcorp.invensense.com>
 <201402101939.46467.manuel.stahl@iis.fraunhofer.de>
 <E7747D604FBC9F43A71AA431AFF44762104C57AF@IUSEXCH01.invcorp.invensense.com>
 <52FF5D61.4080506@kernel.org>
 <20140215133934.GA2579@katana>
 <53031B17.8030608@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53031B17.8030608@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> >>Wolfram, what do you think?
> >>
> >>In short we have a device that sits on an i2c bus and supports its own
> >>i2c bus (mainly so that the internal processor can use data from devices
> >>on that bus) including support for passing the bus straight through.
> >>The issues is the dependencies when the intermediate device is sleeping
> >>for example.
> >
> >Just judging from the paragraph above and not digging into the topic
> >deeper, I think the idea of an 1-1 multiplexer is suitable. Would the
> >pass-throu device then be a MFD? Are the alternative ideas?
> >
> Seems like overkill to introduce an MFD for this little addition to a fairly
> large (and likely to grow driver).  Its a little ugly, but would you mind
> if the multiplexer is just handled directly within the  main driver?
> (perhaps via a config option).  It would be 'odd' to say the least if
> someone really wanted the pass through and not the complex inertial chip
> it is part of.
> 
> Might just be simpler to do a very trivial mfd with the two parts hanging of it.
> The complexity is that the inertial sensor will often take over the device
> hanging off it completely so we will need to have it cleanly blocked as busy.
> 
> Lee, what do you think?

Sorry for the delay, I was off last week.

Doesn't look like an MFD to me:

Features:

    Digital-output 9-axis MotionFusion data in rotation matrix,
    quaternion, Euler Angle, or raw data format

    Tri-Axis angular rate sensor (gyro) with a sensitivity up to 131
    LSBs/dps and a full-scale range of ±250, ±500, ±1000, and ±2000dps

    Tri-Axis accelerometer with a programmable full scale range of ±2g,
    ±4g, ±8g and ±16g

    Tri-axis compass with a full scale range of ±1200µT
    Reduced settling effects and sensor drift by elimination of
    board-level cross-axis alignment errors between accelerometer,
    gyroscope, and compass

    Digital Motion Processing™ (DMP™) engine offloads complex
    MotionFusion, sensor timing synchronization and gesture detection

    MotionApps™ Platform support for Android, Linux, and Windows
    Embedded algorithms for run-time bias and compass calibration. No user
    intervention required

    Digital-output temperature sensor
    Digital input on FSYNC pin to support video Electronic Image
    Stabilization and GPS

    Programmable interrupt supports gesture recognition, panning, zooming,
    scrolling, tap detection, and shake detection

    VDD Supply voltage range of 2.4V–3.46V; VLOGIC of 1.8V±5% or VDD
    Gyro operating current: 3.6mA (full power, gyro at all rates)
    Gyro + Accel operating current: 3.8mA (full power, gyro at all rates,
    accel at 1kHz sample rate)

    Gyro + Accel + Compass + DMP operating current: 4.25mA (full power,
    gyro at all rates, accel at 1kHz sample rate, compass at 8Hz rate)

    Accel low power mode operating current: 10µA at 1Hz, 20µA at 5Hz, 70µA
    at 20Hz, 140µA at 40Hz

    Full Chip Idle Mode Supply Current: 8µA
    400kHz Fast Mode I²C serial host interface
    On-chip timing generator with ±1% frequency variation over full
    temperature range

    User self test
    10,000g shock tolerant
    Smallest and thinnest package for portable devices (4x4x1mm)
    RoHS and Green compliant

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
