Return-Path: <SRS0=R23/=RZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B94C10F03
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0306218D3
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFoGfALd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfCVUoy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:44:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39756 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfCVUoy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Mar 2019 16:44:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so3744507wrn.6
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2019 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j6zqP4MLPtYMqVTQigbCve/GmakRYD7os8ayHkbdFP4=;
        b=ZFoGfALd3NrTiweEXGLEnfGY+CQ5zaqwHgzEYfIt5BgotC9nmk+s5TPOofuehRoY3Y
         kED7f/P6jncaqxhTLXSTpoZGBNHHQsWhcJu1k42ioaZzY8DZFZX7evO4XyaGufiJwGqF
         dXzOw8luc/rFanXML/+xLBX76ULe4XbdrLnnjwFaSbxjYIxyAMdmfem3EGrpogny2Ylx
         eryeZNYhls4yjXdA+m9HPmtNvzFA0ghHjhMEDWTR52o+9wVchW31doEtChXt6egnOPI6
         TTIHB64CJmgCc0lROqi0WHhc0me1ZfwaMpkw1fhYMXxT6X1usFwWqRdAuv6k4moLZwuz
         JEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j6zqP4MLPtYMqVTQigbCve/GmakRYD7os8ayHkbdFP4=;
        b=OCc+hc6aRCda3ptcK4EH+hwCRYmVn07hD0/eyyW1TLtBrC8uBo+dFqkZuoLglSLS1b
         HLk3JgGLzH5tBZT41O8wj69452p8OkFlz95dMQ0FkJUq6uOfXpZBv7iNRES3M/z8NK6w
         CjykHFSS3f813sMOG5/o8yEiX0bFtC7HUVZ07HpZ1PjOae4aydAWRZ6bX2qmWbdDVjqI
         kNGDa3A++xA2gSvxt+smITcorI4w7JlAlK9p0zPc4pO+Eh5E68lze1m9xlaAksDjFy6n
         t46nRBpjCaiNkyoMe6FE0oqpw9fpCkRLyWzdux5EYOAwEg+lOqTdvZe3ShvnHL8G8rJN
         HinQ==
X-Gm-Message-State: APjAAAXE5/MHAEHz6werkjSXijJE0mxjuWjTSyMNMIpn/4YSpeY0ofOX
        w+iU89sSa016NPFT1P+KwEoC8G6x
X-Google-Smtp-Source: APXvYqzJqbz+M0fQgSHS6w8AhyaDKdWuH/+7EIlrzuXa4awA0LNX6e87R5T/hqqVW9pXwL8M7TE29A==
X-Received: by 2002:adf:f786:: with SMTP id q6mr7404992wrp.125.1553287491255;
        Fri, 22 Mar 2019 13:44:51 -0700 (PDT)
Received: from localhost.localdomain ([188.24.4.251])
        by smtp.gmail.com with ESMTPSA id a9sm10436565wmb.30.2019.03.22.13.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 13:44:50 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/5] iio: imu: adis: generalize burst mode support
Date:   Fri, 22 Mar 2019 22:44:39 +0200
Message-Id: <20190322204442.4035-2-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322204442.4035-1-ardeleanalex@gmail.com>
References: <20190322204442.4035-1-ardeleanalex@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

Some variants in the ADIS16400 family support burst mode. This mechanism is
implemented in the `adis16400_buffer.c` file.

Some variants in ADIS16480 are also adding burst mode, which is
functionally similar to ADIS16400, but with different parameters. To get
there, a `adis_burst` struct is added to parametrize certain bits of the
SPI communication to setup: the register that triggers burst-mode, and the
extra-data-length that needs be accounted for when building the bust-length
buffer.

The trigger handler cannot be made generic, since it's very specific to
each ADIS164XX family.

A future enhancement of this `adis_burst` mode will be the possibility to
enable/disable burst-mode. For the ADIS16400 family it's hard-coded to on
by default. But for ADIS16480 there will be a need to disable this.

When that will be implemented, both ADIS16400 & ADIS16480 will have the
burst-mode enable-able/disable-able.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16400_buffer.c |  7 +++----
 drivers/iio/imu/adis16400_core.c   |  8 ++++++++
 include/linux/iio/imu/adis.h       | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
index 268349eb51c7..199bd72348eb 100644
--- a/drivers/iio/imu/adis16400_buffer.c
+++ b/drivers/iio/imu/adis16400_buffer.c
@@ -22,7 +22,7 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 	unsigned int burst_length;
 	u8 *tx;
 
-	if (st->variant->flags & ADIS16400_NO_BURST)
+	if (!adis->burst || !adis->burst->en)
 		return adis_update_scan_mode(indio_dev, scan_mask);
 
 	kfree(adis->xfer);
@@ -30,8 +30,7 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 
 	/* All but the timestamp channel */
 	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
-	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
-		burst_length += sizeof(u16);
+	burst_length += adis->burst->extra_len;
 
 	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
 	if (!adis->xfer)
@@ -42,7 +41,7 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	tx = adis->buffer + burst_length;
-	tx[0] = ADIS_READ_REG(ADIS16400_GLOB_CMD);
+	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
 	tx[1] = 0;
 
 	adis->xfer[0].tx_buf = tx;
diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 34d52863377a..0d799e983d74 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -146,6 +146,11 @@ enum adis16400_chip_variant {
 	ADIS16448,
 };
 
+static struct adis_burst adis16400_burst = {
+	.en = true,
+	.reg_cmd = ADIS16400_GLOB_CMD,
+};
+
 static int adis16334_get_freq(struct adis16400_state *st)
 {
 	int ret;
@@ -973,6 +978,9 @@ static int adis16400_probe(struct spi_device *spi)
 	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
 		adis16400_setup_chan_mask(st);
 		indio_dev->available_scan_masks = st->avail_scan_mask;
+		st->adis.burst = &adis16400_burst;
+		if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
+			st->adis.burst->extra_len = sizeof(u16);
 	}
 
 	ret = adis_init(&st->adis, indio_dev, spi, &adis16400_data);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index cb6c3ed13459..26141ee87cfb 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -21,6 +21,7 @@
 #define ADIS_REG_PAGE_ID 0x00
 
 struct adis;
+struct adis_burst;
 
 /**
  * struct adis_data - ADIS chip variant specific data
@@ -59,6 +60,7 @@ struct adis {
 	struct iio_trigger	*trig;
 
 	const struct adis_data	*data;
+	struct adis_burst	*burst;
 
 	struct mutex		txrx_lock;
 	struct spi_message	msg;
@@ -234,6 +236,18 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 
 #ifdef CONFIG_IIO_ADIS_LIB_BUFFER
 
+/**
+ * struct adis_burst - ADIS data for burst transfers
+ * @en			burst mode enabled
+ * @reg_cmd		register command that triggers burst
+ * @extra_len		extra length to account in the SPI RX buffer
+ */
+struct adis_burst {
+	bool		en;
+	unsigned int	reg_cmd;
+	unsigned int	extra_len;
+};
+
 int adis_setup_buffer_and_trigger(struct adis *adis,
 	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *));
 void adis_cleanup_buffer_and_trigger(struct adis *adis,
-- 
2.17.1

