Return-Path: <SRS0=Oeur=RQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAAEC4360F
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FCB20693
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ph8bAB+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfCMSkm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39599 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfCMSkK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2019 14:40:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id p8so3151371wrq.6
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2019 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fUk9NHDDixYCQ+cZFtqX1R5QiQWFDuPVIXD1RDckfE=;
        b=ph8bAB+j5FW2wQgv0N0op8dKMZJ1AyNk6W3b46zAKsez+I2sqDZzEvku8TE4VNdZwO
         qwFTujpVtGMSWzzW+xIthMawJ2vpXemMC9M5cBNrNWcr54WPXAB30wjtAhx9HlRj33HB
         YAMnUN2eZC6qtzLHlFtM9oz5Bmw2tyvvzG4keyRI6rcPcfL+PIK3ZWXV/U7l82uKBezE
         kuik3XHfdkdcvKE25xX+IKSrJZCrOvlNvT1pY0XfK1evLNquACa9pmu+zuVTuaIqI+3A
         5Nda7eA/uZ2BmEG6c+WKCl6ggMcMDvgR/4ynkxzv3zO2Dv1xT1v4VcmqfopVwCIM64+c
         FEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fUk9NHDDixYCQ+cZFtqX1R5QiQWFDuPVIXD1RDckfE=;
        b=jcXCEkm3IXbT5gX1hxcDlq4Mc3+EmZN2Js+NJWdIC8Lrq0iN9hV6N5dysGiq2/mgFV
         yKfqPJphXzAPDOB5nn8sh1O6qnTERQi41l+sFC7jkbbG6cwRXSQDc0azGkKCWb4YRVSR
         Rz/0tByqntYd8VFccSsshaRdzXXDJw25J7sKb9deS8Z+Z4F5NAtG4umHfKH1hZgj2SoA
         OuqmsngcYjG0Kb4CKaCA8Ou94999JC6ucAXT4vUZpBLvuwuMLYXB6Bxfc4r4CplRhjnZ
         QcAZI+5/9Tg43Efi1oVK10L9yeEtNkQ2ZABFX3YtHQEfqdy157nWQQP+kibj0hnQ8axb
         EjOA==
X-Gm-Message-State: APjAAAUaBavr2bfU/eU1EvahtUdU/uT8t7DY0T43AZ2vi9BljmWcaLdw
        L2VCjmvCUhbuPFPzOmUJFnJBSQ==
X-Google-Smtp-Source: APXvYqyNRWInwmSp9yQNhU4LQPIiJnz6w5N/rYLhZYdjWg5aVzTVfnHXdBiUh2XDYAVPPK0CZDPXPQ==
X-Received: by 2002:adf:f011:: with SMTP id j17mr29175365wro.166.1552502408836;
        Wed, 13 Mar 2019 11:40:08 -0700 (PDT)
Received: from arch-late.localdomain ([87.196.73.151])
        by smtp.gmail.com with ESMTPSA id p17sm3829660wmi.35.2019.03.13.11.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:40:08 -0700 (PDT)
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
Subject: [PATCH v3 0/6] iio: gyro: add fxas21002c driver
Date:   Wed, 13 Mar 2019 18:39:56 +0000
Message-Id: <20190313184002.2501-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
Sorry about the delay, being traveling and other stuff to do, but
here goes v3.

This series introduce a NXP fxas21002c tri axis gyroscope driver [0]
It add a core implementaiton plus an i2c and spi.

This device can be found in the warp7 board [1], where it was tested.

---
Cheers,
   Rui

v2->v3:
Jonathan Cameron:
  - cacheline aligned (DMA safe buffer)
     Great presentation [2] and links in the presentation, thanks
  - global renaming, including filenames, fxas2100x->fxas21002c
  - provide spi info in dts bidings
  - Remove SPI_MASTER in Kconfig i2c patch and move it to right patch
  - remove extra blank line in comment
  - add break range_value_from_fs after found
  - in range_value_from_fs use local variable
  - remove mode check at mode_set
  - combine two if statements in mode_set
  - in scale_get return 0 and let caller to set IIO_VAL_FRACTIONAL
  - remove dev_err from vdd_io regulator get
  - handle regulator error path
  - devm_add_action
  - check unwind order
  - simplify data in _suspend and alike
  - disable regulators at suspend
  - error handling at _resume
  - return -EAGAIN at runtime_resume

Rob Herring:
   - Set label as gyroscope

- add interrupt to bindings
- add entry to maintainers


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
[2]: https://events.linuxfoundation.org/wp-content/uploads/2017/12/20181023-Wolfram-Sang-ELCE18-safe_dma_buffers.pdf

Rui Miguel Silva (6):
  iio: gyro: add DT bindings to fxas21002c
  iio: gyro: add core driver for fxas21002c
  iio: gyro: fxas21002c: add i2c driver
  iio: gyro: fxas21002c: add spi driver
  ARM: dts: imx7s-warp: add fxas21002c gyroscope
  MAINTAINERS: add entry for fxas21002c gyro driver

 .../bindings/iio/gyroscope/nxp,fxas21002c.txt |  26 +
 MAINTAINERS                                   |  10 +
 arch/arm/boot/dts/imx7s-warp.dts              |   7 +
 drivers/iio/gyro/Kconfig                      |  22 +
 drivers/iio/gyro/Makefile                     |   3 +
 drivers/iio/gyro/fxas21002c.h                 | 151 +++
 drivers/iio/gyro/fxas21002c_core.c            | 989 ++++++++++++++++++
 drivers/iio/gyro/fxas21002c_i2c.c             |  73 ++
 drivers/iio/gyro/fxas21002c_spi.c             |  69 ++
 9 files changed, 1350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
 create mode 100644 drivers/iio/gyro/fxas21002c.h
 create mode 100644 drivers/iio/gyro/fxas21002c_core.c
 create mode 100644 drivers/iio/gyro/fxas21002c_i2c.c
 create mode 100644 drivers/iio/gyro/fxas21002c_spi.c

-- 
2.20.1

