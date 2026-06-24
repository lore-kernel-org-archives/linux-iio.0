Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E439281B;
	Wed, 24 Jun 2026 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288797; cv=none; b=q3wlC8X3N7YwJv7uerjPSA6wz3ZYzotTm9p8Ck/GjfEEEPo1A+oAT601KcqxSBFvdy5in5UQ/t2i/TEUxS0YSzYzfriRSvGxUx2jWyR5nFwkpYc4IEahnKgCX3625XdpMlEXGUkiV2pMpCF6PJuyXqDYYIn1dd0MZcsGCYHSTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288797; c=relaxed/simple;
	bh=/p8lMUFIdXTb9RUiSobi+QbVwGpvn3BPDf+qm/fmI50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D14bsw03ajQKfjDxzhAHUwr95ltk308o3m/170SXbPLKdzUM4Fc0wGs4xAb9Gip3eqqp/LmkG7CN+nL9uHb2fa7F+4uOffAOmHrmhc9FW2vxO6xT/pzoTJiOBrp41Yi1fZEp2nWPejGI/kLsRqhBsXqPpZkSHErRGlrgRTNuEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowABXLJOVkTtqoPKvFQ--.53368S2;
	Wed, 24 Jun 2026 16:13:10 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: temperature: Build mlx90635 with CONFIG_MLX90635
Date: Wed, 24 Jun 2026 16:13:09 +0800
Message-ID: <20260624081309.77805-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXLJOVkTtqoPKvFQ--.53368S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4UJw1kJFWktryruw4fuFg_yoWkWFcEyr
	4UWrn7Wr4UWr1jgws3u34xuryqg39Igr15AryjqrnrWay29ry3Ga4DWr4DCF4rGrWY9Fn5
	Zan8X3yxZF9rtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYfHjUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

drivers/iio/temperature/Kconfig has a dedicated `MLX90635` option, but
the Makefile currently builds mlx90635.o under `CONFIG_MLX90632`.

This means enabling `CONFIG_MLX90635` alone does not carry its provider
object into the build, while enabling `CONFIG_MLX90632` unexpectedly
also builds mlx90635.o.

Gate mlx90635.o on the matching generated Kconfig symbol.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iio/temperature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MAX31856) += max31856.o
 obj-$(CONFIG_MAX31865) += max31865.o
 obj-$(CONFIG_MCP9600) += mcp9600.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
-obj-$(CONFIG_MLX90632) += mlx90635.o
+obj-$(CONFIG_MLX90635) += mlx90635.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TMP007) += tmp007.o
 obj-$(CONFIG_TMP117) += tmp117.o

