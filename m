Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF33A4505;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=oXSYYUVsaCoycQmAfjqY4s/niokHTcXDmGb3XYYbEac1fUL3O6XEPwm6GFPj0eij6RuJNjS48jdKMOzlPNdmAlxmk/2MIGJAcIvzrBb3bdcTwHoJZJLyqISOJ6GUaN7CkASx2B7AL4MgIWVW/N+lTLo6TfCdFco+fWuuBNYNO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=6BYp57FnTqY7dgYDlLvbafCG2WJR3R2gjLjC2EAy1+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jsVV4t2BLafwV/ljC+/yfYsITooYX0Hh7a+gsFKA56VqVS40NyAma6f+0m0j4LpztOIaapkHWgeZB8q04rXKn1n9FDon73q6uERpbDNgVlbo6PO5LnIsEGNp63I140mQouX+EEUkcqjZuIddq+qKN06Kbu5JJA8o1FdKimbRE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcBl102s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcBl102s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6165BC2BCFA;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=6BYp57FnTqY7dgYDlLvbafCG2WJR3R2gjLjC2EAy1+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hcBl102s8LeEPFN5V7tEDB90hZDGtEZcYIiScxxKrxGNTXfHZVpEzDxr0AKhJWO8g
	 zmRE7jEbipjAfDGnEAgQ71iau/Vxdv903quWAFuJWHMfzuMi1wkZnoegQtdEgO+Alb
	 /qT4ZP2c9+Lk/tFxU5gM1fKkWbHPExViIbTxZelQYTt/lMsbjOuhAipNU02dTwmofj
	 5JrsL8JyD9lqJkTJAyRItRoLtWcztqigf5vJvn24v2MADqOJ0Mzg0Y3e4UWkRrT9WO
	 5xbWfa8zA6P8acu8T2XyhasJnRTUut/HKp2o9FGK7F4+VQwQxmuhQUhNzg1d6XaamG
	 86SpkNwS9057A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB34CD3430;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:08 +0200
Subject: [PATCH v5 12/18] iio: magnetometer: ak8975: reduce usage of magic
 lengths of the buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-12-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=1861;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=P6PO1KE4H4WDkhTj6+xQlfOfvlMXOvBEi4lRcvei5IU=;
 b=EPi0Cf7mrBm0kIxFMtxtyS+LX6hMb7+g6zg9/5dV/86rvw4lpkM1CEP3RFyPFuZuibB+cSm82
 0i2jUH4muV8CZCgbF2S0QrvHRi8WrYd7PkxFtMepTBwYxQlZy7Ogloc
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reduce usage of magic lengths of the supplied buffer by replacing them
with the corresponding sizeof():s.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index f58cbafb491a5e039b22fc928a6c58dd6ec0f297..fd42e20cd145860bdd1b143409de24b7145f8252 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -490,8 +490,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
 	 * AK8975   |  DEVICE_ID |  NA
 	 * AK8963   |  DEVICE_ID |  NA
 	 */
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, AK09912_REG_WIA1, 2, wia_val);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							AK09912_REG_WIA1,
+							sizeof(wia_val),
+							wia_val);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error reading WIA\n");
 		return ret;
@@ -610,9 +612,10 @@ static int ak8975_setup(struct i2c_client *client)
 	}
 
 	/* Get asa data and store in the device data. */
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, data->def->ctrl_regs[ASA_BASE],
-			3, data->asa);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							data->def->ctrl_regs[ASA_BASE],
+							sizeof(data->asa),
+							data->asa);
 	if (ret < 0) {
 		dev_err(&client->dev, "Not able to read asa data\n");
 		return ret;
@@ -865,7 +868,7 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 	 */
 	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
 							def->data_regs[0],
-							3 * sizeof(fval[0]),
+							sizeof(fval),
 							(u8 *)fval);
 	if (ret < 0)
 		goto unlock;

-- 
2.47.3


