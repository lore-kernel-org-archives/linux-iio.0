Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A1330D28;
	Tue, 28 Apr 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395739; cv=none; b=J9dG7Jz5rOx2DrV5gAwqXxyv9isAxbt9q9bGYzuLdXnyHO4lPTKUizUJlnfTanmsRsXXrefEnYjGuwSQKffcP2l356enwn8HYg/GiwxRl9d3u13qjpW6eR+Bc3OrbpOwx1WKDu7wU7VOKaTWNnx2CPmnCwgqdvj62pYJBwy+8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395739; c=relaxed/simple;
	bh=0JziPPaM9IDT6KUt7vyo/k6/XjAkaCDxmpkh7SxX7QI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bI/NDfDMJBHVc9x80rLXKGaLFJVVeaWk+g75CHLeAlnhArR2IIxZ1hEx50hWOLb6E72UfY00Fsl5TBNz3Pczes5uWLR4aQoiq+B6MM8HALnzDku8xk8bCh0Jpa4tfcftn1HXYDtPrEw4KoU2WIgt1dVVS5axpiFAkZlAwX6OlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMYF5PoD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMYF5PoD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0733C2BCC4;
	Tue, 28 Apr 2026 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395739;
	bh=0JziPPaM9IDT6KUt7vyo/k6/XjAkaCDxmpkh7SxX7QI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hMYF5PoD/u/QgnlbakhFdGdkWMq1Lmoh3SDQ7wFPj6DEXjA63rDhVLf7r/f8wwJx8
	 +yB0MFIjicRqNuOuvewHMo5m7AEQR1g0ca37i/DNstTxKJgQT3iFNH5I47TSxGG/Vz
	 xcAJJRXg3/qGt4suWZSDabIoORNSGFkxG9MRR+nic33gBQnl5TqMOBAJeTxiU+ss5N
	 Cwr7GtkaMyaKMJGjR4m5itrIkNfK/Y6c5aXiUoPzNC4Z3YaSFhKyVUhKvaB7pRC6N7
	 oPrvVG4fhWCaaJQkKRoKAIJ0kjiUofQSoo8IHmtDMvG9ph55SctXjVz3ebBjpIHjw/
	 gbfkT3fYip4Tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F64FF885A;
	Tue, 28 Apr 2026 17:02:18 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 28 Apr 2026 18:02:18 +0100
Subject: [PATCH v3 03/11] iio: dac: ad5686: acquire lock when doing
 powerdown control
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ad5686-fixes-v3-3-9cff7bd67a15@analog.com>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
In-Reply-To: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777395737; l=1335;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=1oS02JnTrI5wiIzSz+QkF/MekEEwrISkavx8yLsCZCI=;
 b=U4qQdQd8KE5MMad2EyvQU7MgouJ7TgeDBvOU8hzO3bV2BdfaahgesjuoWCg5hqhiRGLVYAOvd
 5WhZ6l++EZmB3UgOvy4lu89E+AvwWf9fe8s0u444nmfdkAeh9qxWc++
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


