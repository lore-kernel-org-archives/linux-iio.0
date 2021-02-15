Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D3C433DB
	for <linux-iio@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2EE64DB1
	for <linux-iio@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBOQFC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:05:02 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35812 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231436AbhBOPwD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 10:52:03 -0500
Received: from tech.aim-sportline.com ([185.56.157.72]:34080 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lBeyF-00GYMx-5T; Mon, 15 Feb 2021 15:35:27 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-doc@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/5] docs: iio: fix directory naming
Date:   Mon, 15 Feb 2021 15:35:08 +0100
Message-Id: <20210215143511.25471-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215143511.25471-1-luca@lucaceresoli.net>
References: <20210215143511.25471-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This directory is a, well, directory, not a file.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/driver-api/iio/buffers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
index 3ddebddc02ca..9f7dc245d37a 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -28,7 +28,7 @@ IIO buffer setup
 The meta information associated with a channel reading placed in a buffer is
 called a scan element. The important bits configuring scan elements are
 exposed to userspace applications via the
-:file:`/sys/bus/iio/iio:device{X}/scan_elements/*` directory. This file contains
+:file:`/sys/bus/iio/iio:device{X}/scan_elements/` directory. This directory contains
 attributes of the following form:
 
 * :file:`enable`, used for enabling a channel. If and only if its attribute
-- 
2.30.0

