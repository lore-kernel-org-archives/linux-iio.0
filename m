Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DAC4279F5;
	Tue,  5 May 2026 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984509; cv=none; b=HwLrVZjL9OPHACL1cZPeuHq4OzgyG3DNA50dcKZX67RqHWWvNElDikZxIiyqXK3O9zRkJZHq4FW+MM9ek3ZCfRA0OX+eAHJpXd6mc2XeVP4RlKCktyXamUuQnyTjnK9y1yecziX7mB0xzkEwICNBRo0/v+PFXtv3GoD+4TCEg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984509; c=relaxed/simple;
	bh=n7wp5KT5qvXS3GsF4sp0xhn6kpCEAo0EGk8JnHkT5Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2J6Y4QwFqo+TeaLdKvfugFYONVLBa30tGCv4rNQ1wAXyctGyBMtmgiokhjfFyHX2Z4tfywm1xzV5xgcBXUFR/XJF2bZPuKsSdpkFxlgt18RxCWaaJT2VB7DWEizt+/3cL7q37j8FfFNEu0az4SqxLcZKKIE2Gcyly4mD9PyT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLi0nb/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLi0nb/8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B976C2BCFA;
	Tue,  5 May 2026 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984509;
	bh=n7wp5KT5qvXS3GsF4sp0xhn6kpCEAo0EGk8JnHkT5Vw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BLi0nb/8KiKgAxOipNkaNOMuCE8MN9Kg9sNSr8JmRrO2LQy7LFUQV7tINs4lMzEai
	 7zIrWEJY4nXbLS5IcOyT2dLM009Rd1ergTtRVuBP4uV9PKzuLfR3p6h0F9abL92BWQ
	 OhK2GPp8zVfr35wD57nto1pZr808RSc8mgSsWvestfhsPnG3tM1Xy86sRbluzBDKOC
	 w9UOd8KssEdymGFJn5E9l/UO7ypFzzOOlBDP+b6ewJAlpKGQ3tsI9jt6pPGvX4uGZc
	 xD/JtZ0S/v+bHyK7Xek+hnxMRhvweIcQcqGb5qcnDndB2F7swURrUMqKUC4OcXkOcn
	 NQNJjRt841ZmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEAFF885A;
	Tue,  5 May 2026 12:35:09 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 05 May 2026 13:35:04 +0100
Subject: [PATCH v6 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-ad5686-fixes-v6-3-c2d5f7be32be@analog.com>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
In-Reply-To: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777984508; l=1868;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=haOc2rpr9VqEK0oAREKMq3zgvDJzWfuxU1ZBbencDfE=;
 b=mSgE8c6/ifpF+R+t2n9SRcDHVfpqLnpH+uUauqt6jVU6trVlrYvf/fePLLp+/dlc/z3wg1du2
 zMqgjxGZwOxB1hyx9VFB5b2b55snmXvm24oa15ZJMgOsz2KCSVWPqkZ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Protect access of pwr_down_mode and pwr_down_mask fields with existing
mutex lock. Each channel exposes their own attributes for controlling
powerdown modes and powerdown state. This fixes potential race conditions
as those the write functions perform non-atomic read-modify-write
operations to those pwr_down_* fields. This issue exists since the ad5686
driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 076fe8b8bd85..9eb6b61c471d 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -30,6 +30,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
 }
 
@@ -39,6 +41,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
 	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
 
@@ -57,6 +61,8 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
 				       (0x3 << (chan->channel * 2))));
 }
@@ -77,6 +83,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&st->lock);
+
 	if (readin)
 		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
 	else

-- 
2.43.0


