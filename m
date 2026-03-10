Received: from mail.imp.bg.ac.rs (mail.imp.bg.ac.rs [147.91.50.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04615853B;
	Tue, 10 Mar 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.91.50.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156946; cv=none; b=dE/eWbGY9REU+ki9Kj3vMhd0wvEM+vq3boBeD7qdJRfne7QRwWPJT5nQEitHft8lMnKmVJIT+FYVg9YK3fWqJ2rfZarhIGqkPm/zFhyoRInRBIuWQyV/7XsLMcrHxSSpr9fMuPdp2280sV+wTB0y/I2+/Ts2bvtkuT7JYvGS+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156946; c=relaxed/simple;
	bh=AVLKj8uQtBNoQEGxeVPnV/2j9OD6SDO9AoTNoV2lwrI=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=EVHPeQa0ny/e3IbX5UfpshDqxcRu3lAfthy2+lnDvCbb4bJ0KIjPq/MON8STs0FK5KFw3v7/H9U441P7TbNI6C3socnUC9qMV3h10xh2DjUMeUyFELv/cV/A3OJxoCV2zY0hOl1s0g8zPGfzScNBPOrkegKfsi4jxEkVOjD4XDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs; spf=pass smtp.mailfrom=pupin.rs; dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b=CubVAgJx; arc=none smtp.client-ip=147.91.50.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pupin.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b="CubVAgJx"
Received: from localhost (localhost [127.0.0.1])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id 51C56140C46FF;
	Tue, 10 Mar 2026 16:27:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pupin.rs; h=
	content-transfer-encoding:content-type:content-type:organization
	:message-id:subject:subject:from:from:date:date:mime-version
	:received:received:received; s=dkim20260301; t=1773156466; bh=AV
	LKj8uQtBNoQEGxeVPnV/2j9OD6SDO9AoTNoV2lwrI=; b=CubVAgJxklr4l98N8K
	7jC1ZhuFiWtJwlzrgFtEqJtM9GMHSRZn4JnJUJLT2i3KJjk6YbPG2SOZnzzLE5c9
	NFLo+Nlalc09ckndmWNUpuAlL2PQBQpZXH/JYC1wrG4e9fF5bQ0spLA7ym4t1RTi
	CDL6WuQu2kExce7H1hRbZVdHE=
X-Virus-Scanned: amavis at imp.bg.ac.rs
Received: from mail.imp.bg.ac.rs ([127.0.0.1])
 by localhost (mail.imp.bg.ac.rs [127.0.0.1]) (amavis, port 10024) with LMTP
 id kKP9czrqoVa0; Tue, 10 Mar 2026 16:27:46 +0100 (CET)
X-Comment: SPF check N/A for local connections - client-ip=147.91.50.99; helo=webmail.imp.bg.ac.rs; envelope-from=david.marinovic@pupin.rs; receiver=jic23@kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.imp.bg.ac.rs 366F0140C678A
Received: from webmail.imp.bg.ac.rs (webmail.imp.bg.ac.rs [147.91.50.99])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id 366F0140C678A;
	Tue, 10 Mar 2026 16:27:27 +0100 (CET)
Received: from unknown (unknown [147.91.52.213]) by webmail.imp.bg.ac.rs
 (Roundcube webmail) with HTTP; Tue, 10 Mar 2026 16:27:27 +0100 CET
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 16:27:27 +0100
From: =?UTF-8?Q?David_Marinovi=C4=87?= <david.marinovic@pupin.rs>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: dac: ltc2632: add support for LTC2654 DAC family
Message-ID: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
X-Sender: david.marinovic@pupin.rs
Organization: IMPT
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

This patch series adds support for the Linear Technology LTC2654
quad DAC family to the existing ltc2632 driver.

The LTC2654 shares the same 24-bit SPI protocol as the existing
LTC2632/2634/2636 devices, requiring minimal additions to the
driver.

The LTC2654L-16 variant has been tested on a Phytec phyCORE-STM32MP1
board with the DAC connected via SPI1. The driver probes successfully
and all 4 channels are accessible via the IIO sysfs interface.

Patch 1 adds the driver support.
Patch 2 updates the DT bindings documentation.

David Marinovic (2):
   iio: dac: ltc2632: add support for LTC2654 DAC family
   dt-bindings: iio: dac: ltc2632: add LTC2654 compatible strings

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
