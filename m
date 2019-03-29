Return-Path: <SRS0=Xjfk=SA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4B4C43381
	for <linux-iio@archiver.kernel.org>; Fri, 29 Mar 2019 17:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8E7218A5
	for <linux-iio@archiver.kernel.org>; Fri, 29 Mar 2019 17:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlaSJVxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfC2R4h (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:56:37 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53848 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfC2R4h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2019 13:56:37 -0400
Received: by mail-it1-f195.google.com with SMTP id y204so5119423itf.3
        for <linux-iio@vger.kernel.org>; Fri, 29 Mar 2019 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=hiyQuwUD3yRLrDio99tAhNu72pVPx86tKhApN6B8sTg=;
        b=WlaSJVxUpa0BQjVnFJ6LfmZWUM/5Vm3tgolQN/vfGNArL8SwKziNz4/9AkeO2+Avzl
         oeN1mYKdlgjoiZ2SMcYOgY62qRoeKhFknZ5dl3BFels3LMTgIbO3bo/UuREFNSOHc9xw
         S9YiQiI2tSHzGDu4f7S2HISqRK+F/lI5suCac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=hiyQuwUD3yRLrDio99tAhNu72pVPx86tKhApN6B8sTg=;
        b=JU+AWyqHdEgt6/Bhr7CuJfYeK+EaShukEvqRDh4Lnn/+lKLdYOTCEm5kP6h1Vh6nHo
         5StrQXdd4kDE4037/Uk90e8ecUlxhcyC8PdepssTbDC2fEVISGHjy037spFQAekyyIOk
         iA1VPCDgSrxrdsQlOnggqbo5uFL4yPaU+b9RHv1c3D1tBI1E4BGtFf/75tHqn6Wji2aM
         DbFGs5s1ESnh1+hPc3UX+Wru4h4aHZxpGijBHMxMbRqmueuOnJifHCXW4QahYLxykrLV
         wIPOBd8CyRYnDNP0cayfHyszzuW1n2kJbtZzPyOrni7RFEhijDwambEkCFBLxh2uImSF
         1e2g==
X-Gm-Message-State: APjAAAUdo3ecCS3OiBbLnPqUNB7P6NYtrOR3AKGNw/b1kBQxoXyM9jDN
        miAAMmPg+uejOFs26A4/m6hmJR+K8wo53KyN44Panw==
X-Google-Smtp-Source: APXvYqxcMRXXqnRPjQMbNiefde9dVRODOXTS9BI4YsPTWMt0t1hK1x5Dcs8BUJO0heGJeGa0X2IfPGLnnFxWdzlQ6oc=
X-Received: by 2002:a02:c643:: with SMTP id k3mr26561499jan.19.1553882196407;
 Fri, 29 Mar 2019 10:56:36 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Mar 2019 10:56:36 -0700
From:   Gwendal Grignou <gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
References: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
MIME-Version: 1.0
Date:   Fri, 29 Mar 2019 10:56:36 -0700
Message-ID: <CAPUE2usk3unTTp+3mpL7TgZ02u9fJtB5gLTLBMfMwHErwyeOsw@mail.gmail.com>
Subject: [PATCH 1/3] ASoC: cros_ec_codec: Rename ec_response_codec_gain into ec_codec_i2s_gain
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In preparation to update cros_ec_commands.h to match ChromeOS EC code
base, rename data structure that will be merged together.

TEST=compile.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 2 +-
 sound/soc/codecs/cros_ec_codec.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h
b/include/linux/mfd/cros_ec_commands.h
index fc91082d4c35..c9b58b1133e9 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2879,7 +2879,7 @@ struct ec_param_codec_i2s {
 /*
  * For subcommand EC_CODEC_GET_GAIN.
  */
-struct ec_response_codec_gain {
+struct ec_codec_i2s_gain {
 	uint8_t left;
 	uint8_t right;
 } __packed;
diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 99a3af8a15ff..87830ed5ebf4 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -38,21 +38,21 @@ static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv,
0, 100, 0);

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

@@ -226,7 +226,7 @@ static int get_ec_mic_gain(struct
snd_soc_component *component,
 			   u8 *left, u8 *right)
 {
 	struct ec_param_codec_i2s param;
-	struct ec_response_codec_gain resp;
+	struct ec_codec_i2s_gain resp;
 	int ret;

 	param.cmd = EC_CODEC_GET_GAIN;
-- 
2.21.0.392.gf8f6787159e-goog
