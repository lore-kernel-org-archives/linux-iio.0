Return-Path: <SRS0=q/Pt=RY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43830C43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F70B218D4
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0eIwH+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCUVPj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:15:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39778 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCUVPj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Mar 2019 17:15:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so245457ljg.6
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2019 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JGZp8CAk1awsdZET7L/FtaeJO7Jaq7yKmVD2AdN5UPI=;
        b=k0eIwH+tbQF7SkN/LiPtR/PYBnIfZi8f73kGbjxNA5krc5ux8ZWnWEO7nxQ7b1ZR1M
         4LULxSA7+DuyY4ja0ArBT2bR5VKCdAcdDpxf0THZq6xSf0NA9pQVNcalGqCw3LTYJ8Pg
         L/a1XuvK+I8+4ykrYIGwli2Qtk0+ZyCtXMNAoxVcO/ky3Oit3Uu1uwHg+WHcgeFEAMPw
         zSHf8dNjt7gdJl5L90EubjxFcmtgQimGDrY9Z0auNgpcwEbBd7dQK0mljG/7a7rXYa7G
         nchn6NaOqx6yp1GrQvjfeNa+CpQI3uvT1yTw0zEvWfSFC+g+N/jEjaShJCPsjGya2KVm
         LuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JGZp8CAk1awsdZET7L/FtaeJO7Jaq7yKmVD2AdN5UPI=;
        b=ZuDat0rtv76UWgvOvXa6gaO0qc9wIjOo7G6oA3ZOb5/Iic2ho2neUMOFirNNqBm0aD
         l0a1sx1FQFUX7k0sdcbKDBHU7LPF+NoFUcP/wEGxT0tUUNziPVggqLysHqUXrVM4rdWl
         dsdd+3rSzxSjNB7dOJIpTx5/NQUQj7vx8IxyODJUuP0zMX3GlegR2bwfYcxwKqiAiwRu
         cm1FClnTf0a7b97GM07iI0FwH/s59x9t7Vze70QHgfzWb0ehfvRpfGk15qe5+FwOowse
         WIo4bP6VxN1BVaVQU+55u/7/WbiSHwftF3aM5kQ0teOF0IUlrxsbOYltl0n80oMXjEUJ
         u4ww==
X-Gm-Message-State: APjAAAVd+6xnDboJcBWlC870OLx7pij6uDU+uemznno01RqU7ej5itCy
        gl40NTZdp0Bbc16rGmPcc+vmORBrhOk=
X-Google-Smtp-Source: APXvYqybSAmsFXfpKUQr2C+00xRh6J6PjVVIVNFY8/LWvfKuMruAq7yNrdijOD8/tbPCw6U97uwxVQ==
X-Received: by 2002:a2e:a301:: with SMTP id l1mr3432377lje.61.1553202937182;
        Thu, 21 Mar 2019 14:15:37 -0700 (PDT)
Received: from ubuntu.localdomain ([95.161.223.243])
        by smtp.googlemail.com with ESMTPSA id f18sm1051355lja.91.2019.03.21.14.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 14:15:36 -0700 (PDT)
From:   Vladimir Petrigo <vladimir.petrigo@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Vladimir Petrigo <vladimir.petrigo@gmail.com>
Subject: [PATCH v2 1/2] staging: iio: ad7280a: Add parentheses to macros
Date:   Fri, 22 Mar 2019 00:15:27 +0300
Message-Id: <1553202928-34824-2-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553202928-34824-1-git-send-email-vladimir.petrigo@gmail.com>
References: <1553202928-34824-1-git-send-email-vladimir.petrigo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Fix CHECK Macro argument 'c' may be better as '(c)' to avoid precedence issues
- Fix CHECK Macro argument 'd' may be better as '(d)' to avoid precedence issues

Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d9df126..98cf876 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -97,9 +97,9 @@
 #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
 					AD7280A_CELL_VOLTAGE_1 + 1)
 
-#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
-#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
-					     c - AD7280A_CELLS_PER_DEV)
+#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + (c))
+#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
+					     (c) - AD7280A_CELLS_PER_DEV)
 
 #define AD7280A_DEVADDR_MASTER		0
 #define AD7280A_DEVADDR_ALL		0x1F
-- 
2.7.4

