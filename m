Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C2313E31;
	Fri, 16 Oct 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138544; cv=none; b=PoXXOvmqTxeF54av0wxn0YFf58vuXQEH5q1mSURuOXrtL/+Mv+BU1UhIbWY4MdWYi31wOMQraVHvtUKKPWsAaOPvdMX248flNjE8JT/5K8zzldvlDq8Qqw4tKpli8c86xnlVaSb7G1g0ry8YRPl+pWBUts5nleI3elKwiC2MFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138544; c=relaxed/simple;
	bh=5PXqI2wvHJ33gaVZwqw9mkgCl7xLEsI377R7OfghUec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u17IjcE/oen/8Jq3C1lbaD7nx8lb6uEN1lWchFOAD404vFeOOvEbtxjuRvUA/6DErSik0rKNrdJ+mE5WvP7Mjw774X+J74WUgxKfBjf1c54h2KG2Wpegp/2h2OR5cGbos2l9hiK8JSAY9G7vOe+mBDSZ3eoEcdHu5WedUsuXY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNdwgHug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNdwgHug"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42E73C2BCF4;
	Fri, 16 Oct 2026 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792138544;
	bh=5PXqI2wvHJ33gaVZwqw9mkgCl7xLEsI377R7OfghUec=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iNdwgHugE1WmhZhCSCt4PRWOvsmBccxvtPel2uGAOkXqrdM3z44qYaLr7WZgvgO2Z
	 6QJ0UmQIqZdK3EpmzlafJC38Ou8K5bm0ugfBbexp1+PoUje01KCB1BNHNC+UiSe7YW
	 BcqZDpefjO52/Vz7Loqofppj5nLekgO7OK/xZ0drVYmWsILrXG+zISHpAlbxs/Cd87
	 F6qzMG60s1pwlwfQ2eApS7dMjOC1mWTvDw7abOMlaqIA57YEGhQ7y5ItO0s8SGS7u9
	 MnUFo/tX11I3mfpVMMr5N38m4JhspmjWZKGBmnxvHMIPTp8uJJqAaBqFIUmZsWAnPC
	 7x5fdzpauQolw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C45DCCA464;
	Fri, 16 Oct 2026 08:15:44 +0000 (UTC)
From: HuskerMinion via B4 Relay <devnull+mocker-mug-unwoven.duck.com@kernel.org>
Subject: [PATCH 0/2] iio: light: tcs3472: Add TCS3400 support
Date: Fri, 16 Oct 2026 02:15:40 -0600
Message-Id: <20261016-tcs3400-v1-0-3d79d2a7f449@duck.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACzd0WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0NT3ZLkYmMTAwPdVKNUU9NU80QTSwsDJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAH5knnNrAAAA
X-Change-ID: 20261015-tcs3400-e2e55e7a4980
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, 
 Arka Mondal <arka@arkamondal.net>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 HuskerMinion <mocker-mug-unwoven@duck.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792138543; l=1468;
 i=mocker-mug-unwoven@duck.com; s=20261016; h=from:subject:message-id;
 bh=5PXqI2wvHJ33gaVZwqw9mkgCl7xLEsI377R7OfghUec=;
 b=Nhc4hw5+szeJCF+P/ywM7I1pAQOJ8DAOvTHsLYyTVh2Y7J/gZB/Kg8eQVDjTC6n7t6bcVhbR4
 SwIFQ2X57jqB1xVWAWCIzWNwk+mTw7v9q85gpayCUd6jQqRzoNsHZ+v
X-Developer-Key: i=mocker-mug-unwoven@duck.com; a=ed25519;
 pk=Q7l9BnP4XnFimCK28K+NVowcECqTaJNXicdBAInot0k=
X-Endpoint-Received: by B4 Relay for mocker-mug-unwoven@duck.com/20261016
 with auth_id=1206
X-Original-From: HuskerMinion <mocker-mug-unwoven@duck.com>
Reply-To: mocker-mug-unwoven@duck.com

This series adds the AMS TCS3400 to the tcs3472 driver. The TCS3400 is
the ambient light sensor in the Amazon Echo Show 8 (2nd gen). I added
it while bringing up mainline Linux on that device.

The TCS3400 has the TCS3472 register map, but no command type field,
other gains, a 2.78 ms time step and its own interrupt clear register.
The driver picks the variant from the ID register, so nothing changes
for the TCS3472.

Patch 1 adds a binding. The TCS3472 had none, so it covers both
families. I listed myself as its maintainer, since the driver has no
MAINTAINERS entry.

Patch 2 adds the driver support.

On the device, raw reads follow the light. I tested that on a 6.18
based kernel. The sampling frequency code that is new in togreg now
uses the 2.78 ms step for WTIME and the init time as well. That part
and the threshold interrupt are only build tested on the TCS3400.

---
HuskerMinion (2):
      dt-bindings: iio: light: Add AMS TCS3472 and TCS3400
      iio: light: tcs3472: Add TCS3400 support

 .../devicetree/bindings/iio/light/ams,tcs3472.yaml |  57 ++++++++
 drivers/iio/light/Kconfig                          |   7 +-
 drivers/iio/light/tcs3472.c                        | 162 ++++++++++++++++-----
 3 files changed, 189 insertions(+), 37 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261015-tcs3400-e2e55e7a4980

Best regards,
--  
HuskerMinion <mocker-mug-unwoven@duck.com>


