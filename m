Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792747824;
	b=jtaAmcui6NjsIM/g2hEUYEVZSquqs68P8xN/cNYaLDeDr+LImhU4t9eF0TcJ0J+keWvD
	 z5g5PcJBcfN0uSb5MDw3UNJSnPZubhd3IGSDceAMI2R71ybGTGDOQNzt3ojca9knmScTg
	 fcP1298EE7ZvY32LWikygg76cvdo9T660QeOHbphzGe4iUHoh77+t2W5TLAQi6qKQ6WSz
	 pxJzli1MoxvCPWT9z5JV422/OfTVApmusukUO5k9pluCc/Cf/l6K+MIpIJOZ5enUSnzL9
	 mH2WUWxjqbVWFPfnTGmU3XM/nTcLaVgp51srM+BB1hnaHG1V5d6O9I7gQqJM/Ef5NcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747824;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=o4PvBG7w8lBuWRoD8BH9D2KzbqTQMsls6L9Ozh6m34w=;
	b=ovQeZ94AZD8JDC7x0h+dqaY2b3T0Aj9szF2GHG+iYiz8YR2dxm8DJ90suCH2uVU875pW
	 ArI2qC1haWk62CrJTItZaiQuHzFgncLB0/72iHcBWogu9HKrEyFF5u1m9sNEVSUJk52kP
	 OWmJ0PKmoHMwjBRr7QjDQURSvB+cWaz1nCpxPThnjJ0gtMg1c7ZT7GKHLY+JE4Kt9Ypx1
	 fBCx68Mkbs0jaU0FrCevY3JLERM/VIXLTgH9SF2vRkcm7LiqlruceqGEVWAOQj5+ginh7
	 GGCissAYiECLdiZKCOsu+7NgS4ivZI1Et1TpNt9E1QjMDRw+vtrYXZX3o7GSxz93P0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEAZU695;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C87606A330;
	Fri, 23 Oct 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEAZU695
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792747823;
	b=g+XFZRRUwwBzPEeu/BcklP5a2iGPbtnwp1BwZBuEn9TGZM4BgvzoxK1y8F2upgVZHQnW
	 dCG6r8T6TYvoCpsinngSnvECMaH3eAL8W4QqkwrBy4Ajeq4wDSRU1gWHS8CJDPLkmMjOa
	 htFXQusn/Z64ER/A4LQ5O3xqCYqMFNI0ZmSfPk7b0mKgnDtRHTJd/cgJiaWNW5+zBd+u4
	 6O2eEbFesr67wLNjMGLq5S50Q+hhi57EajPetI/QDVoh5QDwQkl3nFhef7APCpwwDqslH
	 slzui3vprIRKE9E+bo7VVJbKYfmmFlgxCfr4RosTFDELEF8zPJhspOSvsFVwJY47tjQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792747823;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=o4PvBG7w8lBuWRoD8BH9D2KzbqTQMsls6L9Ozh6m34w=;
	b=pTSZq+qEEjsfqq9uwjmbfJBCl9rgrhplZSv3nPNCEN3H9GyVAv8rOhb73YtvXwq7Dwtu
	 g4BNQbvEkI1cAtI9tTuUh4+A+LxWRThJKKhUwK+/NEmiZau7qllXq/X930TEQrK2oIueu
	 zqkxwmMJOo7fp+t5WjiM1WL8F8EarrpMkrDl7f2e2YE54mqsXn+U29U0oLRLNpilXrZL+
	 4UlWnUv3F0fqXEEtZAyewzU4kxqcijbNg4qT2SInkYAhqOUxnbYoy3WZYAxNRYi4707VD
	 gOht9cIuVkiiDk/m47obwwBXZi6/EWDvVbCCAMp6EdZTAN2k+6PoF5Jfm3jSoj7Tt0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D8B5A1F01829;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747823;
	bh=o4PvBG7w8lBuWRoD8BH9D2KzbqTQMsls6L9Ozh6m34w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CEAZU695EH41KZdGkH2Aa9m6nAuMpD38m9xvHc32uXwSsb9pSdynHPOj3wu1MWMgZ
	 DoGw3KWTyjo660QKX842o10MLZG9YXM5+IqzOudRfhPapRHlNAVlOezvKzQiS3C326
	 EENDiG2ASfLwF98L2X1OH0z/N+R9cGo8VpPFPKwOBtxUaW03OFttJkLBKLLgjTszkl
	 D3Df74hWeBqH0i87sjh0q1gKR02QAYt8h5y1wtze+pBmiPRrN7adCtNirRYBlNcHdR
	 h3uxzQyzghf0P+dTGIi8xzelrh7Hlccxj9/V9y3nMjVtzhR0E7XjIxIbROLzgv9TDL
	 Djh5Uqjfen2Ng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 44E0644445;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 23 Oct 2026 12:30:18 +0300
Subject: [PATCH v4 1/8] iio: imu: adis: Add optional self_test callback
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
Message-Id: <20261023-adis16607-v4-1-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
In-Reply-To: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792747820; l=2136;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=YazgVExHlg7DuTSHjItfCNnSyD1jkv3xVZj1NUe2B1Y=;
 b=zjAtXiFPT6vqV4PiSaqaTYsgZlenKRYOWce/zDx963u5ksL4l5XCzFNQXjWblVtUrneZQKZ7v
 E/hl3KW951rBhDFg629/XgrMc9h8nrWfwBrwp0pfZnq4+UNDiNmtcqB
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

Add an optional self_test callback to struct adis_data, for devices
whose self-test doesn't fit the generic mask-write/sleep/check-status
sequence. Purely additive: defaults to NULL, no change for existing
drivers.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis.c       | 3 +++
 include/linux/iio/imu/adis.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index a2bc1d14ed91..388518ebba2e 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -360,6 +360,9 @@ static int adis_self_test(struct adis *adis)
 	int ret;
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 
+	if (adis->data->self_test)
+		return adis->data->self_test(adis);
+
 	ret = __adis_write_reg_16(adis, adis->data->self_test_reg,
 				  adis->data->self_test_mask);
 	if (ret) {
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index bfb6df68e6c9..14f9b304c252 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -51,6 +51,12 @@ struct adis_timeout {
  * @self_test_mask: Bitmask of supported self-test operations
  * @self_test_reg: Register address to request self test command
  * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
+ * @self_test: Optional device-specific self-test override. When set,
+ *		it is called instead of the generic mask-write/sleep/
+ *		check-status sequence. The callback owns its own pass/fail
+ *		determination entirely (it should call __adis_check_status()
+ *		itself if it wants status-register checks). Must return 0 on
+ *		success, a negative error code otherwise.
  * @status_error_msgs: Array of error messages
  * @status_error_mask: Bitmask of errors supported by the device
  * @timeouts: Chip specific delays
@@ -81,6 +87,7 @@ struct adis_data {
 	unsigned int self_test_mask;
 	unsigned int self_test_reg;
 	bool self_test_no_autoclear;
+	int (*self_test)(struct adis *adis);
 	const struct adis_timeout *timeouts;
 
 	const char * const *status_error_msgs;

-- 
2.43.0


