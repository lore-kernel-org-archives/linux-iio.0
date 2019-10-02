Return-Path: <SRS0=PLDO=X3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC06C35280
	for <linux-iio@archiver.kernel.org>; Wed,  2 Oct 2019 14:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9799321A4C
	for <linux-iio@archiver.kernel.org>; Wed,  2 Oct 2019 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570027552;
	bh=ExOe9Jas9T5zKQTMdccb5j//u7g6OAcK9uqWer/itLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=enbuM7LpNHc+9QBmXK3E/U0nqG4amozr/7DsHFmTY8+nizOBYVktXym4fiYHEG7fE
	 yh+1GKh95jfdOI2QUa/8Rfql97AVvPL0wFaFK1/BOQFk2RwDzIH1x96fq4Qs10oxvs
	 4MCEmWVBvNtoPvKmNJjBRFxfQQmx1IFahFKkfTSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfJBOpw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfJBOpw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Oct 2019 10:45:52 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAC321848;
        Wed,  2 Oct 2019 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570027551;
        bh=ExOe9Jas9T5zKQTMdccb5j//u7g6OAcK9uqWer/itLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1532exv22Totpi6EDFSzBBGtbFuXg/+kWuTRavymk6/3Ex7tnxo1Qdp/dzSJF9bB
         Gh7nK7CDIY7vyvbcYJr6MiN2p3t97wtP+w1XoeL8KTXN5EWh6ZamDiSO2QkzPgMM6p
         07YmWb96nmUPpBeg/K7l1YJjXitrsb1bsrI9gAcQ=
From:   Maxime Ripard <mripard@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 2/2] dt-bindings: iio: ad7192: Fix DTC warning in the example
Date:   Wed,  2 Oct 2019 16:45:42 +0200
Message-Id: <20191002144542.114722-2-mripard@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002144542.114722-1-mripard@kernel.org>
References: <20191002144542.114722-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The example contains an SPI bus and device, but doesn't have the
appropriate size and address cells size.

This creates a DTC warning when the example is compiled since the default
ones will not match what the device uses. Let's add them to remove that
warning.

Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 9e62f54c891a..567a33a83dce 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -95,6 +95,9 @@ required:
 examples:
   - |
     spi0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
       adc@0 {
         compatible = "adi,ad7192";
         reg = <0>;
-- 
2.23.0

