Return-Path: <SRS0=ngxN=CG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F19C433E2
	for <linux-iio@archiver.kernel.org>; Fri, 28 Aug 2020 23:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D942207DF
	for <linux-iio@archiver.kernel.org>; Fri, 28 Aug 2020 23:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XiVtKgHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgH1XcW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 28 Aug 2020 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgH1XcO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 19:32:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475CC06121B
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2020 16:32:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so1150989pgl.4
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2020 16:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/PHdei2zAAxiSwF+bxDT9CBP96v4SI/Wvb0TQ+dh3A=;
        b=XiVtKgHzm9G9JmxZjlPa2DIp1V0YZga2sQeg5r3rG3Ow4MDDVJRop81BxSRPAM2/t2
         kRPEQaZ8hhLpKDYY/pnN5m/Gt35Ml/Lt5iCLN3uirRw4C1AtK5wT1NZcuea7NvfREEro
         4w28C0+Xo9o4/B3MtuoIYF9PyyuGC/vNpyhVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/PHdei2zAAxiSwF+bxDT9CBP96v4SI/Wvb0TQ+dh3A=;
        b=f2RqwGtYKoe3mBQVyykzbLxlI/ns1T7nuctfsoyxULDTW2l7TVJEw3oX/c69vvKSVv
         9pToQUGJzAfOHxDI03CgsbzdPXdiFlZCka9PP2WDSv3ixsmOOneoMsoViwsNOR3AAo6t
         YsNueZ8y3vpsEuxXuKfPAgNMW0aS8qefI/emvF7AfnlhBHFBoxydGmzcNBhln0NgidBR
         uV4SSqxEse1wHil7hDC+sdtK5Hlcq87UkM1XgMhY9jGhpg3Hm3jr3ZS6rV4ndsZMMSxZ
         /HqQk4RvufgdGIq3ii9Ygta4Aj8UffeGiyHwyGjvTmoaz0UPeibmNooImlJhKRms14RO
         Ag/g==
X-Gm-Message-State: AOAM532F5tkXDD+y9peSwFrtBvFyobRDAfIdytdVKCDkAaMR9tC4rHe2
        zY29uS8LiYA//Si0e7lg/3gLMgzB6A1HMQ==
X-Google-Smtp-Source: ABdhPJxyHcvDKGsP2odQIQzBmLKY//429Ui7kXlLxbzuhRN7lQr3KDL/YxXFmlZFUDgcNkLIXVx/hw==
X-Received: by 2002:a63:b10a:: with SMTP id r10mr788398pgf.431.1598657533870;
        Fri, 28 Aug 2020 16:32:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id j1sm528966pfg.6.2020.08.28.16.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 16:32:13 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, peress@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/2] docs: abi: iio: Use What: consistently
Date:   Fri, 28 Aug 2020 16:31:55 -0700
Message-Id: <20200828233156.2264689-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200828233156.2264689-1-gwendal@chromium.org>
References: <20200828233156.2264689-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change "[w|W]hat[:| ]" to What: for consistency.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 48 ++++++++++++-------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index c3767d4d01a6f..47df16c87862d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -401,21 +401,21 @@ Description:
 		Hardware applied calibration offset (assumed to fix production
 		inaccuracies).
 
-What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
-what		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
-what		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
@@ -483,7 +483,7 @@ Description:
 		If a discrete set of scale values is available, they
 		are listed in this attribute.
 
-What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
@@ -750,9 +750,9 @@ What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
 What:		/sys/.../events/in_tempY_raw_thresh_rising_value
 What:		/sys/.../events/in_tempY_raw_thresh_falling_value
 What:		/sys/.../events/in_illuminance0_thresh_falling_value
-what:		/sys/.../events/in_illuminance0_thresh_rising_value
-what:		/sys/.../events/in_proximity0_thresh_falling_value
-what:		/sys/.../events/in_proximity0_thresh_rising_value
+What:		/sys/.../events/in_illuminance0_thresh_rising_value
+What:		/sys/.../events/in_proximity0_thresh_falling_value
+What:		/sys/.../events/in_proximity0_thresh_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -830,11 +830,11 @@ What:		/sys/.../events/in_tempY_thresh_rising_hysteresis
 What:		/sys/.../events/in_tempY_thresh_falling_hysteresis
 What:		/sys/.../events/in_tempY_thresh_either_hysteresis
 What:		/sys/.../events/in_illuminance0_thresh_falling_hysteresis
-what:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
-what:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
-what:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
-what:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
-what:		/sys/.../events/in_proximity0_thresh_either_hysteresis
+What:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
+What:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
+What:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
+What:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
+What:		/sys/.../events/in_proximity0_thresh_either_hysteresis
 KernelVersion:	3.13
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.28.0.402.g5ffc5be6b7-goog

