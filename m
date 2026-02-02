Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE3A945;
	Mon,  2 Feb 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063377; cv=none; b=euah/z8Zstf/4zPOPeUDwWvW/LN8Qo9oP/SC5Ke0bKcmgP9j7zHIqMCypTIiPmTP3h4Ej+eBAo9qe5R704cXQm30EkbWrlf5xaKubYxL9Zbm90v0flOs2+WaC5HJAFpnxkOXDNZ7OJWV/frFAQRHtOQf2kJhBw9LHXaD3ZLZjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063377; c=relaxed/simple;
	bh=jDX8raLnna7pl/Oc+RvzmdvSygkCZ7qgexWy5syou+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSN41dpk8VWkFpWTeVZAzwzF/cUnneBpV+Ovdt8sIlEeUWprffNOpdkeJPqVsToOO5hejqjcFAJRpZoY9zvvNSOP6vnlDSBXAcQip9g1si+0zvExVa/VXI96paCBRyV0VB/DMbPrU1S54Kmo8iUCf/E2E4+1NoeA154tvtf0Dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=ORGJq2x5; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="ORGJq2x5"
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
	bh=JNhYfdFR0tc1QZS1d2/N1yJK+kKay1G5h2AIzgRBrxs=;
	b=ORGJq2x5BsVwy7IhmBFw8nA/RP3EYP2eA/hdM3ik3GkM6m1WOMqhJ9h24pvTOJUB29cum8dX8ZH3q5k9tBZTsRnIaN4KwCBD37bv+Jq0/YK+Iyme7S1XI6v9PV3vceiqFvD+ity4kQsIjP5NX2rZ6YHfjqrFr/dtjowKypED+YQ=
Received: from lukas-hpz440workstation.lan.sk100508.local (192-164-142-11.hdsl.highway.telekom.at [192.164.142.11])
	by mail.netcube.li with ESMTPA
	; Mon, 2 Feb 2026 21:16:06 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: RESEND [PATCH v1] iio: potentiometer: mcp4131: fix double application of wiper shift
Date: Mon,  2 Feb 2026 21:15:35 +0100
Message-ID: <20260202201537.2194476-1-lukas.schmid@netcube.li>
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


