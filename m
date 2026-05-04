Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47038838E;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=K550qWnJh2VdJniWlOgUAFmka1rKZo5yo5zpHsGvD/4ER6Vd3lZHa5Uy7DX88i67ZeWRXDyaFNvsV0YyqqbAde+UpShreqGGkZPuXYI6Kq4QQUEY7r2lwrMM/KbeWOtJNRU10xarnLUjbjd4yXT76loM/90daCvVkpZ8fbvPIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=IQqw8dqzN87N3kyvLEEH/hIdLkUDhN+PIO0XcgQOetQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRiU1qTgSCFAw0rpx4eUhvndnoBNOxg6itrZh/HWhaC7QMTo5E7MsU1QLt+6XEj9V1CpTLVhHLUFC8kwxgt9GSW1X0Lz/dC0Iu9PjYAJ4+le3p0n1JEjz/4JuplRp2cLhL+gWXaXUaqQdufr9JeZzzpm7n3TNQiTPJ6fiWuloGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlOqoF2x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlOqoF2x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC52DC2BCF5;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888114;
	bh=IQqw8dqzN87N3kyvLEEH/hIdLkUDhN+PIO0XcgQOetQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VlOqoF2xHEzghd99DccqGyCKJVlh4eJL0sZxC56EPs5WtXCOKrd4swaJZkL3wmiTN
	 f33MP6kQr62tPA/UBjR0D/DgjF7AOSMfDvU+I7sKDVCEqX4UUaAFw9+TDJGXFmx0+T
	 BxEM9kWpu44Psyns6vrICVXNil2htRfp9sb7cey4KfQJWGzUinqZfvQF/U680Ffh2Y
	 VJYjXePCUYP7e49QxVeOBStpI1a6dKFriGVZB2BsZgikl4ptQqJMG3xdzFCXGuItOq
	 kJ8yK7b5K/SYjSb9JgvGVgIj/q+EWKBf5rooAcW22GlvFM5s/5HEkskdQUQw6D5aYD
	 M8OQw0pZDno6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B16CD3430;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:15 +0200
Subject: [PATCH v4 03/17] iio: magnetometer: ak8975: replace usleep_range()
 with fsleep()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-3-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888111; l=1188;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=pYNXSLcsScB1UFEjU4yV7Zvmf3IflZ84nydrNj+FmrM=;
 b=kdSsSuCWY1z/qJqtyJXW2Q6dxOy7BKEipYDgYV/AEIYkLhgB/KS9PsBNQ0WHoG3Wdusn3ra4Z
 o8vIWwb6VZ1Afn3qXEoiDz7PRAiTaKcLgaEKXWnirZljidtmii020NI
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Replace usleep_range() calls with fsleep(), passing the minimum value
required by the sensor for hardware delays.

fsleep() automatically selects the optimal sleep mechanism, simplifying
driver code and time management.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index dac0a90c33eebd43f8aeed846c9cbf5fd1a6ab91..a84a05a1b64280e26c428e9752a39380e386c234 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -461,7 +461,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	 * and the minimum wait time before mode setting is 100us, in
 	 * total 300us. Add some margin and say minimum 500us here.
 	 */
-	usleep_range(500, 1000);
+	fsleep(500);
+
 	return 0;
 }
 
@@ -551,7 +552,7 @@ static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
 
 	data->cntl_cache = regval;
 	/* After mode change wait at least 100us */
-	usleep_range(100, 500);
+	fsleep(100);
 
 	return 0;
 }

-- 
2.47.3


