Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E24C6D;
	Mon, 16 Mar 2026 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773630058; cv=none; b=JYNstr5wO9EZdnLI3jnCvoRQYWULDelgUPWAPbyF5Jbifvq91gdTLiKxrLHqPAlfmnsQSck0TJM7acSydjjnjJsUbI0O3mkD9gJkl86/nKCPd4wAKpRcc0mR4lNulseHIA+Pi7X2ZfYerj6lUCmE0dq9Dabz0ATCRkngV875Aj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773630058; c=relaxed/simple;
	bh=7n3XWwQkTSTYZWTGs/j2GKQm8DXZDI2s/DZ4MDmppHY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Eal9tfaT6x4C7xU5KLnpAkUJH8mQ+Z7i4mZZjKL5nkGhGZ6LD0CodCVDvVqzezShXPblWIst09jLTEKRJ5FDHxiMKR3pUPpLwuaDrpaCbuQi+je8wjnrMXrdNapfIj47DnICCzFDzHZNeL9k9eZbGVDRiNlaHksMaSZRT33aW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 16 Mar
 2026 11:00:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 11:00:47 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v2 0/3] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Date: Mon, 16 Mar 2026 11:00:45 +0800
Message-ID: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1yt2kC/1WMQQ7CIBBFr9LMWgxQpKkr72G6GGCUWdg20BBNw
 93F7ly+n//eDpkSU4Zrt0OiwpmXuYE+deAjzk8SHBqDltrKXvUCgxdmGJ1EJ0eHBO25Jnrw+6j
 cp8aR87akzxEt6rf++0UJJQbUFJyhi7XmhnklChv5ePbLC6Za6xepgHuEmwAAAA==
X-Change-ID: 20260313-adc-479b0ab09bae
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<morris_mao@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773630047; l=1657;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=7n3XWwQkTSTYZWTGs/j2GKQm8DXZDI2s/DZ4MDmppHY=;
 b=xvKCj0NDWh80XBGmiwTSZxyraKDRRfynknLqGlG7iXkL/veXU8GCyWp8kw8rfs9DUjr0S5ccP
 RkU9xMn/VTLCwbEk9pEMJzSI5+c0bkixRI97lp1vxZZVaIddC5Fx+4/
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

For controllers with battery sensing capability (AST2600/AST2700), the last
channel uses a different circuit design optimized for battery voltage
measurement. This channel should not be enabled by default along with other
channels to avoid potential interference and power efficiency issues.

Changes made:
- Introduce aspeed_adc_get_active_channels() to return the number of
  channels that should be enabled by default
- For battery sensing capable controllers, exclude the last channel
  from the default channel enable mask
- Enable the battery sensing channel only when explicitly accessed
  via read_raw()
- Replace hardcoded channel numbers with ASPEED_ADC_BATTERY_CHANNEL macro
- Add helper functions for cleaner channel management

This ensures optimal power efficiency for normal ADC operations while
maintaining full functionality when battery sensing is needed.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v2:
- Split the changes into a series of patches for better clarity and
review
- Link to v1: https://lore.kernel.org/r/20260313-adc-v1-1-7a2edb4e5664@aspeedtech.com

---
Billy Tsai (3):
      iio: adc: Add battery channel definition for ADC
      iio: adc: Enable multiple consecutive channels based on model data
      iio: adc: aspeed: Reserve battery sensing channel for on-demand use

 drivers/iio/adc/aspeed_adc.c | 75 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 10 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-adc-479b0ab09bae

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

