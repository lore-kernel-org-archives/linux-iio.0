Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194464457BF
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559893; cv=none; b=JC/z1Sf5h0azW0P1Ig3TwGPtzxR0Hma+YGC3bikhbc9jvV9s1JL4qluodxdx98/t2QWQhkDVXnTfjKj9SBFKcIlrb0QDJ66HK8lKBh6wn/UjMZdimgA1vDJqP65bVEJnSeTpi3ecJ/lBeegNz46XgyGjaTrOEScfILmYn08yhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559893; c=relaxed/simple;
	bh=93oEPmVDVAOtSpcddrdpxJvDTXVSqzJ0hh1D5icVEtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1XpOBzwxa7T6zou3v/oApJFM/o2fKpMVx4maIA/IFzu7X9TpshP+c4bgneR0fsRe3BYhJ0kSJulnYb9Uw1CA1/a1D1RRQyclrUQhhcwP/HsC7wtVvp32Go/LjVNbFUBMf3Jfqwz1QhIkXQP8VVc8tuXQM5FTVPUSuYQI8NdDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=VXhfjlrI; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="VXhfjlrI"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b58562bdb4so1109236b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788559891; x=1789164691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0feBNimmdTi1Zdy3AJ3fJ15k6KJCU3hOqOsJrVKmKz8=;
        b=VXhfjlrImkuNEdghKxgKtr45/6zHQUli/GvXtaq6+WlvczmOP9+iwkB8hfJB8FmdYu
         wyXKkbjKGib/Vo5KsZuJ470dpAZxXhjoLGWEfoMjQCh3vfZMZyrQkqQDrV5pjYS7lCux
         vCoCnq0qz8s5yIvhdIhKGb/2paoHeoOfUTh10k8eE+RfjOKsym8Zm6rgDTMQPQaq3RkU
         jsh24+flIK8DLIrXU8N180ed+L8BsOSB9qw2v2gzxyr1ZvY4E1qhnbQFzgYSm6uRD+Q9
         ysjUu7YCy6yFtQJfr/asqRBLPzmfIXX5HaT+M2I+o6lFYwhvNpN8Gi1gZloaiHfW169Q
         Za6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559891; x=1789164691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0feBNimmdTi1Zdy3AJ3fJ15k6KJCU3hOqOsJrVKmKz8=;
        b=DVZp2TQNGidDIjT06d2AntAu3F3mhsbbDrV9C0A+CDws1jicesXLn2+OpyVbZe6gSs
         EZS6DUOCvJdGk/4V7/OGyU/H8567Y5zlrQiwx6ke6Gl5/UsEq0SHaw7LE0hCJIg9B41D
         T2jPxqsM4vEl8YPGNHW3GcEvKhNs5gcYUuyx1h0ZZiWZiXLf4TpXN6UcYNfAwXWNDd0V
         SoSViMtRdCGhsYgap/SMpH1vzA+kRaxiP3gsq+LY5DA5F8bOOfZpWPoN3JVpnenmb4+7
         kFI1EW8e2KxoaPKGPhon43FENOnd6P4vjh0V9bsf7zz1aVVAsekKk+77FRSAqZt7aaYc
         688w==
X-Forwarded-Encrypted: i=1; AKwUvByq1SOQQunQozbZZn5Jeb+SMmPSuuZG8Y6Pjpqzl+Kosf8SSBhCmc69wCbxp9sfASEXJGE4Jh2qYHY=@vger.kernel.org
X-Gm-Message-State: AFuF++kYpxJ2+42Qfr6sAgLivZawnB4wRtmxQ8S0ujg6s9PnH7gZNs/P
	L1gtnsmAfavGw6cspFUvp8R2voi7neVznmCzy4OMSWIv8TNkoVSdF2E0A8uWqyZxhkqHOOfVbvq
	mg5Dd
X-Gm-Gg: AYBFou1Bb1GEqUi4EZCxXloUxdlS4qqu4N26ajP0/i95BGAV3R2W0lr/buwaBURJi9C
	TWysr1RQr+k6kTBZEPN4pUXnyT0PZi2MsjXjq4cMEOOfWMNtt5l7DyvpEJcsSYh0V/lfeFNsZnC
	gM/fb7wN2qp/qdRfBD2yGmrHh2qvu8D6fp75HlIMJWbbeKVore6ujMdC2fPeQB2O9X9fO9CnEvM
	7bB7uc9/iBQUB5EQswq8djjNEOQCaRYpA/pTGuAqlVQN4Q21rl5wOsZPqJH8PSIVpdTWA/WeiOz
	lgKHcw8D1PMtcCCI1Izy2LV6siEN31HF2Epi2CL0GLqe1KhQo70Dy8iHoJJKuwoSwcxAIms4Iqj
	oY/o+DzhErNNQQGtdZZsu0sRgTe3OofRv6SAvcxboD6bZ7BK9egJJzlLOXDCXd/s/43GqoC3Do8
	TVL9qCsGHUBi0PKFTzdmE5GKk6JKDQlV5t5q7vcNCB+VclyrtMHlHxHxqc3XBFgSKfuWATgmBgg
	gnE
X-Received: by 2002:a05:6808:150b:b0:4b5:5bfb:f25b with SMTP id 5614622812f47-4b96251871bmr8547748b6e.20.1788559890900;
        Fri, 04 Sep 2026 15:11:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4324:3ccf:e2bf:d545])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1ff95sm3187113b6e.6.2026.09.04.15.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:11:29 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 17:09:55 -0500
Subject: [PATCH v2 10/10] iio: ABI: add settlingtime attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-iio-adc-ti-ads112c14-filter-support-v2-10-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2766; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=93oEPmVDVAOtSpcddrdpxJvDTXVSqzJ0hh1D5icVEtc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqm0Hz072r7ixB4WsM5+YyJd/XYC427jHkB06d0
 fsYEcV9EGCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaptB8wAKCRDCzCAB/wGP
 wOOrB/0czxHW822v3jwxL8gQKimGaQWbWvdb7LRdKz8mvRKUZKoHJyfB4KL6e5YwQ0P/blkBusF
 /gQAIXGJE9vZ9Q49B5TEb5ZDpNTFPp+sekvaDaNNuKMLN86w6SfrLfEOlYI51SP0r4C/TwrfTMm
 zuu1X9vdA32xhG/ByR7gIZWNmGsiSkoPEir/IoCm9TFRlKwdUxBe45gGIEebW0jounT+FN1R5C/
 MbpaZiMWLWtINFdsjSGWeRCP5D1W/GK+My9BHDV3oaO2EQ81jmo3lFMPYGgkwOhF/KaUAJcrtOY
 /VyBso9EsZQ1tcBiClmD1fYZhNeFmBDCh7dHV0Le/PpHLqh9
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new generic attributes for input settling time introduced in the
ti-ads122c14 driver.

Usually, in IIO the output data rate is 1 / sampling_frequency. There
are known devices (generally ones with filtering and oversampling) where
the first conversion takes longer than 1 / sampling_frequency to allow
the input to settle in order to have a valid conversion result. Then,
any subsequent conversions in a continuous sampling mode would be done
at the regular interval defined by 1 / sampling_frequency.

This attribute is intended to allow controlling that settling time
duration.

A device that has input chopping enabled would see this settling time on
every conversion since the device setting (i.e. the input mux) changes
on every conversion.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a8e1cb8e7490..045589058655 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2402,6 +2402,32 @@ Description:
 		Specifies which filter type apply to the channel. The possible
 		values are given by the filter_type_available attribute.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_settlingtime
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_settlingtime
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_settlingtime
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_settlingtime
+KernelVersion:	7.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Set/read total settling time in seconds for a device to settle
+		after starting the first conversion after any settings have
+		changed. The data for the conversion is outputted at the end of
+		this time.
+
+		Depending on the device and how it is used, this settling time
+		may apply to more than just the first conversion, e.g. to every
+		conversion in a single-shot conversion mode or when a device
+		setting changes after each conversion (input chopping).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_settlingtime_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_settlingtime_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_settlingtime_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_settlingtime_available
+KernelVersion:	7.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available settlingtime values in IIO range or list format.
+
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0

