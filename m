Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADE3815D0;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626922; cv=none; b=d/13C/9mQeELGT6bgTQsE2JAqGgOwk37fjIlWZ+XEXYQHPW+M1VY3SyE/UgsLacA71dX2yfpk8inhUcU1iEy6eeDJPAqoODjexgmpS47u4p478fBF/Khxr1L0puxjgzp+FWiaZe7W6Fx8VbLB6NW/E2xC6XuHEFx+ampBGsPHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626922; c=relaxed/simple;
	bh=u8zu46aZYFGibuKEYjYUVhjHGlkJ1ASQ/l0RlSN+kho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCVZVZH85dSzD1cTV9Pw5x/V8dSC8CKtE4W4hXPKCdr4CblUpsis0iNqSxY8M2wIFaVH/3eLNwx45FU2sduiCuKbn0UL3LYrNQ1oGdw126fqqUM6DQG1EyjImGqn6ltgqaL21HRPxGpD5JU06VIwCa8yB2lk9ZnylTZb5hALzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu+Q1ZHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu+Q1ZHe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EC2EC2BCF5;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626922;
	bh=u8zu46aZYFGibuKEYjYUVhjHGlkJ1ASQ/l0RlSN+kho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gu+Q1ZHeAdc8Doi/Ug6SyUy+XFt9gkngw9Gmq/WCMYUvF0xMlRzBrD9FZaSGXujQ8
	 l4fPHiD6AEv1jZgFb7dZBsv/20YIuaa+WVnuTS029nOxkKcKVRuQOal32vzurqiRPM
	 7+ynlnlXfO0JztsyQeRYO9zPIrjPWIRs5i0B/ZP5V1LAEHDLCSKfcg5+l91s4Or6yN
	 0ZTKdU9TKuO4msCBja46eC6GVFQ7SpMvXGwf65Gy2ze+l0nbrfnI+4ZBtuQzrcA2ZN
	 j5gF5udGOLCTyXAvCFmMPbgB1fK4oENqG1tez/pl5MFGWdwpmogxUq/Tzgrk+LGoiI
	 0YF5VhfHFSFSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26953CD3425;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 01 May 2026 10:15:04 +0100
Subject: [PATCH v5 11/12] iio: dac: ad5686: cleanup doc header of local
 structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ad5686-fixes-v5-11-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
In-Reply-To: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=1894;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=4+83aSZnpGuEadPYOq6kP/k+cVfg4F573+ewfHsOtHM=;
 b=0uKj2q4RMxiArBN662T2FQfLHUT0FdxCGMqWT7et1w85st4AjaNFVgA3ZlHLNgbWp6aQY2MBr
 578Is4rapb1A1MadikRGAGs6/4Ocyu3zUoH65yQOOdBg1ZgBpAB99i0
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index dc1961b8c15e..4c38dd43d4bb 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -71,12 +71,11 @@ typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
 
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
@@ -114,16 +113,16 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
 
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


