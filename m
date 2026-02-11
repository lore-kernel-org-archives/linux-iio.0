Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87193349B12
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840433; cv=none; b=CY7GACCcnbQHREm0Mi9ddnoLzqfeiCxm2AluquNWnE/D1E93fqfPjP4HO2eMlyC1M+fCHfwiec7i78K8J65mTdYwCyDLMYVWP3pPu2ze7jXJtl1yPTF6wjsangdML61e5bnyzu9ZuqSBLP6qVkf36r9z7dz69TtDAJTZRiBKsuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840433; c=relaxed/simple;
	bh=m0Cf8Rk7n7F9fguJZFZ6hxaAupWprBDgc6kM7bQibIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpEcMYeTvKRPXXJWScRBi/sUNlexWfzD7hWwIUfj1Ei22FIOdktcKMtMdEhU1JHmChER2dvPAiNrG9Bv+2h55GaqEKB7trm6q1y79eUmI4sb3RXxsYx99ZwENifNfZusCrAt+y8NDcTgkJsMJZevI0oDMjcPPLoEvRFaqMwmOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOlIzv9w; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOlIzv9w"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79088484065so24352267b3.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 12:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770840431; x=1771445231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jQM1mRtKYYKchUiL9MXlFhID/L6f3Klb5mRjr3nQkI=;
        b=dOlIzv9wyA0SGl8vk1mfpZOsMoec9m3mBkBzxtuvLSXlRLS2528hNggcZRglHXOq3L
         isN1MJIO9SRzk/qkSPX4Sp0D70IuW78b2OuvZsG5quirJbGUZV571inEZaXkZ+YOOQmA
         F6x4PoU2NCt9ETGdfHjqQX9uFjzrUY3SnjWG+sMvne58fP1/TUcEXR4Gmq9yAx3+RBx1
         RR10E5Nj+FiZhhOkJR29A0orlKj4PReJzR+nCGeKM9vckU5brdXR2qNpgYAsEqYAUsg7
         Cos37VtHo8zhe5Y5AsDTEKQYZa8HM/NoHUoqg25TGfcxENu/NlnEe/BgBR0RsP0eJkF6
         bhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770840431; x=1771445231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jQM1mRtKYYKchUiL9MXlFhID/L6f3Klb5mRjr3nQkI=;
        b=qhf0rwgPMnNXcolqIGNRE+MH155vCYkLTaH7n3GvV9ldEKey/YICOY4mmjlJHEnbHc
         ZsOojs2CYTqKiMJRPFsh0Lvw0927FwYoRdRHMilKFFzBErJxfHW0O6yFkcbK/nFwv8qC
         7odV2NqDl1HdNFZ1Fpt6QkYKiLFV3EBtMbwMuEsGe3g40LeP7NyHcMXQhpbFU30BuAvi
         2mrLSZA/hC8cQNtlDroset9oEZavHIIVJ8QVPaZlO6nSOfHnWJn92A3lUJy3JTxdFLaL
         11SKyzXml7tmBDgJ9LXObnJuZI7GHTAxTVOV4yqN7Kc/EEUOeghbca+CElkVgeoyH6fo
         vpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVATbwvoz/4bOhdejnxHG8hoTTDKbk7z1LZfyhNw76PJ4UkoP5qQ7dXpJGYSkjeb2uKmwSIZ2F5VgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1I5cdXU8m4qTduuAZpDbrdXKu2QXEXg0ssWoWvC13EoBfxqr
	AjkH7WzyM7uJwnVKJbMEiOTq9XF6uaN3kH8hpA/qQIag7zSeu5zsFMGp
X-Gm-Gg: AZuq6aJfIMErTRD5QQ+pCvDHYOw1R+/Qhl6bEOT4lahsLPW+EuqP1f2Oo2+I1E2Dhsu
	uG3SlVYxZM1/DCuqYhwZcP0wEShianCvsG9fct5y2IyTrcKT7NbrYWXPDyK6KAOihfLDTvfKKs5
	lI3wTNxLcUeGG8UIHdMy3re5BA0kSTE2CT4bA8Sz6CahUg60k+Becip38BqdaGcSF0LKHPh/4eO
	On279/416qg/BiicNWcG4VsMFG0LWBUKBhsaZG+NgX0ANI/PJ6tmcZ/qnSyP+iZBc+1HVVsDXk8
	ic5KT7eN1F4MaigYBBzNo5ticvHSULAl8EiKo/ykd6ivwuw+f17zaYNMdkQ3uuM43LNS9zO065Y
	rQb/OoExYdf1qWCBb/RBUdxd/ZHFmZOUdvB8KKWacMi4HeY+RdOq5dLpu5TTJuTwHZ7GHmA+ygu
	kvTw162LrHzmccijqR5ef7hFar/Jx/XFL5pVh1rJWQIjObB8z402npLR43IuBRuqE47FwxFxHrk
	daFVLoAiPRlp7rCcZYkZ3rQ
X-Received: by 2002:a05:690c:c227:b0:795:28b6:e3e3 with SMTP id 00721157ae682-7972f12410dmr12853067b3.22.1770840431219;
        Wed, 11 Feb 2026 12:07:11 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::9944])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254d5asm27663967b3.43.2026.02.11.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 12:07:11 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v2] iio: light: gp2ap020a00f: Correct return type to int
Date: Wed, 11 Feb 2026 14:06:54 -0600
Message-ID: <20260211200654.25648-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function gp2ap020a00f_get_thresh_reg() can return -EINVAL in
its error path. Yet, the function has return type of u8. Add error
checking for gp2ap020a00f_get_thresh_reg() return's value.

Fixes: 5d6a25bad035 ("iio:gp2ap020a00f: Switch to new event config interface")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v2: 
- Fixed gp2ap020a00f_get_thresh_reg() parameter alignment.
- Removed unneeded whitespace between assignment and check.
 drivers/iio/light/gp2ap020a00f.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..d122730176a6 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -992,8 +992,8 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
-					     enum iio_event_direction event_dir)
+static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
+				       enum iio_event_direction event_dir)
 {
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1023,12 +1023,17 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
 	u8 thresh_val_id;
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = 0;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+	if (thresh_reg_l < 0) {
+		err = thresh_reg_l;
+		goto error_unlock;
+	}
+
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 
 	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
@@ -1080,12 +1085,16 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = IIO_VAL_INT;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+	if (thresh_reg_l < 0) {
+		err = thresh_reg_l;
+		goto error_unlock;
+	}
 
 	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
 		err = -EINVAL;
-- 
2.53.0

