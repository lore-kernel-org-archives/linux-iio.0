Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B893FCB06;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=dBBpb1mWD55N0AvOwSPOOk7z9tSZWYra/mcv1Iljo9Y43IBAo0tVZLC+M6KtePQ/C1RxzSgoY43hA8mfi+/DHpue12ONruC1rQ5abdsHBzG+6DRjuQmExvpvnApHl9xW2O4EDrwmOaH6MU1ElRSMAHgRKaveNh4IBBvZ4E165sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=kxWf2yrbRlNkPFnXK5Px/ytjzc2qowszjnLUder71N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQE42B7p7xYFBHw74NAo34sqrMr+m99c3SNRr5lIdZltTedL0c94RK16eiDH8YcpRaxZk0Iglo2UpUzf4DegWsvVl2mPv8Q3P/704xuH1+rERi8+eo/Sc65XnpksWz9ZZGMmvDsbdliK/+YnbDiPioas+uABAm5wyb+C/CVd4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFfa8drP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFfa8drP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60F69C2BCC7;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468058;
	bh=kxWf2yrbRlNkPFnXK5Px/ytjzc2qowszjnLUder71N4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NFfa8drPb27kTtrdtbzc+x45yDcmdPVAB9ShVZ4so0cmEwVoCos9muyBF0LGI+LF5
	 mhS7TodKBPZzcmnGlSObU+IljLLbrAhMvoI1PTKLnRq/rJYVTbhzElZUwq9oUSE+uM
	 GO3hDofNpZwEZWW9zODqBuRvUXcGRxrv/v1K3hr6PRRma+ow92G6lmDKaJyeKi9sYu
	 df7GwG5+rhGyKRqONFhLJvzNPELob9fVfxqNcpStK/1VYmW+cJHmkXSR9YVN9kMb6M
	 LuWg63DEByj8SxAt5DyUw/OditEIpVhWbHgBtmcaTQsLy0A3z41Nd70lmWkus36fHQ
	 ie6K6gopOIIwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57500FF8867;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:42 +0100
Subject: [PATCH v4 12/13] iio: dac: ad5686: cleanup doc header of local
 structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-12-bb8f1cbd68e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=1894;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=7fK7LzhRbt6H+qVkvDS3hfVh7J2ix4vmxSrC1uBPzCI=;
 b=VugNGuFE5jd7c2QljSlg4tqBai3LmahN+M53MRFeZmx4FBErYGHnPNqn3JO+X6ZGpuoA/A/jI
 hNxZNIuGxb/AujHpE1ZKv8hIdj5qcI+vXv2q+TXy4a4qHogOTmB9Re5
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
index 0ba4168195f5..4397ffd2e236 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -67,12 +67,11 @@ typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
 
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
@@ -110,16 +109,16 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
 
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


