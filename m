Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794573214;
	b=SdCwYPSZtYLJ8h7eeWX1GcRe2TGyIC+8T/QKsoChK7v1RWbUIhP8UrIfE5KUfq6R06P8
	 i5VGuD4EJYTz5idnKHJhN0klwJMlhh0d2b/FVVF1OGSL6doWMPN3g8+NuT3ULAdFrXLl7
	 k/BfXaYeOOzlSnuMfdfIshpB0eILDB6fta5TyqkCmxNQHvn6ctuB4wilDz6stspRdAtsV
	 rSG8SFuLTGyPhUC3Xk/ZLGud0LvD+stlnK1L7Cb/deXcLeCtTWWgucKUmQS7nZqlmXkv5
	 7N9IHMv37UdrZOV0IwPlQrEFnv7V+gdl1BxSgHmHk5hrO8I2Rd19GDwLCujD+fy+OiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573214;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	b=xRFoNOxgY8qeCk6/2mUqgtRdTUO/euo84eIe1h2qjiifMrB6hhRuvnNyypbHUkZ9ENJC
	 kO6+tFFEHMape1p1B9fAGO0fMRa0iNAt17SuYtsgK+GTOAsDNmz24Wf+SuLanFGMutJfl
	 9csqHKiO92SI2gti65murEH+ovCboW0wkznDFKyquGMx5Smn8Fm1R+H67EwnF46djab54
	 s8tZ2NKyACLpIgn0snZHCt+FTCkVaVGvdVHY1zN4Ly4/afY3n4X7HCNogAZJ3SpyuNzDA
	 Jv3Qc/rETGpSEX6gmpYQd4doa56fsUkgylxdLw3+tPTCHVSrYS3XkxgrVqlJn5NyZ6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EswXsMtM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD2606A330;
	Fri, 13 Nov 2026 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EswXsMtM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794573214;
	b=iuq6jvBC9yiYpaw6P62+PvGOX5GgMBSppupbgh6RGyshpwJ1x5o0SpK83irhNbnlhmsD
	 RRrItPPm4Ta7Lo6Pzsn7CGp/wBtHpjGSEVRfGMPeRDEemhYT7wE0Y2pMWCZmE3Y+JYAbd
	 XubPcDiYi3zvzxBS2UzmiqDZGSXYYsIGubcIv6XNm6PS2HEFRXekd4o2JRO49YE0Zooy8
	 BCNBc66RVoOyAozCn57RriBGXZi7Rzg9aDPvSvn74K+n7tzg9KXmIZnzGU4oWizzxohHV
	 lm8H3aAn8y3LxwB/0tON3xMyfN6fNKdydEMuj0852J4X4jjdo8HON0P8e2zrkqPTELw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794573214;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	b=BaD234bvmLN9g80GIhQ4agUm9bYYrwMc71sTwugCMRecHdT9ncQCb+69STrCZM0bQcpW
	 DRyh2cw4M+ynXaAC9LvnY1fNDlrVUVWyssKx5LOuVS0wHvGVV2YvAmzr9Dq20j7XP1EF6
	 JTVt/TxIVM6Hxh+GHdLgWubHBnaSDrtpYhGokszVkjx9ajHqRRADwNrJASWgSs9Cqvf+1
	 ZwgnManzRSzLhtj+SMMVDPt/sASW6/BeCiL09n3Id/W4wj+gzT9P34NKm0XS2iq1bCpgy
	 WJLz26BtCIB8wpfF+OI8P0gf/Uas+SOZxhua8Z6jmEXNCf8GLV7GFJAP7mq0q4xPcbA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1099A1F000C6;
	Fri, 13 Nov 2026 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573214;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EswXsMtMmyvfiCCayQkQQEzpLNZ7k2ajnvf3vuj2zyevL9xFp4A97++Y6tfx1Dwa3
	 Pkt+okO3Cui8FP4WH48pG27sUbqT/5FIIbwZlWORwGTQ8X5yUOsemWmjB4D7Ofk45+
	 sWuf6uFzK0KGdOT4uJrzAYFz7E/+WaaWDxCDIZb1JpyWHChdVfb0QNb7cIbkFixGLg
	 XejxDZYgrxSEAKqp9bdzAzByVO+E/W9RXwmAvJ/1ep8pG8VDiMdKVbpPPjVsQB7fJd
	 hn7C5+jq0jCHK4yDz0XDfjMVuxcZfSQUxuqX3lZDGgNuMXETXuh4enWSQHVhZzy05a
	 qxHntgZNRCdTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9253D47798;
	Fri, 13 Nov 2026 12:33:33 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 13 Nov 2026 14:33:32 +0200
Subject: [PATCH v6 2/8] iio: imu: adis: Add optional self_test callback
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
Message-Id: <20261113-adis16607-v6-2-3f678719942a@analog.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
In-Reply-To: <20261113-adis16607-v6-0-3f678719942a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794573212; l=2180;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=tkzZy4kOyhyn9i1xmuSSgwdCRKGw+8zTfZiJqELNqH0=;
 b=pgGvzwGmPoVM16HB7sUAC2LP9nqntZF5PN0k0yM2o5UPUqVvReJUbCfcq/vKKOx3YVThrgip7
 Wdp3WD1OlFXBlfPoTN6FVg7QHkoq0+t831iS30Rm1+9QpbsB5B5DOSt
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 8bit

From: Radu Sabau <radu.sabau@analog.com>

Add an optional self_test callback to struct adis_data, for devices
whose self-test doesn't fit the generic mask-write/sleep/check-status
sequence. Purely additive: defaults to NULL, no change for existing
drivers.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis.c       | 3 +++
 include/linux/iio/imu/adis.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 793e3b6b0ea7..5c3bb7259037 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -357,6 +357,9 @@ static int adis_self_test(struct adis *adis)
 	int ret;
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 
+	if (adis->data->self_test)
+		return adis->data->self_test(adis);
+
 	ret = __adis_write_reg_16(adis, adis->data->self_test_reg,
 				  adis->data->self_test_mask);
 	if (ret) {
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 97323b8d1cb3..c09b381eb619 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -52,6 +52,12 @@ struct adis_timeout {
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
@@ -82,6 +88,7 @@ struct adis_data {
 	unsigned int self_test_mask;
 	unsigned int self_test_reg;
 	bool self_test_no_autoclear;
+	int (*self_test)(struct adis *adis);
 	const struct adis_timeout *timeouts;
 
 	const char * const *status_error_msgs;

-- 
2.43.0


