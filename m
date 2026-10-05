Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540949B5CC
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208977; cv=none; b=snK6tuo8kqorkYaaxgh4s2s92sK7iXqI1UFvsE4Y2TQRlNuWtwOWnLVRarTpX3qLY7RhLSvYP39ynN2ph6zOH3UtLHHhFtIn47HLezeS070aN8O2mpgbP+q/iT1snpnvu3OcUxCoTH4plzod0Tm5DLkuhZrY9XnKek2W4HKkTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208977; c=relaxed/simple;
	bh=f58Keg7a5kVB9OlAfVBDqD+fiMMWBO8vgSKBr4jApL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kE30DU3EQeQTMM1baNKo9sLOMxVnZ2XgplfdxD+27nSm8lsx77IwJIHX/Ec65gUzUTGm36rCRL+/BvIzHQu3qqkJbMRmySzYVGj9NupBOoFidM/SfCJKU2cHN192Z6os4mr1yPf3LTRx2CxBQZmMLlBaPm20f0iHrT3eXJtDHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=0WqdpdI8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="0WqdpdI8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso15493615e9.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208974; x=1791813774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BD6Yq/3o0OLJRpcfZaMdRAV3LFVZk0ziQSXXEEMncUU=;
        b=0WqdpdI8l2M+gy7zPnwGx6Mr69gBD+Xk356dSpTwvvosE9Gb2ULmAO643IYQ//VH8h
         bYlmbouce2skGU28IYuCUaGqEECmtA137xeTaaoQGpBwpIMHNr0zoMBTNfjehLBUptpG
         cH9YsrpQATyKfYXkkVLoP1cxrhY7ccKWRCI+CgT5AwJVIem5TWSQD2z5LUOjLBPqRrVj
         RROZgCvZgr2NembPpVSJdiKHxQFNO7wFQcbVUjlct37X23aEzy+IRnPfGzrYfIh7bfB8
         8Uv2nm8h6wQP6BCQmv4HUxS4Ofs5zuBMJ18FRLPaP6YG8MHHyNzQ0cjim9fNO9dRI+Zp
         OEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208974; x=1791813774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BD6Yq/3o0OLJRpcfZaMdRAV3LFVZk0ziQSXXEEMncUU=;
        b=VN3fQqHTt9Akz9P0wYnPicy76FGGZWAF13Unw9YY2cAbADemPXM8RfUjNX1saX+l4B
         N4bYVUtgXSi5Pdezf00lAbAdzJKDvLGiakZ13LKYuxSSl+447aDdsJBdQevT37xnQX3o
         rLCnstU9DTESTDs6zZ76Q5afrAtYXIpFNIXnGuWpteJiRPXFBhXFAed1/O5w/aVpyR/M
         n4SaYpx/2KVPDrUz1pXzM6gyxTCXdgCsBVYqYz9t4CaSnTls7CWGRMcdG3bPPE8kEF6N
         5jVthR1aD8m4RpGM25ATnw86+y3Gti60R2HqUpc3RZUoDEWbS3GUlY0XL9Oso4dbNOxK
         NyWw==
X-Forwarded-Encrypted: i=1; AKwUvBxzIzRGVzxHFdc05cZpF7/IycFkYUwpvsU2snI5ECk65jRvULjRqnQSoxL1ZoVg/T2wjwHIo0RXO94=@vger.kernel.org
X-Gm-Message-State: AFuF++lHCmHEJgw4eT5pyhTXLpGWQanwEnsuuR+ufk/8aE8aqzpu5IgW
	w5iA6sexbud4xChjpNwXNrjMpBT/dykjQ/ntA245f+4zlKAwVWBTCmPPVcXZ3C7RLLg=
X-Gm-Gg: AYBFou1QmTUGKStJy1odrL2GwMjSvkAloDmES7WvwpJBT+gd3fy9Vrs7KH1btPbm+DG
	DcG2SUsX/FqHLWV1DbsdlGcDD2MN/ZoYaLwR4boT40PoMX5fP2E/fWlZXfdhp6GuHnOaXJxoc8L
	LTG42NPzEktx3CUx4fHph97ah7nLtViFU7ngsZyfriO9gUAVsDhmAUQ1QpuRUJ9MvykVDO+Iy5B
	8tEHFu63Jh2TXwY8gXfMsQbCxFL24vXCbd9MikgUG2EqCukeSlbjNbIz8KF5sAv3E8qVljWqRXQ
	g5IB1Cmje9oKKY/DoKfn8coP4mVsPbtCsaeZrg+3zKZaup4cddI/JefNv8eTSRa4URQ2h5/bEQR
	Px1EnuoHC0NYizJIFSni1sUQUIjCLvopaGYVXli+bs8DJS9aO9fVxJca2gWisT3KAZCc/TEMVLs
	4ok6wfR72W70ZssR9+Kwry+3eNPk8Ptg8EtD8hr1wDZQS/9xcrHuyZitK8chjEDg0OtFji9R22B
	KVvurMIDVzQzA==
X-Received: by 2002:a05:600c:4f4b:b0:4a1:6dca:51e3 with SMTP id 5b1f17b1804b1-4a16dca51eamr105862775e9.3.1791208974197;
        Mon, 05 Oct 2026 07:02:54 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:53 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:02:05 +0100
Subject: [PATCH 09/12] iio: potentiometer: max5487: use named initializers
 for acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-9-2796f713945a@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=1017;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=f58Keg7a5kVB9OlAfVBDqD+fiMMWBO8vgSKBr4jApL4=;
 b=DA3sSVcKo/WFpLSYhZ9czfdAZf7ap9SF7XaJwnMvSAC+5G20VFHM4AEp5IbBghRAQgMzzYgGM
 v0lnabHO1CdDsFKOcnHGvy8P3lKJJvL44E9Igo0qHW5JHP9IA5ahovt
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/potentiometer/max5487.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
index 1f0d0056f412..d1eb0309d123 100644
--- a/drivers/iio/potentiometer/max5487.c
+++ b/drivers/iio/potentiometer/max5487.c
@@ -133,9 +133,9 @@ static const struct spi_device_id max5487_id[] = {
 MODULE_DEVICE_TABLE(spi, max5487_id);
 
 static const struct acpi_device_id max5487_acpi_match[] = {
-	{ "MAX5487", 10 },
-	{ "MAX5488", 50 },
-	{ "MAX5489", 100 },
+	{ .id = "MAX5487", .driver_data = 10 },
+	{ .id = "MAX5488", .driver_data = 50 },
+	{ .id = "MAX5489", .driver_data = 100 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, max5487_acpi_match);

-- 
2.53.0

