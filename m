Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9855429022
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074901; cv=none; b=Vu9n8a38EfQ4uLV6G2L13NPODc+m2ishi0FwWMDEoORMfrVU7p/q4cahv+Ocy9qL4kw5gAkr1at9a3tXF6VdYm8NZkKPUMwSsCU7dYNa89OwpyvANqPXbrYv50Kr+qB/akDwz/5f/dAuyzF/ftUuQjAxql1QfCtazNA9X8CFtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074901; c=relaxed/simple;
	bh=oco3EQSldSQddBQlm8Qmhp6JJwlywX+YHfTrmsrsHkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/pMtBdsUBD+4Rvfjh/vYYBuekVC17lO583UP1SpMy+Y49E1U9e0BrLQOOhdNCtzVmYztInRxEmWH5Us1kcEYpJOjeeSUqhXFhB7rx7Rk1VqTQirYHCi/IB0Ay7+wN/2T0YAqpDRyuSN5+hBRT8fV5BT1KiUa9pdAUEnz0UJWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bjEhUQXY; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bjEhUQXY"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b1fcd3b1a9so189400b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074885; x=1789679685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcroCnoY8IYvdQg62Y2Lq302IyLGTvPMvxJQS19q0o0=;
        b=bjEhUQXYFJhxC0wuBGuak6QkGAWrC/KZTvdoNPQC/K2vXOACyamcp6ZeGzqMgQGy7i
         yzMcqjzhdbtB8OP6b1efUZ+D1/MYRTxXrEA9laC9Maw+H0v3qks2N0bYmnfVLS9P7J3o
         WNZ3M2VF+EF+P/yt0EaIPdpPQUHREJKMxxOcEcm1YZ7WHgeSFJ7+CC+RbB6DCBLBLPgW
         ayYGOIwaMjpdVDiBScbfrTZUpWPqOKiTkVQ/9RIrWUlZjkdjoY9me1I8O5tefBSAKRXA
         lh+ZVpSlXxsAq7EjKdpiV6tRSxAkmb809ILyykY4QxMFz+7z03XdphL8ny9MKv1YCIay
         918w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074885; x=1789679685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HcroCnoY8IYvdQg62Y2Lq302IyLGTvPMvxJQS19q0o0=;
        b=HuKG2TatkDC48r1y51J45h8oGeaUTZPpht8ePyynPbnawL6d+1/AcDxEYrfpgjbze7
         Q4q9OLCuwvpA5xcv7riv66WG16VT0XTu6It9eJnZ109uE964H2PkJFkUpvxNjoovzp5g
         +2+KnFEx7ng+lHUoCvGoDGqu9oklVHSkQwICUU3ODNaHEHUb6qXS8/ffZyRajdDWZ//2
         jNcj8cdonOLSm00PqYu6U3p/EdlpE09o21IgZmZxWBVIYOcIbQ+3T7bonV00uFMhr7T2
         uUBM6jN3N6XC21+bftRUHg+WhU973aRmfXcAgaxUz6qmQf+/LzlmfLbJCbuT8pA6YtFb
         GgLg==
X-Forwarded-Encrypted: i=1; AKwUvBz2l6jeKWq6f5naf/e4jI8uLPpX1gFOwL1R1XWqPGmkG3047qAEdvadBt943/xiBAQ3otn0n/6gafY=@vger.kernel.org
X-Gm-Message-State: AFuF++lTyaw6q/Ght4aqi/qpN3gQ5jTITh6VNraHOFR68Aa5ktdP6K9l
	cATXwRVQ5IXaPYPMP+VmiAb5zylTkbDOOZd6IKvk7HTzIzZk5q5cYaROG2vld8nPsMhAh6/VpcN
	N/GCL
X-Gm-Gg: AYBFou1xwg+7yn54w6i0MDJjlUcRNEZtUxXRMLGJwIoj7OuB1KNQg1xuhkrzZ9gwgvO
	hUW4VQttVx7m23Zg52a/E0T0Xut+PWtQrh8t8a6a/Oy5bFfZw8RXNw14f5HtUS0b3Hm63xbFmFX
	sOF8z7FGDIbkA29etjWhyX0HTrvAeK/vz+zF6psdxl6bQo15sr6riOCSUTty20JHQvMtApvkuQu
	x+PR31kS3CbH7B96cH78ylBGXvhB1qAkXrP7mXvKC1aUPyZYDP5AM+beNjn6jrLfQH5kG3+sW7f
	fVnWBvPgCk/YV/lqMPWpJqaSqhtNULOj9ThXBcgWoBfbdtkXAmixRk8NxKao0Khdmbn00iWj6gV
	6rSPqhpwZcsp73ZWkQxYdAguKfi4OcJN6Wpf8gdR2fN56weiPvUmfR1AJWbO3dakLFmTxSRSDYf
	2npRweM0luf7VEhP9h6HNHfrmni/cTmTkeohw1HmZEb5xW6I+y4fSVXDtFYl9LJL56fB5imrelQ
	h/g
X-Received: by 2002:a05:6808:1784:b0:4b9:e5fa:8a24 with SMTP id 5614622812f47-4c31c61d3f9mr849699b6e.41.1789074885486;
        Thu, 10 Sep 2026 14:14:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:45 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:09 -0500
Subject: [PATCH v3 10/10] iio: ABI: add settlingtime attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-10-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=oco3EQSldSQddBQlm8Qmhp6JJwlywX+YHfTrmsrsHkU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox2u9xy7hKQq4y/ZNMUSyRLQFZyDbjhu/7DMF
 ntmFQ2pqf2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdrgAKCRDCzCAB/wGP
 wGqXB/4poy/o1/G42PpjjK9/keZcPcGPomxyMJlvUWnGUPtqaSxpA01IOf3Z1Dro4FPelFR8KEw
 dNyzByo8st3amG4/8de2OdQ/WIB037nbnWbsJXko6RrJcDuyidZ4x5uR+PsfW444agkckR3Zda2
 2PdrTh4Lsr1uG20X3OPIQkaUV50V+lwF/+pRV1cFdWwIqUQxttZiqjclafvA+t+gFt+DVP3dzo6
 RYRQsi5CKjTg8US9rr7l9LdKb462XLCeks6rVcwQLGphcGMUykHdBeHRRTcog547dzJp1Rr7HuK
 fUdc74rWQndt7RsRuXJ8ptatZOdz1e9oMC1ZnfgZhlYn7t/o
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

The total settling time is used rather than the difference between the
time needed for the first sample and subsequent samples so that it can
be read back directly via settlingtime_available without also reading
sampling_frequency to compute a delta. The available range's minimum
value represents the fixed, always-present portion of the delay (which
typically already includes the time for a normal conversion), so
requesting that minimum is equivalent to no additional settling delay.

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

