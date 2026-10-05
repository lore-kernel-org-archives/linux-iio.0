Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FC496D4D;
	Mon,  5 Oct 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211493; cv=none; b=uFZb9/QV6N6rXOX9TEE3/JjxgA1eOWOUdGolfGNMLlnp4NHcE2Cf0rzcWt6EweRIUu1Dp811Dz67eS52ZlPlqfvDn+NqjVq6Qoc9t8ku2aq7gv/rpKy5VXOQ8awHSBAbn3/2IZcqmP8PdbXRLVfg7HkTFpJ662DEC/0Gi407rOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211493; c=relaxed/simple;
	bh=70Y1iQTg4GtBzZxsMBcM32thronSI9a9Wknvykzyr94=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VZzSxln+diJ4JWb+Wbw8s7K8y1Q275UDloqeLMNZLrrvvVPnMlgjz5H3LD7tyS2a50AV/IOYnhRdBe9dzlUcOzAV3WA6l3jrNELQ8kZHc/1EsM94Iqexfsj+TB/GwA5njIzyG2VrHbLtmWbLK3xc0u4X7vXeZoL95ux/p7gJyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UPQ+jSlo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UPQ+jSlo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2B8484E41195;
	Mon,  5 Oct 2026 14:44:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2B04601A5;
	Mon,  5 Oct 2026 14:44:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69440103307BC;
	Mon,  5 Oct 2026 16:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791211476; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Ow5/kTRUpFc6cvpQzA2czy+3oyUukphf6tzOcetBAh8=;
	b=UPQ+jSloH85hM2YwgWm7w8PtEym901ICdGkcXlwrJwTUj4HsbCckdCaapZPe9VdFDcOq3j
	Y6B39cGW1zkq+kYH6Tc2xTb5Qkc/iCPM9S0nBqgVJma3v3rgmJKiLz9KBZGB/9eTibv8CJ
	/64HpNs+q7lCUgl3wkjdraxxleT27hKxwwxme23/DWPn4GlPb0/nLkFM2RTI4MPM/nEaGI
	zrNWOdVxzf775Pm6wzOV1nnT1ZX+ePS8tbS2a5EC+TNjsN0WlcrBPjMNY6TV96BrlyFPVi
	SnjGRJOwLl9aqDdMvF3RBjZmNZPw7q2SMGiLhGMpLw78qGvk1r2PtVXnqJIZ/Q==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH 0/2] Add interrupt support on TMP117
Date: Mon, 05 Oct 2026 16:44:18 +0200
Message-Id: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBBA0auQWXcSQKuxV2lcIIx1TAoGaGNiv
 Luoy7f4f4NEkSnBS2wQ6c+Jgy9QDwF2Mv5DyK4YtNSN7CqJxjnM30WpFn3IPKJ2RtlOtg09ayj
 ZEmnk9Vq++9vpN8xk8/mBfT8A3g4qE3QAAAA=
X-Change-ID: 20260930-add-tmp117-notif-2da1c9076e54
To: Puranjay Mohan <puranjay@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=793;
 i=thomas.bonnefille@bootlin.com; h=from:subject:message-id;
 bh=70Y1iQTg4GtBzZxsMBcM32thronSI9a9Wknvykzyr94=;
 b=owGbwMvMwCV2Z+MHT+XNR6wYT6slMWQd3n6e01WmgukRe6Lb2yWHuPQq9OKMHwVemrQvhHv/v
 9cHHy+o6ChlYRDjYpAVU2S54J9aIrD4hHFKethEmDmsTCBDGLg4BWAim+4z/LM2FY/JO2Xuq/n5
 dttF9f0KU+dqdDedf1dzUaDln8KnNwsZfrNe6DXpZIlULQ4+YLT+4gTDib8OvLjnzWOky74xQJ/
 lGTMA
X-Developer-Key: i=thomas.bonnefille@bootlin.com; a=openpgp;
 fpr=D04F657410A3C83364675691DCB1F04923B3C43A
X-Last-TLS-Session-Version: TLSv1.3

The TMP117 can, when its temperature gets outside of a window, trigger an
alert on one of its pins.
This series adds support for IIO events when the temperature is crossing
the two limits.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Thomas Bonnefille (2):
      dt-bindings: iio: ti,tmp117: describe interrupts for TMP117
      iio: temperature: tmp117: add support for HIGH and LOW alerts

 .../bindings/iio/temperature/ti,tmp117.yaml        |   9 ++
 drivers/iio/temperature/tmp117.c                   | 145 +++++++++++++++++++++
 2 files changed, 154 insertions(+)
---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20260930-add-tmp117-notif-2da1c9076e54

Best regards,
--  
Thomas Bonnefille <thomas.bonnefille@bootlin.com>

