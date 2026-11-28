Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866732;
	b=ZPMmSN5fBVHL0xEMwGR4XBw0MAm7wiT7Am1cEMMVSLpycW2AMJK9HrWYu+z+y5Xuk1eS
	 RfN2EmwI7gadiIKAEovoG4aReVBJpCmwkuEenw61bva5pt92xfPGWtdRi39feCtIp2Iz3
	 jYFZWRFIJhlARoHpTUIgbbtYXXbd8AKffod/Rcrc5LvyXa47C356fiu8VdLvQFfYDmWac
	 5uuByfoCfyUvvJxNqOWV2ri6ZRUq+hammbMdeAWWjPlZWoejo47a1dD8HhXJMT05p8ZnD
	 dJYeJN/iylzfywNaPq4RQf4qG/rusnHipMl0JQE2C/Or3U8Jw7aBAsH+7+qoxxbBqGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QoQfhlenszhER9LDDzRyM/3rOAB9Dp610fJaAHzSuAM=;
	b=ursqKprrDgWgs6u6CPiBix0h7mZ8LiOigmnCLpdBhaUNsNkAyco2QRFpJ7qEHwQLWiPK
	 jXbckhmOMIVfnjhM+V65Nznn6pexbMtdSkqOyXhOX/aQQwFHOFB7qMH/dAYF/F6WxXCXS
	 qrSoP100dLYrfF4y9vFEm4rU6/Ju9O88jI/ck9M6GZXP//cfaSoiM6hG9E6CT/aeSXcam
	 R9DkWFgLO2nE3bi8wWvBvC2cJOhoXnA1krClKePVuyVIllZ8OEmvk24EhOWyKLbmWlx3B
	 sW8eRVsoS1EqZzsb2dGSp4aOWbtEQ8YwmMQpIyqo9/E/w/lCIgBpuDYlw29B4iWfShw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zt4b0swC;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2D606A31F
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD2D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zt4b0swC
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38644aedba1so14201343eec.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866731; x=1796471531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QoQfhlenszhER9LDDzRyM/3rOAB9Dp610fJaAHzSuAM=;
        b=zt4b0swC+JcWV0y4SFRum5aUQuIa0Ih7W2GFl5oSMhs3ERDO7irwACqGOjfqu+uDmV
         mmvDAmaIH5bjFqJrjQL8S6pBN6C1tva5T2LIwxUTi40NZ3RWu+68MloQ4JyAN6RLsrmb
         /Za0pJyLnO4umsOKWnlRikEXtBXFrPx0idbAwC0dExhibS3lfDGXPRYNXsb6608zsLlG
         +5xI0SvQZZlnQ9gnGDfTaJeGFxJxb8Z4m8QxqgHTHrPuifn/VgVyOZaB6WJfRmfOaKMb
         eALebPATsO8StKMOrByIMXn4m99BNY782fZzjeWrhXrTRmvE/DnnutWVnuXzeamzfVpb
         XhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866731; x=1796471531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QoQfhlenszhER9LDDzRyM/3rOAB9Dp610fJaAHzSuAM=;
        b=zoOSh5nw4yk1bYK7Vrcr+PW9irnHGvrfGunnygemv5PLhfaMel9kx72OD9bTrVMSuI
         5AeC3wbcBjjwj73rNhV+mgpKzzXWyVj+FgVhHKH8iIrVJTcvmysqbJ9b2xQaw1Zzp8Ss
         bwFqQwnNP/o0a9SpUQSrelj+f/ZrKhy6sr6gZR5Jhl2W8kpL7YaJ1EvPd+LB/gj1qM9A
         DGBYkUDRGtor+P6hC5VJE/8YauBAaLaUxJd4LZnbF/0+Gl7x1SAAa95fvm88FuV2pSd/
         ugbsBealvOkKLCEWC0b/QB+hsSNv+p46mvVMINe8o0wvWL8z+/Q5urb+qIMlxUlqlGAo
         2P/A==
X-Forwarded-Encrypted: i=1; AL+hErH7ftTQJRCFJw00HnU/qhcZ/FWCGwdW9iUzlRGBmYAFG29XkL8ufsOslrUTxOLH6jQhbGWTkMz/XZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9at9rKbQv/A63MvYyAZDGaUD6yOC2CA3KN+/n32eVRF3NtJvGd
	gCxtb1AKS3cGXOZE7dj1PUE/ROBBMnSUzIUW3/60eV4zbLFz6GPjQQC2
X-Gm-Gg: AZFdTZcFgl87a6HkchZM1zBbD0jWgpXqUCG8rXAYKMr0kviBKgd5UCJ4XrWuP2uIEIt
	J9TgVZW6RhN8Pjt0JBL1OaW0J4bi8ovKGalYKkhLlKRoS52MgUmFjB/33/aRWDRWw3SCb8rtaxz
	9E3Dpi/QnNSx5bm/jHDOWzOjlyHL/SWeAVHrA1K+O7brHpGGr0M/pEvlne3I+PpaBxPDMh4yo/D
	O6QtWFBig2w14kwWHJW0+X9qimmH0pLRZa7QLo71ukwWj6yILy5jXyi2TFo32BfwpOn0Nf6tH/O
	/kt5HeFjtXV1x/4I92Y5JkENXXh59AWJ01nNUYNcyAOCuoUnbmJwC1UHr1sY+EFDZDcxwFWMuQ3
	GpzyNXszgMycc9iWsto2aPOlQGdCd30BYNp4Y40RBLXG+F8v4lkMUNVN1fLDGDTtho49ao8eDd2
	LCa5IG9CHksL7z4LcGVGNkk6DfCJqW4GkHn8aFsX3xlb6POtqnEjtCi5V6xKT50ohHznDF/LYis
	Ev4lM52g49AHqEZfi1Fi8iMS1M5nyaBmXdLb3MytV218TXVfP/Zj/1uMUZ1lMOUS/gY4Ta7uRj6
	Brk8q4Alh+wtIwlR9RuSjPd4siL5CXGKVPDZ3vloZ+o19Y6Z84/4DF6R/fsw4bYv1QYyRza1yxb
	PKuXX7PnGGKFBBFxfhv1rwC8xl79D/OU14OY90gYFnrpdPEl1aEjOiZKFpcznsgx2PcyLwYwp/y
	H8fSqsbCRMxXOhLqcGJ/o6cNAEr41d5milxBCQoCIDwI6pleNy3Ia2H8CN2y1eeeU=
X-Received: by 2002:a05:7301:4704:b0:383:729:cabe with SMTP id 5a478bee46e88-3856f8519ecmr28650973eec.19.1795866731071;
        Sat, 28 Nov 2026 03:52:11 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm74256544eec.20.2026.11.28.03.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:52:10 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 3/4] iio: proximity: aw96103: wait for the configuration load before freeing
Date: Sat, 28 Nov 2026 17:21:40 +0530
Message-ID: <20261128115144.557411-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128115144.557411-1-kapoorarnav43@gmail.com>
References: <20261128115144.557411-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aw96103_i2c_probe() loads the register configuration with
request_firmware_nowait(), and aw96103_cfg_update() runs later and
writes to the driver data and the chip. Nothing waits for it: if probe
fails after the request (e.g. aw96103_interrupt_init() fails because the
device has no interrupt), or the driver is unbound before the callback
has run, the devm-allocated iio_dev that holds that data is freed first,
and the callback then uses freed memory. The regmap and the vcc supply
it uses are devm-managed as well.

Signal a completion at the end of aw96103_cfg_update() and wait for it
in a devm action added right after the request, so it runs before any
of those resources are released.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 4f205d6ea030..82353be284a7 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -8,6 +8,7 @@
  */
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
@@ -118,6 +119,8 @@ struct aw96103 {
 	struct aw_channels_info channels_arr[6];
 	unsigned int max_channels;
 	unsigned int chan_en;
+	/* Signalled when the asynchronous configuration load has finished */
+	struct completion cfg_done;
 };
 
 static const unsigned int aw96103_reg_default[] = {
@@ -605,7 +608,7 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
 		ret = aw96103_para_loaded(aw96103);
 		if (ret) {
 			dev_err(aw96103->dev, "load param error.\n");
-			return;
+			goto out;
 		}
 	}
 
@@ -615,6 +618,16 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
 		else
 			aw96103->channels_arr[i].used = false;
 	}
+
+out:
+	complete(&aw96103->cfg_done);
+}
+
+static void aw96103_wait_cfg_update(void *data)
+{
+	struct aw96103 *aw96103 = data;
+
+	wait_for_completion(&aw96103->cfg_done);
 }
 
 static int aw96103_sw_reset(struct aw96103 *aw96103)
@@ -811,12 +824,19 @@ static int aw96103_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	init_completion(&aw96103->cfg_done);
 	ret = request_firmware_nowait(THIS_MODULE, true, "aw96103_0.bin",
 				      aw96103->dev, GFP_KERNEL, aw96103,
 				      aw96103_cfg_update);
 	if (ret)
 		return ret;
 
+	/* The callback uses aw96103, so it must finish before that is freed */
+	ret = devm_add_action_or_reset(aw96103->dev, aw96103_wait_cfg_update,
+				       aw96103);
+	if (ret)
+		return ret;
+
 	ret = aw96103_interrupt_init(indio_dev, i2c);
 	if (ret)
 		return ret;
-- 
2.53.0

