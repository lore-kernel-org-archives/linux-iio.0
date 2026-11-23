Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440351;
	b=AtDrHWUl6SXyEvxqp1C+HU5bu/Vj4T1R5UQ3BuW9DN7osctYhcI6Nkz035y4J1TNt5pt
	 vz6/hJzZRf/hhbB2PhcSjvMnqwGFy/oaCe3Z9KrzjqYdKWhLKNG22jsqWws3/huFHUwDw
	 EGF/fDZx1xzNa7nVFpOVegHlEOPyttbv59VHRyY7IRtBhEr2InDyxTYN+Eqk9sMYj0JDH
	 9a7HWEMLrpjhWW/kT91naYNokZdN8tmRbzjMHB9isJmFKMvUxK4wAYxFgDgd/UbyaFvOE
	 bxtLN1F5WplFHdoQ56izTK+3NOj25au7h/g87MrXWm3alxi0dwvBsdi8i5VsRsZN/bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440351;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8i868gVBYL2QSZu3qyxut7pzy7DbyOL2CdSmfH17eOQ=;
	b=3PY6O7oZDAfXQM6qQVGzvdLf+41Wq264jsGLR/LPymRZSLdJ1Vt6tok/nqO8vqiTia0h
	 cbysqpT5y4WJdl9WoPsaoF84QIREAYW1u0BpY6AVZl61QNce2EgLBfY/DqZqfFH0ikwql
	 7jWDfz/Ze56pvulHCEPbPmgzcSBfpwEfm58wV2PRC47v/gBjsn/9quJm51t2YSk+Y/tBN
	 fyUpqFvsL1KOcJNZpfkuN2ac9t3L8eZV5nLvR7C6HOGv4zEbu4LOIbvcDnOSL4oIDfOnC
	 WPZUqkh/ZZZx9sMBuZ5uDD0/waJRXx4CBZB6xhfs2UlVgghRVdY8V9hKMgQ1QYIJAog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XF5e7Ztk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC860A382E;
	Mon, 23 Nov 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XF5e7Ztk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795440350;
	b=PcpGEkchZwBB6U5RL2KYVuiOeaf64jBSxZBtUJz6XwhXwuU/QP4WXzo1SgiIlHNfjpTc
	 66Mv/5k8tuUomVgZEzzNDp5EsyfvfOc+FmKj9k4ZpzQZjrJ3QeLdCEd3igxRblBruwKZf
	 ucwHmf2FQMS6wiX9TzwcCaUILRAHSGyNfXcy0oAA5wzqkXsuggviLK1zFvc36x+RYSp7N
	 NyOR6eUcC/iO7lj3aa63C0W2F/qULoMlwK7Gw32wHMsMtafAvDEa3lDLsOvuYkupynR4V
	 qWPCSOKEKoa5bJw9ppgiBSP6gKcaxq7cXywUdGjQHrSbY6ppq50RmlXsR6vWnWdWJpA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440350;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8i868gVBYL2QSZu3qyxut7pzy7DbyOL2CdSmfH17eOQ=;
	b=EAjLjdlpFSdODPZWYMET5rUvxTObDhd55F9Q0UL1cWqXQjxcYRjbWIgZHjqnm5w3wgvY
	 +dQfoAgnnGZ5FH/dxlwqh7CX+FpR2g0EW6paxiSLq8PB4q7Pj3nycFLV/fu2pcQEmxiVa
	 2B9Ta3hy18u5krleKKTSeO5C2ij65773tisrkNpl2jLDDdzStNhyKFwdp5ztIzcl+2oBy
	 GSHrxzncLhUSy2g58Oky24O1BS236FPaZTrtR+VUKwUt5MuVS9RPvn2HHRn/wxFOH3b+4
	 hmJdiz4diCtobWl2jXMm5YVt5bXxh/5N3EG5H47UQElS/O29r5iaCWlhOQwF2cZuYIQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 70DBE1F000C6;
	Mon, 23 Nov 2026 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440350;
	bh=8i868gVBYL2QSZu3qyxut7pzy7DbyOL2CdSmfH17eOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XF5e7Ztk1wsI2F4y/USEpgJwW9w5DJ1R0ENMh+L+/5A6ObA7JRWDpJLt6GxB4fqjA
	 qYJOskG2VlKhvjAw1XAURya3ChV4Rwgm4004/mewDb4wKRJWo5SU25BJCevjxvXW9o
	 7UOmy2UXIpbqxVGPSVfMa2s6zLxlPuV7zxTUvaUsBd9OcaYj146i6FlRUavKOLPzYh
	 M2FFxNLfIM54CcWoIw7FlG0Ch0AsvmQSlWK9MnXRFz4AS27Al8tER6smG8hJrzYMBA
	 iubvNwW1Zia3zfuHG/xTfnZvAe134A4eGnBXHt3Cm0HYQQzK+Z0f4YPwFhskCek/5o
	 dES90kwDu85Bg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1EBC04C4A9;
	Mon, 23 Nov 2026 13:25:29 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 23 Nov 2026 15:25:31 +0200
Subject: [PATCH 7/7] iio: imu: adis16607: Report loss of external sync
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
Message-Id: <20261123-adis-fifo-v1-7-f6ad9e493e19@analog.com>
References: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
In-Reply-To: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
 Radu Sabau <radu.sabau@analog.com>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795440327; l=1798;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=Cp1Fu3Up9G3W8L90aBKjL0TvrVLAhTasEOIocguqkbg=;
 b=M4ct0O7E+ID8rn8AVHwZd2n77cUbhjyYPlkWuVA4RUjG+s5vsLCBsQgz0NLgB8/cpLjPdRsny
 aG97jOW3yyPBxvzot11SWkG/K5oz0IykH+OJ4b0wz9WLUZgt/Vng3sl
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

Loss of the external clock or of the sync PLL lock raises DEV_NOK like any
other DIAG_STAT flag, and the interrupt handler already reads DIAG_STAT.
Warn about SYNC_LOST and DPLL_UNLOCKED there, rate limited, without
stopping the capture, since a short loss of the clock can recover. An
interrupt raised by one of these flags is handled even when the FIFO
threshold is not met.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16607.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index 60433c97a855..dddbe3c7fb52 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -83,6 +83,10 @@
 #define ADIS16607_FIFO_THR_MET_MASK	BIT(0)
 #define ADIS16607_FIFO_DATA_CMD		0xA9
 
+/* DIAG_STAT sync flags */
+#define ADIS16607_DIAG_DPLL_UNLOCKED	BIT(1)
+#define ADIS16607_DIAG_SYNC_LOST	BIT(2)
+
 /* FIFO limits */
 #define ADIS16607_MAX_FIFO_WM		38
 #define ADIS16607_FIFO_WORDS_PER_SAMPLE	26
@@ -396,8 +400,17 @@ static irqreturn_t adis16607_irq_thread(int irq, void *p)
 	if (ret)
 		return IRQ_HANDLED;
 
+	/* Only warn: a short loss of the clock should not stop the capture */
+	if (diag_stat & ADIS16607_DIAG_SYNC_LOST)
+		dev_warn_ratelimited(&st->adis.spi->dev, "external sync lost\n");
+
+	if (diag_stat & ADIS16607_DIAG_DPLL_UNLOCKED)
+		dev_warn_ratelimited(&st->adis.spi->dev, "sync PLL unlocked\n");
+
 	if (!(diag_stat & ADIS16607_FIFO_THR_MET_MASK))
-		return IRQ_NONE;
+		return diag_stat & (ADIS16607_DIAG_SYNC_LOST |
+				    ADIS16607_DIAG_DPLL_UNLOCKED) ?
+		       IRQ_HANDLED : IRQ_NONE;
 
 	ret = __adis_read_reg_16(&st->adis, ADIS16607_REG_FIFO_WORD_CNT, &word_cnt);
 	if (ret)

-- 
2.43.0


