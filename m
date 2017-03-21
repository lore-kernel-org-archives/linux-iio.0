Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36453 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757820AbdCUPGt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 11:06:49 -0400
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        linux-iio@vger.kernel.org,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH v2 0/2] Remove Typedefs.
Date: Tue, 21 Mar 2017 20:36:36 +0530
Message-Id: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Typedefs are removed in sm750fb driver.

Arushi Singhal (2):
  staging: sm750fb: Remove typedef from "typedef struct _mode_parameter_t"
  staging: sm750fb: Remove typedef from "typedef enum _spolarity_t"

 drivers/staging/sm750fb/ddk750_mode.c |  8 +++++---
 drivers/staging/sm750fb/ddk750_mode.h | 19 ++++++++-----------
 drivers/staging/sm750fb/sm750_hw.c    |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

-- 
changes in v2
 -change the spelling of coverpatch subject.
2.11.0

