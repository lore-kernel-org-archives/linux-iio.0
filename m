Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E78222565;
	Mon,  2 Feb 2026 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066427; cv=none; b=ccr7MlG2sRJo1yv1ANb+fL/IyWR7/Ds5Gi+M8gcvcfx28qxMBvAnjodLRYW7rGgT+vLi8sEN7RSzqcaEO2QMk/oAhhUSCmoNipwwUgF57KT6yXJiqRVWjyiq39Rh0wUihq4noWTamMmHBRDJu040oliIEf9rS23SyowxzviibD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066427; c=relaxed/simple;
	bh=jDX8raLnna7pl/Oc+RvzmdvSygkCZ7qgexWy5syou+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXgenmAYWknBIoG0avyk8JjU/GOzOwt4K0ZkMsyTqXfzan+IL3Qsvt9eZc+bA1oDNeQ7wK6F+sp69euGITSmTiwm9Xwq6NC21qTB+X9f0xuOZ4nLg2Hmgrs0oucqHgcJLEaxv5ECpjMR0MYl1TTQEkp0bqOLK9VF6CS75GQsg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=ikgceonk; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="ikgceonk"
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
	bh=JNhYfdFR0tc1QZS1d2/N1yJK+kKay1G5h2AIzgRBrxs=;
	b=ikgceonkkWp67TH+Kog7LBpIlC5NtbrdUwOdcu2QXSLg30Z06vuqoZMGwKagLKeWWyB4whI6uiUASFrkqvuPSENKTba6UF6L69Lzb/h2CQZgNW2jdDt2PHBzKuX9fegJ5t1DkEa+2+C6eL/8II/LzOwC4KgeDhwq+XBPOZXLOk4=
Received: from lukas-hpz440workstation.lan.sk100508.local (192-164-142-11.hdsl.highway.telekom.at [192.164.142.11])
	by mail.netcube.li with ESMTPA
	; Mon, 2 Feb 2026 21:05:41 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] iio: potentiometer: mcp4131: fix double application of wiper shift
Date: Mon,  2 Feb 2026 21:04:42 +0100
Message-ID: <20260202200443.2193108-1-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCP4131 wiper address is shifted twice when preparing the SPI
command in mcp4131_write_raw().

The address is already shifted when assigned to the local variable
"address", but is then shifted again when written to data->buf[0].
This results in an incorrect command being sent to the device and
breaks wiper writes to the second channel.

Remove the second shift and use the pre-shifted address directly
when composing the SPI transfer.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 drivers/iio/potentiometer/mcp4131.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index ad082827aad5..56c9111ef5e8 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -221,7 +221,7 @@ static int mcp4131_write_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->lock);
 
-	data->buf[0] = address << MCP4131_WIPER_SHIFT;
+	data->buf[0] = address;
 	data->buf[0] |= MCP4131_WRITE | (val >> 8);
 	data->buf[1] = val & 0xFF; /* 8 bits here */
 
-- 
2.47.3


