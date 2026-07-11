Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B72D94BA
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783737822; cv=pass; b=QT9U0NOgZDCzQuj2bPzHuARBytYX/H43Chry/FYEZvW/yM24gKExud6ravT/Jzyg4MxKvyv/rf5cA9LTmT9cW6K3+myRONwfJ5Jpou/S/OegubLanxyaWsgCSwrXKsg9CO+d1g0LoWqWXqwBtiCOkxoM1lo1RovUWOlEhaI8FgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783737822; c=relaxed/simple;
	bh=cm0y3nfEv5KYZMQ9lE3vuSEaIaX/bYl6zqZ1nzt+X/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OezsMIzwufoYIiDE9fLQ5RaaWlwsQeolxZ+hMJT0rw1Mj1vUcE4VrGM4aeV6Ko82AGKQGKJSNmoTnberzyKR+hW8CUPM8CWJkid/cLo5GxrKnL8aVzysMcHLTv5nwtE4ZULB2SoA3KGHyvWrrwKgYn+7iWOCwjd5U5LTiDSHxto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4uL/GEA; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4uL/GEA"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-738bd0b7960so1160827137.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 19:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783737818; cv=none;
        d=google.com; s=arc-20260327;
        b=Fob4Bm+c1H6FLcPkIhY/3iWaKxqx+NTLZ9Fv1phHMv29WKLXswesV0J0aroj8eqXuF
         FmjPcctHzYprMf4Aa02c9ArRbQh6PlQnYnkRuHFa+x8EufHmk/h3kN2JF+llPxby+fpd
         V7oNnXBLc3UfLLczXXYJuy4NcYCUdXwQIcpW9i+2tYTQ3VP4lteutH6qWeieQlXkSp2R
         1myI6rgWLhMaAz4o3gmIQakos6FBGi+fFRgcivaFV0uVulBth1jaQ0t+Fb9lxuD+wLhn
         UKlnHouK2aP7aaBwL778BmrNgHG9AIj+SpgaBgxglvLKQJ+qvhSHKmAVrksm2d97H7gd
         V3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WZiBVoIHxmqoz1H+3Q12ZE9AXVZ5TYhLyqj1A3OwnYM=;
        fh=wLrnDnAxJ6WXwS7tuoDnUPGzK0qdoSEK2v772FlW6+w=;
        b=GgC2VAuqKwI7/ckMjWXiD/ZdTtd20yjpOO7X6LIn03zSycc8MK81yGG2qDJYaFPMDm
         0epfhKPYoriu68YjOjN+PzhbfApzYvLKGjn63YvTRvSg0GPLFqTQwMicUpBVRQMRjsz2
         9KbNVqpGqWUBvLf0GpUjxekK0M2o83dkccrwrvIOu+/4ry7uYuxJWptSoH5XomMCcyFJ
         FJjkR9OVlk14xJhg+022/i1hz4xuF2PErg4g5nxNgCHtx4zhmj1pUNX8frsIe1w/kSlU
         K2ZhagXlAnAlPrQ/VUCc9h3gGqQOIPbCGQ9p2cTfL4Nb4yQ1utrpemuE1yaAGTTSuhEj
         m2dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783737818; x=1784342618; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WZiBVoIHxmqoz1H+3Q12ZE9AXVZ5TYhLyqj1A3OwnYM=;
        b=p4uL/GEAJis80JMop3JN7/BtxocA27vCqhFhxXkAUoWPyZD45boNZlVLOo3mHEFCZG
         3Q7rVUvy6s9mc3Xkib9/x9AgAQlOGgfug0NSLdo2duD+/902pVbSjlh/oq6wPCp5IAcH
         ffzrSM8LI9PP3cRo4z4cq9uK1M0UyNmvDQ8YnvqJoIzo3+bXS4JRapP4OlcAuI98VOVs
         UW7DlQxJxCKuhBj5482riobsRkXsVs23/iDgfIWir9FH3L+pPFi5pX6PLcgXVzaAJcNx
         1gA9cwXtsw7To9Q6WvBOfl1nioNg7tghR7eH2GtI2GWzdZ7ap9oV8Lwim91Z2ynSzM3B
         SEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783737818; x=1784342618;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WZiBVoIHxmqoz1H+3Q12ZE9AXVZ5TYhLyqj1A3OwnYM=;
        b=P3jiHw5j6tCG/Q0UBRJFzSSzvEALvS0Tmlq3kRdTXPZQ5l+cDVxOuTIKV/efKG/S3a
         kj9s8AoY2kL1DVYTku7hmDGpvBCR+uUW39VSGaIesAvrdvE1UFBAo6iT+seJoUevnc2d
         nvHQW94kvxK+wUwhEyxVLpS5aW5qC1qcZgvTjQoi2rFqZXG/lCtlV2FzOezjjwDkguKD
         KTTUDm5StW6WozgUUn4+DufBCae2026JNYEwSiNl9vrYnpjX4r20eQUTvGmBQzZO+mdP
         5HZe2cTDd0jL1tFjH7su8Yetn9wIwBYVZXV7YfzM/pO+ZKXRv1FTEunk3DE+BM5g2GnW
         IDGg==
X-Forwarded-Encrypted: i=1; AHgh+RrnY8+Qs5+YkfIA1C8Lbca4epywQqetkFUWkq5GT1zOzBI6r4+fsvF3mJ0iTlokgs+R+EvWTT8vshg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpf1xvwlj4Jh4+2XkRWUVCBGoy6BnhrvNBj8fL8GtFd/OeWfe
	imC1Uc1lyDY3eQnAEMVcA8g7vmdJcA+m57f+/lagYc1es5c8WmxaUgeMr4+5EkAk9jsbZkBssjd
	mzl36QbEpM0zj5PfgEC23nE7+vmsfPb8=
X-Gm-Gg: AfdE7clN3G9R4/0DdTX3OaTUab2Ik9qWyANfMTKzoJYtxzjjzcR+rKJ0kQBblEhAMRY
	pE0Cg1xq+gkeSJE+rvTL5EgqqUpDHbSHS3QbMKQlexFnligSTizMY9wuq+vXdinuR840cvHa2F6
	qcH+Z7Oj9XISjaCjN0iYqFiq32btD+h7RMhDZ/AhKgIaC+72NJISsMTWsUIeDLvCLu7hFigAp2Q
	2uzU/RvwVDWyoVjUy8DALfC6/msIZyIntMQV6MwMQtOkmGqSohf1g2N56/NaKRE/BmK68N/vD7d
	cOM8RQEcLCsIOKrSG9S4GFg1b3nmcA34FlvLYGxGiiTM6nUc2yZEFjDKgCkpkrT3cM1SeehK5cl
	SwvTZl4oNfdXy
X-Received: by 2002:a67:f7d1:0:b0:744:d1a6:b11d with SMTP id
 ada2fe7eead31-74533b84339mr908051137.3.1783737818123; Fri, 10 Jul 2026
 19:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Sat, 11 Jul 2026 08:28:27 +0545
X-Gm-Features: AUfX_mxDeHe86_YdwArqEXxpUTiTOxiWdaz-UlADypKSrt-vRHpBc2kW_hLs9sY
Message-ID: <CAMyXUJkncpA3Q-BStPsbXfViNbxzJ6ZrQCt0RoGxtVXV-R_DOg@mail.gmail.com>
Subject: [PATCH v2] iio: proximity: hx9023s: validate firmware size
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
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
v2:
- Explain the U16_MAX limit in a code comment.
- Keep the existing kzalloc() expression unchanged.

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
