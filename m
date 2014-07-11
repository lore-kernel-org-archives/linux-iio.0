Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50350 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbaGKLbS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jul 2014 07:31:18 -0400
In-Reply-To: <53BFB963.7070407@parkeon.com>
References: <53BFB963.7070407@parkeon.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Acceleration units and mma8452 driver
From: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 11 Jul 2014 12:31:13 +0100
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
Message-ID: <8445f626-07d7-45eb-8578-b9efa5ed082d@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On July 11, 2014 11:16:03 AM GMT+01:00, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
>Hi all,
>
>I'm new to iio and have a question on acceleration units.
>
>Documentation/ABI/testing/sysfs-bus-iio states "after application of 
>scale and offset are m/s^2"
>
>However the mma8452 driver, when in 2G full scale mode provides a scale
>
>factor of 0.000977
>
>/sys/bus/iio/devices/iio:device0# cat in_accel_scale
>0.000977
>
>Full scale positive raw value (12 bits) is 2047 so that gives 2G 
>(0.000977 * 2047)
>
>So this driver seems to be using G as units rather than m/s^2.
>
>Am I misunderstanding or is this a driver or doc bug?
>
Driver bug. Good catch. Do you want to prepare a patch?

Thanks

Jonathan

>Regards,
>
>Martin
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
