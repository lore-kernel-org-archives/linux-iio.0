Return-Path: <SRS0=ujoz=S3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750AC43218
	for <linux-iio@archiver.kernel.org>; Thu, 25 Apr 2019 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6185620717
	for <linux-iio@archiver.kernel.org>; Thu, 25 Apr 2019 16:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARt6SQw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDYQdu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:33:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40330 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfDYQdu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Apr 2019 12:33:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id s4so170262pfh.7
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2019 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4zMclgtwCzjTho3GRGznfH2YK3de8ITGWHmE65Ryao=;
        b=ARt6SQw8dlHobXASiYZezaNQMwlI6wZISFj1tejwz8HAg8qVJm3XS3c5RxdwARE46F
         nvY4Ts4Y6YG7fFeM2Tgn/Gxc2nYYhvvrJTt4SBfX4EXCtuDppBOqHbaecIKPpbY4rYWM
         cH5xD0FdHmevQhvdUK8mcAf5b0aZ2xTyBu09U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4zMclgtwCzjTho3GRGznfH2YK3de8ITGWHmE65Ryao=;
        b=mg+kih0Qiy8T7bGEuL8Ye7MWgCbt2WtiAundxNf3HJI/qoJNY8xfUxzDnGSbISRZYW
         mOsoC+o3vmNe9q7zx8I4nm/jEo92o2JPKeg0htRWbLQFtM+AZ8dNfzNZw3eXtakNGop7
         +O5O/moGx9coeECrnDOa2LaB7BXQxeYUCjvTlUAE8GNO/mAe1zgh0eMCu9kDK8ijFB9g
         gZas8hE2b3fTyXKnY8rlc4EAxDL3T6f5D0UyCyJiPBmeg0AZrEEckQHE4r5eFj7v6mux
         A40SjTYw8FHuc7oONJcOuqY9MUZiNr26nfUaIFIh2pATvoqFHiIAswbw+UI6fmjusvww
         7Buw==
X-Gm-Message-State: APjAAAV8mmE3H68ol0unxsOt8hfg9ERsYe86+PfyE/nV+N+mNt9BgOVN
        j5U8NdIZk3PVMneblPF6aF+8LmZ9hSw=
X-Google-Smtp-Source: APXvYqzvCuB9lQaj9n9gNAEkq604mzn/LFuxl3SWW6srm2o6ImNxmi7bLU+Ti0zj9LbYsgHmp1adog==
X-Received: by 2002:a63:7141:: with SMTP id b1mr37976632pgn.331.1556210028568;
        Thu, 25 Apr 2019 09:33:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h187sm39338273pfc.52.2019.04.25.09.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:33:47 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 24/30] mfd: cros_ec: Update I2S API
Date:   Thu, 25 Apr 2019 09:33:34 -0700
Message-Id: <20190425163334.123710-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve I2S API.
Rename ec_response_codec_gain into ec_codec_i2s_gain,
update caller accordlingly.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- Change only cros_ec_codec.c as well, to fix compilation error and
  prevent bisection pain.

 include/linux/mfd/cros_ec_commands.h | 44 +++++++++++++---------------
 sound/soc/codecs/cros_ec_codec.c     |  8 ++---
 2 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 59ad6bae3f9b..c1fe64c0957b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4417,6 +4417,7 @@ enum mkbp_cec_event {
 /* Commands for I2S recording on audio codec. */
 
 #define EC_CMD_CODEC_I2S 0x00BC
+#define EC_WOV_I2S_SAMPLE_RATE 48000
 
 enum ec_codec_i2s_subcmd {
 	EC_CODEC_SET_SAMPLE_DEPTH = 0x0,
@@ -4426,6 +4427,7 @@ enum ec_codec_i2s_subcmd {
 	EC_CODEC_I2S_SET_CONFIG = 0x4,
 	EC_CODEC_I2S_SET_TDM_CONFIG = 0x5,
 	EC_CODEC_I2S_SET_BCLK = 0x6,
+	EC_CODEC_I2S_SUBCMD_COUNT = 0x7,
 };
 
 enum ec_sample_depth_value {
@@ -4442,6 +4444,21 @@ enum ec_i2s_config {
 	EC_DAI_FMT_PCM_TDM = 5,
 };
 
+/*
+ * For subcommand EC_CODEC_GET_GAIN.
+ */
+struct __ec_align1 ec_codec_i2s_gain {
+	uint8_t left;
+	uint8_t right;
+};
+
+struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
+	int16_t ch0_delay; /* 0 to 496 */
+	int16_t ch1_delay; /* -1 to 496 */
+	uint8_t adjacent_to_ch0;
+	uint8_t adjacent_to_ch1;
+};
+
 struct __ec_todo_packed ec_param_codec_i2s {
 	/* enum ec_codec_i2s_subcmd */
 	uint8_t cmd;
@@ -4456,10 +4473,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		 * EC_CODEC_SET_GAIN
 		 * Value should be 0~43 for both channels.
 		 */
-		struct __ec_align1 ec_param_codec_i2s_set_gain {
-			uint8_t left;
-			uint8_t right;
-		} gain;
+		struct ec_codec_i2s_gain gain;
 
 		/*
 		 * EC_CODEC_I2S_ENABLE
@@ -4468,7 +4482,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		uint8_t i2s_enable;
 
 		/*
-		 * EC_CODEC_I2S_SET_COFNIG
+		 * EC_CODEC_I2S_SET_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
 		uint8_t i2s_config;
@@ -4477,18 +4491,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		 * EC_CODEC_I2S_SET_TDM_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
-		struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
-			/*
-			 * 0 to 496
-			 */
-			int16_t ch0_delay;
-			/*
-			 * -1 to 496
-			 */
-			int16_t ch1_delay;
-			uint8_t adjacent_to_ch0;
-			uint8_t adjacent_to_ch1;
-		} tdm_param;
+		struct ec_param_codec_i2s_tdm tdm_param;
 
 		/*
 		 * EC_CODEC_I2S_SET_BCLK
@@ -4497,13 +4500,6 @@ struct __ec_todo_packed ec_param_codec_i2s {
 	};
 };
 
-/*
- * For subcommand EC_CODEC_GET_GAIN.
- */
-struct ec_response_codec_gain {
-	uint8_t left;
-	uint8_t right;
-} __ec_align1;
 
 /*****************************************************************************/
 /* System commands */
diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 99a3af8a15ff..87830ed5ebf4 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -38,21 +38,21 @@ static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv, 0, 100, 0);
 
 static int ec_command_get_gain(struct snd_soc_component *component,
 			       struct ec_param_codec_i2s *param,
-			       struct ec_response_codec_gain *resp)
+			       struct ec_codec_i2s_gain *resp)
 {
 	struct cros_ec_codec_data *codec_data =
 		snd_soc_component_get_drvdata(component);
 	struct cros_ec_device *ec_device = codec_data->ec_device;
 	u8 buffer[sizeof(struct cros_ec_command) +
 		  max(sizeof(struct ec_param_codec_i2s),
-		      sizeof(struct ec_response_codec_gain))];
+		      sizeof(struct ec_codec_i2s_gain))];
 	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
 	int ret;
 
 	msg->version = 0;
 	msg->command = EC_CMD_CODEC_I2S;
 	msg->outsize = sizeof(struct ec_param_codec_i2s);
-	msg->insize = sizeof(struct ec_response_codec_gain);
+	msg->insize = sizeof(struct ec_codec_i2s_gain);
 
 	memcpy(msg->data, param, msg->outsize);
 
@@ -226,7 +226,7 @@ static int get_ec_mic_gain(struct snd_soc_component *component,
 			   u8 *left, u8 *right)
 {
 	struct ec_param_codec_i2s param;
-	struct ec_response_codec_gain resp;
+	struct ec_codec_i2s_gain resp;
 	int ret;
 
 	param.cmd = EC_CODEC_GET_GAIN;
-- 
2.20.1

