Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA238838B;
	Wed, 13 May 2026 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665911; cv=none; b=F9QVt2qneZAj9IeJd+rAw5dnsv1aJmE9w0Mfb/e7D7ddH0ihCB3R/vAmAko00pa/yxBysJA+hRDrsF0cu3ABtgQze6hMoEulKKlFTLiM0XpROT3wDUiAgPnbCoIriQqXTkY9oYe8ZGTrvHtHahgnNYDXrEELhNbXIEM2iSI76JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665911; c=relaxed/simple;
	bh=cGH9FzUEDSNXR8hZ+Ll1yk6IppIPYxWXZ6i8XZ0+QpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qz4yi6+YddzvZX44/32YFJsSn/mAjPHrCSOmqaoZc4ALzsUxRnO4T2+teBYVjA4sYROD8ms3InpavSj1OcOH8CX6aAMnQL0BJtyn+IjZQ/6ciBONXcbdRH5XEzPqA0QPNJ2qaznlJP+InAWT5Fs8qb1BEr/bds5ekSV0+6JSunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=DqzR5+YU; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="DqzR5+YU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:Message-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sUF7kixfrlUowh8RqG5O2aBsMX5gsB9s/0NEwNh+RqQ=; b=DqzR5+YUek1iEY7Vh400M8GQ+K
	nEhniaHhAm5cF5i0ldrdJFoPGIobEknJmU1xhfDyCPszi+OVhcWkWSXhRN8B02GcQmAuu2Vg28/4s
	WXVJPKTlGaKilclzQPuY0pty0WsEMyPrUi0m+LjRNIqaTndDZ7V1QK0ZKKEs5EhhRJYVPQUgbn+tI
	3KbZv5eBGGZ+3qaoaZzIMkiA13ny5q3T2l9HQrTJDlQFq8hCfimqHa0VcuD0IDaN9ElDnkbdn6OSx
	VIIR4rn7JktUrcFTSbk9qquVVEPWJRhigFuB6tDP86tlM6G+Uv7e10STgvnTxIAra83POvW2vydjN
	IeoSSynw==;
Received: from [91.102.182.218] (helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wN6Fi-00000004cgn-0oQE;
	Wed, 13 May 2026 11:51:42 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Wed, 13 May 2026 11:51:31 +0200
Subject: [PATCH] iio: adc: sun20i-gpadc: support non-contiguous channel
 lookups
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fix-sunxi-gpadc-sparse-channels-v1-1-6c21e290bcee@mmpsystems.pl>
X-B4-Tracking: v=1; b=H4sIAKJJBGoC/yWNywqDMBBFf0Vm3YEYa6D+inSRx1SnSAwZFUH8d
 2O7PHDuuQcIZSaBrjog08bCcyxQPyrwo40DIYfCoJU2qq0b/PCOssadcUg2eJRksxDecqRJUDv
 jtDKNC88XlErKVCa/h/79Z1ndl/xyZ+E8L+aYUk2DAAAA
X-Change-ID: 20260513-fix-sunxi-gpadc-sparse-channels-2b6b2063bd49
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michal Piekos <michal.piekos@mmpsystems.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778665899; l=1663;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=cGH9FzUEDSNXR8hZ+Ll1yk6IppIPYxWXZ6i8XZ0+QpM=;
 b=I4zELAsqh5MojydjeCuuULqdQ5HXfFxa7ZjoWu9NybDGqL9c+AUOd/G4qnxyejw7+0sj9CyIV
 DEPG7GUNLpTDvlzKYQfIoupulHo17BfqRslGiiVKHBXeAnlbEfvv9DP
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Using consumer driver like iio-hwmon which resolve channels thorugh
io-channels phandles will fail for sparse channels because IIO core
threats phandle argument as index into channel array.
        eg. <&gpadc 1> will fail if there is only channel@1 specified

Add fwnode_xlate which maps DT phandle to the registered channel whose
chan->channel matches the hardware channel number. It allows sparse
channel maps to be consumed by drivers like iio-hwmon.

Tested on Radxa Cubie A5E.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
 drivers/iio/adc/sun20i-gpadc-iio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
index 861c14da75ad..95f34a352158 100644
--- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -139,8 +139,21 @@ static irqreturn_t sun20i_gpadc_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int sun20i_gpadc_fwnode_xlate(struct iio_dev *indio_dev,
+		const struct fwnode_reference_args *iiospec)
+{
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].channel == iiospec->args[0])
+			return i;
+
+	return -EINVAL;
+}
+
 static const struct iio_info sun20i_gpadc_iio_info = {
 	.read_raw = sun20i_gpadc_read_raw,
+	.fwnode_xlate = sun20i_gpadc_fwnode_xlate,
 };
 
 static void sun20i_gpadc_reset_assert(void *data)

---
base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
change-id: 20260513-fix-sunxi-gpadc-sparse-channels-2b6b2063bd49

Best regards,
--  
Michal Piekos <michal.piekos@mmpsystems.pl>

