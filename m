Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117996;
	b=GXn0A7UkOeyCA0nINW9ONkL0W2J0fZKL+ziTjpDwJudaft/ovbO4u9OGDHU7WO7Yo4KE
	 J7O2zHxbPD/bqaErW7JBDgP5o5Vhk8c6B1qqw+CEdsCsagPf69eEs53z2CcV6j5HjbDCH
	 Wx2pajwbIENklN5Gi3lioMDmZ/CMJs1y/eP7VSbR106VyKwJPtaRJ2rJsGdvQHwd5aS+A
	 MzbtqM5Jl8WgxrGJDqlNLzPyfhNimCe04FblRqgwBU1i9Up3+Xcqj3zGXT0pHzgarANHK
	 ZRi4bZKVKUpvjYFLVb5ySLEOB+tYMhx0woGAOAQahZiXpFEMus9c2fwesd2fQn5b1kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117996;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=o6Fkph5h2pAzn97EpT/8t4z5WuX1XaUfqN6Kra+5vCw=;
	b=qd2LNpIOHFtVlssBtRjKnSjIGWd0iMeOohdGQrpwGpT+x/5HT9Tp5W5syXt+qdIrfkXN
	 wd8EXGhMQWKjyoYxQCQn2dd8PX+b9Wgg2QBLuGqHnqzpTfP9W1aA6oMOUgAwQ2yqrQVHJ
	 gUx4PVrLY6Fv+weuxJfFtOnD/7qvsgahYKAOgGcc0av7c9JRAWySA/i/t4B91dni8AZV7
	 pR6dg6W/An/kVFJyEuz0PDGnqXlPiZ8DwG29xUOXvsd1QHwKP+hj7Kd83I+t7yRpo68b+
	 qpfBhH7FbTHJz5YG88PNKGubJxQqZkDEWcqoEFOWEThaDYZpbd12u4yUmaKdvZucYZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xueaaVji;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD060A261D;
	Tue, 27 Oct 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xueaaVji
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA4E1F01828;
	Tue, 27 Oct 2026 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117996;
	bh=o6Fkph5h2pAzn97EpT/8t4z5WuX1XaUfqN6Kra+5vCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=xueaaVjiiCaI32esyB0C3JtMHlf2m4fii2e68LdCx2mHexh9nVwVQ+ovVaYGvc0bI
	 zhPL6jlmVrr9YCf/aRLPu95N7shkemU3aVuzHCaqDXqYW/Sc+G6bZCp0KB5Crz0oX4
	 iT2KzKZGuH5pOFNumDeQzppaFEVSAoHS2wv9igKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:18 +0100
Subject: [PATCH 14/15] iio: scmi: use 64-bit divisions for rates and
 intervals
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-14-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Jyoti Bhayana <jbhayana@google.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=t6VDM2l5au3qJMOWob91wpdhChP2f0xT4UhjYWazRqw=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjN7X9/dv4GrmaPzbHZyOPeR/6E/pU1/J1vOMZDhT
 z81jzG3I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZyeinDgq6Gtglz7Kf5Pomf
 wsDGur/0yt+pKQzzLFZWTn133HTOgct3pqxZ2n2/Le29HAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

do_div() only uses the low 32 bits of its divisor.  Two divisors in this
driver need more:

- scmi_iio_set_odr_val() divides by the requested sampling frequency in
  micro-Hertz, which exceeds 32 bits from 4295 Hz on.  The update interval
  sent to the firmware is then computed from the wrong frequency.
- convert_ns_to_freq() divides by the update interval in nanoseconds, which
  exceeds 32 bits from 4.3 seconds on.  The sampling frequency and the list
  of available frequencies of a slow sensor are reported wrong.

Use div64_u64().  A requested frequency of 0, which was a division by zero,
is refused with -EINVAL like other values that cannot be represented.

Fixes: f774117c96f9 ("iio/scmi: Adding support for IIO SCMI Based Sensors")
Cc: stable <stable@kernel.org>
Cc: Jyoti Bhayana <jbhayana@google.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 442b40ef27cf..0e51e9c16b90 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -161,8 +161,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	do_div(sf,  MICROHZ_PER_HZ);
 	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
 
-	sec = int_pow(10, mult) * MICROHZ_PER_HZ;
-	do_div(sec, uHz);
+	sec = uHz ? div64_u64(int_pow(10, mult) * MICROHZ_PER_HZ, uHz) : 0;
 	if (sec == 0) {
 		dev_err(&iio_dev->dev,
 			"Trying to set invalid sensor update value for sensor %s",
@@ -237,13 +236,10 @@ static int scmi_iio_read_avail(struct iio_dev *iio_dev,
 
 static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
 {
-	u64 rem, freq;
+	u64 rem;
 
-	freq = NSEC_PER_SEC;
-	rem = do_div(freq, interval_ns);
-	*hz = freq;
-	*uhz = rem * 1000000UL;
-	do_div(*uhz, interval_ns);
+	*hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
+	*uhz = div64_u64(rem * 1000000UL, interval_ns);
 }
 
 static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)

-- 
2.56.0

