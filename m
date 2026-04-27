Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC430F927;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289411; cv=none; b=ueXfzvE4Qhu10HPCVQdciKmhpA8DomuFG7neICcc+2B0hwRYzArIfIzCyiQk+dWygVbfpSAvP8MpIYXvsdrKoD5XCVrSACHeMNZ5I5ePaptfFCN+T+2xHRGA4G8o2wP471wjdnMHHEYdxYYYRVqha0GQ4efSyFtjgHBlA0wSzMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289411; c=relaxed/simple;
	bh=zdzr8vwzfwb8lBqeeDr1+g5aNqFY82b23F5+tM1U38w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLYUfACXbxo8nYBcFuPl30jN99TVgTNw9AvleWRr68A3wxK7FVGCPm9c1yA4GpsJUDnH7Fby9Oo9XyItPiUXjOLMGbdTJSBTqmtfnWEmjRBL8WMv1PS0G7igivi9ENhrTw8+CygYzpd7iAe/NlvqCQ/wXsqyqv4Wr6o79Xg6uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY+MRAAp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY+MRAAp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89BEFC2BCC6;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289411;
	bh=zdzr8vwzfwb8lBqeeDr1+g5aNqFY82b23F5+tM1U38w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kY+MRAAp1jxALERd7938dML55l9nllKSSsf8h7ORcK8jG9y8lhYhLbqpuz1WGHRnC
	 BPg3oMROKzkfIxwzceIz+yOQ0I7plxnxqukm4mY/pmRQxjdBp62d9oPwoZ1/31SwBw
	 QpehDYKsBxGEa3yIms+UalNWs7rKef/jKN017hvTXfyHndWwGdnNPoszjsd4UsUVoL
	 tTZ0vAujRwXP+bSknR4Msn0dqQHo0blUKoh5PBgHwHEk28bPHxbf9auw1eeTbyrNe+
	 ZDb7zy/w8Ks9ABJN2tGQmyrQWpw52RYstoynEfeoisb2nKcRxBh2E0dzgDVGn3vUut
	 avuE53HkLgfNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C2FF8860;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 27 Apr 2026 12:30:17 +0100
Subject: [PATCH v2 10/11] iio: dac: ad5686: cleanup doc header of local
 structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ad5686-fixes-v2-10-188e05199368@analog.com>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
In-Reply-To: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777289409; l=1834;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=/J1GoS+jTlzr+L+zdp8CVtiFjI0oGT5Ng1SIGuun7io=;
 b=mHNo4fFFOzzn4xJl0p9wDHczrAk098qoCOFbUozuSC2yogo3PYs1vzduLfxeYGrDnujDjXZFM
 508d2Jvq2I5DuWf1+xwyDUNZCl8Ml3FvghtkXm/erugNxVPw8mglNLw
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Review documentation comment header for ad5686_chip_info and ad5686_state.
Update variable names and description and remove unnecessary blank line
between comment and struct declaration.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 2f5c1f2c67bf..135935265c10 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -65,12 +65,11 @@ typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
 
 /**
  * struct ad5686_chip_info - chip specific information
- * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @int_vref_mv:	the internal reference voltage
  * @num_channels:	number of channels
  * @channel:		channel specification
  * @regmap_type:	register map layout variant
  */
-
 struct ad5686_chip_info {
 	u16				int_vref_mv;
 	unsigned int			num_channels;
@@ -108,16 +107,16 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
 
 /**
  * struct ad5686_state - driver instance specific data
- * @spi:		spi_device
+ * @dev:		device instance
  * @chip_info:		chip model specific constants, available modes etc
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
  * @use_internal_vref:	set to true if the internal reference voltage is used
- * @lock		lock to protect the data buffer during regmap ops
- * @data:		spi transfer buffers
+ * @lock:		lock to protect access to state fields, which includes
+ *			the data buffer during regmap ops
+ * @data:		transfer buffers
  */
-
 struct ad5686_state {
 	struct device			*dev;
 	const struct ad5686_chip_info	*chip_info;

-- 
2.43.0


