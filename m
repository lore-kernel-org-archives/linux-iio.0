Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:41253 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBGWPc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Feb 2018 17:15:32 -0500
Received: by mail-ot0-f170.google.com with SMTP id r23so2324349ote.8
        for <linux-iio@vger.kernel.org>; Wed, 07 Feb 2018 14:15:32 -0800 (PST)
MIME-Version: 1.0
From: Pavel Roskin <plroskin@gmail.com>
Date: Wed, 7 Feb 2018 14:15:30 -0800
Message-ID: <CAN_72e2eEoLKNUqte=xmUCyLj6L+asJVL9k_rqXGJd1ky7v=Cw@mail.gmail.com>
Subject: Best practices for sending digital data
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm writing an IIO driver for custom IMU hardware. The most important
output is analog. However, the hardware also provides very important
digital data about the status of the measurement.

The register is basically a bitmask. Some of the bits are pertinent to
the specific measurement. They indicate whether the data is valid and
whether the measurements are saturated. So it makes sense to put them
to the same buffer as the analog measurements rather than use
attributes.

What would be the recommended channel type? Is that IIO_INDEX or maybe
IIO_COUNT? Or should I patch the kernel to add IIO_DIGITAL or
IIO_BITMAP?

On a related note, why is IIO so hard to extend with new channel types
and attributes? Why cannot I add angular acceleration in the driver
without patching the IIO subsystem? Why cannot I use yaw, pitch and
roll instead of X, Y and Z as the attributes? Why is IIO_MOD_CO2
defined but IIO_MOD_O2 is not, let alone IIO_MOD_DIMETHYLHYDRAZINE?

I understand that the IIO layer tries to be helpful with
standardization, but I believe it's too restrictive.

-- 
Regards,
Pavel Roskin
