Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF047668A;
	Fri,  4 Sep 2026 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524732; cv=none; b=YUs20pXRdYiw9ZE3lIFayjjbYUngiVquS6EE6c8fQjS7X86AH9vMWg8NXGiluZqtHQz6ciXcSShsJCWPzzqdmFPFWgrjP4GcfBwP6BMYuBqluCbGZzJHVD9qGSzH6Mu0LXVgETwLw/UCr4f5S512tSszaDeTT2ckLr2gHlwo6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524732; c=relaxed/simple;
	bh=cKobHHeUrfk49bcDDwik+p7sMONpGa/ObxN1dvXTXrI=;
	h=From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Date; b=N6emKv0XEOrJPpH9ae7E2xZ6DA7OCMHgfpuG8XSxBwMkig97OQqNMyxTRezz9m6xva+wCmu0Cg4yFhlDPtWWFCi2y6z3Wgzn5cVCRYYfx7ts1pGjO6UBK2Dxknnm5ypwsn41oVDVZn3ETd9M81GdpU4DY1BGjOuRnqeuCU4RgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tunakilic.com; spf=pass smtp.mailfrom=tunakilic.com; dkim=pass (2048-bit key) header.d=tunakilic.com header.i=@tunakilic.com header.b=ZlKJr4kw; arc=none smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tunakilic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tunakilic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tunakilic.com header.i=@tunakilic.com header.b="ZlKJr4kw"
X-Sender-Id: hostingeremail|x-authuser|tuna@tunakilic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5050016552D;
	Fri, 04 Sep 2026 12:25:22 +0000 (UTC)
Received: from de-fra-smtpout4.hostinger.io (trex-green-8.trex.outbound.svc.cluster.local [100.96.13.185])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8022D1658F9;
	Fri, 04 Sep 2026 12:25:20 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|tuna@tunakilic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|tuna@tunakilic.com
X-MailChannels-Auth-Id: hostingeremail
X-Quick-Exultant: 2bcd62b31e5d2be5_1788524722101_1386686478
X-MC-Loop-Signature: 1788524722101:2015702450
X-MC-Ingress-Time: 1788524722101
Received: from de-fra-smtpout4.hostinger.io (de-fra-smtpout4.hostinger.io
 [148.222.55.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.13.185 (trex/8.0.2);
	Fri, 04 Sep 2026 12:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tunakilic.com;
	s=hostingermail-a; t=1788524718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RzjXKx7/dNdw8TIobVRsfZWElVuK+SvfHjx/wVuwM7Q=;
	b=ZlKJr4kwhLsp+/weS4gg+ebti70htJ3NTrRmuFOO213fsStKW85CS8/fjldwAxEl2lwsKK
	uCMyJKNrjVwNmh/lZxyZCv8hzPEwKwGpMmnhNbbrIOaAUU8KY8T83H9jBL3wOgSJ24qe7K
	jgESgDra7+aXTy0q/VzXngUDgnsvkLpKWWVrD/y5gjy9wsj31ZH1C7o/J7V6h6PIjdG82D
	i9XwJOQJXYCao3sg6dXVvp59YGHZv6JRBCk8N38+8hLR/QXVSMkEjMfcLYDMqlMoqFBHla
	rgMXc7bty2prSiVofHOiDH6/wHUgrXnFT3oyuFq7wIYiDUe6/CqGbCh7kMz6Ag==
Received: from tuna (unknown [IPv6:2a02:e0:7474:c000:e0e7:b2f0:b492:96fe])
	(Authenticated sender: tuna@tunakilic.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4hbwf56yXxz431h;
	Fri,  4 Sep 2026 12:25:17 +0000 (UTC)
From: =?UTF-8?q?Tuna=20K=C4=B1l=C4=B1=C3=A7?= <tuna@tunakilic.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260904122513.175298-1-tuna@tunakilic.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri,  4 Sep 2026 12:25:17 +0000 (UTC)
X-CM-Envelope: MS4xfGe9azdtPrTp9u47fiHdHfJ33s/YlpYuR+1DTe0IP2bIvsrXtMsYaLLKgGS14WT9O9yCKI7CVhcdrbMQJcLhW94sN4CKdUzZtawhVmSJSmwVKTci3sW7 3+BT+vHoB6ceKUMHXG3NiWpmnzNFLGknjUOW/spB5Rg5mCt13Tarvc1sNBFLW9BPU6D+sfwNg1kWnKQ+ME8htqRg+cJYZqzL6fcptpVsuzim25n0OFJavClK 0ajBGzlE873EncHtXktrosRliSI7zxznOQoK6CqcsRzLSqaXDpU2is2s04VGnai7l5BWppswSX+9bDzdTWvRxSxPnEfDqBn1xjJyHwxnx3Qqe8QWuJr0BHy6 tXBsPaFY3lwc2cggCOaTnnM3qgRxuEXQTTmCCKazoSjewQQOLUGL+2kRA4Pe843Vg61kE9Uh/BBnKpEBNwMM8n4tHgFfyw==
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=6a9ab8ae a=g35c8EtFT/OoTG0W9QvO+g==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=R-MFOyz7AAAA:8 a=tVWT7hrvFYgB3wJpZm8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=9HMMwjH7N0rl5m39aEjw:22
X-AuthUser: tuna@tunakilic.com

The MCP47A1 has 64 resistors but exposes 65 wiper positions. The valid
DAC codes are 0 through 64, and code 64 selects VREF.

The driver currently advertises 0 through 63 and uses 64 as the length
argument to in_range(), which also rejects 64. Therefore userspace
cannot select full-scale output.

Advertise code 64 and make validation cover all 65 codes. Keep 64 as
the scale denominator because the output voltage is VREF multiplied by
the code and divided by 64.

Fixes: 350d1fb9204b ("iio: dac: mcp47a1: add support for new device")
Signed-off-by: Tuna Kılıç <tuna@tunakilic.com>
---
 drivers/iio/dac/mcp47a1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
index 0bf994aa0e4..3ed306f3060 100644
--- a/drivers/iio/dac/mcp47a1.c
+++ b/drivers/iio/dac/mcp47a1.c
@@ -26,7 +26,7 @@ struct mcp47a1_data {
 	int vref_mV;
 };
 
-static const int mcp47a1_raw_avail[] = { 0, 1, MCP47A1_MAX_STEPS - 1 };
+static const int mcp47a1_raw_avail[] = { 0, 1, MCP47A1_MAX_STEPS };
 
 static const struct iio_chan_spec mcp47a1_channel = {
 	.type = IIO_VOLTAGE,
@@ -46,7 +46,7 @@ static int mcp47a1_write(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (!in_range(val, 0, MCP47A1_MAX_STEPS))
+		if (!in_range(val, 0, MCP47A1_MAX_STEPS + 1))
 			return -EINVAL;
 
 		return i2c_smbus_write_byte_data(data->client, MCP47A1_CMD_CODE,
-- 
2.55.0

