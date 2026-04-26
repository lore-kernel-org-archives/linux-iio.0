Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3453345CC0;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192700; cv=none; b=CBcHYL+03VN5BJmiUEkgOnHfIRoshz7zlXDkj/LZPqnImzpADBdoLDGCsCE4NQaP+yyYvqC0pAMoTKJHvmvQC+/2vLO3zjBFmFwD0tvZ+io+jwoEPMhPcbs4le0yxmHSX44IFWYAXLFSYIBlDWut7YlK/45BWH9XZe5XJvZfL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192700; c=relaxed/simple;
	bh=n1am3Rm9SzJWF+Azvyj1tHTTsTsQ3pwzcWn8m+vf0Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUFXSck7GmkdRtqPgSC7kb6a5lEJRTGYBcYoKktooXD2ATXASptaQWe3w/mX+T9JbFKsJvJwx8A9rAeQbRYgaUseu5JnKwXg5wnABzO3+gHopHnNrnzif6q9LTyCpzCZ4Em1U07lkLlzoeWjuRck1t9t+o67+OhaXdVybscYQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqoVZo3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqoVZo3R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8684C2BCB6;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192699;
	bh=n1am3Rm9SzJWF+Azvyj1tHTTsTsQ3pwzcWn8m+vf0Z4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jqoVZo3R/pSqIW1VmuJPjy4zAKsDNpHsG1tg/JfYi0bUu3cPmgICfcbRxsGMPKsn/
	 8SSmwII6gqtre9+H14bJYi/qyejmh++GKK5mzUL68hFlWDcxZMrBGj+owjaIs/6Xoy
	 eRSdq06GjSv8QmVn3+nOT+HOroIaqVojHSIxbpm/yPA1/JvV8DN7mF4KNB6BjBYUct
	 pU8/lSfVaNDqnEl8D7VkkcqlcFREOtCixLy8E9Jugb5EzEWgKU7d1BcLvvXHLR6cSi
	 RKOh+z50S0lNBZWSklhuwkIfLgtf7f8jeqdrWNC/tTAwAGMtG3GQp9/Eq+PWbXi9hl
	 O8mIq8SAUOkeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12CBFF885D;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 26 Apr 2026 09:38:09 +0100
Subject: [PATCH 08/10] iio: dac: ad5686: fix input raw value check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-ad5686-fixes-v1-8-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
In-Reply-To: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777192698; l=1053;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Jyqj3+FFKyypdm39jK5VmyJy5lEuvWoM3X8faV9LnaQ=;
 b=J5VdC3SHKabbzhvICo8tYevq7BRLLWVqWZ3f9aqHns8S2D7KAC0WikGTH7VKArqdonMt1rbpW
 gyG88+gu0leD+oMUTrOAa0WpB1KnHzVdHwNbmrQFfxSnBjEogV60WvB
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Use in_range() to fix range check for input raw value, which is off by
one, i.e., for a 10-bit DAC the max valid value is 1023, but 1 << 10
equals 1024, which passes the previous check, allowing an out-of-range
write. The issue exists since the ad5686 driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 040a24c62c9a..ab498ec2ed5c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -186,7 +186,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > (1 << chan->scan_type.realbits) || val < 0)
+		if (!in_range(val, 0, 1 << chan->scan_type.realbits))
 			return -EINVAL;
 
 		return st->write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,

-- 
2.43.0


