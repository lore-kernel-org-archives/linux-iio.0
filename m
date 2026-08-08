Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F2260565
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148450; cv=none; b=BAEkLJQPiqK51I9ObIeSW4NTGHhLqBCnaMIk9mG95hGIRkkd3v82Yn+cMOdbys+6cihC2T/bsV+3XIqvAjJiJjB2UtXtoEG+osPfH1hTM9w2olJE+nPeVg+TU4TfOiqk5ri7zg9bkZ5w6NenHeMYmYjXaceRPhrktDGlf0ffya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148450; c=relaxed/simple;
	bh=6QmljWoox6zrX2xlqNFzdFk9xTwBnbgWKPt4zs2E6Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1IUbOO2I5PDPQLgltNxTF5Z0T6B9VULVJsf4hPO+ImVNECeShk8/gP7GO1SZZ5sbpYCM3TUd3wGlzm798RVPxuUKQCn0IUfuLDAyIQY2YbvuAgqc6sJas7CoCJXkWr3nJg/YrIR3hgEMktYG//zSAiARH8ik7TBrGi6trE+0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZCT/Afcf; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZCT/Afcf"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6afcf32fb65so23377eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786148440; x=1786753240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsOi57ifL3TPKpC/47o26x/a2mJaTtoHuDckWfzu3ZY=;
        b=ZCT/AfcfJLG+ACHMapKLXmhMHzPEYT5939xyvklcuW03ZGd5BV3NlVPq33dq1orlmw
         asBWAQPTsKL5zRdFOU8khtvOw068fndj0EY672JsjH6MIsQVw2/vgsbeeIkyLHAXD67z
         iFDY8uB7F1+4NFkU2XMr+ns+JKnXGu5merJivy+Jbsrzq6sFFkd4zW3EMzQd1pyhnnXO
         ibgNwOp0DxlTL7ia4T4blG6RPusJ3POLpks9XGu0tOugthx91N9uSKN1McMJsSScXg3O
         kvxZnNiqHwmVEoa/UJ8l3jMXKdPeMt9HNLWErwrhedRanrr2L24Jic+XJZbH43oSfrhC
         KsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148440; x=1786753240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsOi57ifL3TPKpC/47o26x/a2mJaTtoHuDckWfzu3ZY=;
        b=aQQINRnqsZFpHhJpsZ2x3wghUaN11gsnlCdEEoC9ByMdp4Px0YnM6KRoffOUM79lCN
         YCnYKXac0a0zjjJoz1mHKqzMTNs/TNz721/hRRzVXU/CSA0Yg1Vu9lqhrsJvfdyxXhno
         vEIsEp8G+zuiEOXbPUq1MFAWq2Y0rFWJOKL3ZGl0M4BdumlST2ZSuOMPU74hKg6zIECa
         sYCky037CJZ5o5CiSr7g8BPwcbNAe9JGEJ/kZgxlk+Ph9ag1tTTDzHV3wNs1igA8pKgu
         zCisaYQQF8AAvklp/wZk5QF5g0Xt0PTL/YwMDNsPwmQPaqpsVvYa4Zc7L0SHKjEFsZzB
         u7mg==
X-Gm-Message-State: AOJu0YzTiCPkBhiEOgadbfeQoqSOtV+1Wu3z6mELwtkwlr16l351SVby
	IiQHDUob2gVhaiyre03Yo/xvssmIokrE8/XvNkcU0zL5/0keQF4pZaRZxA73GufoX4PP6YHv8AO
	OM47VGlc=
X-Gm-Gg: AR+sD117Wi6ovrP116VDVrIjOFGbO1RZNlV09YZRfpyHADHrlg7oJnR6+RkL9ePa/UH
	NJ8+dp2rLAALSv7noVaT+kYFiqoIt3UrOBNflgmKJo1/ZphjCg/M07FxqhtNHuKfnZby22eslgj
	NK7q1a26u/JKudRGBUKSbDxSGt81bvjv5RPpi674/yZBR2w2VUFEY86N+Xa77+QDVn8X8uJYXgB
	e5fRS6YEtZq7UN5kpIAVGeOkaS97iilmJ+Va6495sUjjFj5DbXOyMEg2EqxPwzcQy3SrXkASJiw
	awAerMTralDYQPG5shPd6NWt/bkpmhVC0eZHwlYCil8ArqBWQrZN/YJuPzM66WbDb6tSgF3E7KB
	+3XbxDKKBp9gjwCesWehBqmqGlkKCMZbXYlH3BohB8HclhrxPZiE67DDuxIr0LEyuFkIWB365Rm
	D81qNPJRGHYL2/WW5hT+gHgm2Q2XXZFeHT+az8mzxMDoKCbt0HkoY8lI3CuUad6Jsd
X-Received: by 2002:a05:6820:c0d2:10b0:6ae:9712:cad0 with SMTP id 006d021491bc7-6ae9713173amr10479429eaf.21.1786148440488;
        Fri, 07 Aug 2026 17:20:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a7616sm2526147a34.8.2026.08.07.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:20:40 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 19:19:50 -0500
Subject: [PATCH 5/5] iio: ABI: add settlingtime attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iio-adc-ti-ads112c14-filter-support-v1-5-4d3ba00caf18@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=6QmljWoox6zrX2xlqNFzdFk9xTwBnbgWKPt4zs2E6Zg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdnZJWRtURGKYc9u2fepn88ujSjHgxoLOtyJqP
 sAnHP95ob2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZ2SQAKCRDCzCAB/wGP
 wCu9CACB/BO+XSv6PpDzfkZfplTz//bJI1ElN3QkP+s2SUloGnMGmbo2AJO/6h6TBWrttzL/6zz
 RJLZLTHT9aW74CCDGUWJkO4JWiJ2qvqiZts7lVedg4k2rRfwv57HQpwJUf0ieZwE429KzgWUbbn
 NTjx9h4C4Tp3MTR+53dIhN8AZg7OLN89UsFPOGUBwx09h7Z6qXYMrN8xF9ZyBHYUh+aihQLlPVK
 YNQSvlCw+QR3GAUgo9pQe/U7nZmMtS0qcQMdBgN7PszXhrv+l/MEbSCVIayhBrM4CNzdN9py1XZ
 t8e9F6T4N2KgbAoOkzY62sAnMs39oC2ql3ryr8vEqUd4TDOB
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
 Documentation/ABI/testing/sysfs-bus-iio | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a8e1cb8e7490..344f5296a9cc 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2402,6 +2402,27 @@ Description:
 		Specifies which filter type apply to the channel. The possible
 		values are given by the filter_type_available attribute.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_settlingtime
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_settlingtime
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_settlingtime
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_settlingtime
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Set/read total settling time in seconds for a device to settle
+		after starting the first conversion after any settings have
+		changed. The data for the conversion is outputted at the end of
+		this time.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_settlingtime_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_settlingtime_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_settlingtime_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_settlingtime_available
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available settlingtime values in IIO range or list format.
+
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0

