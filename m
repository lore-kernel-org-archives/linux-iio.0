Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295C4AE111
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642911; cv=none; b=jIK2u9lqgtnU4eZPoW2rHznTG5TfX4+Aw5nZwJuEtMdQUwuPAL7qi6I/joiDSulwc2I5vBe5hyOn/d+UXaL/mlDNPDz7IIvbh8XvmvySVujUrk2OMQoPqa4sbPgA6e5/GX4JTNea67dFpxLmUIuYNCdqaspuekkObCSf67DYIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642911; c=relaxed/simple;
	bh=9yyK8gFu2iFYnkKJilPYF+Qy0O6mQZtjh/5coK3RdvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+05EEsb82oFZhcyKNMcV8FdbxnMcbAO5jY1LDQKMJ7HIpDZEBAEOQWGyvFxc3XAi89WAFh+wNzujwB3p39a9Up6xyFOrb9fDkIT/yDJ+JvACwd6wEtigbSmbIMqVwtzGldQGPP478KF0iSI9JXRlduKuF3cBb+tEK8j7oPDax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/NFfeEv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/NFfeEv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so5025585e9.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789642897; x=1790247697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tA6dVTMdNd1u4g6Gp9FhEdnm3luzFoberRSekZW39k=;
        b=m/NFfeEvqamBM+AJk4PEI7Meq/3tJuvtz1eGUcs8izgv8msHKyoEnVrDv7T23p7o8+
         nOT//1r6wsHX4u92eczzrzfnxcIqA5Qd0uJY7UvBoNuj5eDBYsOCNu3obZsJWV4NAZWz
         roLI0ZAGL77XfUL1OeHxmOwraZM8rWBhILJpFWGJkImuzTf4dDDrBbF31NQ/+lQR2UON
         gzm3BslH594PNWYAvX7CuyWNka72l92h0WO5qC8ITfmnIdQEYgwHsoZ4BhjtopGi3a1k
         7dbyM2IMw1Uqdueuz+THTnON9iztUBeXDdWF3z6PNtJ07e2HSeZMZldOQJOERz+BMIk6
         CF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642897; x=1790247697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tA6dVTMdNd1u4g6Gp9FhEdnm3luzFoberRSekZW39k=;
        b=IhV4OryKox4NOgExG3EQI/Trt0V1y2LVsiCXzJDiTZize3+lHrrGPy6harcmfrvegl
         6IuDXRHGpC2v83KceKpDJM4xFnr5Qyz90kuxAuk1DkXNr6zOsL7DQSns/h4htVIHlmgc
         J1VI3Y8UWy918PZWcwhgxayfNLhGhZItm1Vs24+fkbjp0sUms/hY9yUFfbBqV50I4Gil
         Fvm3qDXjljDvKK6XSSfvZzCafvneTcKzN2CImOnrtCzFkdzlHCWuwq0E8Kj6cF2ticJA
         kubgco7XCozknOZ1eGIerCkvtBjY4p+F3f32DVRucDTxOjJFHllD9XtvCzpzisdOOOoM
         +LPQ==
X-Gm-Message-State: AFuF++kz3OWG1WiJy2taS4MVhSJS/K47kL8DixR4g/NsbZzXzv11PntS
	E8W+7sHs8Vj8zHQxVmQKCuE5tUjZbYuuwO4Sha/VWcyCyMUM4izBJz1L
X-Gm-Gg: AYBFou2ZjFH22MBct8D6PskLlO+ZAhBSkFqlrvPnk2Y4bs8gP65tCv2pAua3QUqQCIy
	/ONCFEM9RB0AqjFEreyDJkvmgwdWKDzdVmPgzqmy+OzmxLwAgQsUKkjWLSvPj+Z18KvgDlk4wl8
	5I+xcLgkHua8nfUiCIfvlDI61OLXTeVah4R0wy6VcBDy8F8YY7jZ2CfYAArsCr//OI5yAtayZdG
	K7PMW30B9Jw1N4BpiT/bjGoSPmdndha4N1rfAXpf9gJtLU6OiojgcitI+ndM1+nzYkMDOF09uT5
	cNvN1sOfJsDwK4+dsrHHsMcG/mIFW/WNpayg9Bih/RzNIotsr1e+ZM6ndYYKIhP/N4Isyg62zPr
	5xcBH7tWrKCcf3IjaC3B+Pa3wPIWd/5fNIEMWn7wFKZ3WynKcMyqkXBtQsEEfEwwCs7+9uufRnV
	6/BCf1An1wdn1vt3M71FQBusCDAbdI2w5vvudfRQpfr2K0iSWuM3952tsTKaZhBndLnHTazAT+o
	i+fIzWDcHqeu27c2EQVR/c=
X-Received: by 2002:a05:600d:8498:10b0:49e:6ac4:b76e with SMTP id 5b1f17b1804b1-49ec0543cf1mr54709135e9.30.1789642896333;
        Thu, 17 Sep 2026 04:01:36 -0700 (PDT)
Received: from localhost.localdomain ([196.235.229.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd32c5e1sm95898095e9.5.2026.09.17.04.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:01:34 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: temperature: mlx90614: Fix dual channel probe condition check
Date: Thu, 17 Sep 2026 12:01:20 +0100
Message-ID: <20260917110121.631587-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mlx90614_probe_num_ir_sensors(), the check on chip_info->dual_channel
is inverted.

Currently, if dual_channel is true (MLX90614), the function returns 0
immediately without checking op_eeprom_config1. This forces all MLX90614
devices to be registered as single sensor (num_channels = 2), making the
second object temperature channel inaccessible.

Conversely, if dual_channel is false (MLX90615), the function skips the
early return and performs an unnecessary SMBus read on EEPROM CONFIG1 even
though MLX90615 does not support dual channel operation.

Fix this by negating the condition so that single-channel chips return
early with 0, while dual-channel capable chips (MLX90614) proceed to read
the EEPROM configuration register to detect whether 1 or 2 object channels
are present.

Fixes: 3d5ead238bc8 ("iio: mlx90614: Factor our register IO and constants into model specific descriptor")
Assisted-by: LLM
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/temperature/mlx90614.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 27d6ab5f5d7a..4f79da1f905e 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -565,7 +565,7 @@ static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
 	const struct mlx_chip_info *chip_info = data->chip_info;
 	s32 ret;
 
-	if (chip_info->dual_channel)
+	if (!chip_info->dual_channel)
 		return 0;
 
 	ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
-- 
2.43.0

