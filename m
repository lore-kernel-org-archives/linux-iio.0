Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35615 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751111AbeEUKUt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2018 06:20:49 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 0/3] merge calls to of_match_device and of_device_get_match_data
Date: Mon, 21 May 2018 11:49:07 +0200
Message-Id: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

of_device_get_match_data calls of_match_device and fails if the latter
fails, so both calls aren't needed.

---

 drivers/i2c/muxes/i2c-mux-pca954x.c |    7 ++-----
 drivers/iio/adc/max1363.c           |    8 ++------
 drivers/iio/potentiometer/max5481.c |    7 ++-----
 drivers/iio/potentiometer/mcp4018.c |    7 ++-----
 drivers/iio/potentiometer/mcp4531.c |    7 ++-----
 5 files changed, 10 insertions(+), 26 deletions(-)
