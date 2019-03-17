Return-Path: <SRS0=squ6=RU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5D0C43381
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 20:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBA020857
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 20:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8NLAhhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfCQUxX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:53:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46550 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2019 16:53:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so11966568lja.13
        for <linux-iio@vger.kernel.org>; Sun, 17 Mar 2019 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MH1aQIcsNS6MiLRvNEmELC6W2NQlV/nItXylZIr9rM4=;
        b=u8NLAhhXU8ujng9YFlwJWbW1sf6+FVC01yP98OBh+pAsahNruAzJBc0Odmf6yyrTbr
         9cFiXuDS7Gt0EbTn59ZO3ELqgHr8BlOOklh01zBvZ2mSyhefsLx3a1FhSI3Bso7P4sEO
         AcoQckbl7oy43vHNjjjnvdUoW6+lX6a3Sfm3G5RNVKc+qtQCbWnrStrPyyiSxdeK84hK
         w/pRNW1/hj9IeyCYXV+JjQeUNkDFSJr2ks6UGVcN0W1V/eok0pmudcCvg1Kw6OSfcV6r
         sYaNLO1xrAicKzzC+RDWM1GsvvVkfuH8mT01o4142yYcTbSMTj9HQeV8s7yy3wkXm5EB
         xZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MH1aQIcsNS6MiLRvNEmELC6W2NQlV/nItXylZIr9rM4=;
        b=jBvekU57saLvZaQZiyOzXd3/wK4iTiaLdkde9H4Uu/OuPeePChb2UtyayAg32+RoP9
         O4uk8iawvJQGYY117ydsiIpOE8ShrOjYbZ+l9l7TJosx6TyyeTVKkNDcFKGOD7VK/0q3
         avdy6KXrzXqbN3G/8FkL/tZHZN9ehUe75tF8B0l27/fBx53IwT1jDO5+rPabCesrB1Gp
         l8SjFnPsgw0PTtqn8fJLAeYViwCOjMD7xUlrJDp/fu965cbadNNtLRffuGXk9z4hD/hQ
         XDjBRbAk0Gy1iJACp2wFgHFsFzoz+0EnpDhEChF+Htj6nwtHXI/+gKq5NU+QjvApatMt
         VqHw==
X-Gm-Message-State: APjAAAW9ApkXh3kNY99fwos+blWWRoVmSBQ9m/CNIl2NCYFxedSHkJhc
        bflDDz00g1pUVcrweunOcEBCUO8jwZ8=
X-Google-Smtp-Source: APXvYqxA48bt4ifh+jLq2saQ4KSMpYtvWClZ6CB3lNuvi9YFw/LfDcYVmsDPNaKmWD3DKg/zRmec6A==
X-Received: by 2002:a2e:8658:: with SMTP id i24mr4709527ljj.194.1552856000800;
        Sun, 17 Mar 2019 13:53:20 -0700 (PDT)
Received: from ubuntu.localdomain ([95.161.223.243])
        by smtp.googlemail.com with ESMTPSA id v4sm1725578ljj.80.2019.03.17.13.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 13:53:20 -0700 (PDT)
From:   Vladimir Petrigo <vladimir.petrigo@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        devel@driverdev.osuosl.org,
        Vladimir Petrigo <vladimir.petrigo@gmail.com>
Subject: [PATCH 1/3] staging: iio: ad7192: Fix style issue
Date:   Sun, 17 Mar 2019 23:53:10 +0300
Message-Id: <1552855992-27653-2-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07..7c632cf 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
+			     in_voltage - voltage_scale_available,
 			     0444, ad7192_show_scale_available, NULL, 0);
 
 static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
-- 
2.7.4

