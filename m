Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881042;
	b=ff0AfaThMHX1bK/ZodLgvw7901dFjMbjrwrkXtjzeN18LlWck930H354OPufvqjwmYIG
	 WO5m02fUC/zmXJk02qYuBb6EPhl7hIswP/G579lagssd/odNL6ErD1CS07HZUh65WdX6J
	 4i0Ssyf43myMNnETp4swdN2s95Tw7r6foW63F4B9x7PxLX1FlG6zZv//a/aaShce+EEzF
	 JVAqNpWJsla+BZgpW0yYS1wU06eKSg4ZUVhjjximqYIZGbrZKXj7uFL+R/jsC1+EXhYfT
	 ChHsTu3MlvQgHOWhPpP9WQ+iW3tXr8Hj3SSR6HmP7VW2z3ZZzKu3MofQSQb8U1OFagA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881042;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NZ3CgzX5kCqEc5zzVuYtQMrEP9DNTdrTQOJmfrHXdUM=;
	b=qB6pywNhppTqMTZ09Pr2iKHqaeRAL1kk0MW7rMNIag+s9QDwQygUkXQv5Zi3n9urZzUI
	 ohW7OQe5DtAMy+I8nqD9YYWxZb7RGLuOsx/muuSt+G9f1cmS0QnUPlHEqd6WGMhepNjJQ
	 p7A9zVClqbYJKN9w9Bd8AZblLTQHseyi8oNYgG3tRS3B9M/EuSYjbUlqdVyeW3agKP3P5
	 gru3RrZ6UWD95zFJayttfggL9BNj6w5oMH8heZjhOKWZ/5sCJtTRsdy3oSqlHJk0Ey7L4
	 QCQy2uSiptEb9tnB2XM7T5Jt25pFQS6XwCyNbj6d2n98AC5wT3r/4wWjnk6s2yMvHpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V64hvXG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51569606D83E;
	Thu,  5 Nov 2026 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V64hvXG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877111F0093A;
	Thu,  5 Nov 2026 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881042;
	bh=NZ3CgzX5kCqEc5zzVuYtQMrEP9DNTdrTQOJmfrHXdUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V64hvXG/6ati29xvEOwA+mKQa0d7FJScqk/4Vov27oAQ9RgN2TVHLfQY7TjZ6YRk9
	 KfAftY8bbwNhFfUbwevB6z3w0l+tbCxNFkQMBOLGSJdZ/TWkYLs4jC39F0lC8Ivjvz
	 JJhZhwfNodO4qfOxjx8modj8zfRT+sLG6l01SrikaTWYiJxv53wI2hx/XNqRDVGaXq
	 kxR2nIjwAAUeExh/HM4R9cfmuZd9YxBV0Mj98yNoX1l79198Sa9BZC7RrwUdrUs0HZ
	 run9S9EKxte8HsKtXpKdXvma8V73cMNl+tOQy4x105jjH41sz8DUoW3ZZs3UIZqZ0d
	 CQ1r1xtOSHmwg==
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH 07/10] iio: gyro: bmg160: remove redundant pm_runtime_dont_use_autosuspend() call
Date: Thu,  5 Nov 2026 12:16:32 +0000
Message-ID: <20261105121635.1612-8-crofts@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105121635.1612-1-crofts@kernel.org>
References: <20261105121635.1612-1-crofts@kernel.org>
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

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function call.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/bmg160_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index b007f46d3fd6..f1e1d21e590f 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1169,7 +1169,6 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	return 0;
 
 err_pm_cleanup:
-	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
-- 
2.47.3

