Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE3416115;
	Fri,  9 Oct 2026 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535416; cv=none; b=hHW63lfngQMBHIo/nW08VHF0aoB7Nek7cgmcNRVct6g5kq0zA6Fo2q9b2mmi5gvRcxCxd4xHwZRz1xcar2svD5uQtzrrXTyOWP+rNoSP8DFcUPQDVvAI04i9blwfGsk4jgIuHvgm2+VQE6oGZP7qoaoMewfWWS6ek3jJOce7Qfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535416; c=relaxed/simple;
	bh=XqG0M6u6bRL5a1vhM/WVj2eJ8b9tocu3HMFRkfWs038=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eE+tVOix9d5ZiMI3k9XNs72edIuNT6+av3Sc9uyHSHQVI57nMSpHKJ9S5gPtRuR6k3tH/LiRVzrpfOQuyQ1OXRD4hgzjAeo4R3fkU/FEZlJP+aJjknAR+hpeDWAP7oZ0gKbDKV2WKpXjKZHWG/Er5HUOPrvbNzAjvpd8GX+OyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQKhRT9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQKhRT9i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA170C2BCF5;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791535415;
	bh=XqG0M6u6bRL5a1vhM/WVj2eJ8b9tocu3HMFRkfWs038=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZQKhRT9isVt3nosKjhvzD8+0CjbyFBi+7/xZsEm2geTaJ9ocfdpuf6hTuspauS61p
	 DUrzIGlJf6twyDxZWhRmtXaX0+hjbWnK4aZ7I/lNbjsmNgpJ6HMFeuhLuTFpfps89d
	 K84gOoh1VcYPm+fO2C8sihh6bB2rUEM6fdGjMrwNznWDkPsdv/etbYX0G8Ow8udqrw
	 wpAvfFDfl8XupBUtrFJENvbsdhFq7Bp5SzPpyVb6HJEljoqYbQuUxvRmac2y71b3kq
	 PZFPxtX1o2ShPEZmcX59t8sTVkoX2EIW/JZO9is75u6IREToBDN2at7Ifm9UHo3vOC
	 BdK1t7/kk0W+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98BECA5FED;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Fri, 09 Oct 2026 11:43:39 +0300
Subject: [PATCH 6/6] iio: adc: ltc2497: enable line-frequency rejection on
 LTC2493
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-submission-ltc2493-support-v1-v1-6-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791535413; l=1838;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=7ewq8alFihW5vhjreGYIj3/9edWfbR2R3OHLsw5SrBg=;
 b=bNkz55wgzX/UAqbefg/RmsiFTJUcEQxm5UkHI1KyBb3zLZewB2ZGlKQu0X1Zj6IwsYIlqztLD
 ue2poOvZ6ydAOlq9DcEAaJtEXjC1VTmiZjwVwWkU2O90+x+M6hTeHJB
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com

From: Andrei Stancovici <andrei.stancovici@analog.com>

The LTC2493 carries the same second configuration byte as the LTC2499,
with identical FA/FB line-rejection semantics and the same per-rejection
conversion times (50Hz-only being the longest at 163.5ms). The generic
filter_mode infrastructure is already implemented in the core and enabled
for the LTC2499. Enable the same flag for the LTC2493.

Tested on live LTC2493 hardware connected through an IIO network backend:
all three modes are selectable; conversion times are respected; voltage
and temperature reads succeed in each mode with no -EIO.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
 drivers/iio/adc/ltc2497.c | 1 +
 drivers/iio/adc/ltc2497.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 0df2ad9b3243..d668a81f1ff7 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -195,6 +195,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 		.name = "ltc2493",
 		.has_temp = true,
 		.has_speed_mode = true,
+		.has_rejection_mode = true,
 		.four_channel = true,
 	},
 	[TYPE_LTC2497] = {
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 34ea62c2a4bc..af939e57e1f8 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -50,7 +50,7 @@ struct ltc2497_chip_info {
 	u32 resolution;
 	bool has_temp;
 	bool has_speed_mode;	/* SPD bit in the 2nd config byte (LTC2499/LTC2493) */
-	bool has_rejection_mode;	/* FA/FB bits in the 2nd config byte (LTC2499) */
+	bool has_rejection_mode;	/* FA/FB bits in the 2nd config byte (LTC2499/LTC2493) */
 	bool four_channel;	/* 4 inputs (LTC2493) instead of 16 */
 };
 

-- 
2.43.0


