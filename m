Return-Path: <SRS0=Too6=52=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE31C2BA2B
	for <linux-iio@archiver.kernel.org>; Fri, 10 Apr 2020 09:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE77720787
	for <linux-iio@archiver.kernel.org>; Fri, 10 Apr 2020 09:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgBxphpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgDJJno (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:43:44 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38035 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgDJJno (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 05:43:44 -0400
Received: by mail-pj1-f67.google.com with SMTP id t40so588978pjb.3;
        Fri, 10 Apr 2020 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8UqKiWgsSHiMoGQyCyV9GY+lAN74tpZIBErevA5oYw=;
        b=XgBxphpJWngdfKxnfX8bAaKwdG2vny8asgZwyRWTHV/jfBABLlC2MHjXHJy7fU6dKZ
         mSEouQatBheEvxHnSI8XN9x2dDyvuvMDKlJWmt3lT4v2+AdcFTIe7hls6zTCik+qMjHP
         e8NgjTFGyq7/WP3uQ0i+o0QY6TWLN0AUMfbtMB96kwfnHxJ9kOo+WJrUi0HxkluS/iCt
         s0Ki/JHJlpIALiiwpMJR4NMUfAicgZBOaiOQnOybPUrGHWIQBpT7DJfgQotRoV/XNPPU
         2Q0ljXPcL3T2bdrJtHEF/Ysiz5SWP513TgiUOXtqX6rnZTqrfb+CZ8bJTHkNJtLXC3sa
         2UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8UqKiWgsSHiMoGQyCyV9GY+lAN74tpZIBErevA5oYw=;
        b=SqHEyOAcGPuIDMq64vGYMTIJQaVSv6v6WnYB/NayVanTTBnXOHTMaeXeiOfvYaUra1
         Afs9k7lmnpsTDgcd+ZQjqM9auL1S+PntHO9i5JvRgthF+6BZxpiM/E74s5r5j4mtq3P4
         kJqkSsgiw7n2d0oBIGuYoAx8mvwsYuW8yateBKLdNhws2sDBcsPgeLqYjDoD7UsoBrfk
         45jZBEEtvNbDSeVqP0VKdzDJ0Lx2Jj2TCVt1NaMON0daRi/1bSp9bsGd3NzlxGvlfpM3
         XIfdqbJD4YqUDCCHydkMMOZbVqB/DShwhZYWqSqohhJ9XMJKzxGvX5ERulkFDHwomwOy
         cfrg==
X-Gm-Message-State: AGi0PuZCXQkak7Ji3MoJWBTLw8kZDcG2BKHYlwOdIV7E1DJIET/MXNP7
        jDPKfNg0xEl/K45MoukGvzI=
X-Google-Smtp-Source: APiQypJ+LbV+D+G1TrlHUJ3PKuk1FxsEEVKE0QOuRP0/L2bFIcyjzftDIsBNpq5Oyg1lvchBoRyGAQ==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17mr3700951plo.53.1586511823774;
        Fri, 10 Apr 2020 02:43:43 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:991:ccd7:9dbb:79c0:fda5:adef])
        by smtp.gmail.com with ESMTPSA id bt19sm1305507pjb.3.2020.04.10.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 02:43:43 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
To:     alexandre.belloni@bootlin.com
Cc:     aishwaryarj100@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
Date:   Fri, 10 Apr 2020 15:13:09 +0530
Message-Id: <20200410094324.4334-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409151125.32677-1-aishwaryarj100@gmail.com>
References: <20200409151125.32677-1-aishwaryarj100@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use helper function to simply the code.
The devm_platform_ioremap_resource() helper in the
kernel which helps to make code cleaner a tad by
replacing few "boilerplate" lines of code with a single line.
