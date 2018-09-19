Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f172.google.com ([209.85.214.172]:35084 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeITDnJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Sep 2018 23:43:09 -0400
Received: by mail-pl1-f172.google.com with SMTP id g2-v6so3288595plo.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Sep 2018 15:03:14 -0700 (PDT)
Received: from [192.168.1.68] (d50-92-226-185.bchsia.telus.net. [50.92.226.185])
        by smtp.gmail.com with ESMTPSA id n79-v6sm45074601pfh.2.2018.09.19.15.03.12
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:03:12 -0700 (PDT)
To: linux-iio <linux-iio@vger.kernel.org>
From: David Frey <dpfrey@gmail.com>
Subject: question about iio_dev.active_scan_mask
Message-ID: <320ab010-4200-20cf-f71d-2fb77a2d1a67@gmail.com>
Date: Wed, 19 Sep 2018 15:03:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I am looking at struct iio_dev in include/linux/iio/iio.h and the
active_scan_mask member is documented as:

@active_scan_mask:   [INTERN] union of all scan masks requested by buffers

I believe that this is a bitmap where if bit X is set, that means the
channel with scan_index == X is enabled for buffering.

I believe that "[INTERN]" means that this member should not be accessed
by a device driver, but I see many device drivers iterating over the
bits of this field.  Is my understanding incorrect?  Perhaps "[INTERN]"
means that the field can be read from the driver, but should not be written.

Please help me clear up my understanding.

Thanks,
David
