Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC72F25F4;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289411; cv=none; b=EtOB25/OKvHZWnULrqoa00d5b58/M37CUYXsxzRG0Wroa0aIHZ060/BAWj2HTMKbtxsqufSEUNekgQGC55MmR8NQlKS0C8bUU91/vgfnQ6aaIVkr/zsqXppI+Ev3zCMWg9nicpw9PnJ/0mRo4hf387v4Xqlsq5XHEnQopMNH+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289411; c=relaxed/simple;
	bh=ln2xDqNwzgp1IlNe5nNZRvuJhnMixrpbcxGzvS2tsWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fCvgNvUr0zIKrWTp+Nr2Fekrc5tyLoP0UGUXDug30eNaSfveLbzqnkrWevabnk21Ya+CdQmqzJFzcsmxDyCw2HXi5s+ziPe21lOfZ8ptwEOmW2kczAyS5wpTWAhYKejHzRAiquZcSCtUWmRRCs4nIXCRbHilVNjkRgnYlfIrvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxfaYK1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxfaYK1l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21AABC2BCC4;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289411;
	bh=ln2xDqNwzgp1IlNe5nNZRvuJhnMixrpbcxGzvS2tsWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MxfaYK1lTzn9i2SqANMj2GgtYmmocnEmvr2lGQhobFOQSEvTizvkZ06ThMuza4wc2
	 xhbIl2Y10sVxgCabTsEZEWFpWFeOo+RA4gvIEszZHYrmjwxwIoArr7tQUmt7SLfO+l
	 P/ei9FojJZ3KSdjYLzcUm2t0C7RCo14XUmo01A5wrQMvD5devbtEqUQjHJ2Zxo+yXZ
	 pQXutLxoZmDvXeHF0+tq1bDyJCM1TXfQuN/EBxpJVku1axKzrFnOvrR2O6wBCSPwbF
	 2BFtJeFdz9NTV+3hm2eaelPJrkWe0WyYIMf1dUuqAQagLIVGvdcHdxNApzIcyrdlIL
	 fhrF7Ca/WIVTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18610FF885E;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 27 Apr 2026 12:30:10 +0100
Subject: [PATCH v2 03/11] iio: dac: ad5686: acquire lock when doing
 powerdown control
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ad5686-fixes-v2-3-188e05199368@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777289409; l=1335;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3ewgFdIgEvpo865lUj9Vjv8qanWqzVP1oPspiMSNexs=;
 b=aUnu6PXrDBJdtmqke/3iJAh6vJ7wQb1/WmPh5SwEGqVDFHa+tieebNadQlWURqhRY8axvbBnP
 mlL8KFOxLwlCLMBXIr7dOlYtt+hRBCLst3I4ekyy4cHTJ7GDRtris3f
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Protect write access of pwr_down_mode and pwr_down_mask fields with
existing mutex lock. Each channel exposes their own attributes for
controlling powerdown modes and powerdown state. This fixes potential race
conditions as those functions perform non-atomic read-modify-write
operations to those pwr_down_* fields. This issue exists since the ad5686
driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 24f928ea2b91..aa17ed6aee43 100644
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


