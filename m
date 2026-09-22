Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B34053A3BA
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076079; cv=none; b=U7JXgMKE2OsiLVxdgeK/3RvatI29arUI0tcvCR/W3NgA8aRFPAlLPmTHyKRh/UNAqaoW/anpkAQ8iZrz1rri2PbDewQA3thEulAFOmb1vUCuaUROj4Ie/mE04GoOjrp3nVnC9dDPIdB+bYvB8eE2ILSxmrUzk4rDAY0L7iUuXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076079; c=relaxed/simple;
	bh=Y4uWeAcKFyzlZCN3UfcEiuV2kPZW7IEJOqZeE2Eaysk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PjymH4AhpUTj26Z8nFixSQbMgiIwWMeK6eRLPlDtyOAhOqf1RdpGBglPIgRTGih0MPlLoR2W2+YSCsRxlnAHW3W4JM7aInCjXoUm4LuV0vjU73kl9sKMkLwsvrHhHaM8i0FuHX+4G7nSLMFr/8Zhks39/4f8zLdmLJQj9Sr13U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7arvoHB; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7arvoHB"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dc92350888so72199285ad.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790076075; x=1790680875; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mD51G/+ZfcKpwbBS8tKfKNcklaH8fAziFoDk3Nxasls=;
        b=X7arvoHBj71673XX3FwLv9TDFtTMn15CfcZA9NfyRoE5RPLyZsEFXvCkfwBeMwtwnx
         5UwpqVsFbaKRSJBDGlgFyfQrSjj4Iz/GDhTDGlAgKYpN0Yo5vypYpPIGNhCrkDt2VnyL
         Aqvyq9t6ORT0jnLoIvAkF69IkmcM81TJ61eU3bTrs4/GosLzfY4uPSINeM1AHR/7XU0j
         ENd7ZX8HijBx/IYKa06it+6PkTaPVDvDaRSvkWWCWXCU9VHhwPUpPNMhbyFQlw9UaNeg
         87lZSwJIFt7fj2oEwzA+F+Pr80/B2BvUzfABi/m2HHd2+MuJ7qfJ3d5I4E5QTl2FUyZj
         ECQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790076075; x=1790680875;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mD51G/+ZfcKpwbBS8tKfKNcklaH8fAziFoDk3Nxasls=;
        b=U615XVl9eP0906bJxUowWMPIRkTdzdddopagFOQyeauwgajjOK9lLZCbEIu5QWPe5n
         MuO/J4w1HE8DkRfA8QPABgWgr40n07WaKwStEZD1ncNnZgLX/Nx/0Qo/NOMndOyYsoK4
         btllqAdId8zBslY9TRVtNY+FSG+88Mj2SuhzHfObEoKKH2ZRII3fq/VLn9GvvQlRlype
         +c9Biot4kquz/60vYZ99rr6bo4ApfV56XhdAqanK6cxL3S4VWpMIo3TejJkVWUW5kng8
         zfcbw0T6lne5vJsQmckxJ6b+OR85plpeVgZfDWCnk9G/OzBCoAs+m0hNS+LpfL3EOd3T
         e0xA==
X-Forwarded-Encrypted: i=1; AKwUvBxobudN/bvAWQzV7BCKDhgV0rd84pIizh2Fyaxsu9C/VLEEswW2FMzXmXQ1UgGU3e2zthqIyjpfmW8=@vger.kernel.org
X-Gm-Message-State: AFuF++ml9PsNp6lxg7SW5dbWIsOwdasU7qcIZgYZxdqf3y/S93V2XFSN
	YDhrvlpknTePQo3o7g2QReVmxADhkGOCTn46q4Usm+T9rskhi+gcelhUh1qSPfe2eXVLC5SXU7I
	n
X-Received: from plei10.prod.google.com ([2002:a17:902:e48a:b0:2df:48dd:9e68])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46ce:b0:2dd:c100:a5e2
 with SMTP id d9443c01a7336-2df60b76a60mr9443425ad.54.1790076074505; Tue, 22
 Sep 2026 04:21:14 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:21:11 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922112111.1970872-1-morbo@google.com>
Subject: [PATCH] iio: st_sensors: add __counted_by_ptr to struct st_sensor_settings
From: Bill Wendling <morbo@google.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, "=?UTF-8?q?Nuno=20S=C3=A1?=" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

Annotate the "ch" pointer member of "struct st_sensor_settings" with the
"__counted_by_ptr" attribute. The elements of "ch" are counted by the
"num_ch" member in the same struct.

All instances of "struct st_sensor_settings" are defined as "static
const" arrays across the ST sensor core drivers. For pressure sensors,
"num_ch" is explicitly initialized with the size of the respective
channel array using "ARRAY_SIZE(...)" during static definition.

For accelerometer, gyroscope, and magnetometer sensors, "num_ch" is not
explicitly initialized (and thus defaults to 0). This is because those
drivers hardcode the channel count to "ST_SENSORS_NUMBER_ALL_CHANNELS"
rather than using "num_ch" from the settings struct.

Since these structures are static const, both "ch" and "num_ch" are
fully initialized at compile time and available immediately at boot
time.  The only accesses to the "ch" field of "st_sensor_settings" occur
when assigning it to "indio_dev->channels" during device probing.

Because "sensor_settings->ch" is never dereferenced or accessed as an
array, adding the "__counted_by_ptr" annotation does not cause any
runtime panics or false-positive bounds checks under KASAN or UBSAN.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/iio/common/st_sensors.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 1ba496f0fea5..6e914ed49529 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -206,7 +206,7 @@ struct st_sensor_settings {
 	u8 wai;
 	u8 wai_addr;
 	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
-	struct iio_chan_spec *ch;
+	struct iio_chan_spec *ch __counted_by_ptr(num_ch);
 	int num_ch;
 	struct st_sensor_odr odr;
 	struct st_sensor_power pw;
-- 
2.55.0.1082.g2b9226bbc0-goog

