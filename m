Return-Path: <SRS0=iTXR=QM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01108C282CB
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 17:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82D7217F9
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 17:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ok9P7WNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfBERns (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:43:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38738 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBERns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Feb 2019 12:43:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so4654656wml.3
        for <linux-iio@vger.kernel.org>; Tue, 05 Feb 2019 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5G7MY3lyyhZOIyQwfjnfPbhOo9LpUCTU21q4nR8D3yo=;
        b=ok9P7WNROz+FqlcvqDpVfUWLuzqMjXwl1yyFbeFzLFeFQ9i4Mtk3puyhdyQi6nEHyP
         hcJ74041h7dYfdgiAWHK5H1E+lwWeo/jlBo2h8Z5IPc27ViuQwVyjUpqVlKAaX9Ax0ED
         oVrnucrAsfNMsTJ9k1b42lRBZPkbw5C4NLIigqaHmFdN5TRsAN/zic4Ret/VmMfjvJGO
         s9auq503Z37I862ArwXnRGocitp0BHCte/983Os1I0CyoZ2VF60de/rOBIpmnaJYhB7L
         FSQzn++I8L5GhHLHTceVXx85q7U8+AjNEsoGxuTKXp4s8TQnbXRLEIHcEvDhBxLWhBSX
         b5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5G7MY3lyyhZOIyQwfjnfPbhOo9LpUCTU21q4nR8D3yo=;
        b=jz4REHjXePhS1aiAa55UztVNfaPvSjKk5s7BES1j7WiAKIaN3BX2U/QEUQrwB77QzP
         bdF2x9ztz+lUasb8IHYFWEZIl+7C7kqhBElF+amz6Y+SY5344wd/YmMlDslX9OMHQR6L
         zZi5rDjy2FbsZLv4T4m+tFZgRYGKQkd2qMF6sA15jzb6zigu1yM2ZEPj8hpN7kAEOiXn
         DMpwwjaIWF6QWzZIoRfYkXjW68bxit2ItB8/ct5Rs4QC7W3K1EnZVs9xc4Y5e+cmzqec
         hceXKmqt/zhpPY4bDIf0eocae8vx6mQ1y+HwCj9OuYm7prZ1Redjy2ouL/mUpzS9h0Vb
         /OYw==
X-Gm-Message-State: AHQUAuYgz31dBw5ZUF0U86SLBKGBRjrGLfAxiC0l1xJ0+mNdsNCKt0dc
        MRQyjepyFxR2OFHdXqAn0OX0ZA==
X-Google-Smtp-Source: AHgI3Iax+csmmdOJxYpA4viXAFHQmv8kuqgCKa4uOEYxNNFABJZWkJuEjW9A8i2oUDRyn2CGln0XAQ==
X-Received: by 2002:a1c:2088:: with SMTP id g130mr4577296wmg.122.1549388626210;
        Tue, 05 Feb 2019 09:43:46 -0800 (PST)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id s132sm12225751wmf.28.2019.02.05.09.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 09:43:45 -0800 (PST)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v2 0/5] iio: gyro: add fxas2100x driver
Date:   Tue,  5 Feb 2019 17:43:28 +0000
Message-Id: <20190205174333.17672-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
This series introduce a NXP fxas2100x family tri axis gyroscope driver [0]
It add a core implementaiton plus an i2c and spi.

This device can be found in the warp7 board [1], where it was tested.

---
Cheers,
   Rui

v1->v2:
Peter Meerwal-Stadler:
  - changed (c) to current year
  - add regmap include file in .h
  - fix comments s/cuttof/cutoff/
  - add more info in mutex comment
  - check value in range_fs_from_value
  - ret not checked in range_value_from_fs
  - move mode to enum type
  - remove line between value get and validation of value in all file
  - pre-write, regmap_field_write, post_write refactoring
  - check val2 and val == 0 in write raw
  - check in_anglvel_scale: 7.8125?
  - trigger_handler: 2 => sizeof(s16)
  - check buffer size
  - print %02% to output chip id
  - remove !! as state is bool
  - trigger probe return devm_iio_trigger_register
  - remove error msg in case of devm_iio_device_register
Fabio Estebam:
  - rename FXAS2100X to FXAS21002
  - change compatible nxp,fxas2100x to the exact support
  - add VDD and VDDIO regulators in bindings and driver


[0]: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
[1]: https://www.element14.com/community/community/designcenter/single-board-computers/warp7/overview

Rui Miguel Silva (5):
  iio: gyro: add DT bindings to fxas21002
  iio: gyro: fxas2100x: add core driver for fxas2100x gyroscope
  iio: gyro: fxas2100x: add i2c driver
  iio: gyro: fxas2100x: add spi driver
  ARM: dts: imx7s-warp: add fxas21002 gyroscope

 .../bindings/iio/gyroscope/fxas2100x.txt      |  18 +
 arch/arm/boot/dts/imx7s-warp.dts              |   7 +
 drivers/iio/gyro/Kconfig                      |  22 +
 drivers/iio/gyro/Makefile                     |   3 +
 drivers/iio/gyro/fxas2100x.h                  | 151 +++
 drivers/iio/gyro/fxas2100x_core.c             | 931 ++++++++++++++++++
 drivers/iio/gyro/fxas2100x_i2c.c              |  73 ++
 drivers/iio/gyro/fxas2100x_spi.c              |  70 ++
 8 files changed, 1275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
 create mode 100644 drivers/iio/gyro/fxas2100x.h
 create mode 100644 drivers/iio/gyro/fxas2100x_core.c
 create mode 100644 drivers/iio/gyro/fxas2100x_i2c.c
 create mode 100644 drivers/iio/gyro/fxas2100x_spi.c

-- 
2.20.1

