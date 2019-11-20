Return-Path: <SRS0=J/up=ZM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF3C43215
	for <linux-iio@archiver.kernel.org>; Wed, 20 Nov 2019 14:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D1E206DA
	for <linux-iio@archiver.kernel.org>; Wed, 20 Nov 2019 14:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns3EXHNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfKTOt0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:49:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37790 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbfKTOt0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so8137369wmj.2
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2019 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkPpLeXVv17KBi+qQEqu0qt8LLruco7K41VlVb/OnZ4=;
        b=ns3EXHNLKAyigbcJYt3Sl//QwRtR3nhzvVF7UAvihlu7LdUXlRgYOHYhmyV+5AHHiY
         sgeqAlO/IzLfBsBJ1/lNBiY2qWV82xe/Sj47d9sb7f3nl5YUey3mKFSeDXxArMk/9bjy
         Zi4usijU53coj+3gZI7EaOecuOpJPFeREWBknL2SCtxNCh6miD2aNofwy0bCG8cEQaYX
         /FQQVgUh4p1vQOPH1e51GCIOUB7Rse05R5y9sHnL6TwexPIjMdiA0Qn7BmhiRiLBeXAW
         HGpCrCClvvFQonNpmcedj4hSmJn/O6wABSN3DU1dtsEt7R7ZKtHP3PeUv6ApK6F72lfx
         kmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zkPpLeXVv17KBi+qQEqu0qt8LLruco7K41VlVb/OnZ4=;
        b=Jun3RabpVy2GNUVT+LBc7ILJZAYxzYxqB8J1wTJSJ9viOB9uKj6bvNiPFKhIzanv+4
         nJT9AMwqrysWlNXdZIfiJHhEljrqLG+3iIDe3iy8DcP6tKgnZsVZHJQw4v6598FluR2O
         ZGUeHHLUe+4v6HBvsUWq9f0hEvmm7DDZO7Jfa10KmTaaLTBRzIPQtcXsLVEnGSAQl+GG
         ogywfB48t9yvPE5bfvj6RpV3QKq5dI3EQxfnIuv9IuGJYqWyKPV70NpSTEVpegFQaT+L
         EO9iNC5B3FH6XvbJhfHxZ161EJxDizlp1GnWePXnxJ56Hj124yn2St1vXlHjuw2VFgct
         hHtg==
X-Gm-Message-State: APjAAAU7QVH9VJOeEak6krcU6GocXYyUwrsa6LIxTpDud0fYtdv0Gy44
        KmQ1tCpqd3eU+ww0u1bWMhg=
X-Google-Smtp-Source: APXvYqwMjmUiprvPfWErIS9FeTwtr/mfblG5GFT9IvRUD3K81HrhI6V9Jl6N22LaHvIVuGKZrhsQ1A==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr3483999wmf.24.1574261364182;
        Wed, 20 Nov 2019 06:49:24 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:23 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v3 5/9] iio: core: add thermocouple_type standard attribute
Date:   Wed, 20 Nov 2019 15:47:52 +0100
Message-Id: <20191120144756.28424-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144756.28424-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191120144756.28424-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We have a couple of thermocouple IIO drivers, supporting several chips.
Some of them support only one specific thermocouple type (e.g. "K", "J"),
one of them can be configured to work with several different thermocouple
types.

In certain applications thermocouples could be externally connected to the
chip by the user.

This patch introduces a new IIO standard attribute to report the supported
thermocouple type and, where applicable, to allow it to be dynamically set
using sysfs.

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 958b5c48a86f..fa2c3b321bfd 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -161,6 +161,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
+	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 };
 
 /**
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 8e0026da38c9..e6fd3645963c 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -58,6 +58,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
 };
 
 #endif /* _IIO_TYPES_H_ */
-- 
2.17.1

