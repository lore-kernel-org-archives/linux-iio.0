Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:57526 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbaGKKQH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jul 2014 06:16:07 -0400
Received: by mail-wi0-f179.google.com with SMTP id cc10so1097183wib.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2014 03:16:06 -0700 (PDT)
Received: from [10.32.51.161] (ip65.parkeon.com. [213.152.31.65])
        by mx.google.com with ESMTPSA id k19sm5730126wie.20.2014.07.11.03.16.04
        for <linux-iio@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 03:16:04 -0700 (PDT)
Message-ID: <53BFB963.7070407@parkeon.com>
Date: Fri, 11 Jul 2014 12:16:03 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: Acceleration units and mma8452 driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

I'm new to iio and have a question on acceleration units.

Documentation/ABI/testing/sysfs-bus-iio states "after application of 
scale and offset are m/s^2"

However the mma8452 driver, when in 2G full scale mode provides a scale 
factor of 0.000977

/sys/bus/iio/devices/iio:device0# cat in_accel_scale
0.000977

Full scale positive raw value (12 bits) is 2047 so that gives 2G 
(0.000977 * 2047)

So this driver seems to be using G as units rather than m/s^2.

Am I misunderstanding or is this a driver or doc bug?

Regards,

Martin


