Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23780C4361B
	for <linux-iio@archiver.kernel.org>; Wed, 16 Dec 2020 21:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D366623619
	for <linux-iio@archiver.kernel.org>; Wed, 16 Dec 2020 21:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgLPVl6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Dec 2020 16:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLPVl6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 16:41:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EFBC061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 13:41:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l23so2467564pjg.1
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 13:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTLLHf4mlc6OcfbKqpBmEImDN79nUg5LlGqTBC9T1Po=;
        b=brXjEQ6gnHEcqhs/jBLwLHlQ4WZM5t946UwE6xjDRerm0BG+gnqnOJ875RNEZHI0cv
         ocmG4tsvF6/giDC08/EVJ8OB94Ake/EALZQdPi340+pSA9WMQwaoA/3c5ZCqvLZKnNNH
         DPv01Fyulefg5r/97MPfJhjwPFlqK/Jme9UHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTLLHf4mlc6OcfbKqpBmEImDN79nUg5LlGqTBC9T1Po=;
        b=AUpErSZOKvQv7oP62sxLXYIwdlCiuGaL7g8RYOMyMyei1JsYp9pHHviEw8WrgrBlHF
         83Qlx0NT7WGTcey4AMLaanBy+YYGAcH7xajdjc0Eg9Wuo972yPjICKBF6GyRMi5wCKCM
         YQOGtyNvNM9OHFItW1NoWqyUhs30XHk2P1FyJJ3u8Wzy//vdOeVsLNfPIF8Dt5rnPW7D
         gMaijuwQQMU4NXOSUiZfMqPIvm16jqm6FRrzIDl0wpvgW2Qvyzdzq15+W5daqs8a7V+Z
         iOGXvQUNal/snE6UNe+IQeHN3tWWbARt+N8HkYXJnvHnJFsLtHZOidVybnYzEQ/jiQj/
         Zl2A==
X-Gm-Message-State: AOAM533IlYhvhk8oPJQPpPudhavQIg2LVrC4fBsgFUsPkR4ZbpQDsuuY
        W1z2njHlxpsIRD7trgDOoTy4WA==
X-Google-Smtp-Source: ABdhPJyB3krYP6D08arbgyun+AfS/jNBF62/XmLuPTR37YKnHECKMP44D+d+iXEoSZ5HHOMI0gIklA==
X-Received: by 2002:a17:90a:9512:: with SMTP id t18mr4766973pjo.206.1608154877660;
        Wed, 16 Dec 2020 13:41:17 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id d203sm3393607pfd.148.2020.12.16.13.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 13:41:16 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 0/3] iio: acpi_als: Add sotfware trigger support
Date:   Wed, 16 Dec 2020 13:41:04 -0800
Message-Id: <20201216214107.774969-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices (chromebooks) present the ACPI ALS device but do not have
ability to notify when a new sample is present.
Add support for software trigger (hrtimer/sysfs-trigger) to allow
retrieving samples using iio buffers.

The first path fully adds timestamp channel, the second adds a local
variable in probe routine and the last one adds trigger support.

This patch assumes the patch "iio: set default trig->dev.parent" is
applied.


Gwendal Grignou (3):
  iio: acpi_als: Add timestamp channel
  iio: acpi_als: Add local variable dev in probe
  iio: acpi_als: Add trigger support

 drivers/iio/light/acpi-als.c | 105 ++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 31 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

