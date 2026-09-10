Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F942E430
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074893; cv=none; b=X0kxLUnH96oZ0xRK36nyvBcoZbesdo1Q0XC3Slj1FPzKm+zPL3/BS68xk89H12CU4X845UW/aLTZugcripIrgI6RVcAXaeD22gJAQ0/1tQVpyqDorgxqcVlAXWqAwtoI822R7dLAXupTCufVJU27bg8LtVFTxhtK1VteQxLKqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074893; c=relaxed/simple;
	bh=GJPVs2NQci4j2hQP0V6E0YPPvN8JlhkXSX7vksZ1gUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AqbOpC5cGdcF2YmLxixDOTycs1UvuF5mtHoSpvIuXVV1LrjqFpvCYs5d7mCiKXmm+x+hmr4/Jx9I+2ApndleOCU/Lkdxq5orFyvqoUDuQA9seFsUk2z7gSXyJLGyjA2smyxZAnigBXGNjBvBOICV6KXG+H5Pob2/BwtdyUFHtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HAFDQy7+; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HAFDQy7+"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a39a42dso133022b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074878; x=1789679678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaUDv6jZm7IW5T2ncwIblB7pFriUxG8BMMkD58QXmUY=;
        b=HAFDQy7+RhttkDhQlPJgllU4poo90y1uN58YjM3XrGvv5FmbuZopKLwWkZOl0vXz1T
         3xZfUjqNL1wOVqqxH547ByzayduVw1IerrNi4P5lESH9/DijlGKArJyrbKRNzqEJjW+C
         VUTROwa9G62wVoxbp+Te0dYsTXCpTgeZnszH8xIpzCvCI86O9IZPbmRJeOGWYFLnERL9
         SDogtaGLAquEuqyIGsoB4m0QpmjZRYgjNDE7zM9yZfe/NKKQZGpw0VWKTAW1fApEZNz6
         rCxCRhz6hck+LveWYjxVIhiZn58Alf5Wh9PZVrDYDwoYtHtLSK0KBdBVBdUWGcsRUqpn
         I9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074878; x=1789679678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaUDv6jZm7IW5T2ncwIblB7pFriUxG8BMMkD58QXmUY=;
        b=FVaoc8u1AAj+6sAcv85TlkowKi4JCi5O8vMRdwhyPsEZioUqDDd4gxDA1mjpr88OvE
         7XE3Nfq86XbdWu3VNqvycvamlFaOJM+waRZ1czHVy40IlIOcAXhf4aPHRqsMds/mwGm6
         V3r9qmJgaX3KLGqNIvOy/VXJFVCKDbP9C1Vma3RBhdIfs9VNXp/DLHwgZl5Bldu3zziL
         hISxj5W9zXP3V0CRNT6IXLUAIido6cylg5OqeE2mVYG4fA4uFX825E/4BewaNGveaWgS
         1lBKD5F2b9mjNBGkfwRuKbJxKKvksVj9RmRoaFt8fs/7OLSBX6TzY82cOMc22La0I5eW
         kKng==
X-Forwarded-Encrypted: i=1; AKwUvByQ71majDuP0LkevLhFriKPb+K68D2VDjD55aRH2eCxtsKTXMptC+PFWNJU0Tz0HmMfBuoh6PglVIA=@vger.kernel.org
X-Gm-Message-State: AFuF++mNJ/6noX/XVa/4TiVihMAZMNGliEMotD533LHMHczcuFsw8phr
	7QwOPtMGtRvDFdqC4+c46fWjifIEKOmBMoSYM9zIdoi5861aE/USKoKWarw+NymPmcE=
X-Gm-Gg: AYBFou0KqqNF4GDS5fjDLvVVqV/b6v6oLyz2h3CjobY9BmKCVQjkFurqCiqvO5AkFg+
	HX1bsCEAICL5oXAeeNB3epNF3Tfq0oYGenFJ9BwVCi5HLqbCJyUPjMpvnxpZQdo2sycScaJrfHa
	sCE8F31rHGtGO2ojoXndUz7MRHPtzEzm3ItXSw0yHkSrhXws84hdEovufdUh1PEv9tlZftcCC5F
	Zw8HQoUcqXvtaWfgpuLIIG4EuFcVq4txGWoYV0gqCdXcw+RDo3p4sbdVnH26jvu2lly+9HNP/Wk
	G+dWWh5nXgJWlVEubMeELTeuKKMrQ0PmqRh+mtthYhA/OLCX2oLmNpBTxlsKjWcEaQ7FBaLD4h1
	hJeV4fr31LikAvoQzxHCQ3kbNfZaF46ihHYrlMp22xUJREKuEQfCKAjs3K0/jmZDsOoQcThIXJn
	O1mtWAe691iiRFn/E4FF/px6dw17vDvKCWFfGinH8f5YIPXpv9eUcfiJwtH8m9hP6GyiZXG34Al
	6fj
X-Received: by 2002:a05:6808:2f0d:b0:4b3:5da8:1da0 with SMTP id 5614622812f47-4c3062ff672mr776765b6e.5.1789074877754;
        Thu, 10 Sep 2026 14:14:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:36 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:04 -0500
Subject: [PATCH v3 05/10] iio: ABI: add sysfs attribute for _burnoutraw
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-5-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=GJPVs2NQci4j2hQP0V6E0YPPvN8JlhkXSX7vksZ1gUg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox2Mm0sB7XapQX43w/pwQEiRiUGXEfKSzjCk7
 cMX/22PIXiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdjAAKCRDCzCAB/wGP
 wM+LB/9rV0udXgWjKDj+MCoUTl43iZuCii2tDgM2haR44hQZcLbx1Dh8IN7MLl4ymuyufWrVqss
 V91e0kInXHrXl14MwpqBQKvgiDim7QPh6/2BPr6itnMUVydJcbTLqJbLQzCQoDTfyX3WqfwhRNT
 caSMg1KbwYwGBT3G9E3yetKoKESpQLbg4bgcjdOQAQEM3k7R6mOs1TLzpm+ntWptPTp4KCJVKdB
 q8ooaG3I6pKaX5aPZ1uSGpcoW1mj82xxc1jcGVOeczi6Is0wqVOKwOI8EDNFEfHIu/IpzupGKCX
 tn9Mo2XWh3OtPGWMZyiEuhIRqIQ4lZrELNod5rr8lqFAzZ6r
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new _burnoutraw attribute to the IIO ADC ABI. This is likely only
applicable to ADCs (but is seen on multiple chips and vendors) so it
gets its own file instead of being added to the main IIO ABI file.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc b/Documentation/ABI/testing/sysfs-bus-iio-adc
new file mode 100644
index 000000000000..e1309b371efb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc
@@ -0,0 +1,9 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_burnoutraw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_burnoutraw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_burnoutraw
+KernelVersion:	7.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value from channel Y read using a single conversion with
+		the channel burnout current enabled. This is typically used
+		for diagnostic purposes to detect an open or shorted input.

-- 
2.43.0

