Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4358F078;
	Wed,  9 Sep 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963549; cv=none; b=gXyFRWyU1wkK1F3Ok+RBe6hErHRH6/C5h/8IxPLzGQ9+cTxsJELnraqnxtv/fIomUTMRNGDJZb9jPuYthVbqgSAeYecbFqhRr+9lRAl/1V6Db9H3ux2yFEMJfpKBuH+XE8Q0mbYtX7OfkPl5Huy0OFRNn5aY3yAoUpSFdPPC1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963549; c=relaxed/simple;
	bh=pPXuISqpLOW+nKkX72vg+joZjaAIcuvbz7nTF3Yw0K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=di9B4UoL8VUwGymYuOiIqk9381KOIQ+yo3s/on9Ceibz0mKA3QWinfU36121XGIA85sYnvrtx5EbeL+h1GrzhZ3pNh5SQpqL48I/OfBTcWdxRmuAY4ojMQ+hEIPngZu8onKpUdJRGPlt1z5sq//yu6Hu9VONGhAaEQcunT3A7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TzftPFsp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TzftPFsp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963553; x=1820499553;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pPXuISqpLOW+nKkX72vg+joZjaAIcuvbz7nTF3Yw0K4=;
  b=TzftPFsp1JRpW4ukrmzDFtmFGvsT4TS1zxeBWzinMHI15fulysPOxLbu
   cZTLLChVLDW1zThtd84D+gYtDaddhRXgos19TspiaAriG2XyJNSP+X0+m
   B3tV1egjhEXMoiRubkq2iMJB/lsbxClNnNj+fCUASj3KWTfTwaMIL6l/+
   iXjlqDLh1wJyAAZ4iziczdu2VRNK7i0xtXnes+eQ1efbXwUEWmZvD1pvf
   T62r1C0HOCRvB8lBKPzvvmrDS1mE7DBOfdXoy7DF/E4+gBkD2Vn+tcmeY
   Q8ycmAWVz2EZAwy0DomvXClYHme9Tq9yw4UZUDBrySKyho42SvXQAey0M
   A==;
X-CSE-ConnectionGUID: 8XY2ewfsT5Kqz1KH/hYuyw==
X-CSE-MsgGUID: iKkZHcnMSkqAO7kM/7lTPA==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="63362244"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 07:19:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 07:19:07 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:19:04 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:48 +0300
Subject: [PATCH v5 05/10] iio: dac: mcp47feb02: Avoid unjustified probe
 failure on missing label
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-5-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=991;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=pPXuISqpLOW+nKkX72vg+joZjaAIcuvbz7nTF3Yw0K4=;
 b=FH2KNx4b5+bnBVNhX11smoD3mtmLvs/ta639QWg05Fs4sE9xMzf3bOHljremg+selOw+1D8Ty
 lEKQGfuByQHBR24BFo5xGGDY9Y1UpE2ljoN3GvihHbWD6GmhR45s162
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Fix unjustified probe failure on missing optional 'label' property by
replacing dev_err_probe() with dev_err(). Correct %pfw usage by passing the
child fwnode handle directly in the error message.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 53a7bf4e71c46e75dff8bb5b16c343e7552f6901..6353aabfe252e322a4f0d0efe20673f7e733a7f2 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -978,8 +978,7 @@ static int mcp47feb02_parse_fw(struct iio_dev *indio_dev,
 
 		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
 		if (ret)
-			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
-					     fwnode_get_name(child));
+			dev_err(dev, "%pfw: invalid label\n", child);
 
 		chanspec.address = reg;
 		chanspec.channel = reg;

-- 
2.43.0

