Return-Path: <SRS0=ocBO=SZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D99C282E1
	for <linux-iio@archiver.kernel.org>; Tue, 23 Apr 2019 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70362177B
	for <linux-iio@archiver.kernel.org>; Tue, 23 Apr 2019 10:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p8Cs7/Pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfDWKlC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:41:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32885 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDWKlB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Apr 2019 06:41:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3so9933453wrx.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Apr 2019 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HpAsscdncpv4xr8aQhK4uEvYFygVSPExyuY5/UGAfBQ=;
        b=p8Cs7/Pd2FOhOe1vCUZsEPrt89TEx2W+eauOVaeZSTs0kBvsGbPeSzUN0AfySP10dH
         fs/jJL24VriCSHxniOMgffi4SHrivxKglOfGHISkfoinCI5CrKjHOC234la4rld+uyVD
         QynLL45ODgg7pV3VUPADyMYpdS7jjb13FHVWxZg3VAwKhd7OID8+odVG9loir3dVAY6R
         rVLKSrxCQyoAZp3ET1kg7dZ1n7wTcxYaK0PDYMfym3vKtNXyZ80otmVdyWTvq/gM6huZ
         LfW6iu4cw9iTgl9NHACQrta0jMbnqWbnhIP6YysFKevWwAtwh68rw57ZKIaBsJ8Q+Acx
         p2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HpAsscdncpv4xr8aQhK4uEvYFygVSPExyuY5/UGAfBQ=;
        b=WGlCqDjuustiyZzhQP6jfRQ+wy5Y/DiSs+ugH1HIudsUSfABm8gJ6xzO+QuhG3b0lG
         GP7ICtAxtxnFMiTkOfA5Bo62bH8QfK4WS73Ro4FORzuwb/a8CF178O29NhhIVyp80FdB
         JxKuoH/fU4ibVzXH+GwNyliN/6sZHMAl6lYPl8oQB4JXL3Sh2v1alAcCQZmaNfRUnuBr
         zATrxcXhKNNyY1YbwokI2fdY8TRC9os4nUD/YdOv3PPEfjH0bt/JBxcDfRJW8AAMjswe
         pwH2sWVbvC0/RrgPCoPJGRocw3x9ZxzJbQqLgDU4dvFNbfoAgW2dL5iegZXwfxlf1kf6
         /VBA==
X-Gm-Message-State: APjAAAUyUsk4rhZzMdFhjwkSDQJavf3bjCo0g2YYefO7kDG3fFDPWDRi
        sz/6yVOlY2uC+dK04nRGMK9gpg==
X-Google-Smtp-Source: APXvYqwFHvn81NE2rgFB/poHlx1FVhEVzBXSZvtizVw/8P+Ef6JjiYITcbkZPnnbTLCcIJW+/o3udA==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr15788758wrs.5.1556016059818;
        Tue, 23 Apr 2019 03:40:59 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y5sm13329421wrw.23.2019.04.23.03.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 03:40:59 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: ot: Add docs pat9125
Date:   Tue, 23 Apr 2019 10:40:45 +0000
Message-Id: <1556016046-31231-3-git-send-email-amergnat@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556016046-31231-1-git-send-email-amergnat@baylibre.com>
References: <1556016046-31231-1-git-send-email-amergnat@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the optical tracker PAT9125 and
"ot" directory for Optical Tracker chip.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/iio/ot/pat9125.txt     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/ot/pat9125.txt

diff --git a/Documentation/devicetree/bindings/iio/ot/pat9125.txt b/Documentation/devicetree/bindings/iio/ot/pat9125.txt
new file mode 100644
index 000000000000..2ffacaafba8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/ot/pat9125.txt
@@ -0,0 +1,18 @@
+PixArt Imaging PAT9125 Optical Tracking Miniature Chip device driver
+
+Required properties:
+	- compatible: must be "pixart,pat9125"
+	- reg: i2c address where to find the device
+	- interrupts : the sole interrupt generated by the device
+
+	Refer to interrupt-controller/interrupts.txt for generic
+	interrupt client node bindings.
+
+Example:
+
+pat9125@75 {
+	compatible = "pixart,pat9125";
+	reg = <0x75>;
+	interrupt-parent = <&gpio3>;
+	interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.17.1

