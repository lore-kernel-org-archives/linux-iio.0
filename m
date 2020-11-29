Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA3C64E8A
	for <linux-iio@archiver.kernel.org>; Sun, 29 Nov 2020 09:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D430207BC
	for <linux-iio@archiver.kernel.org>; Sun, 29 Nov 2020 09:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcBpUlUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgK2JoQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 29 Nov 2020 04:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgK2JoP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 04:44:15 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656B620809;
        Sun, 29 Nov 2020 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606643015;
        bh=ba2fVf16ytOyJatbap6E4Y15Dv0UFPzM8JIyUgebOD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcBpUlUlt5vEycJbUw9tHAGvD7a8hn2oNzvRvHsX1oYJONKZEyNvJXFeC5L4Zdj1o
         poNQzTshw1bKe+9t0cLT7iJNIPKWNH8CKl5LjwZnGBfWUl5HWVO0a08YBRLXaGOKCE
         uQedcEoi2zY42cXvhcc8Tr/bcijq5CAVn5/p25l4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsop device bindings
Date:   Sun, 29 Nov 2020 10:43:07 +0100
Message-Id: <501ff8187d2df584ec978c7e7ec5c445c3d0741c.1606642528.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606642528.git.lorenzo@kernel.org>
References: <cover.1606642528.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index fc545a130b30..d9b3213318fb 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -30,6 +30,7 @@ properties:
       - st,lsm6ds0
       - st,lsm6dsrx
       - st,lsm6dst
+      - st,lsm6dsop
 
   reg:
     maxItems: 1
-- 
2.28.0

