Return-Path: <SRS0=l2Gr=5D=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78CC10DCE
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A411020767
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 09:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTYuvhIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCRJKN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:10:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38167 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgCRJKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 05:10:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id t13so2317167wmi.3;
        Wed, 18 Mar 2020 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qY8BT7NEM8WO/54r+PXheg5D2wrkRuhnMEwuwFmHY0=;
        b=dTYuvhIl6cMRpnG0aqsXBF2Iqh6KWdOu8Ngcmw+wAKAmnNvehNz5F+/bbgSi7OJKJF
         pk1iztncDKAutvsxu4y0xOExsFkpVDOUklQ8cAwJNwYKNhb7R30tRgWW1apTzdpUPxMn
         mFTkhq7wJjOMdASyhROeGWcIR06/GlKhOfDqE9s8/HUGVqtJT+ZeEE6k888W8qwfG4uo
         +/ei75yb3Tj4HGUlWf7rKHRfZGgsTG8R3H4SJd+zSzs1NUVd1wtS4YEZqYs2UMpb3NMD
         7sXa+K1NjryJ+OQbROF15toMn2T4kicMbNdI0E6xsnZPTwycsYmKYu+HEAB7i7MEjAKK
         dqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qY8BT7NEM8WO/54r+PXheg5D2wrkRuhnMEwuwFmHY0=;
        b=lllpvn9ZTApxJbGbZKIuTQvzwqkQkc7OlkbhwJ1HmZ+bfr38+nccoIH6AAKqTFRE1y
         qMqtzU68RaR+F/nn4w+ZcDRMF6WiUyd4PpviYJer+A9p7Pt8yXl1sHYz8Igc/gg39C3P
         Yyf4jL9t/ffYEimzJ4cSCnXuoOXdzFDgDSv24EGWsb/ZOoGWWn9dQuHoFCudPVbbvGr4
         rGIBBzw6+5yAF4iHzqchQMNcMbXCSZYo6+voo9yHfrH2YyZPCIrMCEmO2nwm83lx1b5c
         gub11SdEaoG1CWZQgjx5QYvgibZmxmDDsoxcgne2qLx89nzzpY08VoybXTnN7ca2m6+D
         LSuw==
X-Gm-Message-State: ANhLgQ3XNdp6xw4zV4ZVIXAZoYAHexJZyZopEzepyPZ0PnxzLDVzsDcB
        PF/uhCfNkUzmNSuhUOvBH92LWIsP/DQ=
X-Google-Smtp-Source: ADFU+vtw4K9zgs6h2h2IKqVcow3L3BdgbwiQHBcjCX5xIaLCpTkSgR9IPGbBhMNvhT7TXA61WXnkiA==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr4124850wmc.30.1584522603669;
        Wed, 18 Mar 2020 02:10:03 -0700 (PDT)
Received: from localhost.localdomain ([95.77.248.51])
        by smtp.gmail.com with ESMTPSA id w1sm2823986wmc.11.2020.03.18.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:10:02 -0700 (PDT)
From:   Alexandru Tachici <tachicialex@gmail.com>
X-Google-Original-From: Alexandru Tachici <alexandru.tachici@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH v3 3/4] iio: accel: adxl372: add additional events ABIs
Date:   Wed, 18 Mar 2020 13:09:57 +0200
Message-Id: <20200318110958.8621-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318110958.8621-1-alexandru.tachici@analog.com>
References: <20200318110958.8621-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adxl372 uses the standard event interface. The additional
ABIs aim to explain to the user that the values set in
./events/thresh_falling_period and ./events/thresh_rising_period
control the state of the device, not just the events timings.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/accel/adxl372.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index d8f95c9f9587..1122c27fc37e 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -239,6 +239,29 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
 };
 
+static ssize_t adxl372_read_detect_event(struct iio_dev *indio_dev, uintptr_t p,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
+{
+	return sprintf(buf, "%s", (const char *)p);
+}
+
+static const struct iio_chan_spec_ext_info adxl372_ext_info[] = {
+	{
+		.name = "activity_detect_event",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = adxl372_read_detect_event,
+		.private = (uintptr_t)"in_accel_thresh_x_rising\n",
+	},
+	{
+		.name = "inactivity_detect_event",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = adxl372_read_detect_event,
+		.private = (uintptr_t)"in_accel_thresh_x_falling\n",
+	},
+	{},
+};
+
 static const struct iio_event_spec adxl372_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -272,7 +295,8 @@ static const struct iio_event_spec adxl372_events[] = {
 		.shift = 4,						\
 	},								\
 	.event_spec = adxl372_events,					\
-	.num_event_specs = 2						\
+	.num_event_specs = 2,						\
+	.ext_info = adxl372_ext_info,					\
 }
 
 static const struct iio_chan_spec adxl372_channels[] = {
-- 
2.20.1

