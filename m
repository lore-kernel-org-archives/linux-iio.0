Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49F731C567
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229707; cv=none; b=XB1kfh0Sn4zbbTgKXbv7KHsYa8TVk7+Zu7dQFfLPBxdiNZ3OTLY2aaY7dTnNbLG3rl5U0DkXL6q2WAsA9nA/h9cFzFtIJuAUdXreIBTMtHeH+xa4Hy591ivOrfRqPf0tEbnERQA49rh5HjQLg4u0wqb2IaF+FgB1+rwyJNHwqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229707; c=relaxed/simple;
	bh=xo1DgEm+v+4CitQlUArtOELjVVPqS7ieeA8SZvBdteo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTu2z0gmThJsREv/33BNoT1o+s6T6cPmqebOrSGgPnBoQLN4LwGwPM+Y5CHAUycaC7gsyMWKnErPBQlk4KzmvPPU6dhqxUbvWoLzE/FF5mMlZTx7y3b4X/KTyKycm3dGrDrP6j8LJLWwDQEVfNfe3szNY4868//UsdnIHZLkX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzamlGx1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzamlGx1"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so72423b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229705; x=1776834505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD/sVoyPZ+3rAECULNElpo4ngJXCE777D1kzkyumRTc=;
        b=VzamlGx1FHnm4FQpEmzOCgrqcyUpYR4vOiyetk0os8/u3SKsDCd6h5vtdwrWYmt0MQ
         njnhBMTz/9ATuxeMsdMEW2WWcfHKrqfQNowBmh1a/ShDqERhVhwhdFTSqITExitIky1s
         KUtX5Htj7kFEIDI1/Ldw0jpYEFALKOOcBL20M2TnE2Vp98C/a+/wA/wjObPZc4UHrSi1
         poROuwJOwnXSxm+TjwyVmuFmlblNPq4/F3W5hY2+6GDFyxokw9bR1v4EhIHP7hqr7QIE
         j+61sXxeygWXA9jjzujxn+yxBW13pb/NOKRAWL0M7jeZDqL8Fs19SuTo7++XrzVzRP5M
         WHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229705; x=1776834505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eD/sVoyPZ+3rAECULNElpo4ngJXCE777D1kzkyumRTc=;
        b=iewnCH/gduz60teLwfPG0RkwN8B8TGLDtcA531tPUfVzOC6mYt7X3CM6J4gUt48Ttq
         RMRtj26+OvSUazlPCZo+UGegFkwk8+NcWnLnAarPWrpZPQmktOMIIEeFHMRetbNlQ+FM
         Op3docakvVhYz0I+c89i/QeSRRxlePFp41soERuzOm6Sp5qxYGidFcA6kddjQgVR9FoD
         co1m+Ypb1r84MoFJDs18R1gJGp8FJO7eylUQuvzJTh7zRuh4Xa3BNOhyMu1nvytSkMI/
         beZi8UCz/lKpQMGk2bWmHFhqQp0GitwMhtqVCDgpPNjqABaRvxCVGNuEIb6aHP0JiPqV
         AMkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/b+tS6RqSdfG/IsKXpVThU5AkWSFlYyueMRMMqJLUrJufnf82y2M5XTLB3Q3+ly+kJD2PmbCtBLGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGw3WPWbM3H00jVvR4hnCE7KsSIe+DMYgtARLajvy+EFnK6oE
	JlnwaxHEMPB5HmZBYthDWYrwlXWFWuxAurNqbW5v2NLGmsWKrvwwroDn
X-Gm-Gg: AeBDieu+2w5vHLHoP8PTyHnXplMpvnTLZmYJWcWePTMX/66uTmZbx+nQttzypzE+5Zb
	VDgTSu/P8aGK+CGZucB72ruxPQSATtkgTRuWqHi3zLTfu51/hgjwhWh1F3f90fepUq7mXLb4kxm
	KiEtdkyx+K4rOOMSHaNVHQSys/tYkrq04/iMoSmZGZ4dnsiiRtIzpLC+LTY1QAQQmEvI100T6y6
	0dEpw5W9h6wsdI/f6z4h9nEGSod1kPdb/YPMtT5Znc/AUfalZwsRtxjJxSEsWb2eMy3zUU5Qrem
	63oewjeypnBYzekMBdPTnX81L2ZvAuauwy29a1RaQlw7OCCh5sFDExzF7xRQb2rlWgEpQtzmNKN
	7JGDM7r+OBEOjGcT5tn3b8cJRtb7uEDLc5pEvR6d76lCgDmqT/pHFwKmpPmHu+0+RGPnzR/5goE
	0uaMY7Qml2IdYO7kgKNJd4qClE0y0t9tkt3x8kDC+5yaj37iqvyXYMJQ0xC/c=
X-Received: by 2002:a05:6a00:1ca9:b0:82f:5a27:10c9 with SMTP id d2e1a72fcca58-82f5a271a59mr4065059b3a.51.1776229705114;
        Tue, 14 Apr 2026 22:08:25 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67469dc3sm763706b3a.58.2026.04.14.22.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:08:24 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/7] iio: ssp_sensors: reuse embedded RX buffer for SPI transfers
Date: Wed, 15 Apr 2026 10:37:49 +0530
Message-Id: <20260415050749.3858046-8-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415050749.3858046-1-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Avoid allocating a temporary DMA buffer in the interrupt context when
handling hub-to-AP and AP-to-hub SPI write messages.

Replace the dynamically allocated RX buffer with a fixed-size,
preallocated buffer embedded in the driver structure and reused for all
SPI receive operations. This removes memory allocation from the
IRQ path, simplifies lifetime management.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v6:
- Replace dynamically allocated RX buffer with embedded fixed-size buffer
- Fix struct layout to satisfy DMA alignment constraints comment from David
- Link to v5: https://lore.kernel.org/all/20260406080852.2727453-1-sanjayembedded@gmail.com/
Changes in v5:
- Rebase change on top of latest v5 patch series.
Changes in v4:
- Use preallocated buffer and stash a buffer that gets reused each time instead of a fresh allocation.
- Link to v3: https://lore.kernel.org/all/20260315125509.857195-3-sanjayembedded@gmail.com/
Changes in v3:
- prepare series to have all respective cleanup API support for the ssp_sensors following input from Andy Shevchenko
- Link to v2 https://lore.kernel.org/all/20260311174151.3441429-1-sanjayembedded@gmail.com/
Changes in v2:
- split series to individual patch
- address review comment from Andy Shevchenko
- Link to v1 https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp.h     |  3 +++
 drivers/iio/common/ssp_sensors/ssp_spi.c | 20 ++------------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index f649cdecc277..8295bb7062a3 100644
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -174,6 +174,7 @@ struct ssp_sensorhub_info {
  * @pending_list:	pending list for messages queued to be sent/read
  * @sensor_devs:	registered IIO devices table
  * @enable_refcount:	enable reference count for wdt (watchdog timer)
+ * @rx_buf:		buffer to receive SPI data
  * @header_buffer:	cache aligned buffer for packet header
  */
 struct ssp_data {
@@ -221,6 +222,8 @@ struct ssp_data {
 	struct iio_dev *sensor_devs[SSP_SENSOR_MAX];
 	atomic_t enable_refcount;
 
+	u8 rx_buf[SSP_DATA_PACKET_SIZE];
+
 	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 92418721ff82..bab84b25edff 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -336,7 +336,7 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 /* threaded irq */
 int ssp_irq_msg(struct ssp_data *data)
 {
-	char *buffer;
+	char *buffer = data->rx_buf;
 	u8 msg_type;
 	int ret;
 	u16 length, msg_options;
@@ -380,19 +380,12 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * but the slave should not send such ones - it is to
 			 * check but let's handle this
 			 */
-			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
-			if (!buffer) {
-				ret = -ENOMEM;
-				goto _unlock;
-			}
 
 			/* got dead packet so it is always an error */
 			ret = spi_read(data->spi, buffer, length);
 			if (ret >= 0)
 				ret = -EPROTO;
 
-			kfree(buffer);
-
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
@@ -425,22 +418,13 @@ int ssp_irq_msg(struct ssp_data *data)
 		mutex_unlock(&data->pending_lock);
 		break;
 	case SSP_HUB2AP_WRITE:
-		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
-		if (!buffer)
-			return -ENOMEM;
-
 		ret = spi_read(data->spi, buffer, length);
 		if (ret < 0) {
 			dev_err(SSP_DEV, "spi read fail\n");
-			kfree(buffer);
 			break;
 		}
 
-		ret = ssp_parse_dataframe(data, buffer, length);
-
-		kfree(buffer);
-		break;
-
+		return ssp_parse_dataframe(data, buffer, length);
 	default:
 		dev_err(SSP_DEV, "unknown msg type\n");
 		return -EPROTO;
-- 
2.34.1

