Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198577;
	b=O8syWTBEFsJG2fRwfe3qKrtS3jwfwHBx9ZChOaiEZA9mZghMYRjNscgczbf0rrw5G5Od
	 cOdwExVSTttu6SRPYw2J1iyyHpXcImacaji9N4vngbQrWVLJ6wf8+/eXuZpbdL2WDZ667
	 ++x+lMBRlNPGTWOvuDQq1TIhpt68sEqi7zCoMHXr8DJAlUefUi9K4EiyZyQV06cgprjuU
	 QaOBX5BOEul79j6Kbw8UnTi/uw0BTwG6d48YBv05x23sMGSz3LBIWEe45Cw+uD7O9sI2N
	 /0GIzJSqJAm8JsUw0c+0HYMXkc+WPmwU18QrKvTYzNDNC2Inv5eHIowNnQ94M24fKvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198577;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZdxUSqo+w8YeqJVaUlbjwzQ0LSd0yO3WpZRV2w3VNNE=;
	b=MTfK9eFYbcOV+Y7ub1oCNrxZHx0oPUXxYSycl19lnOUE3BfwbCqIEZu6F4ta2Vdoulsg
	 6zvbEHQOSM/SWHvZoK5uIMm0YdtljnFIRTLgJnSFOd59eHJCO7G3fJ/gM9dMGZf+rIL9i
	 tsM2UBivGsrNvM74NawVYIzJtKyTZf/He2U/Df4dPOA3Vf3vt5Qtb+x/V2IX7B36CysTT
	 ujCQkpHV+nda1GnnxbSkDEaouO5Unk6QIICP3iMR0bQe3DsyQWWnMgDQvND3E/Yhs+N9C
	 Z+qiEfAxjXdDVLLd3cGdoG1IAYL2g2RNEYFImVNERh+c1/bE1Jv8IncBv6i7scAALkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9X1OVaC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746F606A321;
	Mon,  9 Nov 2026 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9X1OVaC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9BF1F008A3;
	Mon,  9 Nov 2026 04:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198577;
	bh=ZdxUSqo+w8YeqJVaUlbjwzQ0LSd0yO3WpZRV2w3VNNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9X1OVaCDAc4cYxWdCp1DRrs7TEYWz+40Rz7L2cR9+BhwVHch/dpCnpu65A8eFJ9f
	 knq0IwiPxYlF1+0jtOIiuZAjC1Ff7ZpIdhVero9SuzvU6DVFDnqSwc8ROstRAETTY5
	 pJ7VOrw1MgYEZ0/1ulU8v5l7WSsMORUCtknsm0hmR/062c2ZwfJXvuVoM2fFyWfufX
	 ytZm4npSAo3F0qNF43obSSSW/ZW5PEl4HrvWLVqr8/M1kWvfdP4i8sNWzLCKV3WB6u
	 oiFVAXSp0fyvtzWgNztPKgJlhXFWsXwIT4VHX6ZngXiXcxVrWa8p+rWZE9+BgQ908O
	 ubqmhlb/hnMUw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Song Qiang <songqiang1304521@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	Waqar Hameed <waqar.hameed@axis.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH 10/14] iio: chemical: scd30: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:47 +0000
Message-ID: <20261109042851.1326940-11-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109042851.1326940-1-jic23@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Keep a pointer to the driver's trigger in struct scd30_state and poll
that from scd30_irq_handler() rather than indio_dev->trig. With the
buffer enabled, the interrupt is only enabled by the trigger's
set_trigger_state() callback, so it is the driver's own trigger that is
in use.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/chemical/scd30.h      | 2 ++
 drivers/iio/chemical/scd30_core.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30.h b/drivers/iio/chemical/scd30.h
index 1ac9f3f79271..bdec5cf62a26 100644
--- a/drivers/iio/chemical/scd30.h
+++ b/drivers/iio/chemical/scd30.h
@@ -9,6 +9,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
+struct iio_trigger;
 struct scd30_state;
 
 enum scd30_cmd {
@@ -57,6 +58,7 @@ struct scd30_state {
 	 */
 	void *priv;
 	int irq;
+	struct iio_trigger *trig;
 	/*
 	 * no way to retrieve current ambient pressure compensation value from
 	 * the sensor so keep one around
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 770571c21521..ca824436f60e 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -573,9 +573,10 @@ static void scd30_disable_regulator(void *data)
 static irqreturn_t scd30_irq_handler(int irq, void *priv)
 {
 	struct iio_dev *indio_dev = priv;
+	struct scd30_state *state = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev)) {
-		iio_trigger_poll(indio_dev->trig);
+		iio_trigger_poll(state->trig);
 
 		return IRQ_HANDLED;
 	}
@@ -666,6 +667,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 	if (!trig)
 		return -ENOMEM;
 
+	state->trig = trig;
 	trig->ops = &scd30_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
-- 
2.56.0

