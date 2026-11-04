Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760050;
	b=NDKhaF89bDpV69jtOyEDBpdEpPNQE2FLOF3yLdhMh5NHa+ec6EJRQl73ql7PyRy4xeE2
	 5g69oCCu9xSjtU3r9n30NVaG7nmUF4oCzaLSUMToNvV96O1jakD8bAedb3ontxclou6JE
	 AlY4j/STw42bDK90PlQCNHe+zEiN2Ojp/P/dzBzOZBoruaF0WmhNGKWsQfbsQ2AKZ7TtR
	 EAVtnALZrZ0anlqUykgzcgxb1vyxjCKXmUloSsk1YIbGYYbLaVYb/+2pXjGQ2UvqxMPXf
	 /Gtis8bQ0sPjZOu3OMnFegf/zzZdGtbVjpT8DvgITsUg3Ee1WvN766iBuuA51Tu26/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760050;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=e6HrL2+lYtUGSBGVjQGed5bXaNpP3uRBcYulAh2GRVs=;
	b=vk8zptSI65tockQj8mB2q1att7Uac6dZoWWm5qcWPbXHlAZFbh80rb2YIGZXIyag5KyM
	 CZ0rcM6Q9J4XippIvII2abvxVoabyPYfZrsb2I/XH6irxDLF1YQimUkIcvZcIfHAtO/Mv
	 XQ9LzUUmH/k5so0A/kJ/oQavot6MShn34EF+g8dLHx0jJYPIP4chlnmwSYukqU6JP9Va6
	 OyB7fXF4YaDGhQefDIrMMum07SSW/dcIJ8YTJylpoIQlXqlqpvtTkA3phlM3qQ/vKH14t
	 IwwU7l/r27/sYWqbYNMDbSEVSRutIxSTZRq+tjAuUyZ5tTpHAw0ZNEeV/vb1GVjnzvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57961606A331
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 02:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57961606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAC35P4vm+pq1Lk+AA--.9684S2;
	Wed, 04 Nov 2026 10:40:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: David Lechner <david@lechnology.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] counter: ti-eqep: balance runtime PM when the clock fails to enable
Date: Wed,  4 Nov 2026 02:40:56 +0000
Message-Id: <20261104024056.1508805-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAC35P4vm+pq1Lk+AA--.9684S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfAF1rZr18tF1rKF45ZFb_yoW8Gr1Upr
	4qvFyqyrWxZryIya47Xw1qvF90v3y2yFWrC34kGa48Zwn8Ja4S93WfJa4jqFyIyFykuw1U
	trnrWa47AFZrCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
	6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAI
	cVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU5EQ6tUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQBA2rqY-nVhAAAsU

ti_eqep_probe() enables runtime PM and takes a usage reference before
looking up the functional clock.  If devm_clk_get_enabled() fails the
function returns immediately, leaving the usage counter incremented and
runtime PM enabled; a failed probe means ti_eqep_remove() never runs to
undo either, and devres does not manage runtime PM.

Drop the reference and disable runtime PM before returning, as the
counter_add() error path already does.

Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/counter/ti-eqep.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 0dda3f2b14c7..6da9df563fda 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -547,8 +547,11 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+	}
 
 	err = counter_add(counter);
 	if (err < 0) {
-- 
2.34.1

