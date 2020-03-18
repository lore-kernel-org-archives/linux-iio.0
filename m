Return-Path: <SRS0=l2Gr=5D=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D2EC10DCE
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 13:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7710520774
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 13:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0rWwlJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCRNhg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:37:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRNhf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 09:37:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so30458927wrd.0;
        Wed, 18 Mar 2020 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuo61nM/MH+S9bbLW2vdQq9bZPHHpW6MvtuVuJlfvWw=;
        b=W0rWwlJN7lswrFIX9K9PmiIJNNjqcBkwNsVUqRB9cjH2QbEWw//6zD/YxGc22jwzQk
         MAWmTLj6kNhpytfmLADJPiFwKcto+npBanpNSfEID79+vYWm5JMeuelmWbEiPh/tliXv
         ytKm8R67Edsbi1I5iUjxQ4uTxA2E9DJxRRyxfkAlKBuE1c613/Za8cKU499CJ/X8fzgE
         Kz00OCshqp3RBPGRGCBUEPuG8xXMX0KSrdBRlLmtCg4287LtLKiVXd0GrZ7/huOiCikA
         cokppLLsaoHvsW+40gIh1pXEgD1GiVQkn7fhYFpwoFdpXXk8wU4RiP6TAvZd5GQrw1kP
         MG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuo61nM/MH+S9bbLW2vdQq9bZPHHpW6MvtuVuJlfvWw=;
        b=A01t3NrYnXs1jBusxV1RutdDj8Wg8Z0BSEIDD00mqlYt11sw+gkBng0vYOtJzqUrNj
         o1bBTv+2i9bcaLgT7mIA1kzAYDwDFJbG6QtFETMU5HF3EfHlLcmWD3uzt40Vm36260vT
         bbUGlgbkcgqs16/7kLvY9KZIa5iQWLWPb2bVoeBdbOQf40NI6NS6RHpOS4Hf7iUJX+CP
         x39s6ZuWiqIxTjIfKjl2Df3WgVtwX2/ymSyXc8LDy7KV/cOJAbKymeSi5jLBpwZwdwUD
         81eNgG1UPmbt8oA4VXs2TKJf82wKS8pJXnL0n4atCppGNB9J43uNvrC6MGwPiaagGrwl
         CgpQ==
X-Gm-Message-State: ANhLgQ2eGGV0PlSejXJrpS0oZ6Hd5oyCHcwS3CdNeFOEvU4/SfDvxyLc
        QOnA1bUKeV31BHt36pBm39uhT7z1
X-Google-Smtp-Source: ADFU+vse8RfhuBxKtnCK1LbbuV7axl1zNf9gCdOSP1kVgxuq0HKCcNdzi/SV/zNTG5Cic8Q0koNREQ==
X-Received: by 2002:a5d:680f:: with SMTP id w15mr5670860wru.245.1584538653865;
        Wed, 18 Mar 2020 06:37:33 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id f15sm9444002wru.83.2020.03.18.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:37:32 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, renatogeh@gmail.com, lars@metafoo.de,
        jic23@kernel.org, mircea.caprioru@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/5] ad7780,ad7791,ad7793: localize all IIO channel macro defs
Date:   Wed, 18 Mar 2020 15:40:37 +0200
Message-Id: <20200318134042.30133-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset has 2 intents:
1. We've noticed with newer Sigma-Delta ADCs that the current standard
   macros (AD_SD_*_CHANNEL()) for defining IIO channels are too rigid when
   adding new parts that have some slight variations. Two examples that
   come to mind are AD7124 and AD7192; for the final version of the AD7192
   one requirement was to set 'IIO_CHAN_INFO_SCALE' to
   'info_mask_shared_by_type_available', which would require a new
   AD_SD_*_CHANNEL macro-set
2. Similarly to AD7192, for the AD7793 driver, there is a AD7797 part that
   doesn't need 'IIO_CHAN_INFO_SCALE' for
   'info_mask_shared_by_type_available'. While other parts do need it.
   But the biggest problem in the AD7793 driver, is that we're getting
   checkpatch patches that try to fix/break the
   'in_voltage-voltage_scale_available' sysfs attribute. So, to get that
   driver away from checkpatch's radar, the read_avail hook is used for
   AD7793.

This patchset comes with a bit of code duplication, but as it seems, this
duplication is easier to handle.

Alexandru Ardelean (5):
  iio: adc: ad7780: define/use own IIO channel macros
  iio: adc: ad7791: define/use own IIO channel macros
  iio: adc: ad7793: define/use own IIO channel macros
  iio: ad_sigma_delta: remove unused IIO channel macros
  iio: adc: ad7793: use read_avail iio hook for scale available

 drivers/iio/adc/ad7780.c               |  27 ++++-
 drivers/iio/adc/ad7791.c               |  62 +++++++++--
 drivers/iio/adc/ad7793.c               | 142 ++++++++++++++++++-------
 include/linux/iio/adc/ad_sigma_delta.h |  58 ----------
 4 files changed, 182 insertions(+), 107 deletions(-)

-- 
2.20.1

