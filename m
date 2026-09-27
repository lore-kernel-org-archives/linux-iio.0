Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B2361DAB
	for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546803; cv=none; b=PQRUY++0nM2PJQWQXPJQ0VBZFTY2CsfSDJ5GyRyxKf45bFlMdrUrQWSc9Mg/tAPDhAHtB6W5TS/goZzDJeh65owHHMFnoblu1mtHWRI2zovAtIFxZtnn9HzG3v+6DOnxRzNtNICvKNvSaX7svH0b1eQ5T5npFSQKoAnJ+AfT0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546803; c=relaxed/simple;
	bh=f1aluKtGhtyCkJUJPoTQNC9FdiG9ehY6s0isdzn8KnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uanqzr4xlsnxk2kZ2co1USYEhyUFZeJgEeKlw/Ajtf1VGQrPUMpX3PYaHT2UGd4jmmmw0iSG1fzbcutLuOwr6xnioLLroCIRhXlyUFuYbnVAUYcabxvZ10ByhPqHMJLfBb6XgSt0NVZCLCmjzbMOoygfjyQYA3FD3HWZk668//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRL2oRB2; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRL2oRB2"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5a24e868so165209985a.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546795; x=1791151595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GhKzOiaWtqNWwtP31kKM5/1eWEN7caNKyT11TpSUIXA=;
        b=eRL2oRB2aXUromfmdbeZdRCWdUZnXowuhH4fgiFo4pudQV9sbJPcFmUAAD+SUEr6yq
         hnclbfapElrCRtNEOW42ItejvEyJrSlnzZa3r/igMV5iiRGYrYbgRAZ/R+oNSWlxGu8F
         bmKyVb/Dq9c+un7Yj2RmxcMxilGk7uaaGfCFNcRf7UfH98thPhEWHk0KZ1QWbv4FsdaZ
         Y7enO6RNi82NyrDwaxQxVLSu/QULhQbc4arJA71zW4/d1RhvPXvLltf/PRK2G562xKWM
         +//WZPfwR5gvRDse5Ojh1xX2t8ZRaSFoTvKWKGGOTTAa3XfJ3w4Yx0+VADOIRAH93PBE
         Yhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546795; x=1791151595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GhKzOiaWtqNWwtP31kKM5/1eWEN7caNKyT11TpSUIXA=;
        b=Mfe6rmYP6JIob1fEtxGVlIfK/uFGhLUmrDfdrwk1nCyLejwk08S5gnn+2kBbkbTgSA
         vFMs9FMJpStHQovpsuczc5sHuCtE36tT9pnFIoD6h+92XtBDNWekubzPUQdmXlKvgPcx
         6qhuFsZn23EOmpA3e6ru6nOYCXptO4eGdVQQOrz8Mjt3IO0YF0vuOegsf1rEhuvFGSOA
         LztBbYcEFwAKJzWTcyXbI0f1pC/UjdEsyWT/3brxuBdeRrQsxNcNsOTj3nenmN0+5H+r
         YNpLU7hI/0xQkQT+PS7CIRIKJtYXIfnN2fEt4dyhdhj56w4cazQTFKgEGMl9kCbhpbPo
         PqNA==
X-Forwarded-Encrypted: i=1; AKwUvBxkn0/6vx0PIwAnNJyhLMNtixMWdnHTXzMtZ4hZRixm7n4c1xzd6Sskfi8ByauX16pNUfVmBshFp4g=@vger.kernel.org
X-Gm-Message-State: AFuF++m+XWTAGhN7O0fP04MNUCLPTo+3d6K3hXHMj2bWd/CXe2JL0qZq
	JQMqefWG41qNz2tuoku58R6U/oSiZIWTxo/A3XqLvhWCSB/alviUy7cd8u18neYn
X-Gm-Gg: AYBFou3O4qWT4jcO2sg+wnQLDdnkvI7nS/sL8I8ackfXK582BoO4tIcvX90pQNMeKXK
	/bJVbU/A55X2Lb0Fmqbbnp46vfeoy7uo2evUFUac0fEqJ+JKzJsRMzaPNzhpMGiTCM2mdn+UjV2
	pufkW3wXYSSTfmRyOwAxSu/5P85GELa1gEZbv8akU/uBQQixF6NbBrBhYKiIiE9OB30GQwlgbas
	7x03NBU4Q8j0/xMttpzA8GqWcoyHfplW8I090mBpG02xYlLTNborjBS6+3w7jD974HoEDLKh0Jq
	L9RmwC6trtrUHekg7lrbZyEYC6wOajbT0mTwiH/k4PbkvcwPSzDhz06yFoC5asP/RziomTeXYMq
	qJmHp8uPvYz+VFDnUo5uXLwgH9pPpztmJBdJDc5B8f2qhPE9Ku3WRSJ0EP6h+Gq0w+NvzPaR2/U
	+Bvdh9a/pr0aatL86t/c29Q1jqpzztqQ6/Pgx3pnM1jC/s8rJa5hEWodMlgE48k6LCz0bE/VLYz
	SLV9KLtVR3j/oPIfpls+cfth5h5zyje5OZBBXXchaVQM9/ze6pDf9NFRTgZceFgNSSY0k0bb1FE
	9EGH7mU=
X-Received: by 2002:a05:620a:294e:b0:93c:6d02:9d0f with SMTP id af79cd13be357-93c6d02a148mr570784085a.31.1790546795147;
        Sun, 27 Sep 2026 15:06:35 -0700 (PDT)
Received: from cachyos-SlimIce.lan (1841343-static.dvnpiaaa.metronetinc.net. [195.252.229.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c44972febsm708092385a.39.2026.09.27.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:06:34 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	Jared Wuerzburger <jwuerz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 1/2] iio: imu: st_lsm6dsx: Drop trailing comma in ACPI match table entries
Date: Sun, 27 Sep 2026 17:05:58 -0500
Message-ID: <20260927220559.24169-2-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927220559.24169-1-jwuerz@gmail.com>
References: <20260927220559.24169-1-jwuerz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trailing comma after the last member of an initializer is only
useful when more members may follow, which is never the case for an
acpi_device_id entry. Drop it, as suggested during review of an earlier
version of the next patch.

Link: https://lore.kernel.org/linux-iio/aVFmec8JA6ZX18il@smile.fi.intel.com/
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index edec898cb..fbf4e4ecc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -143,8 +143,8 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
-	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
-	{ "SMOCF00", ST_LSM6DSO_ID, },
+	{ "SMO8B30", ST_LSM6DS3TRC_ID },
+	{ "SMOCF00", ST_LSM6DSO_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
-- 
2.55.0

