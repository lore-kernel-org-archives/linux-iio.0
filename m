Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49C6C388F9
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8011E2071A
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKsArutb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgJaNng (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbgJaNng (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2020 09:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604151815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xpsTtMH9ntXfVKcj//i9QDM7KI2/8ennQA3napfR6+M=;
        b=fKsArutbOor34MFAbnxm5xN/5OOc9HffWmun8l2PDACoQZd0TdwGfGVgiPSXgUVCmWzJ2l
        dZzDIZhGED5CRdvoHmgXYChaa4nvL6vcxZ0QF0+LH+zZyvvm/nWpnHW8YhhEWUOiIfNzbY
        aNrrfkNGyVcHEGkTx0xF/cccKxqn4gg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-vVcNg7LJOmqd8hgPlzTvAA-1; Sat, 31 Oct 2020 09:43:33 -0400
X-MC-Unique: vVcNg7LJOmqd8hgPlzTvAA-1
Received: by mail-ot1-f70.google.com with SMTP id i25so3796816otj.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2020 06:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xpsTtMH9ntXfVKcj//i9QDM7KI2/8ennQA3napfR6+M=;
        b=Pre87QgAx9mnLAxLY6Wfch9xxajX+VjZwoSXJQbWfw6+YlcypJA7g5aO9xVhJGp0/1
         a2oa87PC+RWN+l5ldXEMSFqLwHACrlmLCxTXZIELNVdw6kF+6RuvXaW4HKZXF7VNVbmC
         /4qQjrKDx1s0VISBkszWpTRteDpE0F0f2dUHkrqtW4gUmHTkd8r6tq2x8Dti6etN5WCs
         cx4ym4z1oT2Falrci1wKThOwwn8nwH5nbIDdyFyANFBO4bEs1PFvkedHFNwwaZj26ggF
         aVSwSlSAOYKuzacjf7PZgPKesaONqP7MBtQZNprCDYdIRg4pMMfjPjpqaGIvgZoPU1iZ
         ePUQ==
X-Gm-Message-State: AOAM533L/xbh6+JeHDbESE9Wgv+IjvBZZXzkKy2h++6iIxjxsTLovVDs
        wKF+lGGgcybyaKRqynEGxWs49XZegJpI1ie1hBTsOlMxEXM/1TJWa96ruyH6Vny+vwR73/zGrlh
        gVOtxa3Ys5ML0DA2Csmxy
X-Received: by 2002:aca:6206:: with SMTP id w6mr4952159oib.121.1604151812495;
        Sat, 31 Oct 2020 06:43:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcfxMeR+vmw/c5zsmF0ELbs7FL/idSETkEZq5uw+VXQElduuJ0iys97bvRMt5GCPdWN2p37g==
X-Received: by 2002:aca:6206:: with SMTP id w6mr4952145oib.121.1604151812322;
        Sat, 31 Oct 2020 06:43:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t4sm2104972oov.15.2020.10.31.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:43:31 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: magnetometer: bmc150: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 06:43:19 -0700
Message-Id: <20201031134319.2134314-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index fc6840f9c1fa..73e55ec815ec 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -190,7 +190,7 @@ static bool bmc150_magn_is_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool bmc150_magn_is_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.18.1

