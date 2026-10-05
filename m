Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4F49B1FB
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208976; cv=none; b=Xqavmg3K9Ouk6uRD1KLjaRQpvCFhUy2ac5d3elflrE91XnWsh4rikMQ3UsfEz0w7+bWH9CecZSikwLLVAcOhYtGCQEx233EiU/x5TJSrtBCoFX76KkN0oU+aHiQ8SmMB8zWqh4Qo7CbYtQnZpHmFZfS0Q3SGTOm2QG4TFamgn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208976; c=relaxed/simple;
	bh=TaUlnsNmot4QEG9OLZHJSxsD2VX/SRZI3DsjCT3rfFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzmPh9RY2kzcW4HHA1UI1TWV6Z/0DsZmVgYCJQwx31PAM87nOlpIiF+/KsM8eInSg81oRHsiY8kr0dNBvfCyu3n2jJFPl/xJmSgmutR4BU48OI6Wl6lOQmnNdua1DqrOwm5t8Z+Gi97VnVVdbnXy/jAZHjB6QokuRj1ypUYY648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=a2Ff+tz1; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="a2Ff+tz1"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so634072f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208972; x=1791813772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=41MKH5PbBP4B9ab/ikgvLUqJHlYFMp6f2rCdzsjxlhA=;
        b=a2Ff+tz1zxQVrrq7YGKkQZuIJRK/glOYTvc11EI4ycDSCxWvfMG2oscbhlGTW7Jc0g
         TtdiQEwHmznJJWYCHowKJoC0QF58jtkZD/R3zWAPbmmtC9W+Orobsmohp9IWpO9f5NDS
         YRtc+Wx07RBBL9HsAZgdx8RNspFRajg8Se7OpW+W0elokiG6q1aAL/nd5xSOfQCQ9lYI
         q0pjv/NTxJuQpoQzZzF5+Xazuzo8Kh5y5aODHEEbOeL4UhPYtRZ6rXT5F+J96/2Bxk8O
         KEJoLuG8DZcDWsHMQd14lThevq0qu72nF6Avb+og6s6XR5GO4mKLwcbC2ypfYKCMmEEn
         sIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208972; x=1791813772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41MKH5PbBP4B9ab/ikgvLUqJHlYFMp6f2rCdzsjxlhA=;
        b=Kg6ScAP6Wm6WRAXCpFi9bgLcVlOaO+juANuOHVb3mWbyelNPkDQsi+NP9qGekkAm1b
         jT2cGmGW7oG/GoasQvhiIFnuZ9aOWt1GARboPH5ouF8/1sR8ECACwVURBtn75rzT8Zmw
         mS+r+y0T1XxyV2eNzxjPi8OuPvPzi1krbxQg7k9iOAmmfQl1nLW9RxzQFumDUnXgpeKo
         6HfInyReP4a2wezxaoqf6Zrzj1vS/CED3UGx+ba3o25byKHUG0S6D1g9t18hOTQrCNpY
         0HaknceXgXEVj0XLMyJp+XskM7lEvqgy0nZZw41oTGtfM8qgV53wPRwfKyGsbl3KaNdt
         tvTg==
X-Forwarded-Encrypted: i=1; AKwUvBxx7/z9jXBQhg9TTwOmRb0YGoyNzkL+6GLoDNNPUrLCggl1PZ4Tu8d/eHIF7Y6Aq4U+g4K2JKcUmmc=@vger.kernel.org
X-Gm-Message-State: AFuF++keoA/mcIAUeFVjj3241Uk74F5IPkwPHPBwQV3iF2zEJiQObGqj
	7ec5ifZvCNojHOetVvy0l7O/ux+n8StSd3r2KLtqF3xCjidTDyk6LZIasts8VQxPyzY=
X-Gm-Gg: AYBFou1HckIEXy48OpgwMiSNAhlu0EgTz8y9qh0EKw+7wLAUbtx132LLfpTYdO+323j
	lNiJkZhBDhdHU1ZGDqkyMab8fulmcwFUASHUAmvqqDUSrwXK8w1ajpUuTtfLxNfOSHbLoi+JLKb
	FdW0MaEFeKrBYtE6U5KE7YciYLd6sgWlxWmMd7DTaIwNXZ3Rb/ZR3xUdJ81W+E/OOamPxOuGq7x
	ZBoxitZYdE2Ltd3p1nc5K0L3BhJRl7uvGTckF50wLZwIuQT1wJKOVdDnxmd3zBNXouaNpU3tACq
	ZuoROngbu/WecKkAFKzl2wVJgI3I/xQG9rrKvqVmSAhoJFV3HLoRehdK1Qfd3ko3gqgzilBMabX
	cK6+Lf9rhfPxNlGQWAzMVeVeBjqwoEm9eiNHIX61UKpCZ2eBu7n5iTk8T+BHp1XTpg/4l5Mf/Vq
	z5JIkyCjRBR1o35GuEIHn4XIGE1IXVDiF7sM2K1U/wV5A2HyXDOq2bcfEThiEVghQcXIN2JNRHf
	ZbxaieA3lEY2Q==
X-Received: by 2002:a05:600c:4515:b0:4a1:71bd:c929 with SMTP id 5b1f17b1804b1-4a171bdc95emr59780935e9.4.1791208972036;
        Mon, 05 Oct 2026 07:02:52 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:51 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:02:04 +0100
Subject: [PATCH 08/12] iio: magnetometer: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-8-2796f713945a@thegoodpenguin.co.uk>
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
In-Reply-To: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, Eddie James <eajames@linux.ibm.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=2407;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=TaUlnsNmot4QEG9OLZHJSxsD2VX/SRZI3DsjCT3rfFU=;
 b=YQdFb+/JBoI6Nt55MUjBq8kGTxLk5iI3bJYnBs4gb9hTvifSsYqvIAR1nhLyzO8tbSn34ikvN
 uLDBY6maJqzD2MxvU3vaCL6j8oZuunbY0SJ2DNbheFkuW3H6hrIKuA0
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/magnetometer/ak8975.c   | 14 +++++++-------
 drivers/iio/magnetometer/mmc35240.c |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 8b0c07f82602..1a829a9b91e4 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1119,13 +1119,13 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ak8975_dev_pm_ops, ak8975_runtime_suspend,
 				 ak8975_runtime_resume, NULL);
 
 static const struct acpi_device_id ak_acpi_match[] = {
-	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
-	{"AK8975", (kernel_ulong_t)&ak_def_array[AK8975] },
-	{"AK009911", (kernel_ulong_t)&ak_def_array[AK09911] },
-	{"AK09911", (kernel_ulong_t)&ak_def_array[AK09911] },
-	{"AK09912", (kernel_ulong_t)&ak_def_array[AK09912] },
-	{"AKM9911", (kernel_ulong_t)&ak_def_array[AK09911] },
-	{"INVN6500", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{ .id = "AK8963", .driver_data = (kernel_ulong_t)&ak_def_array[AK8963] },
+	{ .id = "AK8975", .driver_data = (kernel_ulong_t)&ak_def_array[AK8975] },
+	{ .id = "AK009911", .driver_data = (kernel_ulong_t)&ak_def_array[AK09911] },
+	{ .id = "AK09911", .driver_data = (kernel_ulong_t)&ak_def_array[AK09911] },
+	{ .id = "AK09912", .driver_data = (kernel_ulong_t)&ak_def_array[AK09912] },
+	{ .id = "AKM9911", .driver_data = (kernel_ulong_t)&ak_def_array[AK09911] },
+	{ .id = "INVN6500", .driver_data = (kernel_ulong_t)&ak_def_array[AK8963] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 6f40cba4b1ba..310058fe5c07 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -553,7 +553,7 @@ static const struct of_device_id mmc35240_of_match[] = {
 MODULE_DEVICE_TABLE(of, mmc35240_of_match);
 
 static const struct acpi_device_id mmc35240_acpi_match[] = {
-	{"MMC35240", 0},
+	{ .id = "MMC35240" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, mmc35240_acpi_match);

-- 
2.53.0

