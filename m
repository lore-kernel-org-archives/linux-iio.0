Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB923C2B80;
	Thu, 24 Sep 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261328; cv=none; b=C4xRQccSSkol7FcSfHqYXSUCeygwFt6qVy3h+CWwIi5GwYHJdhNcZREg/KNpvssdDgVHAF6lGEpn4G8BXtMK8YdDfmZHre9wJNyYFDNoDvEJ2u5FjUfoINTSdy8R15XKsQnsNnSIuEPTp8m5HtUSSwc34S4piaK5x7Br4rycEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261328; c=relaxed/simple;
	bh=s4qodIDwspgPlY1Y6HFpJuYbOg3J6XfyAUPKWOKNzpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tR+SXP4jw0DVL9cZjmkoyLxxPCRKHZsdtCqD1x0CPQewXk+WnJU9KQeegglRbnSktfGEuIBSE4GpIBPmpIQ33EcrQlXKZmW8f90QCcCYm7cxNsuaPfw92opp4yPbqLK+ToW/+PM0dnLm8fLdT1UQp5CJamkJxNTAJclgREAAfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAtCYpPo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAtCYpPo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52298C2BCF6;
	Thu, 24 Sep 2026 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790261327;
	bh=s4qodIDwspgPlY1Y6HFpJuYbOg3J6XfyAUPKWOKNzpk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AAtCYpPoDbWQewrIzMJjO6eyQ5AVE40bAjjFfzTbDgWUI9jl9DO1cVHIssZQPBkhp
	 zXT/kCnmdAL9S5XvjB47hHDRxYSoQQxei2q8616B8Grvie9uD8bLxu9mdpMIbvcbqO
	 A6B3EzGLk9ZQmx+9nnaaJAhzCUPWZj7zKe9wKJnfzP1w1CRqef+POZ6q9l7qvHroep
	 1gSJLu0VgoC/kXyaiaH7qzgfXMT5FxJQsDUjjxYcCRa5+VsPD572hc7/GBCna14qHx
	 g62LQnoaf9af1AzoagKFza/zmN1d31te+wNVqEBPhu9/Z7AkdNBuSfd3KveWZ4P7yM
	 x+6+fCvFE7tBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C49FC98321;
	Thu, 24 Sep 2026 14:48:47 +0000 (UTC)
From: Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org>
Date: Thu, 24 Sep 2026 09:48:45 -0500
Subject: [PATCH v2] iio: accel: bmc150: check reset write error
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-iio-bmc150-check-reset-error-v2-1-b6dc74d7aaf4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBAAv0J6dk1bEKkn/2E40GWFVaFmi0RD+
 LuAH/A4yWRmUpGEKapTMimhkSOHfgG7SxS2Vd8QcL2wstrm2tkUmAP4Ds1BA7aEdxCKNACJBIG
 0cF673OuqztSSeApd+b3lL+WP48vfCIe1uRotxyHIZ/uPZvX+XI0GDPgCDXnM0GXHc9NV/Nhj6
 FQ5z/MX4NnWPtoAAAA=
X-Change-ID: 20260923-iio-bmc150-check-reset-error-389b096b0ad4
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Olof Johansson <olof@lixom.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Carlos Casadiego <cdcp206@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790261326; l=1746;
 i=cdcp206@gmail.com; s=20260921; h=from:subject:message-id;
 bh=atwOd5gI9arDmyV4IEUHyQAiqnNRy5dIUk3BoqWk3+c=;
 b=mEHoTVdxu3VMl/0b9gO1YV64W44bmxiEmvbvwx/2Lu1pIOsoI48RyKRsPrWzpmJw73rtgmWY+
 kDwFPxka/UyBfg9qmxEtgbADY99HVaA4Dx5HmybtcB3OGeQvMSDH72C
X-Developer-Key: i=cdcp206@gmail.com; a=ed25519;
 pk=Vr3c2AUi1oYbgVkQtRSsWin33frZn0vGGq5g04VWmH8=
X-Endpoint-Received: by B4 Relay for cdcp206@gmail.com/20260921 with
 auth_id=1041
X-Original-From: Carlos Casadiego <cdcp206@gmail.com>
Reply-To: cdcp206@gmail.com

From: Carlos Casadiego <cdcp206@gmail.com>

The software reset is required to bring the device into a known
state before reading the chip ID.

Check the return value of regmap_write() and abort initialization if
the reset command cannot be written.

Fixes: 1c500840934a ("iio: accel: bmc150: reset chip at init time")
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
---
Changes in v2:
- Remove the blank line in the tag block.
- Add Srinivas Pandruvada's Acked-by.
- Link to v1: https://patch.msgid.link/20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com
---
 drivers/iio/accel/bmc150-accel-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 46bb36d9366e..43a39e1ccce5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1561,8 +1561,12 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 	 * Reset chip to get it in a known good state. A delay of 1.8ms after
 	 * reset is required according to the data sheets of supported chips.
 	 */
-	regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
-		     BMC150_ACCEL_RESET_VAL);
+	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
+			   BMC150_ACCEL_RESET_VAL);
+	if (ret < 0) {
+		dev_err(dev, "Error writing reset register\n");
+		return ret;
+	}
 	usleep_range(1800, 2500);
 
 	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);

---
base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
change-id: 20260923-iio-bmc150-check-reset-error-389b096b0ad4

Best regards,
--  
Carlos Casadiego <cdcp206@gmail.com>


