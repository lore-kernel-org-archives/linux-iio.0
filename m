Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE8EC43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD31C20828
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LL9eMp1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfCSK7n (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:59:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50384 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCSK7n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Mar 2019 06:59:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so7661246wmi.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2019 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zH9giUCYZL9zDARv1fT0vviPsw2iChigPaqO4dJ69OU=;
        b=LL9eMp1gA24PrTn3hVdEamV4dmNVTomStZsfO1Efi6WM7M3xnqAclTPEEoC7Wvz/Sz
         ClgUBA/k8bvy5tekaWPTce7gRlxga9DSJ2mj7ypnUpvNHvZTSbgnezWAv5WV4lyGJmxS
         E7P6IhyktkXDV1pUVDVxGFcTzKh0govVFllYGGsF4P6VrKSicSpvIFM3bMvzShi4dnmE
         udYWVbzyzu76aj86cpDa8GkDCo9ZxAA+IW+Ifxg/Y4agoleqG8NSnhduh8icaopVed+g
         MIzSXxOCoBmArV5HgRakEfGqzSPS4OJj/Fok68ftLTL1hSTBSYG+k5nyBox4JkgAX7yV
         1tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zH9giUCYZL9zDARv1fT0vviPsw2iChigPaqO4dJ69OU=;
        b=g79hr76hdP1rDeIXr4i1KStI3fQm59Dq3i5UbTM99/mpP0y8wPxD5a0hNuSuCPFTlI
         vVIj/SwSdHUx9VuGqatB7HPd/qPanlJO0rtCBADwhpjlWJJntdHTYXXLjx/kUm8BqVI9
         N2CBuucBtjNnfokxqRFxpRQ+lxsPBM++omJBPHbdXp8GSbLWqWktQAfYeYs2XNbtlDoY
         Dus96ZHLoHPjn1E1ogIit3qxGfdkzb8iWk1Mwq9yKeGss5HX7m5ijaW6ISMzfNx2FlhL
         HCt30lNydNzEnlFa28i7ScUDrRQ2O288AbC+YSklTWC51Ex/C91jnsqXL8FqlAMbCd8h
         O/7w==
X-Gm-Message-State: APjAAAVaBFK2rrYrznkGKS2bsc83Xa5cifBa4IG2yVXXzttcp4YXHfZZ
        UF7i3QMLfNQylgrvMVdkXobEzQ==
X-Google-Smtp-Source: APXvYqz+cWMKZCYyLj0Hc0eU/GopHjvApsSnTXivv6jMeg1cbj+uI47LHg4GkNKJQ66kapmQyvjilg==
X-Received: by 2002:a1c:38b:: with SMTP id 133mr3053926wmd.26.1552993180699;
        Tue, 19 Mar 2019 03:59:40 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm4120052wmf.2.2019.03.19.03.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:59:39 -0700 (PDT)
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
Subject: [PATCH v4 0/6] iio: gyro: add fxas21002c driver
Date:   Tue, 19 Mar 2019 10:59:19 +0000
Message-Id: <20190319105925.25863-1-rui.silva@linaro.org>
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

v3->v4:
Tomasz Duszynski:
  - mention irq flags in bindings
  - add reference to drive-open-drain in bindings
  - fix headers files
  - drop comas in of_device_id sentinel
  - drop of_match_ptr
  - use probe_new

  Joan Cameron:
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

 .../bindings/iio/gyroscope/nxp,fxas21002c.txt |  31 +
 MAINTAINERS                                   |  10 +
 arch/arm/boot/dts/imx7s-warp.dts              |   7 +
 drivers/iio/gyro/Kconfig                      |  22 +
 drivers/iio/gyro/Makefile                     |   3 +
 drivers/iio/gyro/fxas21002c.h                 | 151 +++
 drivers/iio/gyro/fxas21002c_core.c            | 987 ++++++++++++++++++
 drivers/iio/gyro/fxas21002c_i2c.c             |  69 ++
 drivers/iio/gyro/fxas21002c_spi.c             |  70 ++
 9 files changed, 1350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
 create mode 100644 drivers/iio/gyro/fxas21002c.h
 create mode 100644 drivers/iio/gyro/fxas21002c_core.c
 create mode 100644 drivers/iio/gyro/fxas21002c_i2c.c
 create mode 100644 drivers/iio/gyro/fxas21002c_spi.c

-- 
2.21.0

