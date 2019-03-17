Return-Path: <SRS0=squ6=RU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C9C43381
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 20:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC9820857
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYDbpXpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCQUxZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:53:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46552 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUxZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2019 16:53:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so11966603lja.13
        for <linux-iio@vger.kernel.org>; Sun, 17 Mar 2019 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sCYupxHcBBvzocazkQmggBfMLHXvEaLIZvoat/PLuTw=;
        b=jYDbpXpnN8bO4LI46pBHGyuLmqTVG22nlnWUr1hl8BpOKSWE2E3Av4siqRfL3j0+xE
         w4Z3o07r7BwmD6m1/T1vdX/JNl8qSOsieJBxWqW/IRAcXVcsSQtSUF4Nqp8ZpO6gUrwo
         aZAp/W4szuzkWDpXThsXTrgLrz8tL8KuPMcYiTO2JDUzCxTtdu0jYLmJE4nrxtEgnHRm
         uSl/WPMDTQ/fDm1ephLk8gOMiGslWJUYMHUmCRFK3yI5BUxOidKDJwCR3rYK+U00GLFY
         +bXimEJk28zp0bv3QdC17omZXJMCrt7f0m7Cx30xuD9jtsVfVpSTD1DI+DVRHgszGM6r
         eUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sCYupxHcBBvzocazkQmggBfMLHXvEaLIZvoat/PLuTw=;
        b=LPCjPRh6VdjjL0akyxlGeCycRwEnI22CW7DqJe7QUwTuziqVBGjgz40xVgiMV4W/wh
         b95aZMsCeANbDSybX2m9HTG/nJ7I9tTw4quJosunu7clmU3XXeGlwuJ2Sg+T3V4/oEVB
         s47kE86/cxvRQ1UoOFFOMuRSVHUbiuhtQmsdWZxsUS/q5W8OVTfY3xKMGGVU9MngnF6p
         muTidW3hkXXqvSB+hfFd0pzK/b1zQPoM1zYbU+6TxjdL86xlSx9E5twbZmKVhXreB+zI
         QvPSpww/eMgiVWavx85/jFSbnU86faA4WNIdMEDWvqfe9846jiMlYGFZfWknmvu77lgK
         QXlg==
X-Gm-Message-State: APjAAAVPVVxAqtgEc1YNI1X+1q6v14znOUVJ4cor4BJ83a8YHXBk5SXb
        XgNq+AKbRDrsktZI1Lgfu07Ltg3iGMI=
X-Google-Smtp-Source: APXvYqzsWsTodI3esfNVQJz/Bp3qkMV2ZX7MTq/GC+EY16Fx+gSgUWAzXursNWuwrImqKZ7Mbt7rEw==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr8110754ljh.104.1552856002785;
        Sun, 17 Mar 2019 13:53:22 -0700 (PDT)
Received: from ubuntu.localdomain ([95.161.223.243])
        by smtp.googlemail.com with ESMTPSA id v4sm1725578ljj.80.2019.03.17.13.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 13:53:22 -0700 (PDT)
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
Subject: [PATCH 2/3] staging: iio: ad7280a: Add parentheses to macros
Date:   Sun, 17 Mar 2019 23:53:11 +0300
Message-Id: <1552855992-27653-3-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix CHECK Macro argument 'c' may be better as '(c)' to
avoid precedence issues

Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>

diff --git a/drivers/staging/iio/adc/ad7280a.c
b/drivers/staging/iio/adc/ad7280a.c index d9df126..98cf876
100644 --- a/drivers/staging/iio/adc/ad7280a.c +++
b/drivers/staging/iio/adc/ad7280a.c @@ -97,9 +97,9 @@
 #define AD7280A_NUM_CH (AD7280A_AUX_ADC_6 - \
 					AD7280A_CELL_VOLTAGE_1
+ 1)

-#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d *
AD7280A_CELLS_PER_DEV) + c) -#define
AD7280A_CALC_TEMP_CHAN_NUM(d, c) ((d *
AD7280A_CELLS_PER_DEV) + \ - c - AD7280A_CELLS_PER_DEV)
+#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) *
AD7280A_CELLS_PER_DEV) + (c)) +#define
AD7280A_CALC_TEMP_CHAN_NUM(d, c) (((d) *
AD7280A_CELLS_PER_DEV) + \ + (c) - AD7280A_CELLS_PER_DEV)

 #define AD7280A_DEVADDR_MASTER 0 define
 #AD7280A_DEVADDR_ALL 0x1F
---
 drivers/staging/iio/adc/ad7280a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d9df126..98cf876 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -97,9 +97,9 @@
 #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
 					AD7280A_CELL_VOLTAGE_1 + 1)
 
-#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
-#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
-					     c - AD7280A_CELLS_PER_DEV)
+#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + (c))
+#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
+					     (c) - AD7280A_CELLS_PER_DEV)
 
 #define AD7280A_DEVADDR_MASTER		0
 #define AD7280A_DEVADDR_ALL		0x1F
-- 
2.7.4

