Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D43FB7EB;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=tXemPXMETmXE7R9WPoMU0P6JQKjvONNGE3gNk69ZfglVYMj029rAPCR7dKTOcdMX9IL1gvnIONASXVfY3agTm94Vd1tyYvpOourNC1qxFKipuEAjHG5hIAeRK6xlWrm1kRY0g3hTtSQO/xulgph2Xp1rsXMkzFdMf6VvTgMbEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=l6b0m/8tpPZhcd1xoUPK+UYPNIMKo+diyowWW/xZ9TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Obez5gZmlz4v/qolARSYdcMGoT+2BW7xpIxZ4KZ89X25IAs6GgAdhJb9gRTKsQYjUTu9X0Ca5nd6PXgKW0Z4LNG5G6/HjMA9GY38q/dt/Fv5OXV9gy711AEy1DG4rt4MxIQXI0CY3aBp58PQwT3b6zVsseuY0VoTDnOrTmZUgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juMA2E/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juMA2E/4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B89DEC2BCC7;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468057;
	bh=l6b0m/8tpPZhcd1xoUPK+UYPNIMKo+diyowWW/xZ9TA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=juMA2E/4ZgAvK1zoj0e7C3B2rH916GVbqYzvw5zZTKi5cG3bayMGWwE5bUBsHP7MA
	 EGMwa2w7xH+nJUHJZO/dj+zs7ExqcX39vxLE+lDac2T8laX6RQ/mPd5kzmp5Gy4qya
	 EQbvyf2w1QEcV1JnljqNOQTT7CF4ufyisFyPmZ4hV1RMKhS9R4wwdleN3hVVIkn1We
	 ngxMKpdgVLjaKyUgLOrWWc0Pjz8H06+t1iMRLfRodOcCkzEUjfUcq783vYdt/oFAjC
	 Vm+t9eCfB9jMRrHT1VX+/tiqBNpCkXSvv/rcgNu8WoxBL2rSoPTMeCDJPjU60m8qhF
	 0ps4VtfmuSvsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAE2CCFA13;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:33 +0100
Subject: [PATCH v4 03/13] iio: dac: ad5686: acquire lock when doing
 powerdown control
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-3-bb8f1cbd68e1@analog.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
In-Reply-To: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=1395;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=WJ9grwmFpTnUy61Cm75lOSuLfVSZ+oTAauaTKqq2DP4=;
 b=T7BVHu5psApAgmbYyqcoLyIDl6hmOfPSHkeMbNdd/TivFEWQ8YxMpQVYsJ93XLzftGvtvFqgn
 DJPEQsGqh0pCXm17IZJevbWiFr5nRN5r4FIlmureG8AdLLH0KJqiXxb
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Protect write access of pwr_down_mode and pwr_down_mask fields with
existing mutex lock. Each channel exposes their own attributes for
controlling powerdown modes and powerdown state. This fixes potential
race conditions as those functions perform non-atomic read-modify-write
operations to those pwr_down_* fields. This issue exists since the
ad5686 driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 076fe8b8bd85..69358dd66cbc 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -39,6 +39,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
 	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
 
@@ -77,6 +79,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&st->lock);
+
 	if (readin)
 		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
 	else

-- 
2.43.0


