Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F3AC77B7C
	for <linux-iio@archiver.kernel.org>; Sun,  7 May 2023 17:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjEGRM2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 May 2023 13:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEGRM1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2023 13:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92EA83E2;
        Sun,  7 May 2023 10:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CE3660FA3;
        Sun,  7 May 2023 17:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41CEC4339B;
        Sun,  7 May 2023 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683479545;
        bh=3phYCtkDDuBriMRIaltff51dUC74TH4KL0xBZLdD/q4=;
        h=From:To:Cc:Subject:Date:From;
        b=oOceODegN8PIhYL6go+L5mNRLm5WVIULG7h7djF7XZqS6WU21JSmJD1TQjhrd2978
         pfaH06t6D3Gqj6/j0vsoG3pnneX+/X0UWvTmVFb147HZje3IBnhpoHgv0LSN9UZ9NH
         9LVpO+pMFek/cAijUXzeLc7/YuIhAtVYpB/pFLO0B0nNA/putMW34xNNDWgoIzSBSs
         pLs7DC17aUuYbNEpZx3OzA4qe7zGhKIu78VPj71U2g/ROm59kLCfF0btBK5RTscvlY
         rw0XSXWoSkdI0UnxavthEoFNWZPuJh4j9enjCvplypKH+/CH5pHxG9FjkHiWm+ftxo
         ia+BHFmKRRJHA==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [dt-schema PATCH] schemas: iio: add label
Date:   Sun,  7 May 2023 19:12:19 +0200
Message-Id: <20230507171219.232216-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Linux IIO core code parses label property which is already used in
several IIO devices.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 dtschema/schemas/iio/iio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dtschema/schemas/iio/iio.yaml b/dtschema/schemas/iio/iio.yaml
index 5ce5e147aef1..727ca0f9afec 100644
--- a/dtschema/schemas/iio/iio.yaml
+++ b/dtschema/schemas/iio/iio.yaml
@@ -30,6 +30,10 @@ properties:
       with a single IIO output and 1 for nodes with multiple IIO outputs.
       A few unusual devices have a 2 level mapping.
 
+  label:
+    description:
+      Unique name to identify which IIO channel or device this is.
+
   mount-matrix:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     minItems: 9
-- 
2.34.1

