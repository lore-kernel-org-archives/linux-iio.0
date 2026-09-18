Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4851DB1E
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755955; cv=none; b=rI5HquyKe108MvPtBOWOHV7XGjsNRiTyPKPvki/9X2tAi4Woq2ugS7bpzEc8h9cEszdFsUgCuCG8uAjMQJZx04xvOMLovoOKbsDZ/CW3VFUNdaVSBbHiN8f1lXQaGMwxG0GX0PZtaCbYS1gXRSDC3IwZOhrVYPc7drymV/abXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755955; c=relaxed/simple;
	bh=2OGhOg4x8E+oiLi6DIb0pGpF3aPtbsqrEd6Kyowp3Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5J2g4dJ7xQOioXur/Pphlr7X40hMMnjiMY/Q3wYQz+6umqozkMZPzZVtDQWd1+ykZUccktTnG3G0c0I2rEEJz98tNESD2TMJGazKQ1a6XDGaRQk9+E0lse2Wl5f8k5QvW4vtaiZhpPFoWcDmU06YZ1RquWHKAwCYmYl2udhjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEO8EiPE; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEO8EiPE"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so13678045ad.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755952; x=1790360752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjLqYREv7hzeTClbjazYWzBGvHYiFH3EC3usZTg/nxc=;
        b=gEO8EiPEAIuium84kTBGjjJzXI5SVdgthfDjuey0T9jJEYmntxtGdaYhVi4z0gOY/b
         LkZEir4ySGfLaCTJ+vEAlIQ3Xa9JgCdVCdCKnj24xHQ+nGpcZlg2jemfVvDxUCTqithq
         5xEFv3iypoTYATyRZnTgwVMIvrJIzG1NuXZi5pzkSMFJZV5Fs6Rd1pNDh+5kmmYBuQ5X
         dL/J+rn16j0RtAyiIQoPHoJ+GLqjq/TGUYb+DbeL06FsK64uW3N0MUbk0a1DsFExSCIX
         B22b6Gq6zPXG8Ix6+jrzJWtDXWFwu7wQcucUfr3hnKgPN/821EwGZgQLXBLwYOL4m0M9
         OYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755952; x=1790360752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjLqYREv7hzeTClbjazYWzBGvHYiFH3EC3usZTg/nxc=;
        b=Fx/5GRiXV8RP7sJD0bKUaWp30JtyQzlElFdzqkkZIr6nN6M9oQGciXlW3LRIBZQm2P
         at2ncRMXPsncnAG65u31HAAWdv16AWsEr5AifVLT6t4r4v61XAcE32iECdex7cQym8Wh
         wRO+zms4oRiqdFDIb07FEhDJBJ8xg1awOdlHOcNNvywOyeRa3Pwu0CFSChmmvyRdbNB8
         nWTg/oD15g7Y4lldv0NFk7i6yH5cop9D3iicFwjfcTkUU+X188WdAVgIC6dMK+512M8r
         x/SN1/pJ99g+fCVvl7xrow/MhxukaBeVZ+qRxNfwWzLOgcgW5R3fdrDfjo+K/senTGoD
         Yo5g==
X-Forwarded-Encrypted: i=1; AKwUvBzlHDPoD7W+kvHwqJSiPeNt1Ixl1yNRB66G0WIKALw9tKQm32yKnBQYdijm2OFH34NYJFO1uyqIM38=@vger.kernel.org
X-Gm-Message-State: AFuF++lz1MOAKD/bVroSaz31bfOO/tcMfsgy6bZ+baS0IPQn6/EdFfBJ
	KQeBR4mZENJSqajrVuRs4jTdtCbihL6P/7ytxJKlXDknjXX+zwRF4HDY
X-Gm-Gg: AYBFou2IGKDnJ1r2FxUTblfu/wi7BMv0GMA3+izIHfGjNcjKwZH2tsOM61KWHCnP8bb
	z5Jrn7q0HHMvvW66sQg/IK99Xi5yF41U3nfQtOFE34h+WhIzWQrbm0v4HSy5Hmo7T09EUsbG9g8
	yeESGFZYHY5CZYqhhSI6/ibUPpkw38ATG1sci++pCPDTu3eELLu53GdFr0f6yv5TotNhuKXZduk
	UX1GqAkTqIuHuvEg6OyHMu1bfmfAiePPr0l8/tZ+GBNoOqCPl5GdpF0lOCCv5J/Syji4hQURrbQ
	NkSgvGiwdDE4yC0bA9KFVNU476O7NsCpErA7om4IbogWGUJT4mB52VQCmL0w0qSoUU2S+cx0GNm
	wbsngH5uOI+7IdJqwsBoNq7/CHOxSOb2BnPQKdwzlNYMETtwGveqnk/c08IeTvWObRTBZ6NVXj+
	5vJ3zleSBYQLtH/9voZTs9jCLRbLdLUKi1Cl8HwWYXhBcltTjvscHxxruSxl8T+Z8zCLWHBFOf/
	EupvM5MgMLYz4+BQ9V5f0qltSoLCPQzHn3L6J5yc84oVhlt4PyZZgr3XHr0dmOBBms3lpcSBOeu
	6jXR5bT8
X-Received: by 2002:a17:902:ccd1:b0:2dd:40cb:a04c with SMTP id d9443c01a7336-2ddb1b7cc6fmr68702465ad.19.1789755952231;
        Fri, 18 Sep 2026 11:25:52 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b49casm871895ad.7.2026.09.18.11.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:25:51 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com,
	julianbraha@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v10 6/8] iio: osf: add IIO devices from capability reports
Date: Sat, 19 Sep 2026 03:24:44 +0900
Message-ID: <c88d0ced0bff5cf29e765cd2c280ce3c10c50988.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register IIO devices from supported capability descriptors and expose
signed raw samples, descriptor scales and software buffers. Keep early
capabilities owned by the core until UART and supply setup is complete,
and unregister children after the receive producer has stopped.

Validate nonzero descriptor scales and sample/descriptor equality, leave
discovery open after empty or unsupported inventories, and compare
repeated descriptors independently of order. Fault a bound session if a
descriptor changes meaning, gating cache and buffer publication together.

Add initialized active-scan packing and buffer producer quiescence. The
production implementation is now complete; subsequent patches only add
the existing core and IIO KUnit suites and their build wiring.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/Kconfig      |  13 +-
 drivers/iio/opensensorfusion/Makefile     |   3 +-
 drivers/iio/opensensorfusion/osf_core.c   | 364 ++++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h   |  46 +++
 drivers/iio/opensensorfusion/osf_iio.c    | 338 ++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h    |  22 ++
 drivers/iio/opensensorfusion/osf_serdev.c |  11 +-
 7 files changed, 788 insertions(+), 9 deletions(-)
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h

diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
index fa25ad24bef6..f955a1f2993d 100644
--- a/drivers/iio/opensensorfusion/Kconfig
+++ b/drivers/iio/opensensorfusion/Kconfig
@@ -1,12 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config OPEN_SENSOR_FUSION
-	tristate "Open Sensor Fusion UART receiver"
+	tristate "Open Sensor Fusion UART IIO driver"
 	depends on SERIAL_DEV_BUS
 	select CRC32
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
-	  Build the Open Sensor Fusion UART receive path.
+	  Build the Open Sensor Fusion UART IIO driver.
 
-	  The driver receives and validates OSF protocol frames over a serdev
-	  UART and caches device status reported by the sensor hub.
-	  Message types without an application handler are ignored.
+	  The driver receives OSF protocol frames over a serdev UART and
+	  registers IIO devices for supported capability entries. It exposes
+	  accelerometer, gyroscope, magnetometer, and temperature samples
+	  through IIO direct reads and software buffers.
diff --git a/drivers/iio/opensensorfusion/Makefile b/drivers/iio/opensensorfusion/Makefile
index 940c82eddc2e..b4e03b80cfa4 100644
--- a/drivers/iio/opensensorfusion/Makefile
+++ b/drivers/iio/opensensorfusion/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
 
-open-sensor-fusion-y := osf_core.o osf_protocol.o osf_serdev.o osf_stream.o
+open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
+			 osf_stream.o
diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
index e6812cef4d8c..6f83ab485b34 100644
--- a/drivers/iio/opensensorfusion/osf_core.c
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #include "osf_core.h"
+#include "osf_iio.h"
 #include "osf_stream.h"
 
 #define OSF_RESERVED_MSG_FIRST		0x7f00
@@ -16,6 +19,247 @@ void osf_core_init(struct osf_device *osf, struct device *dev)
 	*osf = (struct osf_device) {
 		.dev = dev,
 	};
+	mutex_init(&osf->latest_lock);
+}
+
+void osf_core_unregister_iio(struct osf_device *osf)
+{
+	for (unsigned int i = 0; i < osf->iio_dev_count; i++)
+		osf_iio_unregister_sensor(osf->iio_devs[i].indio_dev);
+
+	osf->iio_dev_count = 0;
+}
+
+static struct iio_dev *osf_core_find_iio_dev(struct osf_device *osf,
+					     u16 sensor_type, u16 sensor_index)
+{
+	const struct osf_iio_binding *binding;
+
+	for (unsigned int i = 0; i < osf->iio_dev_count; i++) {
+		binding = &osf->iio_devs[i];
+		if (binding->sensor_type == sensor_type &&
+		    binding->sensor_index == sensor_index)
+			return binding->indio_dev;
+	}
+
+	return NULL;
+}
+
+static struct osf_latest_sample *
+osf_core_find_latest_sample(struct osf_device *osf, u16 sensor_type,
+			    u16 sensor_index)
+{
+	struct osf_latest_sample *latest;
+
+	for (unsigned int i = 0; i < osf->latest_sample_count; i++) {
+		latest = &osf->latest_samples[i];
+		if (latest->sensor_type == sensor_type &&
+		    latest->sensor_index == sensor_index)
+			return latest;
+	}
+
+	if (osf->latest_sample_count >= OSF_MAX_CAPABILITIES)
+		return NULL;
+
+	return &osf->latest_samples[osf->latest_sample_count++];
+}
+
+static bool
+osf_core_capability_supported(const struct osf_capability_entry *entry)
+{
+	return osf_iio_sensor_supported(entry->sensor_type,
+					entry->channel_count) &&
+	       entry->sample_format == OSF_SAMPLE_FORMAT_S32 &&
+	       !(entry->flags & ~OSF_CAPABILITY_FLAGS_MASK);
+}
+
+static const struct osf_capability_entry *
+osf_core_find_capability(const struct osf_capability_cache *cache,
+			 u16 sensor_type, u16 sensor_index)
+{
+	for (u16 i = 0; i < cache->capability_count; i++) {
+		const struct osf_capability_entry *entry = &cache->entries[i];
+
+		if (entry->sensor_type == sensor_type &&
+		    entry->sensor_index == sensor_index)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static bool
+osf_core_capabilities_equal(const struct osf_capability_cache *old,
+			    const struct osf_capability_cache *new)
+{
+	if (old->capability_count != new->capability_count)
+		return false;
+
+	for (u16 i = 0; i < old->capability_count; i++) {
+		const struct osf_capability_entry *entry = &old->entries[i];
+		const struct osf_capability_entry *other;
+
+		other = osf_core_find_capability(new, entry->sensor_type,
+						 entry->sensor_index);
+		/* Type and the supported major version also fix the unit. */
+		if (!other || other->channel_count != entry->channel_count ||
+		    other->sample_format != entry->sample_format ||
+		    other->scale_nano != entry->scale_nano)
+			return false;
+	}
+
+	return true;
+}
+
+static bool osf_core_capability_is_duplicate(const struct osf_capability_cache *cache,
+					     u16 index)
+{
+	const struct osf_capability_entry *entry = &cache->entries[index];
+
+	for (u16 i = 0; i < index; i++) {
+		if (cache->entries[i].sensor_type == entry->sensor_type &&
+		    cache->entries[i].sensor_index == entry->sensor_index)
+			return true;
+	}
+
+	return false;
+}
+
+static int osf_core_register_capabilities(struct osf_device *osf,
+					  const struct osf_capability_cache *cache)
+{
+	struct iio_dev *indio_dev;
+	int ret;
+
+	for (u16 i = 0; i < cache->capability_count; i++) {
+		ret = osf_iio_register_sensor(osf->dev, &cache->entries[i],
+					      osf, &indio_dev);
+		if (ret)
+			goto err_unregister;
+
+		osf->iio_devs[osf->iio_dev_count++] = (struct osf_iio_binding) {
+			.sensor_type = cache->entries[i].sensor_type,
+			.sensor_index = cache->entries[i].sensor_index,
+			.indio_dev = indio_dev,
+		};
+	}
+
+	return 0;
+
+err_unregister:
+	osf_core_unregister_iio(osf);
+
+	return ret;
+}
+
+void osf_core_start(struct osf_device *osf)
+{
+	int ret;
+
+	if (osf->iio_ready)
+		return;
+
+	osf->iio_ready = true;
+	if (!osf->capability_cache.valid ||
+	    !osf->capability_cache.capability_count)
+		return;
+
+	ret = osf_core_register_capabilities(osf, &osf->capability_cache);
+	if (ret) {
+		/* As with RX discovery failure, a later report may retry. */
+		osf->capability_cache.valid = false;
+		dev_err_ratelimited(osf->dev,
+				    "failed to register pending capabilities: %d\n",
+				    ret);
+	}
+}
+
+static int osf_core_handle_sensor_sample(struct osf_device *osf,
+					 const struct osf_frame *frame)
+{
+	const struct osf_capability_entry *entry;
+	struct osf_latest_sample *latest;
+	struct osf_sensor_sample sample;
+	struct iio_dev *indio_dev;
+	s32 values[OSF_MAX_SAMPLE_CHANNELS] = { };
+	int ret;
+
+	ret = osf_protocol_decode_sensor_sample(frame, &sample);
+	if (ret) {
+		dev_warn_ratelimited(osf->dev,
+				     "rejecting malformed sensor sample: %d\n",
+				     ret);
+		return ret;
+	}
+
+	indio_dev = osf_core_find_iio_dev(osf, sample.sensor_type,
+					  sample.sensor_index);
+	if (!indio_dev) {
+		dev_dbg_ratelimited(osf->dev,
+				    "ignoring sample for unregistered sensor %#x:%u\n",
+				    sample.sensor_type, sample.sensor_index);
+		return OSF_STREAM_FRAME_IGNORED;
+	}
+
+	entry = osf_core_find_capability(&osf->capability_cache,
+					 sample.sensor_type, sample.sensor_index);
+	if (!entry || sample.channel_count != entry->channel_count ||
+	    sample.sample_format != entry->sample_format ||
+	    sample.scale_nano != entry->scale_nano)
+		return -EPROTO;
+
+	if (sample.channel_count > OSF_MAX_SAMPLE_CHANNELS) {
+		dev_warn_ratelimited(osf->dev,
+				     "rejecting sensor sample with %u channels\n",
+				     sample.channel_count);
+		return -E2BIG;
+	}
+
+	for (u16 i = 0; i < sample.channel_count; i++) {
+		ret = osf_protocol_sensor_sample_value(&sample, i, &values[i]);
+		if (ret) {
+			dev_warn_ratelimited(osf->dev,
+					     "rejecting malformed sample value: %d\n",
+					     ret);
+			return ret;
+		}
+	}
+
+	/* Serialize publication and cache admission with the session fault. */
+	guard(mutex)(&osf->latest_lock);
+	if (osf->session_fault)
+		return -EPROTO;
+
+	ret = osf_iio_push_sample(indio_dev, values, sample.channel_count);
+	if (ret) {
+		dev_err_ratelimited(osf->dev,
+				    "failed to push sensor %#x:%u sample: %d\n",
+				    sample.sensor_type, sample.sensor_index, ret);
+		return ret;
+	}
+
+	latest = osf_core_find_latest_sample(osf, sample.sensor_type,
+					     sample.sensor_index);
+	if (!latest) {
+		dev_err_ratelimited(osf->dev,
+				    "latest sample cache full for sensor %#x:%u\n",
+				    sample.sensor_type,
+				    sample.sensor_index);
+		return -ENOSPC;
+	}
+
+	memcpy(latest->values, values, sizeof(values));
+	latest->sensor_type = sample.sensor_type;
+	latest->sensor_index = sample.sensor_index;
+	latest->channel_count = sample.channel_count;
+	latest->sample_format = sample.sample_format;
+	latest->scale_nano = sample.scale_nano;
+	latest->sequence = frame->sequence;
+	latest->timestamp_us = frame->timestamp_us;
+	latest->valid = true;
+	osf->last_sequence = frame->sequence;
+
+	return OSF_STREAM_FRAME_HANDLED;
 }
 
 static int osf_core_handle_device_status(struct osf_device *osf,
@@ -45,6 +289,91 @@ static int osf_core_handle_device_status(struct osf_device *osf,
 	return OSF_STREAM_FRAME_HANDLED;
 }
 
+static int osf_core_handle_capability_report(struct osf_device *osf,
+					     const struct osf_frame *frame)
+{
+	struct osf_capability_cache cache = { };
+	struct osf_capability_report report;
+	int frame_result;
+	int ret;
+
+	ret = osf_protocol_decode_capability_report(frame, &report);
+	if (ret) {
+		dev_warn_ratelimited(osf->dev,
+				     "rejecting malformed capability report: %d\n",
+				     ret);
+		return ret;
+	}
+
+	for (u16 i = 0; i < report.capability_count; i++) {
+		struct osf_capability_entry entry;
+
+		ret = osf_protocol_decode_capability_entry(&report, i, &entry);
+		if (ret) {
+			dev_warn_ratelimited(osf->dev,
+					     "rejecting malformed capability entry: %d\n",
+					     ret);
+			return ret;
+		}
+
+		if (!osf_core_capability_supported(&entry))
+			continue;
+
+		if (!entry.scale_nano)
+			return -EPROTO;
+
+		if (cache.capability_count >= OSF_MAX_CAPABILITIES) {
+			dev_warn_ratelimited(osf->dev,
+					     "too many supported capabilities\n");
+			return -E2BIG;
+		}
+
+		cache.entries[cache.capability_count] = entry;
+		if (osf_core_capability_is_duplicate(&cache, cache.capability_count)) {
+			dev_warn_ratelimited(osf->dev,
+					     "rejecting duplicate capability\n");
+			return -EEXIST;
+		}
+		cache.capability_count++;
+	}
+
+	cache.sequence = frame->sequence;
+	cache.valid = cache.capability_count != 0;
+
+	if (osf->iio_dev_count) {
+		if (!osf_core_capabilities_equal(&osf->capability_cache, &cache)) {
+			guard(mutex)(&osf->latest_lock);
+			osf->session_fault = true;
+			return -EPROTO;
+		}
+
+		osf->last_sequence = frame->sequence;
+		return OSF_STREAM_FRAME_IGNORED;
+	}
+
+	frame_result = OSF_STREAM_FRAME_IGNORED;
+	if (cache.capability_count) {
+		if (osf->iio_ready) {
+			ret = osf_core_register_capabilities(osf, &cache);
+			if (ret) {
+				dev_err_ratelimited(osf->dev,
+						    "failed to register capabilities: %d\n",
+						    ret);
+				return ret;
+			}
+		}
+		frame_result = OSF_STREAM_FRAME_HANDLED;
+	} else {
+		dev_dbg_ratelimited(osf->dev,
+				    "ignoring report without supported capabilities\n");
+	}
+
+	osf->capability_cache = cache;
+	osf->last_sequence = frame->sequence;
+
+	return frame_result;
+}
+
 int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
 {
 	struct osf_frame frame;
@@ -66,9 +395,15 @@ int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
 	}
 
 	switch (frame.message_type) {
+	case OSF_MSG_SENSOR_SAMPLE:
+		ret = osf_core_handle_sensor_sample(osf, &frame);
+		break;
 	case OSF_MSG_DEVICE_STATUS:
 		ret = osf_core_handle_device_status(osf, &frame);
 		break;
+	case OSF_MSG_CAPABILITY_REPORT:
+		ret = osf_core_handle_capability_report(osf, &frame);
+		break;
 	default:
 		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
 		    frame.message_type <= OSF_RESERVED_MSG_LAST) {
@@ -99,3 +434,32 @@ int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
 
 	return ret;
 }
+
+int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
+				u16 sensor_index, u16 channel,
+				s32 *value)
+{
+	const struct osf_latest_sample *latest;
+
+	if (!osf || !value)
+		return -EINVAL;
+
+	guard(mutex)(&osf->latest_lock);
+	if (osf->session_fault)
+		return -EPROTO;
+
+	for (unsigned int i = 0; i < osf->latest_sample_count; i++) {
+		latest = &osf->latest_samples[i];
+		if (latest->sensor_type != sensor_type ||
+		    latest->sensor_index != sensor_index)
+			continue;
+
+		if (!latest->valid || channel >= latest->channel_count)
+			break;
+
+		*value = latest->values[channel];
+		return 0;
+	}
+
+	return -ENODATA;
+}
diff --git a/drivers/iio/opensensorfusion/osf_core.h b/drivers/iio/opensensorfusion/osf_core.h
index 7095e3f967fc..1fd8e5db1443 100644
--- a/drivers/iio/opensensorfusion/osf_core.h
+++ b/drivers/iio/opensensorfusion/osf_core.h
@@ -2,11 +2,35 @@
 #ifndef _OSF_CORE_H
 #define _OSF_CORE_H
 
+#include <linux/mutex.h>
 #include <linux/types.h>
 
 #include "osf_protocol.h"
 
+#define OSF_MAX_SAMPLE_CHANNELS	3
+#define OSF_MAX_CAPABILITIES	16
+
 struct device;
+struct iio_dev;
+
+struct osf_latest_sample {
+	u16 sensor_type;
+	u16 sensor_index;
+	u16 channel_count;
+	u16 sample_format;
+	u32 scale_nano;
+	s32 values[OSF_MAX_SAMPLE_CHANNELS];
+	u64 sequence;
+	u64 timestamp_us;
+	bool valid;
+};
+
+struct osf_capability_cache {
+	u16 capability_count;
+	struct osf_capability_entry entries[OSF_MAX_CAPABILITIES];
+	u64 sequence;
+	bool valid;
+};
 
 struct osf_status_cache {
 	u32 uptime_s;
@@ -17,13 +41,35 @@ struct osf_status_cache {
 	bool valid;
 };
 
+struct osf_iio_binding {
+	u16 sensor_type;
+	u16 sensor_index;
+	struct iio_dev *indio_dev;
+};
+
 struct osf_device {
 	struct device *dev;
+	bool iio_ready;
+	/* Protects session_fault and latest samples; nests outside buffer_lock. */
+	struct mutex latest_lock;
+	bool session_fault;
+	struct osf_latest_sample latest_samples[OSF_MAX_CAPABILITIES];
+	unsigned int latest_sample_count;
+	struct osf_capability_cache capability_cache;
 	struct osf_status_cache status_cache;
+	struct osf_iio_binding iio_devs[OSF_MAX_CAPABILITIES];
+	unsigned int iio_dev_count;
 	u64 last_sequence;
 };
 
 void osf_core_init(struct osf_device *osf, struct device *dev);
+/* Serialize start with receive_frame; pending entries own their data. */
+void osf_core_start(struct osf_device *osf);
+/* Stop the receive producer before teardown; init starts a fresh session. */
+void osf_core_unregister_iio(struct osf_device *osf);
 int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len);
+int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
+				u16 sensor_index, u16 channel,
+				s32 *value);
 
 #endif
diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
new file mode 100644
index 000000000000..f4011b8fae14
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "osf_core.h"
+#include "osf_iio.h"
+
+struct osf_iio_sensor_spec {
+	u16 sensor_type;
+	u16 channel_count;
+	const char *name;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+struct osf_iio_state {
+	const struct osf_iio_sensor_spec *spec;
+	struct iio_buffer *buffer;
+	/* Serializes pushes with buffer activation and quiescence. */
+	struct mutex buffer_lock;
+	bool buffer_active;
+	u32 scale_nano;
+	u16 sensor_index;
+	struct osf_device *osf;
+};
+
+struct osf_iio_scan_3axis {
+	s32 values[3];
+	u32 padding;
+	aligned_s64 timestamp;
+};
+
+struct osf_iio_scan_1axis {
+	s32 value;
+	u32 padding;
+	aligned_s64 timestamp;
+};
+
+#define OSF_MOD_CHAN(_type, _mod, _idx)				\
+	{								\
+		.type = (_type),					\
+		.modified = 1,						\
+		.channel2 = (_mod),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = (_idx),					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 32,					\
+			.storagebits = 32,				\
+			.endianness = IIO_CPU,				\
+		},							\
+	}
+
+#define OSF_CHAN(_type, _idx)					\
+	{								\
+		.type = (_type),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = (_idx),					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 32,					\
+			.storagebits = 32,				\
+			.endianness = IIO_CPU,				\
+		},							\
+	}
+
+static const struct iio_chan_spec osf_accel_channels[] = {
+	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_X, 0),
+	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Y, 1),
+	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec osf_gyro_channels[] = {
+	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_X, 0),
+	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, 1),
+	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec osf_mag_channels[] = {
+	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_X, 0),
+	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Y, 1),
+	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec osf_temp_channels[] = {
+	OSF_CHAN(IIO_TEMP, 0),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct osf_iio_sensor_spec osf_iio_sensor_specs[] = {
+	{
+		.sensor_type = OSF_SENSOR_ACCELEROMETER,
+		.channel_count = 3,
+		.name = "osf-accel",
+		.channels = osf_accel_channels,
+		.num_channels = ARRAY_SIZE(osf_accel_channels),
+	},
+	{
+		.sensor_type = OSF_SENSOR_GYROSCOPE,
+		.channel_count = 3,
+		.name = "osf-gyro",
+		.channels = osf_gyro_channels,
+		.num_channels = ARRAY_SIZE(osf_gyro_channels),
+	},
+	{
+		.sensor_type = OSF_SENSOR_MAGNETOMETER,
+		.channel_count = 3,
+		.name = "osf-magn",
+		.channels = osf_mag_channels,
+		.num_channels = ARRAY_SIZE(osf_mag_channels),
+	},
+	{
+		.sensor_type = OSF_SENSOR_TEMPERATURE,
+		.channel_count = 1,
+		.name = "osf-temp",
+		.channels = osf_temp_channels,
+		.num_channels = ARRAY_SIZE(osf_temp_channels),
+	},
+};
+
+static const struct osf_iio_sensor_spec *
+osf_iio_find_sensor_spec(u16 sensor_type, u16 channel_count)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(osf_iio_sensor_specs); i++) {
+		if (osf_iio_sensor_specs[i].sensor_type == sensor_type &&
+		    osf_iio_sensor_specs[i].channel_count == channel_count)
+			return &osf_iio_sensor_specs[i];
+	}
+
+	return NULL;
+}
+
+bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count)
+{
+	if (osf_iio_find_sensor_spec(sensor_type, channel_count))
+		return true;
+
+	return false;
+}
+
+const char *osf_iio_sensor_name(u16 sensor_type)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(osf_iio_sensor_specs); i++) {
+		if (osf_iio_sensor_specs[i].sensor_type == sensor_type)
+			return osf_iio_sensor_specs[i].name;
+	}
+
+	return NULL;
+}
+
+static int osf_iio_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, int *val,
+			    int *val2, long mask)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+	s32 raw;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = osf_core_read_latest_sample(state->osf,
+						  state->spec->sensor_type,
+						  state->sensor_index,
+						  chan->scan_index, &raw);
+		if (ret)
+			return ret;
+
+		*val = raw;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = state->scale_nano / NANO;
+		*val2 = state->scale_nano % NANO;
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info osf_iio_info = {
+	.read_raw = osf_iio_read_raw,
+};
+
+static int osf_iio_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+
+	guard(mutex)(&state->buffer_lock);
+	state->buffer_active = true;
+
+	return 0;
+}
+
+static int osf_iio_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+
+	/* Wait for the current push before the IIO core changes its buffers. */
+	guard(mutex)(&state->buffer_lock);
+	state->buffer_active = false;
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops osf_iio_buffer_ops = {
+	.postenable = osf_iio_buffer_postenable,
+	.predisable = osf_iio_buffer_predisable,
+};
+
+int osf_iio_register_sensor(struct device *dev,
+			    const struct osf_capability_entry *entry,
+			    struct osf_device *osf, struct iio_dev **indio_dev)
+{
+	const struct osf_iio_sensor_spec *spec;
+	struct osf_iio_state *state;
+	struct iio_dev *iio_dev;
+	int ret;
+
+	spec = osf_iio_find_sensor_spec(entry->sensor_type,
+					entry->channel_count);
+	if (!spec)
+		return -EOPNOTSUPP;
+
+	if (entry->sample_format != OSF_SAMPLE_FORMAT_S32 ||
+	    (entry->flags & ~OSF_CAPABILITY_FLAGS_MASK))
+		return -EOPNOTSUPP;
+
+	if (!entry->scale_nano)
+		return -EINVAL;
+
+	iio_dev = iio_device_alloc(dev, sizeof(*state));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(iio_dev);
+	state->spec = spec;
+	state->scale_nano = entry->scale_nano;
+	state->sensor_index = entry->sensor_index;
+	state->osf = osf;
+	mutex_init(&state->buffer_lock);
+
+	iio_dev->name = spec->name;
+	iio_dev->info = &osf_iio_info;
+	iio_dev->setup_ops = &osf_iio_buffer_ops;
+	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	iio_dev->channels = spec->channels;
+	iio_dev->num_channels = spec->num_channels;
+
+	state->buffer = iio_kfifo_allocate();
+	if (!state->buffer) {
+		ret = -ENOMEM;
+		goto err_free_iio;
+	}
+
+	ret = iio_device_attach_buffer(iio_dev, state->buffer);
+	if (ret)
+		goto err_free_buffer;
+
+	ret = iio_device_register(iio_dev);
+	if (ret)
+		goto err_free_buffer;
+
+	*indio_dev = iio_dev;
+
+	return 0;
+
+err_free_buffer:
+	iio_kfifo_free(state->buffer);
+err_free_iio:
+	iio_device_free(iio_dev);
+
+	return ret;
+}
+
+void osf_iio_unregister_sensor(struct iio_dev *indio_dev)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	iio_kfifo_free(state->buffer);
+	iio_device_free(indio_dev);
+}
+
+int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
+			u16 channel_count)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+	s64 timestamp;
+
+	if (channel_count != state->spec->channel_count)
+		return -EPROTO;
+
+	guard(mutex)(&state->buffer_lock);
+	if (!state->buffer_active || !iio_buffer_enabled(indio_dev))
+		return 0;
+
+	timestamp = iio_get_time_ns(indio_dev);
+
+	switch (channel_count) {
+	case 1: {
+		struct osf_iio_scan_1axis scan = {
+			.value = values[0],
+		};
+
+		return iio_push_to_buffers_with_ts(indio_dev, &scan,
+						   sizeof(scan), timestamp);
+	}
+	case 3: {
+		struct osf_iio_scan_3axis scan = {
+			.values = { },
+		};
+		unsigned int channel, index = 0;
+
+		/* Pack the active channels; unused storage remains initialized. */
+		for_each_set_bit(channel, indio_dev->active_scan_mask, channel_count)
+			scan.values[index++] = values[channel];
+
+		return iio_push_to_buffers_with_ts(indio_dev, &scan,
+						   sizeof(scan), timestamp);
+	}
+	default:
+		return -EPROTO;
+	}
+}
diff --git a/drivers/iio/opensensorfusion/osf_iio.h b/drivers/iio/opensensorfusion/osf_iio.h
new file mode 100644
index 000000000000..d0745167f8e0
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_IIO_H
+#define _OSF_IIO_H
+
+#include <linux/types.h>
+
+#include "osf_protocol.h"
+
+struct device;
+struct iio_dev;
+struct osf_device;
+
+int osf_iio_register_sensor(struct device *dev,
+			    const struct osf_capability_entry *entry,
+			    struct osf_device *osf, struct iio_dev **indio_dev);
+void osf_iio_unregister_sensor(struct iio_dev *indio_dev);
+int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
+			u16 channel_count);
+bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count);
+const char *osf_iio_sensor_name(u16 sensor_type);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
index 8a747c01ff9d..3d5e90d83967 100644
--- a/drivers/iio/opensensorfusion/osf_serdev.c
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -23,7 +23,7 @@ struct osf_serdev {
 	bool vcc_enabled;
 	struct osf_device osf;
 	struct osf_stream stream;
-	/* Protects the parser and all RX counters. */
+	/* Protects the parser, all RX counters, and the registration gate. */
 	struct mutex rx_lock;
 };
 
@@ -68,9 +68,10 @@ static void osf_serdev_release(void *data)
 {
 	struct osf_serdev *osf_uart = data;
 
-	/* The TTY controller drains RX work on close; hold no RX lock. */
+	/* The TTY controller drains RX work on close; hold no RX or IIO lock. */
 	serdev_device_close(osf_uart->serdev);
 	osf_stream_reset(&osf_uart->stream);
+	osf_core_unregister_iio(&osf_uart->osf);
 	if (osf_uart->vcc_enabled)
 		regulator_disable(osf_uart->vcc);
 }
@@ -121,6 +122,10 @@ static int osf_serdev_probe(struct serdev_device *serdev)
 		return dev_err_probe(dev, ret, "failed to enable vcc regulator\n");
 	osf_uart->vcc_enabled = true;
 
+	/* No fallible probe steps remain when IIO children become visible. */
+	scoped_guard(mutex, &osf_uart->rx_lock)
+		osf_core_start(&osf_uart->osf);
+
 	return 0;
 }
 
@@ -139,5 +144,5 @@ static struct serdev_device_driver osf_serdev_driver = {
 };
 module_serdev_device_driver(osf_serdev_driver);
 
-MODULE_DESCRIPTION("Open Sensor Fusion UART receiver");
+MODULE_DESCRIPTION("Open Sensor Fusion IIO driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0

