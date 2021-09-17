Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE293C4321E
	for <linux-iio@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B8260EE5
	for <linux-iio@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbhIQGM4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245026AbhIQGMv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 02:12:51 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72BDC0613E3
        for <linux-iio@vger.kernel.org>; Thu, 16 Sep 2021 23:11:28 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c21-20020ac85195000000b002a540bbf1caso35628692qtn.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Sep 2021 23:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TXG48xSRlx8rIgQW++hQT3j5R9gwaLAhcS6CZziLHmQ=;
        b=WmhloRtjGIK9ydAlJ6OHR1E2w5RjxR8VBTPhCI/O0xak8DgT2MO76zuYYPl24VmGPp
         yse5VSvtdAU2msUdkpYQOJUnKSnFyFST5EPn8fCafk6yZQ46FNdPLWKTSBR3+zxtOBW7
         sNbBXeRo0RHv8ziNHdSoGEpUFFISJxxpYhiy+2MVKGbzGc7jYpxOV8tLAcwl+rv4VK8Q
         OMGMl9rnWCFAnIkBzs5nVhwMf8z+PicX1CD1YvIz5WrRHo6Ylwov8F5oYotxfS+1/LEt
         DKN9SHB8jZeMVVnMBsn1ODzNyalQkI/zxfzf3xRkXWq64KC757pRykt/gdw+TEESPIrZ
         Su1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TXG48xSRlx8rIgQW++hQT3j5R9gwaLAhcS6CZziLHmQ=;
        b=S5QU3VVKWz67/Y2hn+dJjN9vOg3cSaxBSL2Rb7Dvb001OKZ7HtJjebZlw3W3j3toFj
         qPAzBUH5qkMKtFLfWDkqf/sEa5xP6HDk01BV3IY4j7TwDN7f2fh9pAoar9S17jC8PVbk
         RGPjm/7bUSobKFPwVvyA0xIDHU7ljo/aaRbN7yrSvtapHY4D2jzX29w1YegiF3bjNT4J
         M2ItuxjvxZi33/ZCCUrUGm5vd2SftRquFtV7MtqCVUlXTh64Ym20FT5VobFWx+v3Ihw+
         QGzPUjqDA98vwAguaANlTVXVDJxiwUKNbzxfIVOOg7MJPhk+1OCIdWl7ng0hreyNZ5rU
         Qg6A==
X-Gm-Message-State: AOAM5307DRYkgC9zTQNp1r3YwkLeCFOvh9FFb3bCvmCmBtZ0R3Sd9dV8
        EXFX4mBRUYb+mkLKMO842yYlH+ZgSbvZoQrXI/q97A==
X-Google-Smtp-Source: ABdhPJypn4hhdPHmNfweWLWHauxWHrVoQvMZsHWsDKioZ9IeJPJspxqNCPwjtYoY9xvXJMChe6ahFtlZ1gOXKE6/5Xximw==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:a25:ca08:: with SMTP id
 a8mr11249514ybg.231.1631859087755; Thu, 16 Sep 2021 23:11:27 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:10:59 -0700
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
Message-Id: <20210917061104.2680133-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 1/6] gcc-plugins/structleak: add makefile var for disabling structleak
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

KUnit and structleak don't play nice, so add a makefile variable for
enabling structleak when it complains.

Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 scripts/Makefile.gcc-plugins | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 952e46876329a..4aad284800355 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -19,6 +19,10 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF)		\
 		+= -fplugin-arg-structleak_plugin-byref
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	\
 		+= -fplugin-arg-structleak_plugin-byref-all
+ifdef CONFIG_GCC_PLUGIN_STRUCTLEAK
+    DISABLE_STRUCTLEAK_PLUGIN += -fplugin-arg-structleak_plugin-disable
+endif
+export DISABLE_STRUCTLEAK_PLUGIN
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
 		+= -DSTRUCTLEAK_PLUGIN
 
-- 
2.33.0.464.g1972c5931b-goog

