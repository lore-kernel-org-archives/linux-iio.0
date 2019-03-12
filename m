Return-Path: <SRS0=PpOZ=RP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90629C43381
	for <linux-iio@archiver.kernel.org>; Tue, 12 Mar 2019 08:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6097D214AF
	for <linux-iio@archiver.kernel.org>; Tue, 12 Mar 2019 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JslS7/ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCLIk2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:40:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35686 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfCLIk1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Mar 2019 04:40:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id t13so1536792lji.2
        for <linux-iio@vger.kernel.org>; Tue, 12 Mar 2019 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=590kX8IU9JdrgkDmrWCgy0wAJi05VBTUAZCrissAwkc=;
        b=JslS7/ZKnKIHBa3oIioiM+idE6vjxIW9jdzkmc4+9w7ixwUSe62E10OfPuIc4hLk5+
         TegQnq5hXwqCrGzThCqBiGYynNolUFN6J4yXUfVNVihDoPBxFldZEAeCgZLB4Y8rrHID
         NR5AeGrtCUopVanDKQgZLAdmo4gmhrIZ5NQ5O0jX5xekepF6UjUc68+itpLbCDqR2p0l
         odrhCJSnAjpbSB3QS/EzVo8CGtKmergokC3RsDqajvBrjLNgs0cDzeXcfAW8zXkBYREf
         f5QFEfTln5BTZWYWB4FVIBnQxQPd3DXN/Vqqz5AsH6gHVH9kour/0R6ffULkOaTGsaud
         HxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=590kX8IU9JdrgkDmrWCgy0wAJi05VBTUAZCrissAwkc=;
        b=Inz4ojWGZA85uV01uV6NTskzc24ATkIUTdi3zQL55djIYBpJL2R7qsku+jWTMuzZpa
         vKqZMBfhNrVlMIOJWc/lPL9v68xSWLMDllVUypULQq5gZF7C+vRScGgAdIjj4R0CWlTS
         WKCquTj4nHgYRGSpQd8HxnOHPOVsic+WINCWZQUHtgAJl/kpZruQ4VgfnTGnpCIkJzvn
         ctm7qVr4NetH/EQm5vMB17zCcZYF18uyWD9EfM2o0UVWxG/jDwsFGk20omkUQx8BTfFi
         VRS88Ss4IQqUpe91CqzCTjidC5VkdNnB5Z/QGpMObrWCf5DUljT3A9qb8wboRltFLvcr
         f/7w==
X-Gm-Message-State: APjAAAXx+maKfhbhs0sO9ckpWID+IxWrlynE7Y+C0dBIg0Xq6WKPqDsQ
        HAzM3BYieIX7KXOotDQODpMnkQ==
X-Google-Smtp-Source: APXvYqyfe1dPxnPUgW3ygbMgTG060sOPQwCVIV1tJZmYia+0/M6YhCk5hxgBQJPp66b5XYU+nOcsww==
X-Received: by 2002:a2e:8659:: with SMTP id i25mr19122404ljj.110.1552380025446;
        Tue, 12 Mar 2019 01:40:25 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id a23sm1260651ljd.20.2019.03.12.01.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:40:21 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Stefan Tatschner <stefan.tatschner@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH] iio: pressure: bmp280: BMP280 calibration to entropy
Date:   Tue, 12 Mar 2019 09:40:18 +0100
Message-Id: <20190312084018.12697-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The BMP280/BME280 calibration data should also go into the
entropy pool, like we do for BMP180.

This just adds the temperature and pressure calibration, the
humidity calibration seems like too much annoying calls to
add.

Cc: Tomasz Duszynski <tduszyns@gmail.com>
Cc: Stefan Tatschner <stefan.tatschner@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/bmp280-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe87d27779d9..3329d740c86c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -164,6 +164,9 @@ static int bmp280_read_calib(struct bmp280_data *data,
 		return ret;
 	}
 
+	/* Toss the temperature calibration data into the entropy pool */
+	add_device_randomness(t_buf, sizeof(t_buf));
+
 	calib->T1 = le16_to_cpu(t_buf[T1]);
 	calib->T2 = le16_to_cpu(t_buf[T2]);
 	calib->T3 = le16_to_cpu(t_buf[T3]);
@@ -177,6 +180,9 @@ static int bmp280_read_calib(struct bmp280_data *data,
 		return ret;
 	}
 
+	/* Toss the pressure calibration data into the entropy pool */
+	add_device_randomness(p_buf, sizeof(p_buf));
+
 	calib->P1 = le16_to_cpu(p_buf[P1]);
 	calib->P2 = le16_to_cpu(p_buf[P2]);
 	calib->P3 = le16_to_cpu(p_buf[P3]);
-- 
2.20.1

