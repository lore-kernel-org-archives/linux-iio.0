Return-Path: <SRS0=eBr9=QH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1363FC169C4
	for <linux-iio@archiver.kernel.org>; Thu, 31 Jan 2019 15:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59752085B
	for <linux-iio@archiver.kernel.org>; Thu, 31 Jan 2019 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWviNoww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAaPcZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:32:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40543 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfAaPcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2019 10:32:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so1619917plq.7;
        Thu, 31 Jan 2019 07:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d8EaDJxEMO1Wa4XMCP07czzfkvcJWqHHhB+W3APYyaM=;
        b=uWviNoww0mVd8+5SLn41oR4CklYVV3V4UEb7dXwYKu7qw0W37KaJyp5iLKdbM8n3fF
         PRlTHUQzaVXQZQtr+OCGcybY/wn38S0QqVotH0BbsBMt0OjTWxqU/cMaI6DMnuiHeFoq
         2NKCpxAiRtJqTjdOpWguobSRHhjRanY4+gJB5UYbwCIfkDPG0MLzbpBSnk5B3UTLY2Mb
         wlNLkkqyUxWY6Bm6JMSaGgqafP2jsy/hV4lubMq17gY10ZTm295ApcraPGF6IBmt+8ay
         +GSc9TCQ0pt7fEGDIuJOA3hFUeee1zxXcMDo3Uopt/F7ln1FT0XJ1cjd8iPiMv43FkTs
         pgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d8EaDJxEMO1Wa4XMCP07czzfkvcJWqHHhB+W3APYyaM=;
        b=RoGIGUgyoAY6ps/cC16rS8L5+Rh3UR/Xfny8XuLtaYKeiuXdkK6BneqaihcFkEpNcr
         k2CCuOClQ4e7ldyX0xj1JnqGqq/EsKrH2NMPGwhTV7guW3pu3vLqAEd9C6tPXUCFwHH3
         YRACPTi3Y8JVjjUsZYP9RoGPUsW112hqHPENMzDUEbXbeRe8F0HSEpbRYv4P0xCFmtj6
         zbsbswWmedxrmBsmgA+fb/20wKEwEmIpUzVtLC7HOXcHcPAYZFS761wCRJNHE5qeiTRN
         pCiFLd/4l63FC3MSymR6GpzYxeyO/qxLRQDJXy5HXp6C7wVrelPmg+7CJ4AMN84WPbwJ
         AtAg==
X-Gm-Message-State: AJcUukfHzXwR9aYWsmE7fvMea+LfjdtMioIDG5Z5OADGy6I2ACp6hJU4
        phGqJkqNNoWubETZ8OgdmGI=
X-Google-Smtp-Source: ALg8bN66BK1Yzadaoxdrkb6vonZqMqvWSNheTKLJjL30NDOjP6PUTfMgav+L72RcGB5HwMU6V9d04A==
X-Received: by 2002:a17:902:2868:: with SMTP id e95mr35384259plb.317.1548948744341;
        Thu, 31 Jan 2019 07:32:24 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::3977])
        by smtp.gmail.com with ESMTPSA id g190sm6359246pgc.28.2019.01.31.07.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 07:32:23 -0800 (PST)
Date:   Thu, 31 Jan 2019 07:32:21 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.orghange-folder>?" 
        <toggle-mailboxes@bobby.localdomain>
Subject: [PATCH v4 2/2] dt-bindings: iio: light: Add max44009
Message-ID: <b36579acc3031a28657b6f2e143e9ea4051d7c46.1548947951.git.bobbyeshleman@gmail.com>
References: <01f62d9d67110fd2c2f34e7835973fc6874a9fe8.1548947951.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f62d9d67110fd2c2f34e7835973fc6874a9fe8.1548947951.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds device tree bindings for the max44009 light sensor.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
Changes to v4:
- Use correct subject style
- Change node name to be 'light-sensor' 

Changes to v3:
- None

Changes to v2:
- Clean up style

 .../bindings/iio/light/max44009.txt           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt

diff --git a/Documentation/devicetree/bindings/iio/light/max44009.txt b/Documentation/devicetree/bindings/iio/light/max44009.txt
new file mode 100644
index 000000000000..557297c86fba
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/max44009.txt
@@ -0,0 +1,25 @@
+* MAX44009 Ambient Light Sensor
+
+Required properties:
+
+- compatible: should be "maxim,max44009"
+- reg: the I2C address of the device (default is <0x4a>)
+
+Optional properties:
+
+- interrupts: interrupt mapping for GPIO IRQ. Should be configured with
+  IRQ_TYPE_EDGE_FALLING.
+
+Refer to interrupt-controller/interrupts.txt for generic interrupt client
+node bindings.
+
+Example:
+
+max44009: light-sensor@4a {
+	compatible = "maxim,max44009";
+	reg = <0x4a>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+};
+
-- 
2.20.1

