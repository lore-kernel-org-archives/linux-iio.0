Return-Path: <SRS0=gFHn=OW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29914C67839
	for <linux-iio@archiver.kernel.org>; Thu, 13 Dec 2018 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E343420849
	for <linux-iio@archiver.kernel.org>; Thu, 13 Dec 2018 14:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=elementarea-net.20150623.gappssmtp.com header.i=@elementarea-net.20150623.gappssmtp.com header.b="u60LdoOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E343420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elementarea.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeLMOoN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:44:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42330 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMOoN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Dec 2018 09:44:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so2210129edp.9
        for <linux-iio@vger.kernel.org>; Thu, 13 Dec 2018 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9ENHyVN8bquqxl3FHVwLNcHPO91MhKyV7Sw3VUDBU9A=;
        b=u60LdoOpwKdGAgTkUYOywyEoEyNS+taSEyCX75doI0phW8ecbfmfwVpx4L8qF6dqEb
         HoluZi4HiNP+0ZkpV2bf0fyXamLRdFYZZOdcnfva9rnPLnXLULlZDrS/PhKpJJ0JfWu/
         qkMTfjA0VL18yuQb/ErHLDyIehMf4F8mK7LBW8O0nmdx9fwNY05nE346ecJGSOCpF6Pf
         Qd7MiU6eYVfw1A6kQohJguQ16QGhJQs6y3AK7Lnc6r09VMWrQ8OLBsHsSJUIF40/3zR9
         eVtk9Faa5I2ggF4y+pQ12HTpb9DgWbOSeEGWqh0ScqQwyIxG+DezXFVUhNJyyQdLh6lg
         MZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9ENHyVN8bquqxl3FHVwLNcHPO91MhKyV7Sw3VUDBU9A=;
        b=QrkHQ7qAhToeUJdnZFQaZ4T2TvWWTmqM+jkkKlI9k86lGfeqVjS+4zkd/hziUM9dV7
         tm6/Bp2/zjpe2a5bVmPkeUatqACtKwRyM8Xe8KcvYu/BwFiDeVVXGo3h6fv49RToWqBE
         oSlAtXsnf1k4cccXKtTawXxgYTUNoLGauDFSVeYmTXDtBEHuXgilDhJuPhJqbsVuQdO5
         Imc1oYkgIDP5tSLre5pJCv37FXtTc2nNTamWI0oUC9vcKNOfBp2Zq2RVlVYKI4tzjEU8
         /lAA3rGBrtxWhizMQyZUQBOhvgBBqkKaBdcazhcqVmPGZAHcm1f7GsL/cK/a3BuQJk9j
         M2hg==
X-Gm-Message-State: AA+aEWbU2OOh2bXNf9klbNmerYruu6foXfEpeeyd+BVQIfDIe9lFM7LV
        e9zQeC8I0nP/9RnZJxi1rat9eg==
X-Google-Smtp-Source: AFSGD/XZHyDeKxfrfgZNGX6JP4C9rjH65PJWphyxk9awPTZ23wRkdsvB0SOnazaMWp6Tunbk1AVTCQ==
X-Received: by 2002:a50:a4b6:: with SMTP id w51mr22221370edb.48.1544712251315;
        Thu, 13 Dec 2018 06:44:11 -0800 (PST)
Received: from ch-sta-l-li0012.sensirion.lokal ([209.206.26.1])
        by smtp.gmail.com with ESMTPSA id q16sm656290eds.60.2018.12.13.06.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 06:44:10 -0800 (PST)
From:   Andreas Brauchli <a.brauchli@elementarea.net>
X-Google-Original-From: Andreas Brauchli <andreas.brauchli@sensirion.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: [PATCH v3 1/3] iio: Add modifiers for ethanol and H2 gases
Date:   Thu, 13 Dec 2018 15:43:22 +0100
Message-Id: <20181213144323.24820-2-andreas.brauchli@sensirion.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add ethanol and H2 gas modifiers:
* IIO_MOD_ETHANOL
* IIO_MOD_H2

Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
 include/uapi/linux/iio/types.h          | 2 ++
 tools/iio/iio_event_monitor.c           | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 8127a08e366d..6d64521bf565 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1554,6 +1554,10 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ethanol_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_h2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_h2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
 KernelVersion:	4.3
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 92baabc103ac..04a6649fa442 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -87,6 +87,8 @@ enum iio_modifier {
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
 	IIO_MOD_LIGHT_DUV,
+	IIO_MOD_ETHANOL,
+	IIO_MOD_H2,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index ac2de6b7e89f..f29c885f4b28 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -114,6 +114,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_I] = "i",
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
+	[IIO_MOD_ETHANOL] = "ethanol",
+	[IIO_MOD_H2] = "h2",
 	[IIO_MOD_VOC] = "voc",
 };
 
@@ -199,6 +201,8 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_I:
 	case IIO_MOD_Q:
 	case IIO_MOD_CO2:
+	case IIO_MOD_ETHANOL:
+	case IIO_MOD_H2:
 	case IIO_MOD_VOC:
 		break;
 	default:
-- 
2.17.1

