Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC72EB5A6
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754744; cv=none; b=C+sCF+boCdx1egfpKKpQGiLXCPmHadyeQqkCishHcYwUMkuzlUAo7NrTLfEkIVSvXHyFUVRGF7oeZXSWmV35YhN/nYG+eFIM55lPl0cmJyU2Kztgu0eke5z4tTTXSL6zSuaQwXHcymdGAlWWmdDP2Qot75Unaxzg4IeUWb4fs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754744; c=relaxed/simple;
	bh=i8TdYVTnlgUx8z+S0f17uyrfNqpqBeM0AvvLy2KDWXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGlDsR/JngaYuMGRtLwJzFAZr01YCuX7sc+RM8t/fQzNrlwOZzy2TezvkkFSaVN0K5qN16DHqsg89E5M7J1/jbn3N0gfYs1GGhl7hY+/Vg5qXktAweVRLVL/ahDpqxc+qZhpVZmm5dQW1OsypJcgkQj39Ov2ZFHOwuw/tLtISe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUCH4HP/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUCH4HP/"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ba92146cc86so142289866b.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776754741; x=1777359541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Edq2ptyCRSr5qgmGluyTV2ehlX9fHU1GZR+pVn7rhBE=;
        b=RUCH4HP/ykh3NGKzIm6LXQjRgpU28l0tWJpePijh3zcFKxJ27UCCeiZr+7JjkHPfho
         NoyeUQobP1wtbaPWXOxP38XRa31IVb9x96sB2akCOh8fHKQpq/EpTttpHZbFtyvqC1l7
         ocORswVl9T5Lj1rxWtdIQbJwqIwrYOo0i4wNGpipic5eN0BNLGnPFjLWOAAnOIHbz+5P
         GUItn4Z7uotGyLzrxMZBmD9VRTIuuVU7EpqXdbwBIbsjy9IISE+uhOMT53z/nR3HZjSf
         WAUpHTfEy4ufTIER4ljuZISTOhoIFtv0FIvnftbKhXDtkhorhQ5pumcv2z1zEIaPAvsg
         bACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754741; x=1777359541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edq2ptyCRSr5qgmGluyTV2ehlX9fHU1GZR+pVn7rhBE=;
        b=oQFl8IvIRcKc/N2oT/2bx0f4W8gufo2PJAnE2bg4T5iWeHmAe6FFkjLVMCI2QRR0pd
         a54vf8ezIU8+C4LwXSSD2oA/P5u+trgZyE0dwYdPwSaMWBQwvclV+G1X3RPOYjRvZBIP
         ywpeVfWzxuucMT4ZLt/qMRPY0UbmrxDDXk0ZRBqWuMP7Yk+lH015B6G0A3H/nWwVjmdT
         sGOaSNZRNi/SfT2DT+gWcI/if992dQaZK0GDlpOa7zF7aE2qrIb7A4mdShkTGmY55gN8
         L17mqgMtey4H94SdDzCMKFnoMaKgQF9589aTE8pDnzgLek25wUKRIPxGaGgBFk76+GU6
         8Ajg==
X-Forwarded-Encrypted: i=1; AFNElJ8DOXWErIyIR+fw945h+6q8rE6YqhQZg19hRdHOX919t7PuqM1/4fx64zqzoXmxtJwdqzm99uXZ/C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuh9woiLj/pTlNmdlsDw4PniYoiru9oXkZFJ5FlEtpkZaTqOpP
	Og0q3qpM2COjhiDKgyY+Z5OQSoCcf/3KhjTdVV3WtyMz/E3vhiNgUeog
X-Gm-Gg: AeBDiesobSMr0oLM2IFjJE4J+nfHuqYhWU5e6nlHMji++GBYL3u9MV6JA6XYS3wfCtI
	7TMVRi7KInrklUy5ZqaNcsOhbASCsf3ua+tGBs0dIPXW/wzLbIrNC45PTqKXxKEcneISzRC0dKf
	MlrsGYBJmHP7zlDzFaLo3BWNHMhA9B07g2cxHgfvc7OBoDUFK2fRrW69vx5dW3q276XFtb2kY+p
	D1mq390ZstUhi5D9T6C9YlwJw29um+b0AHL0eksr3A5SaZzqYIzKk5QPMIQV5ELk40VaacCnj30
	9ca1FrluoqYQW/qWFXojaoDqGFGrrr4RMJqBzt1b+g+SStBzf3TjWUd+LgKQqNV5pc+a7+Z4+/A
	aRCnU5z5BnT+RdmXir5gji2bzWoKNmMs+Ng39Avsc+qd8t+9E/BoAHEDSKzXKarF5yJV0yFGYIl
	rbuZxa7lPjm2G9Wyx13tGTnAyr52AWmVE1V1XMnyQ3vqXyB1PGBsiSC+yWITTqNgMjCfLxwB7M6
	q6ecgGiRSeVX87tKk7nphHeoFdRGUAbXm65NjLUGhjanY7Vmgzkf2N11hTxRlCtWxJP237sqQo3
	40vdzsInaQg0xwcklnUC5IqC97HDEa05PDgc9+tTzMEbOkhPS2SLKyvcTsOf01jPNihJlNWk5B6
	FGHm00QK9Iykq8Ubww1AwI12xfBrb4iz7bDsJsNFzGOICLgEgvL0I8LCLjRDZ2KCuvsIPHEb0BQ
	3gMt3Qe94=
X-Received: by 2002:a17:907:d508:b0:ba9:3e6d:f768 with SMTP id a640c23a62f3a-ba93e6df95emr158575066b.2.1776754740965;
        Mon, 20 Apr 2026 23:59:00 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (172.178.13.34.bc.googleusercontent.com. [34.13.178.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455533bdfsm409675366b.57.2026.04.20.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:59:00 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3] iio: magnetometer: hid-sensor-magn-3d: prefer 'u32' type
Date: Tue, 21 Apr 2026 06:58:37 +0000
Message-ID: <20260421065837.1290-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'u32' instead of bare 'unsigned' to resolve checkpatch.pl warnings
and correct type use as defined in the struct hid_sensor_hub_callbacks.

No functional change.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - changed 'unsigned int' to 'u32' per struct definition
v3:
 - commit message edits

 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e4..b01dd53eb10 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -280,7 +280,7 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -302,7 +302,7 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -350,7 +350,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec **channels,
 				int *chan_count,
-				unsigned usage_id,
+				u32 usage_id,
 				struct magn_3d_state *st)
 {
 	int i;
-- 
2.47.3

