Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8430C43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754E220863
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzAp6Esx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCZKRG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:17:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35020 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfCZKRG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2019 06:17:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so13652786wrp.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2019 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FvjQ0KaN17fm8d4sliqWx6H9mLiak7bj4iGfsi7kTDk=;
        b=RzAp6EsxzQga1DAPb5dbmZ1XK7BkGS461hptV8r2MFW1JE+mto7YfCStisTZ9Rla+5
         kRnoMTpc8sOKoKSg4rNEJTTRLL69+eRqP278C43LwvcE7EabJ0QuEJdX+s1bvUf6g0kH
         5xJIokKZzJbnrgu3zGLfAxi9vONduuh4cs1bDKysCGUlM2Q1x7Z89kAr2dT3H4SHKv22
         xjLmK4NoEi7uVyhGBJeHvGkG8/QMDvvI1Hcq/HyBkvY2RC078TrGQZZpj+lsF6pHfVN0
         +oAKzAr4bHrEuLKSjtoGJKcfvi4ITouPJaczGF6RvqKXrHnAMRPyNe55lMwERWVXGCH5
         zLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FvjQ0KaN17fm8d4sliqWx6H9mLiak7bj4iGfsi7kTDk=;
        b=ICg+RHh5m4I08jm+OWvWAGtf12/cwL8Hc8mhYgVsKM/o8zLjkV9qASQDvQvGTVEQ+h
         nxZSkX4DSzyVYO1Sfn4HXLZqJs77fd99tAjMH7FzpIRctd5x9l6woQ/X7BYcrQjK0Fg/
         d7gRYDm0I2jkemLZlkd8Vzfmldjj4R/Vu5R6MQczD0FAmfDGuJDZG5vIIPPtjgopaP7C
         WZiPdLr4c8jV8qYS98w50d5QXFoREi/rqagUQgABe0ZlcSP0uodoj9S2O34lpITM6zkk
         K61v66A6qbIXqsEX6kC7yDZDuTD3oiPuOZncsOHD/mvSjnBeDVQq0AEivciDQEqGIujs
         V5wg==
X-Gm-Message-State: APjAAAW08O4lruwR8Rw11OfSyY+HmwHtnfbc5k8loZuKm06+KqeYupdw
        OLG07M27DSlUJD2Ws60muS4uQA==
X-Google-Smtp-Source: APXvYqxVV6Js5raGLvyZqV6+snpSzgLewhB1aQiZ6l8LT3Q/QDYOhQKYXVTcfr6oyb33Xubp/SPrDw==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr1976780wro.40.1553595424046;
        Tue, 26 Mar 2019 03:17:04 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id j1sm22281024wme.4.2019.03.26.03.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:17:03 -0700 (PDT)
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
Subject: [PATCH v5 0/6] iio: gyro: add fxas21002c driver
Date:   Tue, 26 Mar 2019 10:16:45 +0000
Message-Id: <20190326101651.25056-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
This series introduce a NXP fxas21002c tri axis gyroscope driver [0]
It add a core implementaiton plus an i2c and spi.

This device can be found in the warp7 board [1], where it was tested.

---
Cheers,
   Rui

v4->v5:
Jonathan Cameron:
  - remove init ret
  - change handle of iio register, buffer and trigger in probe and
   remove (I think this is what you mean, Jonathan)

v3->v4:
Tomasz Duszynski:
  - mention irq flags in bindings
  - add reference to drive-open-drain in bindings
  - fix headers files
  - drop comas in of_device_id sentinel
  - drop of_match_ptr
  - use probe_new

Jonathan Cameron:
  - disable vdd regulator in case of vddio fail
  - use devm_add_action_or_reset
  - simpler functions returns
  - remove noisy dev_info
  - remove EAGAIN from runtime_suspend

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

 .../bindings/iio/gyroscope/nxp,fxas21002c.txt |   31 +
 MAINTAINERS                                   |   10 +
 arch/arm/boot/dts/imx7s-warp.dts              |    7 +
 drivers/iio/gyro/Kconfig                      |   22 +
 drivers/iio/gyro/Makefile                     |    3 +
 drivers/iio/gyro/fxas21002c.h                 |  151 +++
 drivers/iio/gyro/fxas21002c_core.c            | 1006 +++++++++++++++++
 drivers/iio/gyro/fxas21002c_i2c.c             |   69 ++
 drivers/iio/gyro/fxas21002c_spi.c             |   70 ++
 9 files changed, 1369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
 create mode 100644 drivers/iio/gyro/fxas21002c.h
 create mode 100644 drivers/iio/gyro/fxas21002c_core.c
 create mode 100644 drivers/iio/gyro/fxas21002c_i2c.c
 create mode 100644 drivers/iio/gyro/fxas21002c_spi.c

-- 
2.21.0

