Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F42DC282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 18:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE1F20811
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 18:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBISCJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:02:09 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33394 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfBISCJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2019 13:02:09 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 6FB849E74F4;
        Sat,  9 Feb 2019 18:02:05 +0000 (GMT)
Date:   Sat, 9 Feb 2019 18:02:03 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tj <linux@iam.tj>
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: bug: i2c-INVN6500:00: unexpected HID descriptor bcdVersion
 (0xca9b)
Message-ID: <20190209180203.49646da8@archlinux>
In-Reply-To: <27a0a01c-7e4b-136c-7cfe-9ef93d5bfd05@iam.tj>
References: <27a0a01c-7e4b-136c-7cfe-9ef93d5bfd05@iam.tj>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


+CC Srinivas

On Wed, 6 Feb 2019 10:35:09 +0000
Tj <linux@iam.tj> wrote:

> Looking back through boot logs this message is seen on all kernels used
> on this Asus T300CHI, from v4.15 onwards:
> 
> hidraw: raw HID events driver (C) Jiri Kosina
> i2c_hid i2c-INVN6500:00: i2c-INVN6500:00 supply vdd not found, using
> dummy regulator
> i2c_hid i2c-INVN6500:00: Linked as a consumer to regulator.0
> i2c_hid i2c-INVN6500:00: i2c-INVN6500:00 supply vddl not found, using
> dummy regulator
> 
> i2c_hid i2c-INVN6500:00: unexpected HID descriptor bcdVersion (0xca9b)
Interesting. The code matches the bcdVersion against 0x0100.

Needs someone more knowledgeable in this spec than me to track down whether
the value reported could be valid or not...

Jonathan

> 
> inv-mpu6050-i2c i2c-INVN6500:00: mounting matrix not found: using
> identity...
> inv-mpu6050-i2c i2c-INVN6500:00: i2c-INVN6500:00 supply vddio not found,
> using dummy regulator
> 
> It's not clear if this is a warning that can be disregarded or an
> indication the protocol isn't being completely decoded.
> 
> The accelerometer is working correctly but the ambient light sensor
> isn't. I tested that by shining an LED camera light around the edges of
> the device where the sensors are located and monitoring for changes.
> 
> I'm reasonably sure the light-sensor has worked previously but it isn't
> something I would generally notice since the device is used in fairly
> constant low-light conditions.
> 
> This may or may not be related to the error message.
> 
> 
> $ monitor-sensor
>     Waiting for iio-sensor-proxy to appear
> +++ iio-sensor-proxy appeared
> === Has accelerometer (orientation: normal)
> === Has ambient light sensor (value: 0.000000, unit: lux)
> 

