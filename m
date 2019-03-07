Return-Path: <SRS0=p+Fr=RK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B10C10F03
	for <linux-iio@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9693121019
	for <linux-iio@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="uLsXhyCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCGKeW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:34:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36652 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfCGKeW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Mar 2019 05:34:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id g9so12999606eds.3
        for <linux-iio@vger.kernel.org>; Thu, 07 Mar 2019 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQfzRKxR1O3joIUJZYh1QtI21K+DZPqA7zcAwcwER9k=;
        b=uLsXhyCEV2caJOyuUt/5mTumhFWeBCwD/7/NxK0+39mLl3kCgihZoKw54jqDbIvuG5
         N2aOhApw4z738Uvm5VVP5Z3ihcjBVVzY21SDq45wgezQ0Kar2d6gWnzLo7Wv4soAK/5Z
         34BhjQ18DWAtaf7r/R22LJmzS9GDRZwKvJkGdLhAVjoh6AaTk6LQqXn114UcPjQSZJPw
         oFE5+PYhQFjRWlHEADfRmzGjMpfDKogeoxOLu5I6yR58Ee1t+Ukc7JFueAcxN00Bux/X
         wQvgRhiwbknGaXuMt8V4QUvgfL0A1tFASLU0iH4jSqyR69Ce+YCLiL+KBPj1W9G3XX1V
         hgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQfzRKxR1O3joIUJZYh1QtI21K+DZPqA7zcAwcwER9k=;
        b=TJG6iBxBX/+wMdgDHuL26lVrlO3yvRhC5hZyMgNzSqlT6euVuRwzc3SBU20SgPRDKA
         8AKd+2D/PVKAciZhSrQRqgTfczZSOF1dFbx+CKGoC93lqYsiz7hYhDsfZS3O7JGVC+SS
         P3DbSDnA1kvWzegR7wEXnzlOYEtw/e/1PPc94bKb98UAR/MnPJ/ydBgsWtIrDLwqxr5h
         l32MlTY+UJKquSQHc9mmfLNdeOCpkA/VCAEuPokVksHUclzL/D1JAcmc/g7nfFYUu55A
         fPvCuElVseplCw3kidVD4n3LQlM7RA2VGmq+2NsPhEKU8VltQkAUcuEt1tcdrheP3o7/
         +h/w==
X-Gm-Message-State: APjAAAUM/0VOk64su5nfRJ43XcBI9/YKnv7Nr1Lr6v8dD6uU6ptvRqox
        BBlujj9ie93XJYUSSRvb12B4ag==
X-Google-Smtp-Source: APXvYqybcFMjvD/8zpJsT0v2f535jDR2S/+NDwRi33+Dw24oEnVrsa4IWg7hHKwDCEO4wVvgKdUCSA==
X-Received: by 2002:a17:906:7b0d:: with SMTP id e13mr7012374ejo.165.1551954860309;
        Thu, 07 Mar 2019 02:34:20 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id h8sm1250998edb.36.2019.03.07.02.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:34:19 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v6 2/4] dt-bindings: iio/temperature: Add doc for thermocouple-type
Date:   Thu,  7 Mar 2019 11:34:07 +0100
Message-Id: <20190307103409.24174-2-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190307103409.24174-1-patrick.havelange@essensium.com>
References: <20190307103409.24174-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This explains the new generic property "thermocouple-type" that
can be used with temperature sensors.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes v6
 - Add this file
---
 .../bindings/iio/temperature/temperature-bindings.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
new file mode 100644
index 000000000000..69a6441d8083
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
@@ -0,0 +1,11 @@
+If the temperature sensor device can be configured to use some specific
+thermocouple type, you can use the defined types provided in the file
+"include/dt-bindings/iio/temperature/thermocouple.h".
+
+Optional property:
+thermocouple-type:	The type of the thermocouple used by the device.
+
+For example:
+	device {
+		thermocouple-type = <THERMOCOUPLE_TYPE_K> ;
+	};
-- 
2.19.1

