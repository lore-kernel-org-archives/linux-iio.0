Return-Path: <SRS0=NXws=AY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D123C433E6
	for <linux-iio@archiver.kernel.org>; Mon, 13 Jul 2020 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FF72075D
	for <linux-iio@archiver.kernel.org>; Mon, 13 Jul 2020 14:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zuaeamKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgGMO7z (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgGMO7v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2020 10:59:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095B9C061755
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2020 07:59:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so16922772wrw.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2020 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PXD4vP8fC6/t9fZb9g5coIXGjPw+6LiW/rcHcw4O0Y=;
        b=zuaeamKd2MOWNbcgimVgdWbMCvRNXeFqsGveoccXf9UiMRMyp2Eh64VIogpLrTZbbv
         en7AsCseJgjsgYtIkuMlaGuViO8O84ylg4R94V5el2S2MFL3E15S2zRJWH6JfgqeemH5
         nBmpSUDN+SlS6ahmpO8sRK9pviEegd8FUhAOG7Kio53ocuDxaTchRh7Kec/ZfY8rAQNF
         v8jwG9nbg3vGNPRudk7wqbyTDopPLKAQKVlQ7cKB32+F/X5O/WFOKQcTAfHrU5L5BjWY
         WHrNvfD+1mA00Hj4DQa/f8QuBc8ZOuPD0sxJ2OxIcrgz1yhDFswT8MiSlIz2emY5apE8
         97Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PXD4vP8fC6/t9fZb9g5coIXGjPw+6LiW/rcHcw4O0Y=;
        b=Z+zWW7x/W84jErE9E++TWIkN3AT7uvIje/sWmIsnB/Or4mLipdVRnTwu1EFs2tHoQt
         8pUVXX429Wi+MF7JZ8H0Ux0xUrF2G/hZMMoxUr/N2uh5xDinFTNql+11HEpviQUgmozF
         RN03/Mr6umilqi50jNb9CbJP+VFXFXh+aRxJFRrLV9r9dRPBLNiOCZwTd7XVBU/A3gyP
         K6BYXiX25wKNzp+q3wXLhfItAooD2xpvHs7JUoLitENqg64oS4fSvj4VUT4IZFE1YlUj
         FdD0GayJBTdgvgIyChhMTKchL2eaYWUPDA/fFIWa1D7r9mtmoxG9uyTlbf/MHM25KcLK
         KktA==
X-Gm-Message-State: AOAM531OlDMVKaZyzkI0AtkP1KSD6z1C+qBn3SYgfmvtxpoaWYNovrWT
        1ZHt+yOpIf0IR6rdFhqXe/uvANo3vVA=
X-Google-Smtp-Source: ABdhPJzjTMedChvGhWLYNaMyNCNGnKnwYsdLQG+HFCPhfJxEYwUA9Oy8TIQFHPUl0BfOjyPN0jjZ7g==
X-Received: by 2002:adf:dfcd:: with SMTP id q13mr80164558wrn.295.1594652389817;
        Mon, 13 Jul 2020 07:59:49 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id u20sm21991145wmm.15.2020.07.13.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:59:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Mon, 13 Jul 2020 16:59:34 +0200
Message-Id: <20200713145934.18243-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713145934.18243-1-brgl@bgdev.pl>
References: <20200713145934.18243-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed variant of krealloc() and shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d7fecab9252e4..5bdbe502e983a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1094,6 +1094,7 @@ MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int *conf)
 {
+	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
 	struct iio_chan_spec *channels, *chan;
 	struct device_node *chan_node, *child;
@@ -1138,7 +1139,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
 	}
 
-	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
+	channels = devm_kmemdup(dev, xadc_channels,
+				sizeof(xadc_channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
@@ -1174,8 +1176,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	of_node_put(chan_node);
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = krealloc(channels, sizeof(*channels) *
-					num_channels, GFP_KERNEL);
+	indio_dev->channels = devm_krealloc(dev, channels,
+					    sizeof(*channels) * num_channels,
+					    GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
 		indio_dev->channels = channels;
@@ -1229,14 +1232,14 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
 	if (ret)
-		goto err_device_free;
+		return ret;
 
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
 		ret = iio_triggered_buffer_setup(indio_dev,
 			&iio_pollfunc_store_time, &xadc_trigger_handler,
 			&xadc_buffer_ops);
 		if (ret)
-			goto err_device_free;
+			return ret;
 
 		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
 		if (IS_ERR(xadc->convst_trigger)) {
@@ -1354,8 +1357,6 @@ static int xadc_probe(struct platform_device *pdev)
 err_triggered_buffer_cleanup:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_triggered_buffer_cleanup(indio_dev);
-err_device_free:
-	kfree(indio_dev->channels);
 
 	return ret;
 }
@@ -1375,7 +1376,6 @@ static int xadc_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
 	kfree(xadc->data);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
-- 
2.26.1

