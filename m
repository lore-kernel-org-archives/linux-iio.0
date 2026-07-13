Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B1340A6F
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918004; cv=pass; b=d65Fis3BolwOixUMgiCT/HUyGi5gqTTM5tidhbsefAYJoXSXv9HJAit1y0sn91/KnUGEeQI5Enuj1o2c9ihc4+ez5qU/jYPlcq0HVW4Vta1bad+DYUiITJE7J+G8rAdgNGZh6fXAMCFyJ02rnuXsy+oMW6/wHrmgRnul9B9GE3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918004; c=relaxed/simple;
	bh=fvnrMic/Wc1PqTxLDwgJWHRDgytppByxvectU/n/IUw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P0qsP32SVOmUWvN5Z3qnR4pR7qcEyhrKzqKryaN0PqoDV/fOFEPRffVlhYdM6AwAUCfbPiwpuXcLDMyncwJ65m22iCx+3XpsAQbu8C5MTYM0DiLgALYnoNnfWzjNJn8847ezO5Q7Kr+XepmgzHUbqm9hlJ5UDZmCUdlNZTxLk8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKWawFVM; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKWawFVM"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-745659c70ccso85155137.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 21:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783918002; cv=none;
        d=google.com; s=arc-20260327;
        b=Kft5TlpjaxUokOWtr0SIXyRK5Og4tJ5fdezVkARca6SXPaRY3L/YyTn3qvJz5NQSfI
         zfYpq9UTcDTTczT+h6I6rTgqLf78+hX++itcmHgKrHvWu90L8dBFYiXM2slRDzintJWl
         HwMBWShzsvYuYf9l2TM+Sgn8PD7fdlAzo7KlPHq2nWmCZmz+NmKuzFWHPTecaCN5s2VV
         6XqC5+/VNLwV45I7yyvefonqLPREvUMsS38s/s1AmuNX+MbBM8jWaSqP/kHofT+ARJXP
         RPTIQpNt01v1Ulqm9HGmh1dtmEtSi4iDUeCVZSx96C3rl5Q7TQsaxl7n4ntYY8L18wse
         raWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tIvuNpwtX62wjAACnY5xLsw8rSHDkSGnso4sTTSlICc=;
        fh=5reePXkwxjzwWOp/7Kai845vGTehBO4kXwBwwpEnhi4=;
        b=k5XTrHLg1iV+IyPhOIAC0WNL/Qm61j93m82a3GsVuSrDia+D9exlSbFYmKIJ0hd2sq
         mYbfq1LTbzeBTpJ03Z21O2ULATi/xG6TINoaEWQVnBWhtIytLm02jqXS8Af8hSqvsj7U
         y3ESw31zvpKre0VnkpHRNppRDVFIeBjuqQqcmCw7MFgXMkTVHBM37Pi2uu/8yhWkXAyt
         EczRl+4zzFolrsTPvqRS3Db1GW2uX13+SUdiI2CMDXnpnvxdlK573zbolsH22mHq8k6k
         4q/E7/yL9ppnfBUyFuwvcSEIvAq7nazk9R0QPQEyDome6mUD8FNy/HwEzuRfI60+UAHx
         rqSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783918002; x=1784522802; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tIvuNpwtX62wjAACnY5xLsw8rSHDkSGnso4sTTSlICc=;
        b=VKWawFVM5BIeOP3qLxypfVpetO2xJCBjiyZOScJ3m9zueCZYvL/HzWQC4khGdhLrS3
         yFgY33Jx57nSaWF+0HHM5Ek9iVXbw95lyKPPpqRWzG+uejQBC8oRuPdPXo1ydet+rTci
         JxicKhagF8E11EOFeT+7FB43gJy2YwiNpuu7kjpL21hBC4kU6PRixnwofRNqe08+4RfO
         m7t2VzK/Btn5bWDlKB7B5wlMx/gLPwKrS5LboH0zUCLvaJOS1ZU9IXH5cgAjllyue0nG
         jb8O1QkEiyTF4mmSpAHjzSMKwYyY6QlA8Oh2atcv9q/WUeOnKKcaFNgvwncFDanWw3eJ
         Wmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783918002; x=1784522802;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tIvuNpwtX62wjAACnY5xLsw8rSHDkSGnso4sTTSlICc=;
        b=k8s5LEEKzCEAsbjTxNjO3ex0/PbTLaF83Cjx1qBjmYTiGWRw1HuOzcxZZuzIP70tF4
         Ps7tonHEYfOVBw7q3sHA2Vbh666eIk+tSi1EGfO8yancQoFBG9YrihEHC3eqs551N80K
         XEJx0oMOIw+XCe8u18aZZWOjlMmfxbSOuwh25KO/jhfmFo9JZYW11k/iUhJbmVg5CD2j
         PMpPFd8CSS3nUJriUO7TJD9p3ScTfFmbzYRFE9M6N1k//W3nd10VOZfjwx+1jfT8habF
         ROGOWxY8snntctzg5+IV5t6i3mK/ESfig5xfEd/g5q4YaQWysWlpOFBB0C9+oA8y6Gik
         g1hA==
X-Forwarded-Encrypted: i=1; AHgh+RowxBEe/ji4WwsYF2W5stXxSL6gkWk6LAaJ10IkonDucEUjag3YJNtCGQNsMC74pO67q7IavH6eRtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJqQxzZe0lnKjHTHxokzGcRkuWOCCVhAe/VXHwbZKI3pH/LL50
	/SFF8Qz/223ZD6PxXIy98HRxAhEnERBNR1CLg7V1zeWUnFsBR2FDrfbkBzl0wS5WDCEYVcNGbDz
	MyJLNmoOM7SjSkK55yU9WSnBO/pvejbk=
X-Gm-Gg: AfdE7cnsj5+QotTD+xKLWlpqs2rcac7lkkXOU1t8ngiDiwSMF5orSgbQ+eMZikEybxl
	yL99KppzEV0vewAcWhTxyMDrfJSu4bQ0yqDzYbvKCJTu54+ORa9ylR2B/ce+6yYMMq0D4mTeV3m
	8EO1Y8lKW8b1Hfu+VA33tDnAMhmEarztPlPxoxVgmSxfiWic41Mp5I7+umTtHIqabOE3KIAeDpL
	9N1Oh9M9XnpmLavpNcmd3qBGTZaFf3USgXFmZIRtRNRmBgfg4mlslQohaoHuBJu3hMchgKH5e7G
	a1BgRvx3s8NJtxoILJp2UuVI3ffZOyo+AGgSCg/Dj+9L1twVx+/K22Y9R5lQmsYw/IL+heCkqlz
	S1DEx9NbJu/8=
X-Received: by 2002:a05:6102:3ca3:b0:737:80f0:7887 with SMTP id
 ada2fe7eead31-74533bbbd15mr4116564137.8.1783918001726; Sun, 12 Jul 2026
 21:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Mon, 13 Jul 2026 10:31:30 +0545
X-Gm-Features: AUfX_mwwEselmh9IRE3VEYEs8ZRe2pmlXbwSM1DlLxUaasQrg06o4Yn065i_PUU
Message-ID: <CAMyXUJnsV1GD0VmK_n25hqr_=A5Z=u_gCXV=oACgKuP3dSgwnQ@mail.gmail.com>
Subject: [PATCH v3] iio: proximity: hx9023s: validate firmware size
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hx9023s_send_cfg() copies the firmware into a counted flexible array and
then reads fixed offsets from the copied data before walking register/value
pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
make the driver read past the copied buffer during probe-time configuration
loading.

Reject firmware images that cannot contain the fixed header, reject images
too large for the u16 fw_size field, and validate that the advertised
register count fits in the remaining payload.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file
parsing functionality")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
v3:
- Resend once in plain-text format after the duplicate v2 messages.
- Keep each commit trailer on one complete line.
---
 drivers/iio/proximity/hx9023s.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index a6ff7cbe9e65..685053b84b34 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
+#include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1031,6 +1032,10 @@ static int hx9023s_bin_load(struct hx9023s_data
*data, struct hx9023s_bin *bin)

 static int hx9023s_send_cfg(const struct firmware *fw, struct
hx9023s_data *data)
 {
+ /* fw_size is u16 in struct hx9023s_bin, so reject truncation. */
+ if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)
+ return -EINVAL;
+
  struct hx9023s_bin *bin __free(kfree) =
   kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
  if (!bin)
@@ -1041,7 +1046,8 @@ static int hx9023s_send_cfg(const struct
firmware *fw, struct hx9023s_data *data
  bin->fw_ver = bin->data[FW_VER_OFFSET];
  bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);

- release_firmware(fw);
+ if (bin->reg_count > (bin->fw_size - FW_DATA_OFFSET) / 2)
+ return -EINVAL;

  return hx9023s_bin_load(data, bin);
 }
@@ -1058,6 +1064,7 @@ static void hx9023s_cfg_update(const struct
firmware *fw, void *context)
  }

  ret = hx9023s_send_cfg(fw, data);
+ release_firmware(fw);
  if (ret) {
   dev_warn(dev, "Firmware update failed: %d\n", ret);
   goto no_fw;
-- 
2.51.2
