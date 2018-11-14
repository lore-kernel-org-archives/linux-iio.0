Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f176.google.com ([209.85.214.176]:34711 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeKODkw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Nov 2018 22:40:52 -0500
Received: by mail-pl1-f176.google.com with SMTP id f12-v6so8125549plo.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Nov 2018 09:36:45 -0800 (PST)
Received: from [192.168.1.68] (d172-218-133-108.bchsia.telus.net. [172.218.133.108])
        by smtp.gmail.com with ESMTPSA id f64sm29801927pfh.0.2018.11.14.09.36.43
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:36:43 -0800 (PST)
To: linux-iio <linux-iio@vger.kernel.org>
From: David Frey <dpfrey@gmail.com>
Subject: Buffers and sampling frequency
Message-ID: <9a7e271c-92d5-f8f4-b077-8e24d8d7798f@gmail.com>
Date: Wed, 14 Nov 2018 09:36:42 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm trying to add triggered buffer support to the bmi160 IMU driver and
a question came up that I don't know the answer to.  The driver defines
an x, y, z channel of type IIO_ACCEL and an x, y, z channel of type
IIO_ANGL_VEL.  Then within each of these channel definitions,
info_mask_shared_by_type is set to:
BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ)

This means that the driver allows for a different sampling frequency on
the accelerometer and gyro components.  The chip has a hardware FIFO and
the chip is configurable whether the FIFO is in headerless or header
mode.  In header mode the header tells the reader the structure of the
data.  Here's a relevant snippet from the datasheet
(https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMI160-DS000-07.pdf):

> In contrast, the header mode is intended for situations where flexibility in the data structure is required, e.g. when sensor run at different ODRs or when switching sensors on or off on the fly during operation.

Do IIO buffers support the case where multiple channels are enabled that
have different ODRs (sampling frequencies)?  It seems to me like the
client on the receiving end of the buffer will receive samples of a
fixed size equal to the sum of the sizes of all the enabled channels and
that the client can only look at which channels are enabled.  They can't
distinguish which channels are populated in the current sample.

Am I correct about this limitation?  If so, what is the suggested
behavior by the driver?  Should the channel definitions be changed so
that sampling frequency is info_mask_shared_by_all?  Or should I do
something like use iio_buffer_setup_ops.validate_scan_mask to validate
that the sampling frequency is equal for all channels specified by the
scan_mask?

Thanks,
David
