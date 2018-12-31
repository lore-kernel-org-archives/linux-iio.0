Return-Path: <SRS0=jGMz=PI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D6BC43387
	for <linux-iio@archiver.kernel.org>; Mon, 31 Dec 2018 03:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F9420828
	for <linux-iio@archiver.kernel.org>; Mon, 31 Dec 2018 03:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="mSjfKhQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbeLaDHI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 30 Dec 2018 22:07:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38900 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLaDHH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Dec 2018 22:07:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so12257555pgc.5
        for <linux-iio@vger.kernel.org>; Sun, 30 Dec 2018 19:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Mzt2sUHpda6Ur3ArMUylzs7ZT/7ucoiNwclSjbZfJEY=;
        b=mSjfKhQxIoC3zlupHVWmhKjAu3+VP7UtZpavPXELrwNcMFm/2QF3QaLDfUDyFkBCb6
         vtXYbKlGJ2olyqaitjfsuxQVfBqL6uo4+iolMJuyOzL+MoS/8zKthbU7F9ms72iITUkQ
         ixKwsXjKlFCmP8gwGBaBKwR54zxGN3RtY1MDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mzt2sUHpda6Ur3ArMUylzs7ZT/7ucoiNwclSjbZfJEY=;
        b=DuoRCuGbMbIZywWQdkmBa0bcADhucJp3TtA0AI2v8VKji0jW6sNUuqDHFtXglSOFuO
         1sDXEFngWOCpA1XngPbGCFAW7StJMdPMKiGDmNOgJBt3WlWBIACLCg0zPY2DoxcwNXy3
         46b+vTcKmvA/hYnXY586gADFv+2WaZeSGo+nCOmf60RT1jrhroMuO6uC27HG7IFgI0SB
         el/J2P5X4Gf6XWblR1IGrtazafhNVka2C4iEYjQZgS9S0AWBFeYxTfgJOWRaQOQEm0dY
         W+nTpPdxF9wevjm060GoD5/dxvgKtLv5HahLQTc26/W3onX2gWszNBgTKG2iDBHXIUiN
         yD1Q==
X-Gm-Message-State: AJcUukeINb0RY9eQdF5eA9s8JmyoH2zu0q1nDLolI9kCUghMOmvMcAWT
        EMFsNtP5IDi+NuwdBgqw55hmpq9w2mA4pA==
X-Google-Smtp-Source: ALg8bN5rYsA/ISPSlUneEAGq/AN/KaXUZ2GFtfC2eW8xmoax1BsZQz101dwmtalO7ZaoXAh/3aMVzg==
X-Received: by 2002:a63:b0a:: with SMTP id 10mr6293345pgl.423.1546225627057;
        Sun, 30 Dec 2018 19:07:07 -0800 (PST)
Received: from virtualbox.hsd1.wa.comcast.net (c-71-193-240-108.hsd1.wa.comcast.net. [71.193.240.108])
        by smtp.gmail.com with ESMTPSA id l184sm70347658pfc.112.2018.12.30.19.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 19:07:06 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsius
Date:   Sun, 30 Dec 2018 19:07:01 -0800
Message-Id: <20181231030701.29789-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO_TEMP scale value for temperature was incorrect and not in millicelsius
as required by the ABI documentation.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index a406ad31b096..3a20cb5d9bff 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -444,9 +444,8 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = 1; /* 0.01 */
-			*val2 = 100;
-			break;
+			*val = 10;
+			return IIO_VAL_INT;
 		case IIO_PH:
 			*val = 1; /* 0.001 */
 			*val2 = 1000;
@@ -477,7 +476,7 @@ static int atlas_write_raw(struct iio_dev *indio_dev,
 			   int val, int val2, long mask)
 {
 	struct atlas_data *data = iio_priv(indio_dev);
-	__be32 reg = cpu_to_be32(val);
+	__be32 reg = cpu_to_be32(val / 10);
 
 	if (val2 != 0 || val < 0 || val > 20000)
 		return -EINVAL;
-- 
2.17.1

