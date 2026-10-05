Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD9496D34
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208972; cv=none; b=H10XCKXeECU/d90fAbpfGSN55A6IcWnVASCcxGLy6uvB3HLJAOqwRbIuFmAOJLkWZJCfrmWPv/CnJCDqipF4UN1gXweGg0P+CG33wcMcGqvUWRO3XGFs9lLU26r2V+/yQNxalcTCoX+7pQD2OA3kjs/tlY90HfiLBUeHpSiZuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208972; c=relaxed/simple;
	bh=+eIdFQGujeAk7EsZ4toE8ZIpbEW9KfEh6uQCbQzHc7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0FtW8SZgVho8Je0HvOP4xKqEBT2Q0AABb0QSovCHrnVDrdITRz6l/PHgIOGNf0FrwIykb5D7LFivE55LOEwRr2e9UjKS13N1tffCfZwhKknZOXr80FvA69+RhqIwro2TYAzDPm8DcLXifGCvx8adujBXKUXPwLXgbTma+utq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=mvXHQhOZ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="mvXHQhOZ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso10598865e9.2
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208966; x=1791813766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkNKKOXr/p1BVwzQGdB5FcUA+YuUVaqEOoZvmlHjUWo=;
        b=mvXHQhOZZqL1AYEkqSxpUVcOJABdXW5FNJadH/U85IUsKvZmyNlnZMEEKG1WOGiILy
         w41E9NdK1DHoxSkua7NhvbUjQ8tGhJiQodIzihvZDPgyuXELfAJvk8wt69zlhEglLthu
         1fdFwRYkhdC3g2+dP/Y87LB9CrABHA86yIoM3KTWMZifa8/dc/RggbIhQrL4/igCqsle
         8DaLKc8uveCBPYOrwlFBNyweUcFhqx3FKAQulsj9lkSi07HbmsrPvdvFhkN7je0zN14V
         JYiWlxLqWNmRgGXZaT3j/b1qJaV5g4CIifU9/r7K9IhdP7RlxIIkoIdPQER4zcRq+evp
         DiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208966; x=1791813766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkNKKOXr/p1BVwzQGdB5FcUA+YuUVaqEOoZvmlHjUWo=;
        b=UyHyp6bHGeMIJm+oq4bywonHppY1/xR/tb0fZkuNS9NAYVYwYt/p95IOE/oC5u4tFu
         JIpNgbMlP/Uy/oNDTd6ooh4EndU7J0szh8xb9XDt4FLWnKhiw5vuSt043Ago4gzgSdHi
         Ravqifi7hYQow2KWKAaO4XWCti4AB/XpTIUiochdFoVR4yG6ZyMLur3bFoeEkh6q1Yf0
         L9J/k7sVbdZXYaeUYSpQWWN/7UMInyHz2kT+6NAI7JZ8DgOgTLWzKAWTQjLIEj2dDTK7
         ZZGXhy+2SURhg9pRF6WwbKN+tEZxyg2YTYVqlrKt6ME5GbOawjXPTi6nFpSwFxK7vCDP
         DA/Q==
X-Forwarded-Encrypted: i=1; AKwUvBx6WBwL/MYsJazMJh3ebN/uHGnuFR/cjAY88RjfjVKPPBphUQjfl+3hSwc1gT+mF7Foqs9wY12kpxc=@vger.kernel.org
X-Gm-Message-State: AFuF++l/0qfA1KjmCdJ60VlRLwAw14HX5WhcAlMmS/dERPArFldvhdlE
	F/Opj43Q7tyCftcH0Sw092dKg30xCNlAv3Th1VD/Whd9FbNjPnwxgiBgBBJE4F0JTvg=
X-Gm-Gg: AYBFou0vDhkPmVxpNqxSyYwuAjyZTDNZn7/kVfXxMWW8zb/Q6x07sFR/eeL7SfmgmVr
	L++ANRJySgD1dHIh5KN/YdwXdu5A8KLAC/SkpzYUtQMCvaq6/X/sr8j/pQKuf+QWbSeSPpNobkR
	cKRVwQy5bDD7ii6GRDE6/+DiCZwJbqGUVMVWrHI04aScIC6ZzmnU9gVxClNZQ3raIJMBPwv5k6k
	rlUrVfCtQmAPgztg+f2PovYh4jH12RSVNMpJ4tfH62sZXTCRJhxkAfy1nsuPvXVALj5WtSBteIZ
	u8it0JJu4nmmfgodJspyq72Ncd5weEG7J6sq71xMiANEqSGjC9+xnmoDk83PzZOP/dGkXSLGUwQ
	UdjgWs2tHQ92mqumSP2XahxU/FVGrmauC3iXMoRYDNlkDZ+4la19EFUew1P1p9J8xUQEEO8szkd
	MzcxmShN14jvkbCPX0QnN+lvPWsD/dTUXKARCmBABTSKaciy0AvANF+Tej6AeYPdbkZ3K9rxtBl
	8VlstbDv4zdq2pXejj0I5yJ
X-Received: by 2002:a05:600c:6212:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a0275432f7mr170039935e9.9.1791208966464;
        Mon, 05 Oct 2026 07:02:46 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:46 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:02:00 +0100
Subject: [PATCH 04/12] iio: gyro: bmg160_i2c: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-4-2796f713945a@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=813;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=+eIdFQGujeAk7EsZ4toE8ZIpbEW9KfEh6uQCbQzHc7c=;
 b=OftuUn60HBnkz6FP7ud92U3gDinybTTUMLfjIrV6j7ukuBXsEzoawStXJGDRXSXhFilLuqnmg
 PEVKUbGAFzxA9d6ncAkJk6Smwa5lVU2Cgv9caNI9PDY0Ynd3eYHI5Oe
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/gyro/bmg160_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index be3cfbd286aa..e4ebd0318494 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -39,7 +39,7 @@ static void bmg160_i2c_remove(struct i2c_client *client)
 }
 
 static const struct acpi_device_id bmg160_acpi_match[] = {
-	{"BMG0160", 0},
+	{ .id = "BMG0160" },
 	{ }
 };
 

-- 
2.53.0

