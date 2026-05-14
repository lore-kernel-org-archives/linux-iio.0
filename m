Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A503955E8;
	Thu, 14 May 2026 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758709; cv=none; b=EHOh0QRti5iJw2oQbLIGlecBGuCsz6Cabz8j2tHpBBpLvyV6EZWGaKprkU3/IHZsS985XvNpyDP+bUP6C6i+rBYI7wKVHaA2v5Le98o2ZM79RkJEDNkBq4zyS1rTTo/efKQr0DiSDH1Yr1aah32WWSdmnoFOjy5fJuCsjSPyC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758709; c=relaxed/simple;
	bh=qOeqdQ7ci5c7vG5MOUmli26m37bFzCxGqZUBtcMv3/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X3qpLq3N2QLnSPQWyBPDs6eDWLKPMbUjqrQdZeK5vrlg/kru+HhWlRROT6/DTogD5A4lxESFJsHN6vHs1pbAwbsKB8AkCnt4hAuM1pLYqHJkK/S+9GD46R92UWoNHK1Q2ue0/X7ze53ETI8FojBa67Kt2Tf6L6yVHLX5BK2cjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARKPm1Bi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARKPm1Bi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72B66C2BCB8;
	Thu, 14 May 2026 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778758708;
	bh=qOeqdQ7ci5c7vG5MOUmli26m37bFzCxGqZUBtcMv3/k=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ARKPm1BiAdHsRG1zCimKm4DqhBCtx5cSb+y7Ou/x2pZAiZqTyRGbCaY24KeZEzLrg
	 xJIWXw1Rhq0euiLFPoNP9mE0X1uO3q/XPsNGgQxS/5sE/vuMLry+UppzkZ1myYoTeo
	 Yd0jhlNM2ZlbnD5dGnDmHR5NzGn9C5hCBycJaXjmlS8HZnQqb0x1tgq7jTXzf4/qul
	 5WK4aTZf6eOMZhrW/gOVaVShFFpqkv9cjGiEEWU/5eSkDKmSZ61RwZvSE+/gaUE8Lg
	 DzAmFLG78aMvV3J53Q/idmXhRnqnU8BsKC2pMOf/1vP31UdabksvmjiUKymCFquE7i
	 NANWNDRxr8w9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D9DCD4F39;
	Thu, 14 May 2026 11:38:28 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 14 May 2026 13:38:17 +0200
Subject: [PATCH] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
X-B4-Tracking: v=1; b=H4sIACi0BWoC/x3MQQqDMBAF0KvIrB2IoUroVYqLwfzaQRPLREQQ7
 97Q5du8iwpMUejZXGQ4tOiWK7q2oekjeQZrrCbv/OD67sFJ5ox9S9hhvMAyVk5IvEIWjiFI6KM
 PMjiqxdfw1vPfv8b7/gHj0abRbgAAAA==
X-Change-ID: 20260514-magnetometer-kernel-mem-leak-d88a85d28a60
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778758707; l=2174;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=GqOXxU45elozlqyCiK4X26ELkyrFrvZVLWhrLgBFlvc=;
 b=h31IQxZQ1kG/gxFRDpDa3i+MGZyJqxMm3jAJuJz+YEASakyBIDnUtnqy8/JHJeyuFbOYXG5v5
 +ebElN3ACRHCyFhMu0LVJZRA04GwZ5fLrL8Z3pnLhF9rcOMyP81LvR3
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Currently in the AK8975 driver there are two instances where potential
uninitialized kernel stack memory leaks can occur. If
i2c_smbus_read_i2c_block_data_or_emulated() returns a value less than
the size of the buffer, uninitialized bytes are retained in the buffer
and later the buffer is passed on to IIO buffers, potentially leaking
memory to userspace.

Fix this by adding checks whether the return value of the function is
equal to the size of the buffer and subsequently if the value is
lesser than zero to distinguish from a returned error code.

Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513-ak8975-fix-v1-1-104ea605dd54%40gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b648b0afa5733fd7a54bdf2b8f92f00e924c074b..9d23c8136291a52ca9ab928d81332aa32933fec6 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -756,8 +756,11 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	ret = i2c_smbus_read_i2c_block_data_or_emulated(
 			client, def->data_regs[index],
 			sizeof(rval), (u8*)&rval);
-	if (ret < 0)
+	if (ret != sizeof(rval)) {
+		if (ret >= 0)
+			ret = -EIO;
 		goto exit;
+	}
 
 	/* Read out ST2 for release lock on measurement data. */
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
@@ -871,8 +874,11 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 							def->data_regs[0],
 							3 * sizeof(fval[0]),
 							(u8 *)fval);
-	if (ret < 0)
+	if (ret != sizeof(fval)) {
+		if (ret >= 0)
+			ret = -EIO;
 		goto unlock;
+	}
 
 	mutex_unlock(&data->lock);
 

---
base-commit: 86138b484d6367a57312f69af4ec958806c2673c
change-id: 20260514-magnetometer-kernel-mem-leak-d88a85d28a60

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


