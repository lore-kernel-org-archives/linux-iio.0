Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938206;
	b=Sr7YpMDZ5k1cGqyeduwzzYUmNAxRNcdpUVn3rEHunoH6OkTmqdzVQ0iqBf1nsH2JonzA
	 R7742UPRN/OndYffarVmebsJQbSNtrE41vH2QjtkY5RdgVfTTrW6KmMYHaEE7sRyBSkAr
	 psuFGL8dg85dw488Yx+bqlvtHJtn3unSOIEuO8ACee1uraJb3jhfhEMoBuIS0WuyvqZI5
	 BfcAcOqJhiMRGWQbBYggXpGe4tf1BlB3PV5Cp8lhiJkEXptY4n1ay6vbHxj7bTcn3ShJr
	 OAkeC7ijxBJS7NHz6MTGcq5niMSC/uNy2KeNU91gDLhqEDcTimgxDYjL+9dUAv1T84w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938206;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w7dFDkqDW/rIFGxkStx87/r7LXJ3QjdIRNRvmQ7tuZU=;
	b=KpR0WX8c3Yb22XDi2CO7VYYRrgK1Bd0o8XIHfinBLzTa/Nr7nke5xBeq/O41NdvPb/U0
	 zHwCHN9/N+Ss8XuLtzTzVMyIIsfbEEOcoMU43g/pdVoBSnZXElq9/DRNjDiFvY4J2osGV
	 QmN3/2VPAoTCs1jyLBpVKVxMg58DBFABgxo8usqX8H3R0OtpeFv2HlbB3lshFpyh2avNN
	 42P8lmoynCarP4MRcz0/ad5u6KFVyrAC1JFt0NrFm9hOeFUOvzcef3o21Ucoogw/egdNv
	 CpWngEpO4nUfp/Nm/3JjyeP5dG5mUTfcF/tApmk+uue0QCSS4CGmC4UkTLu9K7PK+eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0R2D1cv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F6606A331;
	Tue, 17 Nov 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0R2D1cv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938206;
	b=dntNh03HL9LtJdN2t4erm/9qPmLQF09TrDZrq9G30qiMz3rQl/8WU+LN35B0wPx3zfea
	 gKP5byWF4+gkdPQbqWJAA0d2uWVBe5wMWsv085h3m4MtB/E7+/FGzAvn4CP5a/b1TaGzq
	 +qe3byrDjwTTUhHCtEtFeRLGo4Pm0VvpJie9oTabPsqPbVHxrUTkz5O2OzGmtaBEKiKQZ
	 l2Xk2Cg6t3xB6rLiZUMtFB7+ZRCa8GLw6ZJNEISQRJNxFpH8uXPSrjTjY+3kuexxSMu8n
	 cpEkFL+OmSSkiHy7ZJ5j+OvbQxTXY+VfUWqlq905aGjYxclGHVUGhf6GOPwIZXTMlzg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938206;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w7dFDkqDW/rIFGxkStx87/r7LXJ3QjdIRNRvmQ7tuZU=;
	b=dRIXIhiz3xK9QKdRhcmenvOueLGFx6Nlgx4WRdBLY7py6VwiI0iQfpLTBJCsn4OSGrtY
	 46Tz9Q/2JlMUzap8H9YkmdOdvz4Lgkyg+z6wjlFnwvaWBKXw/kxxCI3M6KdR+0CTbSbJZ
	 walS4v/CnE5U6DTEFUG+HXnD90TLHrt29OPOD/H5Jo6zwZ91E2nXbsDHXZHnIORX1E2nJ
	 Ez5H9jLjnbIYKyQ4+4Sx1u/QHzCiVJ2Y1+k5qguOfUuPuvyd+2r41pD4fH5L9+3z+BOYB
	 vtISoQ+uK2ej7RTJUuH4pDphw30XI2djIuP0RmfEH8v0uM3AJ5SA7yE0p79pbsYU82w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 47B8F1F000C8;
	Tue, 17 Nov 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938206;
	bh=w7dFDkqDW/rIFGxkStx87/r7LXJ3QjdIRNRvmQ7tuZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E0R2D1cvShTyhYIhtf9KYGtg0tJriuM9nJqUAcY/CjG0oxROHAP5hYV0Keag2naOg
	 Cd5QsYmaW2NzuNkByx7MEsOg8uOlgINu4iqApMeHpCa15R6YXEtHHqkPfaAJW67yFO
	 sE7ugFlnS3sT0nfvVJTgv2c8rkt0Ogvrf1I0kDRgVZ09V9qYwDOYrikUIdzS+I8hml
	 IrH+Lksr8SbUW9+Flrp+s9sxLXeYAplvEcS6IMmZdDvxByhl/kyGG04NVAZSQxFiN8
	 v6m2skqHF9mCYVkpYcX9RA64RPsQXViXD2JTU2hZIm7IzD0LsdLlDErCdrSEgQzJhY
	 wmm6KbN3nt8Xw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B98A74AA22;
	Tue, 17 Nov 2026 17:56:44 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 17 Nov 2026 19:56:32 +0200
Subject: [PATCH v2 1/3] iio: adc: mt6359-auxadc: correct channel types to
 IIO_VOLTAGE
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-6768-6358-fixes-v2-1-1ffc3c2f3c80@protonmail.com>
References: <20261117-6768-6358-fixes-v2-0-1ffc3c2f3c80@protonmail.com>
In-Reply-To: <20261117-6768-6358-fixes-v2-0-1ffc3c2f3c80@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938202; l=7888;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=KZggTfnE6JmUpUfl7f5ZEwmXhpX3uI69FyQirUUycUE=;
 b=IhpWQjYn+laG4mBWsmKF5XV4bpV+NQ29y985B9QFDw1+1TZpwL6a5frdjbHEcYjSc3mNwPb0D
 0KRB40tlJWKCwsPybdQScU6fwUuFAkDjnCz8nmRXU1K0q/RuEcvyL2v
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

All mt6357, mt6358, mt6359 and mt6363 declare their channel types as
voltage, resistance and temperature. This is wrong, since the PMIC
doesn't include any built-in conversion block. It simply measures
voltage, while consumers are supposed to convert these readings to
the actual temperature or resistance using efuse calibration.

Correct all channel types to IIO_VOLTAGE.

Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Fixes: d6f49313272b ("iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC")
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 78 ++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 88b0e26309e5..951d236f972b 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -205,18 +205,18 @@ struct mtk_pmic_auxadc_info {
 }
 
 static const struct iio_chan_spec mt6357_auxadc_channels[] = {
-	MTK_PMIC_IIO_CHAN(MT6357, bat_adc, BATADC, 0, 15, IIO_RESISTANCE),
-	MTK_PMIC_IIO_CHAN(MT6357, isense, ISENSE, 1, 12, IIO_CURRENT),
-	MTK_PMIC_IIO_CHAN(MT6357, cdt_v, VCDT, 2, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6357, batt_temp, BAT_TEMP, 3, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6357, chip_temp, CHIP_TEMP, 4, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6357, acc_det, ACCDET, 5, 12, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6357, bat_adc, BATADC, 0, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, isense, ISENSE, 1, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, cdt_v, VCDT, 2, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, batt_temp, BAT_TEMP, 3, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, chip_temp, CHIP_TEMP, 4, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, acc_det, ACCDET, 5, 12, IIO_VOLTAGE),
 	MTK_PMIC_IIO_CHAN(MT6357, dcxo_v, VDCXO, 6, 12, IIO_VOLTAGE),
-	MTK_PMIC_IIO_CHAN(MT6357, tsx_temp, TSX_TEMP, 7, 15, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6357, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_RESISTANCE),
-	MTK_PMIC_IIO_CHAN(MT6357, dcxo_temp, DCXO_TEMP, 36, 15, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6357, vcore_temp, VCORE_TEMP, 40, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6357, vproc_temp, VPROC_TEMP, 41, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6357, tsx_temp, TSX_TEMP, 7, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, dcxo_temp, DCXO_TEMP, 36, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, vcore_temp, VCORE_TEMP, 40, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, vproc_temp, VPROC_TEMP, 41, 12, IIO_VOLTAGE),
 
 	/* Battery impedance channels */
 	MTK_PMIC_IIO_CHAN(MT6357, batt_v, VBAT, 0, 15, IIO_VOLTAGE),
@@ -251,19 +251,19 @@ static const u16 mt6357_auxadc_regs[] = {
 };
 
 static const struct iio_chan_spec mt6358_auxadc_channels[] = {
-	MTK_PMIC_IIO_CHAN(MT6358, bat_adc, BATADC, 0, 15, IIO_RESISTANCE),
-	MTK_PMIC_IIO_CHAN(MT6358, cdt_v, VCDT, 2, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6358, batt_temp, BAT_TEMP, 3, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6358, chip_temp, CHIP_TEMP, 4, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6358, acc_det, ACCDET, 5, 12, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6358, bat_adc, BATADC, 0, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, cdt_v, VCDT, 2, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, batt_temp, BAT_TEMP, 3, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, chip_temp, CHIP_TEMP, 4, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, acc_det, ACCDET, 5, 12, IIO_VOLTAGE),
 	MTK_PMIC_IIO_CHAN(MT6358, dcxo_v, VDCXO, 6, 12, IIO_VOLTAGE),
-	MTK_PMIC_IIO_CHAN(MT6358, tsx_temp, TSX_TEMP, 7, 15, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6358, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_RESISTANCE),
-	MTK_PMIC_IIO_CHAN(MT6358, dcxo_temp, DCXO_TEMP, 10, 15, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, tsx_temp, TSX_TEMP, 7, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, dcxo_temp, DCXO_TEMP, 10, 15, IIO_VOLTAGE),
 	MTK_PMIC_IIO_CHAN(MT6358, bif_v, VBIF, 11, 12, IIO_VOLTAGE),
-	MTK_PMIC_IIO_CHAN(MT6358, vcore_temp, VCORE_TEMP, 38, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6358, vproc_temp, VPROC_TEMP, 39, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6358, vgpu_temp, VGPU_TEMP, 40, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, vcore_temp, VCORE_TEMP, 38, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, vproc_temp, VPROC_TEMP, 39, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, vgpu_temp, VGPU_TEMP, 40, 12, IIO_VOLTAGE),
 
 	/* Battery impedance channels */
 	MTK_PMIC_IIO_CHAN(MT6358, batt_v, VBAT, 0, 15, IIO_VOLTAGE),
@@ -299,18 +299,18 @@ static const u16 mt6358_auxadc_regs[] = {
 };
 
 static const struct iio_chan_spec mt6359_auxadc_channels[] = {
-	MTK_PMIC_IIO_CHAN(MT6359, bat_adc, BATADC, 0, 15, IIO_RESISTANCE),
-	MTK_PMIC_IIO_CHAN(MT6359, batt_temp, BAT_TEMP, 3, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6359, chip_temp, CHIP_TEMP, 4, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6359, acc_det, ACCDET, 5, 12, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6359, bat_adc, BATADC, 0, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, batt_temp, BAT_TEMP, 3, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, chip_temp, CHIP_TEMP, 4, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, acc_det, ACCDET, 5, 12, IIO_VOLTAGE),
 	MTK_PMIC_IIO_CHAN(MT6359, dcxo_v, VDCXO, 6, 12, IIO_VOLTAGE),
-	MTK_PMIC_IIO_CHAN(MT6359, tsx_temp, TSX_TEMP, 7, 15, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6359, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_RESISTANCE),
-	MTK_PMIC_IIO_CHAN(MT6359, dcxo_temp, DCXO_TEMP, 10, 15, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6359, tsx_temp, TSX_TEMP, 7, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, dcxo_temp, DCXO_TEMP, 10, 15, IIO_VOLTAGE),
 	MTK_PMIC_IIO_CHAN(MT6359, bif_v, VBIF, 11, 12, IIO_VOLTAGE),
-	MTK_PMIC_IIO_CHAN(MT6359, vcore_temp, VCORE_TEMP, 30, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6359, vproc_temp, VPROC_TEMP, 31, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6359, vgpu_temp, VGPU_TEMP, 32, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6359, vcore_temp, VCORE_TEMP, 30, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, vproc_temp, VPROC_TEMP, 31, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, vgpu_temp, VGPU_TEMP, 32, 12, IIO_VOLTAGE),
 
 	/* Battery impedance channels */
 	MTK_PMIC_IIO_CHAN(MT6359, batt_v, VBAT, 0, 15, IIO_VOLTAGE),
@@ -349,15 +349,15 @@ static const u16 mt6359_auxadc_regs[] = {
 };
 
 static const struct iio_chan_spec mt6363_auxadc_channels[] = {
-	MTK_PMIC_IIO_CHAN(MT6363, bat_adc, BATADC, 0, 15, IIO_RESISTANCE),
-	MTK_PMIC_IIO_CHAN(MT6363, cdt_v, VCDT, 2, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6363, batt_temp, BAT_TEMP, 3, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6363, chip_temp, CHIP_TEMP, 4, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6363, bat_adc, BATADC, 0, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, cdt_v, VCDT, 2, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, batt_temp, BAT_TEMP, 3, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, chip_temp, CHIP_TEMP, 4, 12, IIO_VOLTAGE),
 	MTK_PMIC_IIO_CHAN(MT6363, sys_sns_v, VSYSSNS, 6, 15, IIO_VOLTAGE),
 	MTK_PMIC_IIO_CHAN(MT6363, tref_v, VTREF, 11, 12, IIO_VOLTAGE),
-	MTK_PMIC_IIO_CHAN(MT6363, vcore_temp, VCORE_TEMP, 38, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6363, vproc_temp, VPROC_TEMP, 39, 12, IIO_TEMP),
-	MTK_PMIC_IIO_CHAN(MT6363, vgpu_temp, VGPU_TEMP, 40, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6363, vcore_temp, VCORE_TEMP, 38, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, vproc_temp, VPROC_TEMP, 39, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, vgpu_temp, VGPU_TEMP, 40, 12, IIO_VOLTAGE),
 
 	/* For VIN, ADC12 holds the result depending on which GPIO was activated */
 	MTK_PMIC_IIO_CHAN(MT6363, in1_v, VIN1, 45, 15, IIO_VOLTAGE),

-- 
2.56.1


