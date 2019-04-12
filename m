Return-Path: <SRS0=K6jb=SO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27283C10F14
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AF321872
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVcNr5Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDLQtZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:49:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40179 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfDLQtZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Apr 2019 12:49:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so12791912wre.7
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2019 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHf2VKgcNk4uBXiSKu/iHQi0CPZ+DDpgbvoraVKsNl4=;
        b=QVcNr5Pz5nopH/ls1cFeKJFo9ClTDGnpEpcMSyTJ2qLnboHtfPyfRR34jQx3WarzEA
         x2JXwhDWIhBiKh0Y5dMr5ktr6mzgXAY3Hq9Tt8WQWbwyK8L8JSGBrVxplDtKrOrtywcC
         0F8wsQnBxEoe4IcJMdPXGp77DlaVm/FWY27pE0MY9UF0ZylKWVVdRnXWzMDX8nQAj1PJ
         HzuJMjsWrtK6JKqiEm5UNKLGqtDDznolnFT3QRGwcIfgFiboLLOwazY5/8sQZG1DbGmU
         qd4s8pMTWGt4/NYokS8nPOwEFSiShp94pXCktJ5NLCS9t7MoJhwvg7eXX/PymSx68Zeh
         yCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHf2VKgcNk4uBXiSKu/iHQi0CPZ+DDpgbvoraVKsNl4=;
        b=WzOsnO4jY3fdoGm4W57ChH6JwIXWM3k/JcIg0Zt9NhhCSRJ/siWmRvQ+Rk0xO6XuvY
         7f7fZ3vfP9uI4VJoabGARxjY+7GmuAqocnGAGEATzsSoN8SVL5WE/AgU/4a2YceTsukB
         qiBhhRPqeaSsQ+ptEE/zLeZZdjYPyAFQBi5SOixjgyJAu5IagRWWXpUrgvldYyVPvyeu
         W2y02Y9LZMWMAWSmBsVQrE1UcrF8FtKSjBOFqh5iVyP3N/3NE7N+K3k9FSZc09ZKfuVm
         sGDYYa9KxlxqIlvwU3RT39yBHlFXrlzvMdW3OYt+MSWhQZiHNKJAVqvXpgAcQcDGUCD3
         O5tg==
X-Gm-Message-State: APjAAAUfUoMtUXMlOm7YXjVmHEV3fxYHGVkpaJjtfimJLdhdgacXx2Os
        HzrnO/ye3xMEZA1CaoM75MPuTw==
X-Google-Smtp-Source: APXvYqzwYMjvpvbZr8VPXC5BjmTo78QqdayeDkIUUMOowQ2p1AKcSgK2W4mmoQZMYOElgL9dyRLWyQ==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr1708780wrs.250.1555087763667;
        Fri, 12 Apr 2019 09:49:23 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm73863141wrs.27.2019.04.12.09.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:49:23 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v6 6/6] MAINTAINERS: add entry for fxas21002c gyro driver
Date:   Fri, 12 Apr 2019 17:49:01 +0100
Message-Id: <20190412164901.2321-7-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412164901.2321-1-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add me as maintainer of the nxp fxas21002c gyroscope driver.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3671fdea5010..f770f5124f4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11117,6 +11117,16 @@ F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	include/linux/nvmem-consumer.h
 F:	include/linux/nvmem-provider.h
 
+NXP FXAS21002C DRIVER
+M:	Rui Miguel Silva <rmfrfs@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/gyroscope/fxas21002c.txt
+F:	drivers/iio/gyro/fxas21002c_core.c
+F:	drivers/iio/gyro/fxas21002c.h
+F:	drivers/iio/gyro/fxas21002c_i2c.c
+F:	drivers/iio/gyro/fxas21002c_spi.c
+
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.21.0

