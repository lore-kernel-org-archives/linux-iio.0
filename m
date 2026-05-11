Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B8372ECD;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498780; cv=none; b=q+tWJ1MutOAIVFDvmhINDTJ3DhPzk2FZpY6JXdwFg5o+LRzffiWa7p1AjFy5tl17lvevt+XS99lvWQR9W9SLP8NYWbfq2V/63VODxrAy8UOOCDnxA46fXPaUEAv4QMDTwyR0epBXmcK2FBHnylhVBs2mOtnneOZWJY6Wku4usX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498780; c=relaxed/simple;
	bh=YF/xA1eULbp2hbNahc5bLSLJSQTEu+xoGtIQF4b5vtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHRntZmrNJ0LqP4O6/2i6ww3gwMg1OAWeGnBhpak5XUhsk7RdaNh0tRaFzmkhExwvAtX/HR2f7U5kYkrcDbRHiG/nkNl/uYiEervsLnQM6jQYJz+AZBiRjCTNwLJWXOh2zNp5cNwNpRtbyDsaKbkiTBSv42tzOcIuk5rLnnGVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3nZdPX7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3nZdPX7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8AF2C4AF0B;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498779;
	bh=YF/xA1eULbp2hbNahc5bLSLJSQTEu+xoGtIQF4b5vtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L3nZdPX78cQgWyx8PqVPOLL+dxrLAsieuD2746z/Ca26mbGMthC+hInuJpB7KzKQr
	 /3mNMVWe33HSi7LSPSZwAoe/HmUifdMJfTLU9jdp026VkIxuKIrmtWL+4ZEkoMLCau
	 /TLUwGJPuT9U2A6wUt5/Cuz8CSgfaThg8HToiZW2w9SHdyka76fdqw0HwOocoFGH/I
	 c9wGugFfJUcy4Y3eovYuU+6cPg/Pylb+BaP5szUmJ5uW22ZVKOuAhzi8cQS36x/0yh
	 2YZDTBO0MMSUbYF9S2NuL0oysFKmSU9SsjFuL0+SMIX64/Jp5rJyl9fQ+xx5mdRmmn
	 Y9UcsV7Y0xNwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0436CD4843;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 11 May 2026 13:26:16 +0200
Subject: [PATCH v7 7/8] iio: magnetometer: ak8975: add scan mask index enum
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-magnetometer-fixes-post-pickup-v7-7-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778498777; l=1586;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=ewbNSwOSC0k1f6ppPGABML5drGHyj3QXLXQNhui/6vk=;
 b=8vRWaFESnkMXRugrjFcALRwt5DYWjflVQqOWqkP3zlfVHojRl/4mj4qu4CU15TZTnIUh853Dn
 IefvZdhaYtGBZhYl6E7bDrL7VahKKYhZLtmu3SIX/Ei7qyATogaIFKe
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add an enum to explicitly define scan mask indexes for the X, Y, Z and
timestamp channels. Also, update the struct iio_chan_spec to use said
enum for the .scan_index parameter.

This prevents magic numbers from obscuring the hardware channel mapping
and improves code style.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 2267928a136912c901e604fe938e9a17c8cd5607..d87a98090c991508ac835839286da0371d689cd8 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -238,6 +238,13 @@ enum ak_ctrl_mode {
 	MODE_END,
 };
 
+enum ak_scan_index {
+	AK8975_SCAN_X,
+	AK8975_SCAN_Y,
+	AK8975_SCAN_Z,
+	AK8975_SCAN_TS,
+};
+
 struct ak_def {
 	enum asahi_compass_chipset type;
 	long (*raw_to_gauss)(u16 data);
@@ -835,8 +842,10 @@ static const struct iio_chan_spec_ext_info ak8975_ext_info[] = {
 	}
 
 static const struct iio_chan_spec ak8975_channels[] = {
-	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	AK8975_CHANNEL(X, AK8975_SCAN_X),
+	AK8975_CHANNEL(Y, AK8975_SCAN_Y),
+	AK8975_CHANNEL(Z, AK8975_SCAN_Z),
+	IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
 };
 
 static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };

-- 
2.47.3


