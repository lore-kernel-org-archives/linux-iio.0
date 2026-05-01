Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B237FF71;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626921; cv=none; b=WFgOs/fjyGIZZvZaripwIJJzFTu9D22fWgfCquu4yHJsWjLpuXUD5Ij34akNJ6VHAZCOjMJeiF7GHW1koX5ReAzsREVgwc1vlIxUJ1asAYBi79XQFtU6XcuRmgIV2ReuCv9b7WeKykk4TWG4M8s94c6CcphNhMGuLrerqaCXpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626921; c=relaxed/simple;
	bh=l6b0m/8tpPZhcd1xoUPK+UYPNIMKo+diyowWW/xZ9TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ocYkhJ0CLcxkj3YdMw/Bz8/JkgTTFf2n77PaBBigD3oH19mVhX1ddnCye3c6FY/D5gFAWRLAV3+Rce52qpGBSWr3f9sbBi0mFSZ/XyFGNXniCscF091udDf6O0YFyjLDcHspLen07p5qkqHgfj84SKdQAJdJwsh9mDs4z/I/X3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru4rnU4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru4rnU4V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA6D7C2BCC9;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626921;
	bh=l6b0m/8tpPZhcd1xoUPK+UYPNIMKo+diyowWW/xZ9TA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ru4rnU4VAsE6hKgj3JABIie2fnCCoGks0AzoRuy0sjHtH79DsX0Q/IJG2Ctg24QOr
	 VJD0u2B8Z2oy9qdfeBsYCsjvfuYucZY2frweT9weKSN8OCPYqxFxqdq+bwzRT0jUnk
	 o13MxmYlaW2QvFaj3WS921su0miRHEnvLORvFvs9JsQLr4N9SFpTX03iWvoXfPQLNB
	 YSQ5NhJqUACP1okKRRlyl2onQyQD5vmJ9ZOREPPAnIySz4GtEZxhYeLnpyO1NDUHDV
	 Uy39ZlByn80Q5eDdY5WzdyPYyAcpwfUGOMETmWThiLncuYhYHoZCJULN1k+pt1k1nK
	 svvLMH6xZYVwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A072BCD3424;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 01 May 2026 10:14:56 +0100
Subject: [PATCH v5 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ad5686-fixes-v5-3-0b2f45488418@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=1395;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=WJ9grwmFpTnUy61Cm75lOSuLfVSZ+oTAauaTKqq2DP4=;
 b=68nFv47I5pcDUHxg+UGKwxmp77qDy0Gjc8ap2htaEMP6i1VoyOchiYDtHVj+WyZ3hvTftdR6M
 1FS4Lw/IlzvAD40Jmv6u/NaWx2tLSwPBS+TWOOkaFEUJH/1vPYbdQNe
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


