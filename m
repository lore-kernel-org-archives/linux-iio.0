Return-Path: <SRS0=cU5P=SD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEAAC43381
	for <linux-iio@archiver.kernel.org>; Mon,  1 Apr 2019 19:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473452086C
	for <linux-iio@archiver.kernel.org>; Mon,  1 Apr 2019 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554146933;
	bh=fRmgDKXzR03Vy+3S5cJIpvftoHZOoYjVDrdFqL8ChJ8=;
	h=Date:From:To:Subject:List-ID:From;
	b=UAQbvqex+VqlRUVKmpTi0px3dEkK3HU8zFjeGwoSbjj2zC/lkqIi6N6zCi98XV36z
	 iKx1cb4WOq1ZwKaIPZxkA9CRbTbzL2YIyIG0z9YJdQ/RLqFIWR3LTxPT7NpRNjpB/d
	 DjGsAJIgh5OVVGecaRvZDuwEgLb2TbkphlqdEobU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfDAT2w (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfDAT2w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Apr 2019 15:28:52 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2855D2086C;
        Mon,  1 Apr 2019 19:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554146931;
        bh=fRmgDKXzR03Vy+3S5cJIpvftoHZOoYjVDrdFqL8ChJ8=;
        h=Date:From:To:Subject:From;
        b=AHhNxRfGfIQK1MA3ZsIedQ1oxEqz4NCdbFzM0zYlQF4/ghFBCyWQhQrKkQ4txkPXE
         jakXawi5WpQNqx+pNltgiYebI3ugpKQw57CFTVkKcGpYNwzSSFEpGz8H6LweSRy44H
         ywoCE20AL7cyXo0DPhwCMVqm+TEyLUx0Ps9uEjAQ=
Date:   Mon, 1 Apr 2019 20:28:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 5.1 cycle
Message-ID: <20190401202847.50491d1c@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b:

  Merge tag 'io_uring-2019-03-06' of git://git.kernel.dk/linux-block (2019-03-08 14:48:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.1a

for you to fetch changes up to 7f75591fc5a123929a29636834d1bcb8b5c9fee3:

  iio: core: fix a possible circular locking dependency (2019-03-31 11:11:31 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 5.1 cycle.

Mostly the usual mix, but the bme680 SPI fix is much larger than
I would normally like.  It never worked, but conversely we have
code there that would make people expect it to do so.  Chances
of side effects are very low.

* core
  - Fix an uninitialised bitaks that could potentially result in random
    channels being enabled on startup.
* ad7192
  - Fix a wrong channel address for ad7193.
* ade7854
  - Fix a typo that results in returning peak voltage instead of peak current.
* at91
  - Fix a potential hang due to a race on interrupt setting.
* bmg160
  - Fix scale factor of temperature
* bme680
  - Fix scale factor of temperature
  - Fix SPI read interface.  This is a bit of a large patch as it seems
    that it never worked.  It's major for this driver but is unlikely to
    have any negative side effects.
* kxcjk1013
  - restore sensor range setting after resume.
* mcp4725
  - make sure to store powerdown bits when storing to the eeprom.
* mpu3050
  - Mask the chip ID correctly as we have chips that set the bother bits of
    this register.
* sgp30
  - Fix a missing Kconfig block that means the driver doesn't actually ever
    get built.

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: pms7003: select IIO_TRIGGERED_BUFFER

Dragos Bogdan (1):
      iio: ad_sigma_delta: select channel when reading register

Fabrice Gasnier (1):
      iio: core: fix a possible circular locking dependency

Georg Ottinger (1):
      iio: adc: at91: disable adc channel interrupt in timeout case

Gwendal Grignou (1):
      iio: cros_ec: Fix the maths for gyro scale calculation

Jean-Francois Dagenais (1):
      iio: dac: mcp4725: add missing powerdown bits in store eeprom

Jonathan Cameron (1):
      iio: chemical: fix missing Kconfig block for sgp30

Lars-Peter Clausen (1):
      iio: Fix scan mask selection

Leonard Pollak (1):
      Staging: iio: meter: fixed typo

Mike Looijmans (3):
      iio/gyro/bmg160: Use millidegrees for temperature scale
      iio:chemical:bme680: Fix, report temperature in millidegrees
      iio:chemical:bme680: Fix SPI read interface

Mircea Caprioru (1):
      staging: iio: ad7192: Fix ad7193 channel address

Sergey Larin (1):
      iio: gyro: mpu3050: fix chip ID reading

Sven Van Asbroeck (3):
      iio: adc: xilinx: fix potential use-after-free on remove
      iio: adc: xilinx: fix potential use-after-free on probe
      iio: adc: xilinx: prevent touching unclocked h/w on remove

he, bo (1):
      io: accel: kxcjk1013: restore the range after resume.

 drivers/iio/accel/kxcjk-1013.c                     |   2 +
 drivers/iio/adc/ad_sigma_delta.c                   |   1 +
 drivers/iio/adc/at91_adc.c                         |  28 +++--
 drivers/iio/adc/xilinx-xadc-core.c                 |   3 +-
 drivers/iio/chemical/Kconfig                       |  14 +++
 drivers/iio/chemical/bme680.h                      |   6 +-
 drivers/iio/chemical/bme680_core.c                 |  54 ++++++++--
 drivers/iio/chemical/bme680_i2c.c                  |  21 ----
 drivers/iio/chemical/bme680_spi.c                  | 115 ++++++++++++++-------
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   7 +-
 drivers/iio/dac/mcp4725.c                          |   1 +
 drivers/iio/gyro/bmg160_core.c                     |   6 +-
 drivers/iio/gyro/mpu3050-core.c                    |   8 +-
 drivers/iio/industrialio-buffer.c                  |   5 +-
 drivers/iio/industrialio-core.c                    |   4 +-
 drivers/staging/iio/adc/ad7192.c                   |   8 +-
 drivers/staging/iio/meter/ade7854.c                |   2 +-
 17 files changed, 183 insertions(+), 102 deletions(-)
