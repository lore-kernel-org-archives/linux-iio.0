Return-Path: <SRS0=mvch=O5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0867C43387
	for <linux-iio@archiver.kernel.org>; Thu, 20 Dec 2018 06:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC65120869
	for <linux-iio@archiver.kernel.org>; Thu, 20 Dec 2018 06:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="f5FsAG7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeLTG7k (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:59:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38925 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeLTG7j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Dec 2018 01:59:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so462627pfc.6
        for <linux-iio@vger.kernel.org>; Wed, 19 Dec 2018 22:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1IUzYJqmbd9OZPBJLfHwOP1jDLvMfSlhyBAHHr6cRA=;
        b=f5FsAG7Mi9tk1OEUsabVYG4ji3GwF/cAJnPEAOM83t5DldZPK1+foNZ+fIM8G/C/b7
         DMr65a7i9qRkEc9EEHgzeWYXPlSD63HaEmdkyfR72OwKDhdAbWjf8D1vO7VO1vlfAckq
         QNKYMwCT6v21MpOaqiXfwGjAJsgJgQi2iGmvD6le4VW9fyPDNfk5MMtvJcvxUXZjeQpE
         K4T7WMg4fSA6X6ix3B76iCxL9+QNiE0WRhZjLapauh+e+EnHpMI/XJ7sLtqSzLHTMpZf
         i9KR9xZl670Qoaz+DiDRO7TTArwMqS1Zrc5ADoQsKNBjHy/VBipX/6s7G8qBX/tzDiv0
         Nurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1IUzYJqmbd9OZPBJLfHwOP1jDLvMfSlhyBAHHr6cRA=;
        b=dHrKUAkibV8AEkOr2tRhcAsB7Ag9RGFZ561BLUAIugf9/Cut2mol44HbFGUN7a45h+
         wHwgIl80v/QP7H3FBFcORgkE+S9I8WobGUzFFoGb0Dxt+U2L/NXlF+uRj83VrlT6Uqdo
         NEUMpenyDFCmyhOI/w/ly8tSdmzKE/GCUvrN1DlRMGgFpW1lwPNrxQHHoL8BRVkWTGCV
         dCXqkSDlvdQtFvat/g9ARcTNpLnqHBFrl2twiEJs9VOArfBNVJ0600lo1wffpg6EDfV0
         kvhdnoc+GK/6H7CmRjNY6n5dF2z/U32dgT/Y2VEVWOCXOMU/p4TrGB2K3zeZX0anXOtz
         RUWw==
X-Gm-Message-State: AA+aEWb7P6bq3IE0SS79BQnGfqQRM/SdWJaB6Kx6tCz4mCtySlp5Pu1M
        /y+dO/5o6zXAjUsYR23JpRO6YQ==
X-Google-Smtp-Source: AFSGD/U+KB/T1+6shD1dQnM/1Tf2I25Tc7HBUlHXg3WEfwdt8dyFRk6AhqQpD39hFaER/vnQfAOxJQ==
X-Received: by 2002:a63:8149:: with SMTP id t70mr22525126pgd.172.1545289178900;
        Wed, 19 Dec 2018 22:59:38 -0800 (PST)
Received: from limbo.local (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id 83sm29980791pgf.57.2018.12.19.22.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 22:59:38 -0800 (PST)
From:   Daniel Drake <drake@endlessm.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux@endlessm.com,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        hadess@hadess.net, hdegoede@redhat.com
Subject: [PATCH 1/2] iio: drop const typing from iio_mount_matrix rotation
Date:   Thu, 20 Dec 2018 14:59:32 +0800
Message-Id: <20181220065933.25964-1-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to conform with orientation data from the firmware, we
need to dynamically construct the mount matrix in the ST accelerometer
driver.

Drop the const type from the mount matrix data to make this possible.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a74cb177dc6f..d3094ffeb9da 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -125,7 +125,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  *            main hardware
  */
 struct iio_mount_matrix {
-	const char *rotation[9];
+	char *rotation[9];
 };
 
 ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
-- 
2.19.1

