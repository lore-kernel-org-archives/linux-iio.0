Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0338F627;
	Wed, 18 Mar 2026 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856572; cv=none; b=YDXlpSlqjVQEr0J+ezw7VsGJhS0oD0WmM+isBVdCQS/9PhrSDiPDhHRIUOunyz+WnPOky5utH9bWuKsDb/6uG8KaNnHpgx9XtbiNbKbHAoavnI3bOTHSgTfwJLlnjACnJLrJCnp79SitCWNHVGsWR4wpZon6sg9b7/dY39uvg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856572; c=relaxed/simple;
	bh=ZZL70UVcEkvednKdyzDVWraVyXPm7WFMg3Uq7f4Cxtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cV5iZfV4C22sWGbfhb73AV7dnM1TSOO0AuuZh6Xy0fsx106tLvyuD9tGZ6cL27w/4S1KxTn/ge2duHPnix91MjCXUCF3RX8ZfjGKnlYN0LTsDFZCh9UzRJB7LNMhr4KZDYXBcJeK8yErI77Hd8aA2Wn7gJq4gVWThrmxqaVlgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THMlSzpS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THMlSzpS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87B85C2BCFA;
	Wed, 18 Mar 2026 17:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773856571;
	bh=ZZL70UVcEkvednKdyzDVWraVyXPm7WFMg3Uq7f4Cxtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=THMlSzpS14BfeHWmFlJwCHtaa8vtLUOOkHTpNbLVVYwhmd65jm7mwhWUPfJo8CMJS
	 Fvrv4yxTPYl6jKbIItIP2mG457uxR+CzTP8tqYWc+woiboz3kRhm5T4DdSebP5cWCe
	 6VeVxW0nrx+PnVqfFFBQyaYxLymbbSVcQE66aiy74TTdyx7+XLbH9wLMYSqDuOA1AZ
	 1xAN51J6V6iQxgsXZwxDPnshXR3UJXE+HnKuipAdkpBtlFrJ1BByegPe5yXfP/nF9L
	 RJayo+UOC3uqmbGCR3Gi8I7rRvkd4Z9ZPhixB2ba04EzEkaFYg3vVnq3jNe5RxfmAM
	 s72ZH51PvIRBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7371077604;
	Wed, 18 Mar 2026 17:56:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 18 Mar 2026 17:56:07 +0000
Subject: [PATCH RFC v2 7/9] iio: frequency: ad9910: add channel labels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-ad9910-iio-driver-v2-7-e79f93becf11@analog.com>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
In-Reply-To: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773856569; l=1499;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=7/JC2hv0UHTBwwtimWPscFOCNqU87V8BJrjmF2IrHmI=;
 b=lzO8Hpz++30FnD0TKpKX/KV+kVIAsisDAy5FTXCcIJlWxc2zkJ7upl1rlosANvEWjRx3Pklen
 Wa81q2wUIG6BurkmSZ1psKDkgR/K8aE6COtb9N6MZ4ty+wa4/1CCWCI
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add human-readable labels for all AD9910 IIO channels via the read_label
callback.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index 35572d60d6d2..8ff2a9d69265 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -1965,10 +1965,29 @@ static const struct fw_upload_ops ad9910_ram_fwu_ops = {
 	.cancel = ad9910_ram_fwu_cancel
 };
 
+static const char * const ad9910_channel_str[] = {
+	[AD9910_CHAN_IDX_PHY] = "phy",
+	[AD9910_CHAN_IDX_SINGLE_TONE] = "single_tone",
+	[AD9910_CHAN_IDX_PARALLEL_PORT] = "parallel_port",
+	[AD9910_CHAN_IDX_DRG] = "digital_ramp_generator",
+	[AD9910_CHAN_IDX_DRG_RAMP_UP] = "digital_ramp_up",
+	[AD9910_CHAN_IDX_DRG_RAMP_DOWN] = "digital_ramp_down",
+	[AD9910_CHAN_IDX_RAM] = "ram_control",
+	[AD9910_CHAN_IDX_OSK] = "output_shift_keying",
+};
+
+static int ad9910_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     char *label)
+{
+	return sysfs_emit(label, "%s\n", ad9910_channel_str[chan->address]);
+}
+
 static const struct iio_info ad9910_info = {
 	.read_raw = ad9910_read_raw,
 	.write_raw = ad9910_write_raw,
 	.write_raw_get_fmt = ad9910_write_raw_get_fmt,
+	.read_label = ad9910_read_label,
 	.debugfs_reg_access = &ad9910_reg_access,
 };
 

-- 
2.43.0


