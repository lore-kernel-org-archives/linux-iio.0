Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D249B5A1
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208989; cv=none; b=Olpj7Xlaukj7W7ypLnSB4CGckJ4Lc4mWige4DOKVXxsoF/a0MmipuolQpXro3bzYjlS8VXZzi1svcNMjCgcTJeTS9qorqh3Te2gC/k4k6j1fN0Gpd/F++NUOABYdybsv5lg52B5MVXNI0sNMjjk8Dcnxj9lpcIbEJfdhJUSjPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208989; c=relaxed/simple;
	bh=JjrYGntgpkHCX5paNkOYn8McUGlNbiymDVupgnjvCEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAeLYX4fqtLSzpRIutrKKyH8fEFnp1AJns+p/tl9eE1erRHNhcoaKLKl7vBX8QQHTN7QQ3pscYvHMRM7vHg1JXdp6FQi0Ot4Uk84MftbAoc1u3fM27K80N4yGhat0llaoZqq63HxrOZGndQHixE4XtJ2Blu1R+IGzlBBOZugyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=ZUTbJTjw; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="ZUTbJTjw"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso10600595e9.2
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208978; x=1791813778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wSBauqB5zF5k0g2pWKRs8w0XmZ/Qu8eAdzzpkSZQ1Wc=;
        b=ZUTbJTjwi8YgYCyJ0vSQZojjwV7R3v1dGQL0H46J3T6D3+ZzfWvL1Riv531tmmQ3O9
         tCmzxmoH30t4cuKplWDAhc3CYKdia0/ulp7F5KoqA7RQkb6OlAxIjt5ImKFNz2GomiII
         /xkqFYSfrP2IKldnzn+vOpsjyddPp1fq2+F1a2A2cbOAw1tB7CE9d9oDypc9K4O947i1
         nr3lbcisFaOIc3WKPVXh/3M6CuR/c/Ve/1NXprWdwLdiSMcjIjLhVcgkzimyhCttymTD
         UFwvjpKyr4OEIusWFrtxwgnv4c0CeAs6H9tDUlLq2kR5DQitmQRMA86SGIYntqL36NsK
         pybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208978; x=1791813778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wSBauqB5zF5k0g2pWKRs8w0XmZ/Qu8eAdzzpkSZQ1Wc=;
        b=FPBrgrjG+lyCNad4pc/qJR43FoQFr7FBoUuQhKwrpi4lp3llvFDZKWKeKZtN72GBod
         Yan0o0nSb5jHoHLGaOYjOfkmZs/vQwq8h+So3Am8H18CB9DfUJBdUHhgHhjG+ZrqCgeo
         8d94gHpERRYbfEcvY9vfiEhHk7ed7hQFqQKDCmwnBM5ODQyhL2vFzf+Dwo6SfxcA7snz
         trRcDxshJwr34zNev+UzgSCABjJEsbzJ2AGdjJXooxWrRcaTdHEXxfrgmO5y5+TaHQ9H
         NEjUbk6e+ysroLpAFkfRB2LT6WVf/wcLFqfU614QIu6YjjJ4RIu5u+Dt1T2g55IDfIlE
         Ssqw==
X-Forwarded-Encrypted: i=1; AKwUvBx1WrsaLRfDDORJXgI12HmmbqxmX3jhV0Rx8gZWJFcxV0KNKzmSzYCV5aehKFttuZ4Pgx9bgOr78FI=@vger.kernel.org
X-Gm-Message-State: AFuF++nGKQkY5pOsg/yY6JuscprUT7GK4zW0TXxICL5COXwB8HbiXqiO
	h0j60duDm2tU/mee4qPkNgfj71iU4iScyqZ4Qf8l223RexccUDJb52AUGbzsiMwWEAw=
X-Gm-Gg: AYBFou2milbhl3JpvxfPD4r/s2+I/Mc+SjNXviFCxaVmglcugyyPbEST1qfaytWUgcu
	ZAoOvB1h0VD4I366RM/KN3cxS1W2bYWNOV60y/ppSgyEZ1ILOdXcryhDNGUyl8dGGmdR9GryLTD
	a7Y+0o2Izm1vDOOLSCT0qHkfTGSQS5d1+jndFaTXU7KFsbRO+JSv7kwhMvWbuxajSoVdqkwy48v
	nqgdpeNrLFMds2CIZf2yeB3hOgrn3TtWBqwD265vIdxNpGpOJm1z+J1D+No0b2VREO8kTuzo1mK
	yxMy1d/kUL15Mb5S/hTQ9Kz1IA8fK1yfr0o6i0kChmF+h3v+O3AiCNmof2t2rMgtDl2XAWeDBOj
	/HJqiC8YDO5jlGPjZVImPXiT8AfbPs4qBMwgJXrdXx94ud4oQrNlu8gWmRgTbcU5Q96NkKu5XUh
	AxoTEIOCYxJo+cxZj/s7EaYstOd+naV/wUOyXiRNtcGodFMde8ues2RZWXd4bOUkS9U+t2ee4fS
	WzDyZjUbLXCiA==
X-Received: by 2002:a05:600c:e557:10b0:4a0:2484:2800 with SMTP id 5b1f17b1804b1-4a0274f40d0mr121299315e9.3.1791208978225;
        Mon, 05 Oct 2026 07:02:58 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:56 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:02:07 +0100
Subject: [PATCH 11/12] iio: proximity: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-11-2796f713945a@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=1651;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=JjrYGntgpkHCX5paNkOYn8McUGlNbiymDVupgnjvCEw=;
 b=D7SXQcDe48iBcUBMBWwek43+A5JkmUQIi1NBul7YToWoafZT80IByGHlmmRoRCI3NrgcxpQnj
 tmMbqv2fpO5BqCSxoLRbsaDDT3CsoTAjmuOS5xerdbxR0mawn8uiOj9
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/proximity/sx9310.c | 4 ++--
 drivers/iio/proximity/sx9500.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..8c197973479a 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -992,8 +992,8 @@ static const struct sx931x_info sx9311_info = {
 };
 
 static const struct acpi_device_id sx9310_acpi_match[] = {
-	{ "STH9310", (kernel_ulong_t)&sx9310_info },
-	{ "STH9311", (kernel_ulong_t)&sx9311_info },
+	{ .id = "STH9310", .driver_data = (kernel_ulong_t)&sx9310_info },
+	{ .id = "STH9311", .driver_data = (kernel_ulong_t)&sx9311_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index dadce9b44227..cd67d88d2be4 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1012,8 +1012,8 @@ static int sx9500_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9500_pm_ops, sx9500_suspend, sx9500_resume);
 
 static const struct acpi_device_id sx9500_acpi_match[] = {
-	{"SSX9500", 0},
-	{"SASX9500", 0},
+	{ .id = "SSX9500" },
+	{ .id = "SASX9500" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);

-- 
2.53.0

