Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760811;
	b=ABGNlg4Ve78k0P0/nYeTkbtJCViwJbnSXK99+9n7i/X2MYQYJKlgf73F24e4v4syuuj5
	 gPG8XA52+VM64a4lH7VVxCq0MsKmGlPLiysZC8LhCbtEPBnTkBE6CmsUJP/6fV0Rf6ptR
	 MGrPKdKomhR+RqYV61rtTDJnUZcvM45HKS/CjgJQ8AXXvW39Y3tNw+cM/anVDyT/nUtp0
	 0VOXu3+CxPN3NJP61ECpxUGyqIM6RdDL5hV7NJF+r/hl75uFxXA0dJLaNeMW5LeqN0oFo
	 lnp8NZLeY7qFgpclkc2wsLV1RI29DzQBPg48j2BqIIhxXixz7LBH757KveUijXKIkxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760811;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=vz6aqKUlAw4P2lbFBUu6CLePWoyHMXyD1Sd0NXGSTr4=;
	b=knjIaS42mlTlo1/jDzbv7X5Dlouis3+Go9bQZeRy4fbglXTyg1uycqR5m9QmerrOPseR
	 jeF6BvKMFv5v1ROpKPSSpPH9Bkqggm0Vx3AAm6byogsGfntBRT8AAqMzL53Rg8SStNjDo
	 FjAhJoCIR9x4vnzzgtaOVaHZp1gjBCH4RzLsFAINP8RxhOL9+PilUtB+LVH/qdyI9wx4C
	 Savfg8Gb13XhvS0VLLK7lzNSx3BNW9LscqGE/j8/HNGF2yBoKRFGPcsVAFO4/kfARWotj
	 jFB6Zj5NxtWkJu51C4jvUHkFLt6qoZOh+wWkvPsklbvGPKu3wA1aeKp/FZfzddJti4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A7606A326;
	Wed,  4 Nov 2026 02:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA5A7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABHcfsnnupqseQ+AA--.42699S2;
	Wed, 04 Nov 2026 10:53:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] counter: drop the runtime PM reference when enabling fails
Date: Wed,  4 Nov 2026 02:53:37 +0000
Message-Id: <20261104025337.1527287-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHcfsnnupqseQ+AA--.42699S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4kAFyDuF4kJrW7ZF45GFg_yoW8GF17pF
	42qwn8ArW0yrZ7Ka17JwnrJryavw40yrZ5KFyrGay8X3WrArn0v3WkWF4UXF1vyrZ5GF12
	qrn7W34UCFWDJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
	6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAI
	cVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU5Sg4DUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcBA2rqZFjiNAAAso

rz_mtu3_count_enable_write() takes a runtime PM reference before
initializing the counter. rz_mtu3_initialize_counter() can fail, for
example with -EBUSY when the channel is busy, but the reference is only
dropped on the disable path. Because count_is_enabled[] stays false
when initialization fails, a later disable write returns early and does
not drop the reference either, so the parent device remains runtime
active forever.

Drop the reference when initialization fails.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/counter/rz-mtu3-cnt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193c..b828618f9033 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -508,6 +508,8 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
+		else
+			pm_runtime_put(counter->parent);
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-- 
2.34.1

