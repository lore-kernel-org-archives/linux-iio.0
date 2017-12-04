Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42279 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdLDPaS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 10:30:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id l141so6534768wmg.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2017 07:30:17 -0800 (PST)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 0/3] iio: temperataure: MLX90632
Date: Mon,  4 Dec 2017 16:29:55 +0100
Message-Id: <20171204152955.25950-1-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everybody,

With the sensor now available to broad public, it is time to also
share the driver with the community. MLX90632 is just 3x3mm in size,
but with factory calibration offers instant usage in every project.

Driver currently provides basic functionality, but I might add
some more fancy features after a while.

v2 includes comments from Rob Herring (dt-bindings) and Jonathan
Cameron (iio), as well as proposal to split out int_sqrt64 function
into the linux/kernel.h

Crt Mori (3):
  iio: temperature: Adding support for MLX90632
  dt-bindings: iio: temperature: add MLX90632 device bindings
  lib: Add strongly typed 64bit int_sqrt

 .../bindings/iio/temperature/mlx90632.txt          |  28 +
 MAINTAINERS                                        |   7 +
 drivers/iio/temperature/Kconfig                    |  12 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/mlx90632.c                 | 793 +++++++++++++++++++++
 include/linux/kernel.h                             |   1 +
 lib/int_sqrt.c                                     |  27 +
 7 files changed, 869 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
 create mode 100644 drivers/iio/temperature/mlx90632.c

-- 
2.15.0

