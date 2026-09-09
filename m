Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600C339B3D
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966341; cv=pass; b=KZh6b2cL4q+UN7dJQ+uwxuU1gXHvRIUhSrXyTakUretzErzxPlixBrdL6kysUjyMj+ctp4eAX08SY1LT9/tIHf/7j8AjuerjvNZK5MKx+HICjF1aHXr4UDMBERPgVCl3Cy67PZJ9UQbcX5byYKJkFFwHFBump94htInHAFlajXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966341; c=relaxed/simple;
	bh=CdSWv/WiURR6Acy7P/4aVQQtslC45I4dSTkhDw1BvgI=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDbXOOrNlus2SSb0FY9yoYk2UrMlDVtlYzerV2FbuyHXRaAAATUU4oH7RLT19KsDu8jVJmFlewBTNWn9jyUs0B5PuM/xooXydmL+CLswU8U4e2PiPi/B9NIloXoYv5JZzXM1RXtnGN8LhuGHrajklq1SKX6tVKJ0+QOtLWAfiJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MffD7ozd; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MffD7ozd"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43b7e186a0cso3221440fac.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 08:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788966339; cv=none;
        d=google.com; s=arc-20260327;
        b=AiBRdhyNeb8TcLcLW4TWx4xtwM44Uf0iw1iLzTJLlVgYsbUhPfibUFZ1W8FG0YGImp
         8b86pnzZrIAMtuOqaW7l6d+JLeI/wob7AE2ji/HKcrk7eXgEl6hsLInhHe/x2japkNYh
         qH0mfXnlOcydtDXAShzzz6gxdjy4F3psUvzfK2aXKkWRJfF9jcE2yW0EsfB6WswOElEf
         EgDZrUssmBj1brWQNdd+AfqlTjfPriesHDWBi4UIE+vzee6lVuFeLI6UlK6L5UneZxfs
         q64SXq1dV025r4ruqQtjr9d3QYE4+DFJDZEP2RdCFQ+3qSfzk6BJxLo26FFW/QrGeSYC
         W47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=bPifW9Smu+tKBLdTNDc9b+YeXLJbZl3BP3bUtreOS1w=;
        fh=UN3Dj/gppJuVJlunBrzgrKJ2XPQr4cP2K/VaDprxNmQ=;
        b=Gfi+xmD4gu9Pb/JBXEEL/iUOx7CSrdwBfmms5DiUBZSA0aKMBPa6j8zZxwuqNNVzyO
         vNcjBLrqygvR8TJicMfa3/MDuA8inXUs40VqfvK2sNpxWdpSqdDWpv8mml0iAOyR2gPj
         f14LeMj5Xq9KO7bG2zo1t3aIcu4P3d/0bAUkSb8PYWs341yip7aq6+tDRZFSl9+a/79W
         v2ArcJOugWs4C7L965sQuZ4y1Eb8zp2iNq/6qfuxc1jhKNERR9w+ot64i8W4UqRyT86x
         AtaoNCE6kInIsoF7ThfSoC+vzyzG5zOChSl5+AgoJrs8vpnLkP7QEZvI224XGr58B318
         6dqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966339; x=1789571139; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPifW9Smu+tKBLdTNDc9b+YeXLJbZl3BP3bUtreOS1w=;
        b=MffD7ozdMsfGj8F4DamnIZ+7kNFrlvGiu1toNtJyONjoc3+nDY9xgXfFQRt/+ou3Cn
         T0LQE4bSPGK/mW3OcN7SL/NXMEHBcXLahoxXFiGsjUICJvxz9jv1Wf0VQAa1Ar6trJa0
         HO5uNBADKgUgIVu8Gz3x6lrFfENkOW0r1ZSNFdZKZ77hE/QDK2OaqMWwHhdaiKbLV2kW
         yjCTNnfsCBBvuyQOflwe7r2YaTruWLxs4CkaawZErJLiJFnd2zeUn62SrAL1hkOzcKBx
         D7W39vBhTkjAF7SFL6vyMIbUsNJry+bILMutzBH0omCg4WibewZ0bb5XzPUeMu1Z5kHD
         8YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966339; x=1789571139;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bPifW9Smu+tKBLdTNDc9b+YeXLJbZl3BP3bUtreOS1w=;
        b=kQeBilM/IZGEgQ/hm4+yXbk+vTwEsbk/DiepcPRihytI4juCCIkYdHkE5k9VCh7hj2
         AVCqLFphYSoEViY/GCRqZxr2X5UVXGx7Mc1VqjE5TrWFuTE6yiyKj8lo5KkAyWPMqGWS
         nH7CERk/9AW2L+TC1sodJY3BxQoLDcBIJHWaWqPas6sYuE8qa1zeUZls137sSB2uI68i
         BbOFYLu3iiol1CaDsyOKhuA3tlI+u4Ogn7TbmffKZ5nGcFSrhRoEhjJEoac+9KYlfMNF
         vjNeQ2kJ3y551elZFG5ReivO6LC6GB943WWMsAEB7V57w8nuflFCKe//x7nNkrHIHqBc
         sglg==
X-Forwarded-Encrypted: i=1; AKwUvBz4lYyemMflpsaNPIALd8cEgwmKabXbPfJG8R68J0ITblBMr6D8BGcDDxumVP059R+6kJGj5mIGr84=@vger.kernel.org
X-Gm-Message-State: AFuF++ngsRvJGr09pns559vt0Eh0ib2CcIa1iVy2zWHdaeuSFUX25BlN
	RftIEDviTBSwFHsp3WCaGvvt2OU62DsJKb4rGuTmrT3WwviV4izV9QF0Icy1gV38chKUSfn/ro0
	30O1H3NEAZc5Jq75VK4YaJ1ETnNuB2sw=
X-Gm-Gg: AYBFou3YSZAz3tS3TXwmpbBYcIbfFWg6PVGeTa3zcnFAmGMUtvKiSd/oDTdTzkvBEea
	G5mzN13AJ78/iYr8zBWXtQb9QC6x0I4GKoR4YaVXuwR9vMaLhgOa60B+G0/40mVLeFxZoZgazXn
	a2ZnPy0tx8hk/8Tw8CCRoh5+m/YX4JBQbgM4lBTBt/QpLMnIUd8YhIFNtq8RWU38YH0lRnE4+sE
	HlSGGSiNHdv4khlV5YjlCV7zyGhwmbhDoZo3lifYVAYYAzkyu1txEOFiOsZtxfQ/srfzlsp2sJF
	55+SPAW73AcWdCsMBOzKd5BCES6GMBBLzqvGVCU2cVNcCkdtuCSeVKT0d0m2SLEjV/BuhqnmTZq
	2ssUOQZHhIlCw0BwAzwugccGMEIk0MspGbEFT1A==
X-Received: by 2002:a4a:e847:0:b0:6b7:46e9:9700 with SMTP id
 006d021491bc7-6b746e9a360mr19044134eaf.48.1788966338598; Wed, 09 Sep 2026
 08:05:38 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:05:36 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:05:36 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinseob Kim <kimjinseob88@gmail.com>
In-Reply-To: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
References: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
Date: Wed, 9 Sep 2026 08:05:36 -0700
X-Gm-Features: AcwNN1XXvx0UutbQz3C8pC-IVMf-p4wSoPFQaanIGZK3T3vTnj6LaeC92XUpPTI
Message-ID: <CALMSewK17jG3MXTHv4Rj+tFVriw9+tqNuAMcX4KGQGy5NQP_MQ@mail.gmail.com>
Subject: [PATCH v9 2/5] Documentation: iio: add Open Sensor Fusion driver overview
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-kernel@vger.kernel.org, rdunlap@infradead.org, joshua.crofts1@gmail.com, 
	u.kleine-koenig@baylibre.com, julianbraha@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document the Linux IIO mapping for Open Sensor Fusion devices.

The overview explains that sensor channels are discovered at runtime
from mandatory capability reports. It also documents that OSF0 is a
wire-format detail and that protocol_major and protocol_minor carry
protocol compatibility information.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 Documentation/iio/index.rst              |  1 +
 Documentation/iio/open-sensor-fusion.rst | 84 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 3 files changed, 86 insertions(+)
 create mode 100644 Documentation/iio/open-sensor-fusion.rst

diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index b02b879b053a..c2b7963348fd 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -40,4 +40,5 @@ Industrial I/O Kernel Drivers
    adxl345
    bno055
    ep93xx_adc
+   open-sensor-fusion
    opt4060
diff --git a/Documentation/iio/open-sensor-fusion.rst
b/Documentation/iio/open-sensor-fusion.rst
new file mode 100644
index 000000000000..15d41202eb66
--- /dev/null
+++ b/Documentation/iio/open-sensor-fusion.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Open Sensor Fusion
+==================
+
+Open Sensor Fusion is a sensor aggregation hub interface. The Linux IIO driver
+receives OSF protocol frames from an attached device and registers matching IIO
+devices for the sensor classes supported by the driver. The actual sensor
+channels are discovered at runtime from mandatory OSF capability reports.
+
+This document is a driver-facing overview for the Linux IIO mapping. The full
+wire protocol, firmware behavior, and hardware model details belong in the Open
+Sensor Fusion project documentation.
+
+Device Model
+------------
+
+An OSF device sends binary frames from the device to the host.
Devices using the
+``opensensorfusion,osf`` compatible are expected to provide
+``CAPABILITY_REPORT`` messages so the host can discover which sensor
streams are
+available. Device Tree describes the attached OSF sensor aggregation
hub; it does
+not enumerate the individual sensors discovered at runtime.
+
+The currently supported Linux subset exposes:
+
+* accelerometer samples as ``IIO_ACCEL`` X/Y/Z channels,
+* gyroscope samples as ``IIO_ANGL_VEL`` X/Y/Z channels,
+* magnetometer samples as ``IIO_MAGN`` X/Y/Z channels, and
+* temperature samples as ``IIO_TEMP``.
+
+Protocol Scope
+---------------
+
+The driver supports OSF protocol major version 0 for the IIO receive path.
+The current wire magic is ``OSF0``; that string is a wire-format detail and is
+not the Linux driver identity. Device Tree keeps the generic
+``opensensorfusion,osf`` compatible rather than naming a product such as OSF
+GREEN or a wire magic value.
+
+Protocol versioning is carried by the ``protocol_major`` and ``protocol_minor``
+fields at fixed offsets in the OSF frame header. The driver currently
+supports ``protocol_major`` 0. ``protocol_minor`` changes within major version
+0 are intended to remain backward-compatible within the fixed header layout.
+Incompatible wire-format changes require a new ``protocol_major``. A future
+device that cannot expose compatible version discovery through that fixed
+header layout would need a different Device Tree compatible.
+
+The Linux driver handles device-to-host frames for:
+
+* ``SENSOR_SAMPLE`` buffered and direct-mode sample data,
+* ``CAPABILITY_REPORT`` based IIO device registration, and
+* ``DEVICE_STATUS`` cache updates.
+
+Vendor-private message types are ignored. Command transport, calibration
+control ABI, fusion output ABI, and runtime capability removal are outside the
+Linux IIO receive path.
+
+Timestamps
+----------
+
+OSF frames include a device-side ``timestamp_us`` field. Buffered IIO
samples use
+an IIO timestamp captured on the host when samples are pushed to IIO buffers.
+The driver does not correlate the device timestamp with the host IIO
+clock.
+
+Compatibility Notes
+-------------------
+
+This overview describes the implemented receive path, not a normative wire
+specification. A publicly versioned specification covering reserved fields,
+extensions and physical scale units remains needed for interoperability review.
+
+The decoder requires the fixed header size and the exact payload lengths of
+known messages. It ignores unsupported protocol majors, unknown message types
+and frames with nonzero header reserved fields. Unsupported capability entries
+are skipped individually; malformed known payloads are rejected. Appending data
+to an existing known message is therefore not a compatible extension for this
+receiver.
+
+IIO scale is taken from the initial capability report and is not updated by
+sample frames. Devices must supply scales in the units required by each IIO
+channel type, including gauss for magnetometers. Historical OSF draft documents
+differ on reserved-field handling, trailing extensions and magnetometer units;
+those drafts do not establish a canonical specification for this driver.
diff --git a/MAINTAINERS b/MAINTAINERS
index ff09899bd645..0c9c322162b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20515,6 +20515,7 @@ OPEN SENSOR FUSION
 M:	Jinseob Kim <kimjinseob88@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
+F:	Documentation/iio/open-sensor-fusion.rst
 K:	opensensorfusion

 OPENCOMPUTE PTP CLOCK DRIVER
-- 
2.43.0
