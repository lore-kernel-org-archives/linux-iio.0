Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847200;
	b=VbiH6y0JntNt9suC9CaQNEFE81ramgN9sfvUc5a72RFQV+k+LSw2OqQNXu/lK3wCc83c
	 JSovq0mS+HSGpe0eTE7P4dYNHrhHsM9YOgX0MO3ebTOG8wUoXIBvP49VqmQK7VZNNn/kv
	 2vAgUd590uphYUPa93u8TnUWCuT5jVjlzFvMsdle2ZGsqLDwvvdAywNaJuh3lCty2mgAJ
	 fM4DjNcZIDQV8O5mrdYpwctQHSBFgIjfUlEDH7km/mmeSSTFlI5oSbjW7iTJ5WIsja05R
	 fAlwkdfSRHk19HOXkjwaq/E3z+V9n+Rt5o0kpEmGKO2wOXGg4/4IPpXt3V/aVxo58Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847200;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NLxSLGAlbxw7z0m7lP8HQ1a5F0qjVvjKFvItA58evvg=;
	b=GfBhxq67oaR8KpNafU3QAhnEpW+0cPLF8Ca4GbTelM/1lWxH7uOnGFSBOQFtqCNgZTHt
	 PjawbUC7EBigA2WtaAqRgO5cfGbm+xIAZPI4F9JY6Q4szEH1+ypFaMxzam+YX9cSRgOR3
	 NIux00AuCDh3jpkbzTrlk1HUHsambkZq3j9PApu94DRLOUbv8hSqUYwYAB3G6/jCzdv8j
	 Z2X+g5ZPw8PehokecJVVyLxqG04ZYBLMUnCG/gGgfBJloEaJJiF7E21iYDUwylr/USo+Q
	 QEjmsYZ3KPNQqTnj604pzDCZ8URsR2DyQkyCSNRt6CVlXxLZqAEFWOFqxK2GhdNKkow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UV70e/pJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B927606A331;
	Mon, 16 Nov 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UV70e/pJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847200;
	b=byAKPIslIZ8j3MAyPLwMX4zKiniu2v/dU6r3v/DYYP8wS4lOh1En0Tr1kWcBz6ZJWmIU
	 8pAqtHxlALl8i7Q/OZnXJqDtLiS/dgYOYjjeZLCEH9Ur1maVGwShxpfhKHd5mcvzGM2d4
	 bqbuFxAyImnSNtPgg0Kb5xmt6lNeMCHwnZoxcs+c4NzkdxqW73BWwLBOs5MDOwUarclvj
	 Or4uT1odAi8bpHWf5WG20Qw/KZ1mOlrtuYeOd60BuTIWk8tdd6PTuNnTpgdTfn1WylEPb
	 HE58ItxfaSqUWSO94A3RPTZXZfyq9dTz9Mdi4P2ZxDgEp08tJiGrb+sZD7EOCTyojXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847200;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NLxSLGAlbxw7z0m7lP8HQ1a5F0qjVvjKFvItA58evvg=;
	b=Hhc5ET0bihN+QV1Obyu+CjWDdlt3v1QkFRHrZP8nySU6j9/LZMjc65Sd0r4NLHc8vxM6
	 ZzgT+YmCD8ZG/57ZhIRNCEd4wapDr+rcVK80No+h0E9jqsDYw39FwqC2Jy60S0DBDU5Y4
	 ko39fzB0sOx0Kcc7cPRTV6ozlirgrCMnd6pD/gO6iDP51XyABEZxgJLvPgAmr9AfgpsHr
	 yAW2+C8kDN0OskDznQVixQRXIbvVlPxyor6mq7nqk1C1qoOpY9z5zVC7S24i1z8dAiEfq
	 0PGiJK7fsAN9CIaAAO8cNP84ENhvjLf/t99Tz0gejMBxrbKmN24pV+nkmd255tlkwQA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 70FF41F000CB;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847200;
	bh=NLxSLGAlbxw7z0m7lP8HQ1a5F0qjVvjKFvItA58evvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UV70e/pJcmpdUo0QxZlNbBh3519ENtvJmm+mzsLwXRqWjqHMZzCbMixHa8wuvcUgw
	 o/cuc1n2RyckTfAeoy4iwrzwTXFCYh3qCZRa8fydEoRVVIi5z7NouvMdyCJHGXA86M
	 bD2uCW1+xYa5HN9L4iUZSwT70sx0szcufQlin9KJV7Q16jNbbp4jQR9+NlD01orfvM
	 y+nsvEIuf0+qu3TkbNMIlba5t8bbBa2Hk+xLNm9Ne512PtjtcPqCP4wUMeO8Crk5KJ
	 /7YTrcCL/uKFz5lQ1EbnsC2Kdx7GlmiM8RGvB9Z4VSveoUD9NfiMbDs+cJFUoxOVCq
	 WLRiSCgKzaRZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F12344A522;
	Mon, 16 Nov 2026 16:39:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:39:55 +0000
Subject: [PATCH v4 03/12] iio: backend: use the consumer fwnode for named
 lookups
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
Message-Id: <20261116-ad9910-backend-support-v4-3-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=1465;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Aqd7cXKBKNmzoZvZz6wBTgwNO0tV9BfSYFDnK0IgmaA=;
 b=zQO3o3/r28xNjDjGsijCE1stfX+0fyvRhA4KM0FaJOxu0c5VtuhGhr+72tRNA3JVXtMfzxknS
 BJyNc2KPSg7BrMkuYzkQPWBKlF0lG1MAYBi6+6NuEO1+WL+NbVX6DP+
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

__devm_iio_backend_fwnode_get() receives the consumer fwnode, which is
used to resolve the io-backends reference. However, for a named lookup,
the index is obtained from the io-backend-names property of the device
instead. When devm_iio_backend_fwnode_get() is called with a fwnode other
than the device one, such as a child node, the name is then matched
against the wrong node, either failing or returning the index of a
different backend.

Look up io-backend-names in the given fwnode, so that both properties
are read from the same node.

The only current user of devm_iio_backend_fwnode_get() does not provide
a name, so it is not affected.

Fixes: c464cc610f51 ("iio: add child nodes support in iio backend framework")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index fbf5c39d7655..9a1072b39815 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -1034,7 +1034,7 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 	int ret;
 
 	if (name) {
-		ret = device_property_match_string(dev, "io-backend-names", name);
+		ret = fwnode_property_match_string(fwnode, "io-backend-names", name);
 		if (ret < 0)
 			return ERR_PTR(ret);
 		index = ret;

-- 
2.43.0


