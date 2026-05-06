Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90C48123F;
	Wed,  6 May 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076530; cv=none; b=NhxyTcBGid1lUN0Hew/SCwPPrnRX+eIYvLM873VQRgR4dzgxQ4phZgiTwhugwUj8gH2niuGojDxbUJg2C6YCJw8X3O4NIDSCVmerQJTPn+aYPhzu7vMjFKsz4o66hyAz9EZ4OsiBgFVLlM0vYRVcrFy+rIZjVvPSxSxGOvH04S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076530; c=relaxed/simple;
	bh=oZYW6wdRC4ATSAthvNKnz/qvii6oFdxmKMrKp5IMOvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FbCNwZXKRINoZjh55kFIAcwYvw3el37xYcW8vrQEjV3c0b6iReS3Wn3JjXKisSGmvwY6g2vxRk0WtVaHTmgNNhAJrFEfsgGMOZsO6GjVFUA71brut6C/eWyxSkVwHun6xLVO3ql6ujsVWbv8sMqINi378uh2jbLCPfvuvNp2mUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UobII831; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UobII831"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AB9BC2BCF4;
	Wed,  6 May 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778076530;
	bh=oZYW6wdRC4ATSAthvNKnz/qvii6oFdxmKMrKp5IMOvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UobII831HXKrEwcg6nb+0jIVzrxBFaXoaoMWgPZkxV1UhMWRe85zVNFT/tia5qBSM
	 9oS+FVOu3kozzFRuG+kYEvEnquFL4fxoR5Oq2F0STLG6wfmfJc2kLk39eHobEPASjq
	 VWWUBS7MGCC+2Xx02TzGc+NmZv2rRUcbCbFZxuwM+sLWuDq+FWkTGJH9wGdYasRkPQ
	 99PtcqFBhRhB1FRG7zJB7XqxCE+0GCXm868jdZvFqxdQO8uj0hGLhy4rCIRmq+QiM4
	 w+1VbOODAlPsGtjnU8EILt5oQoRBTOeHyhliKEFjRdeojOMPUuITvRlPB7WNjFlRsI
	 OeiKUQPIrNFXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFECD3440;
	Wed,  6 May 2026 14:08:50 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 06 May 2026 15:08:53 +0100
Subject: [PATCH v11 09/11] iio: frequency: adf41513: features on frequency
 change
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-adf41513-iio-driver-v11-9-2b7e99cfe8f2@analog.com>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
In-Reply-To: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778076527; l=5624;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=DiZIG3KloW12G+mYdG6abXhD29OzXjbv9aJKBeCBk80=;
 b=RkLdzH2N7yRAPM/dhnPrPyP82j/SxGG/N6tM5N/VJB+AIDdFLq3qjyJBaEFUXl2TbIYbxSz/k
 K4DUmYP5OtCBODyFmq62Bbb9DPKLy6HCsbmlLVylRXWfP8K3mW+leJa
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Set Bleed current when PFD frequency changes (bleed enabled when in
fractional mode). Set lock detector window size, handling bias and
precision. Add phase resync support, setting clock dividers when
PFD frequency changes.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/adf41513.c | 100 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index 6072ceae9bfb..238bf6e2e55a 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -20,6 +20,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -206,6 +207,7 @@ struct adf41513_chip_info {
 struct adf41513_data {
 	u64 power_up_frequency_hz;
 	u64 freq_resolution_uhz;
+	u32 phase_resync_period_ns;
 	u32 charge_pump_voltage_mv;
 	u32 lock_detect_count;
 
@@ -264,6 +266,16 @@ struct adf41513_state {
 	struct adf41513_pll_settings settings;
 };
 
+static const u16 adf41513_ld_window_x10_ns[] = {
+	9, 12, 16, 17, 21, 28, 29, 35,			/* 0 - 7 */
+	43, 47, 49, 52, 70, 79, 115,			/* 8 - 14 */
+};
+
+static const u8 adf41513_ldp_bias[] = {
+	0xC, 0xD, 0xE, 0x8, 0x9, 0x4, 0xA, 0x5,		/* 0 - 7 */
+	0x0, 0x6, 0xB, 0x1, 0x2, 0x7, 0x3,		/* 8 - 14 */
+};
+
 static const char * const adf41513_power_supplies[] = {
 	"avdd1", "avdd2", "avdd3", "avdd4", "avdd5", "vp",
 };
@@ -571,9 +583,82 @@ static int adf41513_calc_pll_settings(struct adf41513_state *st,
 	return 0;
 }
 
+static void adf41513_set_bleed_val(struct adf41513_state *st)
+{
+	u32 bleed_value, cp_index;
+
+	if (st->data.phase_detector_polarity)
+		bleed_value = 90;
+	else
+		bleed_value = 144;
+
+	cp_index = 1 + FIELD_GET(ADF41513_REG5_CP_CURRENT_MSK,
+				 st->regs[ADF41513_REG5]);
+	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * cp_index * bleed_value,
+				1600ULL * MEGA * MICROHZ_PER_HZ);
+
+	FIELD_MODIFY(ADF41513_REG6_BLEED_CURRENT_MSK, &st->regs[ADF41513_REG6],
+		     bleed_value);
+}
+
+static void adf41513_set_ld_window(struct adf41513_state *st)
+{
+	/*
+	 * The ideal lock detector window size is halfway between the max
+	 * window, set by the phase comparison period t_PFD = (1 / f_PFD),
+	 * and the minimum is set by (I_BLEED/I_CP) × t_PFD
+	 */
+	u16 ld_window_10x_ns = div64_u64(10ULL * NSEC_PER_SEC * MICROHZ_PER_HZ,
+					 st->settings.pfd_frequency_uhz << 1);
+	u8 ld_idx, ldp, ld_bias;
+
+	if (st->settings.mode != ADF41513_MODE_INTEGER_N) {
+		/* account for bleed current (deduced from eq.6 and eq.7) */
+		if (st->data.phase_detector_polarity)
+			ld_window_10x_ns += 4;
+		else
+			ld_window_10x_ns += 6;
+	}
+
+	ld_idx = find_closest(ld_window_10x_ns, adf41513_ld_window_x10_ns,
+			      ARRAY_SIZE(adf41513_ld_window_x10_ns));
+	ldp = (adf41513_ldp_bias[ld_idx] >> 2) & 0x3;
+	ld_bias = adf41513_ldp_bias[ld_idx] & 0x3;
+
+	FIELD_MODIFY(ADF41513_REG6_LDP_MSK, &st->regs[ADF41513_REG6], ldp);
+	FIELD_MODIFY(ADF41513_REG9_LD_BIAS_MSK, &st->regs[ADF41513_REG9], ld_bias);
+}
+
+static void adf41513_set_phase_resync(struct adf41513_state *st)
+{
+	u32 total_div, clk1_div, clk2_div;
+
+	if (!st->data.phase_resync_period_ns)
+		return;
+
+	/* assuming both clock dividers hold similar values */
+	total_div = mul_u64_u64_div_u64(st->settings.pfd_frequency_uhz,
+					st->data.phase_resync_period_ns,
+					1ULL * MICROHZ_PER_HZ * NSEC_PER_SEC);
+	clk1_div = clamp(int_sqrt(total_div), 1,
+			 ADF41513_MAX_CLK_DIVIDER);
+	clk2_div = clamp(DIV_ROUND_CLOSEST(total_div, clk1_div), 1,
+			 ADF41513_MAX_CLK_DIVIDER);
+
+	FIELD_MODIFY(ADF41513_REG5_CLK1_DIV_MSK, &st->regs[ADF41513_REG5],
+		     clk1_div);
+	FIELD_MODIFY(ADF41513_REG7_CLK2_DIV_MSK, &st->regs[ADF41513_REG7],
+		     clk2_div);
+
+	/* enable phase resync */
+	st->regs[ADF41513_REG7] |= ADF41513_REG7_CLK_DIV_MODE_MSK;
+}
+
 static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 sync_mask)
 {
 	struct adf41513_pll_settings result;
+	bool pfd_change = false;
+	bool mode_change = false;
 	int ret;
 
 	ret = adf41513_calc_pll_settings(st, &result, freq_uhz);
@@ -581,6 +666,8 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
 		return ret;
 
 	/* apply computed results to pll settings */
+	pfd_change = st->settings.pfd_frequency_uhz != result.pfd_frequency_uhz;
+	mode_change = st->settings.mode != result.mode;
 	st->settings = result;
 
 	dev_dbg(&st->spi->dev,
@@ -622,6 +709,14 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
 		st->regs[ADF41513_REG6] |= ADF41513_REG6_BLEED_ENABLE_MSK;
 	}
 
+	if (pfd_change) {
+		adf41513_set_bleed_val(st);
+		adf41513_set_phase_resync(st);
+	}
+
+	if (pfd_change || mode_change)
+		adf41513_set_ld_window(st);
+
 	return adf41513_sync_config(st, sync_mask | ADF41513_SYNC_REG0);
 }
 
@@ -895,6 +990,11 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 	st->data.phase_detector_polarity =
 		device_property_read_bool(dev, "adi,phase-detector-polarity-positive-enable");
 
+	st->data.phase_resync_period_ns = 0;
+	ret = device_property_read_u32(dev, "adi,phase-resync-period-ns", &tmp);
+	if (!ret)
+		st->data.phase_resync_period_ns = tmp;
+
 	st->data.logic_lvl_1v8_en = device_property_read_bool(dev, "adi,logic-level-1v8-enable");
 
 	tmp = ADF41513_LD_COUNT_MIN;

-- 
2.43.0


