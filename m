Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C593B4EAC
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658284; cv=none; b=oLLZhss7T0G/HFDjcvmrSR/9x2eU3KtXH9yimUptsCqvX2/3QbTjPqNA7m1QKvtylTkXSBFqWO/IzxHweUo+Hti8h2slpRiRa0lL3FiZlqkG1RfUPRiuezYSNsB1vEMxcPpLg2GRt64MdWLaH8zaCn/mRIKzNlNBUx/HV6L/w7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658284; c=relaxed/simple;
	bh=vLiYXQMunhQUXt43pguNpMz7eu5LQxGsP/wx5H0+Rl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pYGT4zjnpN2SD2TlY1NpyammyQnrU2sPKsfl2zeW/aV6Ewc7V8+qhl7MUvgjsCRGb5Mp+R5Ya2KxnoQd8P/y3TF5JRiksdUicyurJEku8m4iEliz2fgjxYHvNrhg9FXmb9NWSyPlf7QFuso+l9tFVe4dflI00ws1DRjtGBx9Kf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEzBX44C; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEzBX44C"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso7693596f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784658281; x=1785263081; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hh0MQTlP1Z8TfVOfqEcGY4B0iK9G2tVmrKphyfkwPB8=;
        b=bEzBX44CeWZ85iopJRg1EPTJNz+5kGeMVxr9HnYITose7QTXlTqc9bWB+xDEt+zZ71
         oycCH3nWAEWW1Vx9QwMh1+71DoRD09VXAxj7LdWPFM8GBmGfZ7dQbf3Y4cbZ2m3vs+f+
         87btSOSzeWesG7asrw2zcW2CG4OmTcYATSM6h0zicPCykvybzUV4CgaWAihdEspL3oW3
         7MYpoIa9GOJLTu4/f6CPnSmU3GEThZuZJ1PMgt2JqiZ8ijIUQxfs+DFcBwRpv1RJlg5i
         tiwBNOa2PdLY7efGIb0i6P0y4ptPLVuQIqpcFFv58/i5dxrsYkcfD8t46bl54RmnFYCL
         2dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658281; x=1785263081;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hh0MQTlP1Z8TfVOfqEcGY4B0iK9G2tVmrKphyfkwPB8=;
        b=UIl6zw6316bCq9R0tjsDw8oc4ynUjflWRQ91Vz+moqHGzCXBSz3ZTRHj/WhYrLOHua
         BfmCOWHTWkb9Gp+o+ev9stp1IUbufOeT0VS7C9AIMhgyiSP7+N7d5YDm9OJboI5yo2Vb
         683XScyGhtnC+87EqVd7rOq58x9Tg8Th7gs4v02EGN7NpoOXltJ7boUsuRQk6hFuDvEA
         iBI06H3fwz0i0niqMpk0pFjJGcH6b6cBd06D2bZg5zyiPpxXbVfJwZgYtPiQHbnUEpHi
         9Q7LndQZBupou7oefAg8rigiIaUQgU5MfTO3VNaig2+XkYksKNx2YirJmIrdYtCc3ODq
         nkaw==
X-Gm-Message-State: AOJu0Ywj4BcHb2odw5laypBm/2jknQRrgPtWP5FQNvMINztUz52013cg
	MdBiSIUHhQVW4i27IHDlt6oUVarEMN4PmeMl/CZyzMYsVHxzdW7btoYD9QBR6g==
X-Gm-Gg: AR+sD11iCLB/VeBegGO5o4IICROsrF5r3AxoJaWCt+I6YFm5CgevVVaSNviw0mzczzc
	3Zteeqt1HDlVeNlZ/J/UBlXFIUBjA8gi1YVvoDR68ZKQbpS/HhAseCeKfStJDkA7+wAVfjficHF
	se+Osk5nAGb8PM7z/Ul4fifM3uiAUBWC/Z+jJifeGn3ZxhTEJkzAlDi5sV5+HKOgFfa6CyP6uit
	MNI1MZzXg5vIcj3asrrb/mju1ddyrojviWNRTQtoaDjLH4X/28bT5v/Q9NIy0u55yuEIN9AQZAx
	9wCM3U1pTEXZvsQAlDlRqDbMMuydUMw3qd8cgxMiGJXmQTVe6YR/RwzOCER46X8TSIAwqdfscUB
	BzCvAiJWnaE/pIFD6mGYx2cni+AHgIN1IJWrfaTA+PHisRrbjs1+FcMurQ1PkqDUlBCxjGF+EqS
	uH+vYOod0T9KoGohLx1Tc0NFTWcMN/JrONkEg+RP9w/OWU+Gw1/nVMJMpTw0YfynW2yNiy25SWa
	fwKXOrSPAk4h+MpIckrFsgjA7/kvPJlf1TxooC/dsAazAmo/goAp6FzUd4zDfRKBGjV4llklqkT
	SHt+lX8GMEtUMKrbq6HXTYb3cVecTbBWwrVCICzpCu6vCXhzHJfP34wLEToKr+gTVleh6lpzMJV
	05YErqlMO3NEqx8mhZsidgmjrJw==
X-Received: by 2002:a05:6000:4b1d:b0:462:ce05:c5e4 with SMTP id ffacd0b85a97d-47f62326d48mr25931401f8f.37.1784658281089;
        Tue, 21 Jul 2026 11:24:41 -0700 (PDT)
Received: from [192.168.1.187] (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm40835081f8f.29.2026.07.21.11.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:24:40 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/2] iio: dac: mcp47a1: add support for new device
Date: Tue, 21 Jul 2026 20:24:37 +0200
Message-Id: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgOm/uJVxCHYVDOopVURxLtbH
 L/hvQeiBJUIffZAkEuj7lsC5RlMC2+zoNpkMIVpipYI18lXLROytRhP7/dwYMmOTNU5KrmGVPo
 gTu//Oozv+wFbZzOCZQAAAA==
X-Change-ID: 20260711-mcp47a1-add-support-3af1248f13a5
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784658280; l=1591;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=vLiYXQMunhQUXt43pguNpMz7eu5LQxGsP/wx5H0+Rl8=;
 b=Ne6gdv8oZksUl0mkhNWe49WW5pDjBvwiCOTS7rxG8wQs8QxMlzqjAsVj4IyIjHujznW1q1B2e
 3UNqBdX3aHJCvpXQMnhQccvjqXQ/D8JT28Zn85xWEKVl+v+QuS+h1RS
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This patch series adds support for the MCP47A1 DAC.

The Microchip MCP47A1 is a volatile 6-bit Digital-to-Analog converter
which communicates via I2C. It is a low-power, low-cost DAC commonly
used in embedded systems.

Reasons for adding a new driver:
- Existing Microchip DACs use a more complicated set of commands
  whereas the MCP47A1 communicates via SMBus using only one command.
- The closest Microchip DAC already in the tree - the MCP4725 - uses
  an EEPROM while the MCP47A1 is volatile, meaning that altering
  the driver of the former would worsen the code flow.
- The MCP47A1 maps cleanly to a standard regmap.

The driver was tested on a Raspberry Pi 4 using a breakout board with
the MCP47A1.

The datasheet can be viewed here:
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (2):
      dt-bindings: iio: dac: add support for mcp47a1
      iio: dac: mcp47a1: add support for new device

 .../bindings/iio/dac/microchip,mcp47a1.yaml        |  56 ++++++
 MAINTAINERS                                        |   7 +
 drivers/iio/dac/Kconfig                            |  11 ++
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/mcp47a1.c                          | 193 +++++++++++++++++++++
 5 files changed, 268 insertions(+)
---
base-commit: 036d96ceec6d966339aea34d034420991e24cfac
change-id: 20260711-mcp47a1-add-support-3af1248f13a5

Best regards,
-- 
Kind regards,
Joshua Crofts

