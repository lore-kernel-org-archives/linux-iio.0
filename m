Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34044 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbdK2WHo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Nov 2017 17:07:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so38102136wmg.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Nov 2017 14:07:43 -0800 (PST)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/2] iio: temperataure: MLX90632
Date: Wed, 29 Nov 2017 23:07:18 +0100
Message-Id: <20171129220718.11234-1-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everybody,

With the sensor now available to broad public, it is time to also
share the driver with the community. MLX90632 is just 3x3mm in size,
but with factory calibration offers instant usage in every project.

Driver currently provides basic functionality, but I might add
some more fancy features after a while.

Crt Mori (2):
  iio: temperature: Adding support for MLX90632
  dt-bindings: iio: temperature: add MLX90632 device bindings

 .../bindings/iio/temperature/mlx90632.txt          |  28 +
 MAINTAINERS                                        |   7 +
 drivers/iio/temperature/Kconfig                    |  12 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/mlx90632.c                 | 802 +++++++++++++++++++++
 5 files changed, 850 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
 create mode 100644 drivers/iio/temperature/mlx90632.c

-- 
2.15.0

