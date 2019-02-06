Return-Path: <SRS0=djfl=QN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E35C169C4
	for <linux-iio@archiver.kernel.org>; Wed,  6 Feb 2019 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68F2175B
	for <linux-iio@archiver.kernel.org>; Wed,  6 Feb 2019 10:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfBFKm4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:42:56 -0500
Received: from yes.iam.tj ([109.74.197.121]:42030 "EHLO iam.tj"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbfBFKm4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 Feb 2019 05:42:56 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 05:42:55 EST
Received: from [10.254.1.52] (gw.iam.tj [82.71.24.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by iam.tj (Postfix) with ESMTPSA id 789C734181;
        Wed,  6 Feb 2019 10:34:58 +0000 (GMT)
To:     linux-input <linux-input@vger.kernel.org>,
        linux-iio@vger.kernel.org
From:   Tj <linux@iam.tj>
Subject: bug: i2c-INVN6500:00: unexpected HID descriptor bcdVersion (0xca9b)
Message-ID: <27a0a01c-7e4b-136c-7cfe-9ef93d5bfd05@iam.tj>
Date:   Wed, 6 Feb 2019 10:35:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Looking back through boot logs this message is seen on all kernels used
on this Asus T300CHI, from v4.15 onwards:

hidraw: raw HID events driver (C) Jiri Kosina
i2c_hid i2c-INVN6500:00: i2c-INVN6500:00 supply vdd not found, using
dummy regulator
i2c_hid i2c-INVN6500:00: Linked as a consumer to regulator.0
i2c_hid i2c-INVN6500:00: i2c-INVN6500:00 supply vddl not found, using
dummy regulator

i2c_hid i2c-INVN6500:00: unexpected HID descriptor bcdVersion (0xca9b)

inv-mpu6050-i2c i2c-INVN6500:00: mounting matrix not found: using
identity...
inv-mpu6050-i2c i2c-INVN6500:00: i2c-INVN6500:00 supply vddio not found,
using dummy regulator

It's not clear if this is a warning that can be disregarded or an
indication the protocol isn't being completely decoded.

The accelerometer is working correctly but the ambient light sensor
isn't. I tested that by shining an LED camera light around the edges of
the device where the sensors are located and monitoring for changes.

I'm reasonably sure the light-sensor has worked previously but it isn't
something I would generally notice since the device is used in fairly
constant low-light conditions.

This may or may not be related to the error message.


$ monitor-sensor
    Waiting for iio-sensor-proxy to appear
+++ iio-sensor-proxy appeared
=== Has accelerometer (orientation: normal)
=== Has ambient light sensor (value: 0.000000, unit: lux)

