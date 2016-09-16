Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:1802 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754368AbcIPLNl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Sep 2016 07:13:41 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3] constify iio_info structures
Date: Fri, 16 Sep 2016 12:55:23 +0200
Message-Id: <1474023326-24645-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Constify iio_info structures.

---

 drivers/iio/accel/ssp_accel_sensor.c |    2 +-
 drivers/iio/adc/men_z188_adc.c       |    2 +-
 drivers/iio/gyro/ssp_gyro_sensor.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
