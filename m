Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6B44C4E2
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559887; cv=none; b=ujWEKwMqlGmxlkZ0bX1n9ze7z81A1UAXZHzrczmhQcNkcA0hiAPV/0ucMRGw5eeGbM9O8SVvgj8Gv9zM5AcmRw2KOa+JREOZNuKKIc4fJJocjAHcP/pmZx6xpFVkVulGWb6DVoKx7iicT/eLva8ZuT1qaQXU2oCwE4g33hxD7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559887; c=relaxed/simple;
	bh=GJPVs2NQci4j2hQP0V6E0YPPvN8JlhkXSX7vksZ1gUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bYnAstq3XtvgPaAJ/DfBZ2H7JKiYVfMtd8eX7EVtn9f0TYzVWHL/npopj2PpEBxw+UD//gWn8wrYFBYhC1F+4R5DN3c2I4ITZF/IZjjiBoRwljQXREdv7LssmCA7jbdoNd6V017mZR+cOfWbs7pRbMrO/NjyW8Bo8Pfy/Y2Pkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DUjFL/Gq; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DUjFL/Gq"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b28df1f600so1322356b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 15:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788559880; x=1789164680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaUDv6jZm7IW5T2ncwIblB7pFriUxG8BMMkD58QXmUY=;
        b=DUjFL/GqBpCAQ6ofwufiLtoNQker3TV0cxCVCaLP0Q8fUKOBuKpOEOKcPzhpw7xX9b
         ACFOzkrW76weag2DYJryPQXYTPVn2eJw1+UASTOcvq7U/TmqsjDg6iKWBhmS517iN1gx
         hQuOjg6zzz7wPamHfwzxn5iXgo0l+KyDQAWE/0FNisq+aQchnEJTiRSxan9jWxKQkI+M
         bPGg0eBzYXd18ZW9FCWJ2qXoID7a8/PA6IlCL/gKnHAQoEdyNQUiSUdmP6ByAMo3/XSz
         ps+u9mdXxZyiWE0BPOFKmpbTEtQ/iewoqpR0oE/vA4JuIdu4iLs4znA5VSuax14kKSG1
         XKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559880; x=1789164680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaUDv6jZm7IW5T2ncwIblB7pFriUxG8BMMkD58QXmUY=;
        b=fTi5G2dn1p91GLXGeYCjYJ5ge24KaYL6lMD9PNLA8f2hICyaw2Lgdh1V9HHxxp+7yR
         auRQ5pi/swHawte0fm5nUWEAXRBbQ7RU2BoZ68ZvQm2o2aesv8l6hnphj6vt75annaho
         IGzvlkINi5AlrEbyepEWb5a2ut1pck4iMRLsEZOlI2nAbiLpS7G6xKPgA9jeanuxMZ3p
         cix4Ts6n1T5i3W8CKKObsQvn/6+9xin12wFQlF8C85LAi9PPcF9RZlQPC6gzQeX5Oz1B
         seaao2aeJMD4PoRbQwoPKeQTUwmE0pcSUprU3s50gGvypFzk3wimc3eQJoImEgeZJViu
         3Q5g==
X-Forwarded-Encrypted: i=1; AKwUvBwE6JxqetAv8lPCb9K3DY+ha3RQSlQbeYT6IZfmn0P4OB0EbVvE0JJoVlpFzM2dRXm44O2TjfZMICw=@vger.kernel.org
X-Gm-Message-State: AFuF++lN3AoAP6gv09S5KyI7MXY0kKFQEYTINnJI7IYHgBWqcztI5GGd
	5pqCS+fCJdieO2op4vXGOac7rseq8ZDme+53gywIcxREg6WCzPoKnRvZ0UWUwgLz4kM=
X-Gm-Gg: AYBFou0qMWDy3Ni1B76uxbFrKrWrnRdhJNXwVRTQPFLNbWlzNzv5to5mX7o/HRRhP+J
	XyQv3yHPcqIlBaAjbV/HNQzDmYzKRiU7eJ4wdaO27GL1MecdVqNKmcMJpLlWXg7loiFJA+BtvTc
	4vmft2wvQVkRy7F9kwIKOpsOcNq/3rJ49IbAG7VxtLP9aXfqxXsNGPJggX0gOwBOd+rR1cFPSAs
	qmi9JhELCxSgMfScTvce8IkkgrdujO/qasUtqN9a9p2NcnVfY7Wu6+Dsh7uXiJLHLdCbYVoxscu
	fj1DUaCN7gFYCWOrWdj6R6PaN+tgy+f2ZpKPkB8H1mkDUoK2XjGD/Pj8gNleC8B+AAjaOUCdLsu
	6PpUMYWaNHi8Weic1dyYNG9r7MAKJTwqJGrOB/q9Lo+vijXnHfB+Qn8DSttA3QKVNyFrx1NfmlB
	50G+C9qhvv1M7Z0u/g7VrVGDbzv+khCevCEnnZLziX9+y6hgpqhE85nIQSLpdxKZPVXQ==
X-Received: by 2002:a05:6808:a550:20b0:4b9:e6ab:d089 with SMTP id 5614622812f47-4b9e6abd678mr3315635b6e.41.1788559880038;
        Fri, 04 Sep 2026 15:11:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4324:3ccf:e2bf:d545])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1ff95sm3187113b6e.6.2026.09.04.15.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:11:19 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 17:09:50 -0500
Subject: [PATCH v2 05/10] iio: ABI: add sysfs attribute for _burnoutraw
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-iio-adc-ti-ads112c14-filter-support-v2-5-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=GJPVs2NQci4j2hQP0V6E0YPPvN8JlhkXSX7vksZ1gUg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqm0HR8vc0nLpD3rmWBwQsDtQqjue9MwC8svTxx
 o2vIkzgsUeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaptB0QAKCRDCzCAB/wGP
 wM8zCACV0PFxMXpRibNU/88tMO13HOkj5mrxhXGkWH3OiiSeNwFDsR8IOgbMKetmaRXALi5u4a9
 1uy5YOQ7A3c5stUkBq+IIM5MSGPC4moal/yuvheoHlbikiw8qS6tn2mgV4HM4D/xi8KHTtJnbMB
 JuXtV2cnuV+yT9RW68F8S4ktiLYa1ECdqJBxBGIwwOHM9A7Qxg+uX770EZHhXlqE3QxlYNdOYlM
 Wcq78ExR6GiaMaOInO3xnwUu3cnaL9fghW8dw/WAkj4ZFvSJXu1NoOAfz0uIsFjknlnxbzKn/Yo
 l63HNX+vWbVmn/WgvY8i4SWKfa//8L3WMjWIMdLEh2NOOZh2
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

