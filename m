Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11EA37FF6F
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766051; cv=none; b=SfWL/t9PHRRhWjSaYyMnNpNUN35eZJyfno3yI3xG+LDHjfPkNKtVse/8hZsjYqb2PELwWGN/ihVWHhjmND8kJ71BiOu8zFf9pBTyCLCfXv5kH5HweSYFzxOQTjXQ1B2jctQsWoYvrw4dolpE+BTp6dOrassZePLkWIOjzxvWAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766051; c=relaxed/simple;
	bh=1OS0HFA0GejceI55WUfmF/6NLWbOAkpgk+FWmV5IwuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5Y6G3fOd1fRrFPqA4hh17NBJ06UrKKPj4koQal8TbxFMSvZpsJOVXwCD92vP+DUEUQEqzE9n5zDW0HdviKNZmlA+8V3oHkJ6Ea0OuHtKBb5/jcoKVNzvIm5aLWbx7njP/AnGtJTySeTNAZWx/lMVWWPcrZ5SmOZgRIRrkXGnGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7mhAOpN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7mhAOpN"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9358dd7f79so713770166b.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776766048; x=1777370848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQcpHLVocRLxc4AzukGKVoJP7nG3R7E+uIBXjYLun7I=;
        b=s7mhAOpNvI/BzisOpmfrxpVE9ZYUc7rtTa6bBXGgdVWBzBK2evu43/Dj1MVCyCSm0E
         YvBbOVE3MiLCjk5GS5KDLx8GIvTcOvGePrzx9MeMP9ZWF2gxPZl+vJnsGlIK+yh7jjnT
         DTAP8Lqmrc94uuq5vbhpOr+rTg0DhUuVhqz1+jerrpSovtawLavbksQMPrvZLHXGSv3k
         JZwjudytI9X4x1hRhXNycEO7HdvB38l/MWv4sJoCPQywcX6fVV22OjaLjtdCh53OchAE
         a/5TTAFxEFBSU4Aat1CK1Y3swZKn4E3Ei/vbwfJNr42GwNNsEOVxj56JaA9RPDUD0gV9
         YNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776766048; x=1777370848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kQcpHLVocRLxc4AzukGKVoJP7nG3R7E+uIBXjYLun7I=;
        b=Pmc3DvXt6cxo/d57oB+G/P04rFt3vJw4uJgwXeePzF/B5VuXjmfpw3XnlFbbjJjGgn
         u5b/7KnAN+ZykuSlfMqBXdfjfyKVbpRZBpv+tMqBglUTG8W9GDUKy13T+pUqPwIgQqRN
         +se1qjfy89BSEYA6exu9V5GRctgn6bFy30FbkfwyQw/uoAax4526saQbovN6XAnshiIL
         K14CwWaL+O8HI/ZBQiXolRoU25tOw2lCcuPyQX+2OcNKGTI719Ii8jfZ3GnIk0vAKRub
         Zx3BvUHGMhclXt8CYdDQ+AHP5blMH1piHgg0jp4X14DooWULtN6SPh1v0EBC+1OrCBFz
         d4pA==
X-Forwarded-Encrypted: i=1; AFNElJ8m4uRRsNLhqMz+AtTnRPlFTSk1uwxeiifr/3ZMW6d4JdQYylB2SCNkQa0/GOpODZEhG+yYzWeIJ9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87Kqd4xYzhPmtBSCBEWpd4hG4mPPvGQmPz5Ms5c+dttBMapxA
	g6WdpkUKnfUSRykk/1reJJZ5wtlue8R01Jw6Raw01l8vKVsxczhbKb7pfCbUWrrKGe8jbw==
X-Gm-Gg: AeBDieupUSUriMuHK1kVgE9N0JA3m5nlBcWLK31Ffubgv5SCPME7MZIcpN5lUL//YV/
	7yk9muwlmSPiK+pV/IwBQzSCejZigJao2yzIBET7cubJg4awR/wcyzQP5ln6wWXSsL+/XRC4eS+
	NWncgtUxiIXCRlXrmCpmZeM/obz5yPo5joB9YveuNHuXSkTt86pTSfkIPCH/6nmElVTxD32LG4J
	dlMzV4URBHFXQXqHqzImNHB/vv+ZHXiwNHFwItWo8VKZp5+gtualB0gIUVQOZKiUA/N4E/UvFKu
	Z9wXq85Kpsp0fQKvwjEE62giERI0tCv3V8yTa/GsWsJS9vlk0+HG1kJH8OxBwLlf2QgNzaFDKyO
	+m6PrQGIbcIuSLJLmpWpEuqt/Aca7V7aYRxQd/vub1grf8PjtpWUcmayk86Si27IDRyfHEScXnR
	W6GD9NvUWohNiZ/RDjVZFp8hzHBnQxlers6Nrl/KMDd969ohCK5yLlUKIu+KC5rO38HRQe0YoQm
	cnwleX2sKdsm8u8fDEH7hKXHS9EPI1DK0rf+44wgbrUlEM3YgZOiQtKMGU8zglqbmVgm33RlATy
	77NPNXZaKdVh+Jb7ACeArVY0hf4DDD4in8QMzxFXT6XiDZVJnXquxj9hLF3417FeY6mEILtkMOX
	be29BeCqc+R49QVuEaPb3CrQPK8jgE9ig0S5Bu8dVvyKeyG7Di5iHLFKhaP+cb4Riup7GCOjJdy
	sqpT477gfE5zT0DDPOkw==
X-Received: by 2002:a17:907:3cd6:b0:ba5:2743:fd5e with SMTP id a640c23a62f3a-ba52743fdb9mr716464966b.27.1776766047771;
        Tue, 21 Apr 2026 03:07:27 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (238.77.147.34.bc.googleusercontent.com. [34.147.77.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4550468d6sm428078766b.52.2026.04.21.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:07:27 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 1/4] iio: magnetometer: ak8975: header cleanup
Date: Tue, 21 Apr 2026 10:07:19 +0000
Message-ID: <20260421100722.1296-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421100722.1296-1-joshua.crofts1@gmail.com>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up headers by removing proxy kernel.h header and adding new
headers to ensure atomicity (array_size.h, dev_printk.h, types.h,
asm/byteorder.h). Removed unused headers (slab.h, iio/sysfs.h,
iio/trigger.h) and added minmax.h, property.h, wait.h, irqreturn.h to
mitigate transient dependencies during compilation.

Audited using the include-what-you-use tool.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 44782c26698..a829bee4cf8 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -9,8 +9,6 @@
 
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/err.h>
@@ -20,11 +18,19 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/array_size.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/irqreturn.h>
+#include <linux/minmax.h>
+#include <linux/property.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-- 
2.47.3

