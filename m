Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB552F9D98;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752537; cv=none; b=coFGoG4y5GYcNzyX8JG4uvdPD8F6HOKPSXqqtIO01UaqGpg2dXuB62Lh3oe4aum3mVFC2waggWf819oWxfXIKsdcnZH5vBUCeev+c3duoA94565gl5bP1OAvYsN8rGStGzq3MfRKyl7ffig4uh2W37CF3U4R8/PrXuZtZH1CWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752537; c=relaxed/simple;
	bh=o3bvt5IVoPOuC7CuBgSGeBwzgK4Z/m9v9mxJ/tknRCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJezt62EvNGgusKUu9d95ioLFugt9PELzt/hkKiJ+7QHsiGx3jd1qctnURTCpSo20og2qAgReDuCxmuUyakEtZNzkCxVMMmni97BNdWBlL+RQwhZ1Bb9whf8tYAb3ui/+3P1QvmRHLBTWNaYwmQ4qmXtaakVl418mj24q5riUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6J34qRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6J34qRc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68A09C2BC87;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770752537;
	bh=o3bvt5IVoPOuC7CuBgSGeBwzgK4Z/m9v9mxJ/tknRCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t6J34qRcpBoXPEFWMMztTMNULhb5CXeq1toeDHqG1yhatUegCLYJmwkVP0rJ9BzV0
	 dIvzSMV6yM7hOUsEOY1WiwNLVD1YUSrzxIVEd/UviSgdb4rCK60ncdMraOIfb8wtEm
	 Qk9oTI/b+Y/ISVEuIpt4mHvOKlhWFKKsZaedKBBwL6XBSRf7MqKB8EuDR2t/Ie3uv9
	 K4PW7lieD5WHUR0DD27FlrBth/t03iDoXi/VtUZfTP2r/1nKLVzgPLfagCgzVSF1Sm
	 cRz9y8rS/fsViqf+rhzjCCq6xs/J86VM9pcvEAm+xH26iVqhAfnUchF+skFXBnBdNQ
	 C1eSyqBmDzNsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498FCEB2705;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 10 Feb 2026 19:42:01 +0000
Subject: [PATCH v4 01/11] MAINTAINERS: Add missing maintainer entry for
 AD8366 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-iio-ad8366-update-v4-1-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
In-Reply-To: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770752535; l=890;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=IB6nsbVkeaHwQfGZNvFxArIH7f6StXcyc8CEVB24Hfs=;
 b=4zQ52Qt/ZsCCtthuGrEUHbTy9pNbDTdV69F3DXElL6m8vgEeR7ZSwzn44qomDZapTP2Je1J3x
 VHTeXFuHlJzBjw5H3GOu0+LLg7PL8SkOFSbm023/VESjxamPfXXlnaH
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add maintainers entry for drivers/iio/amplifiers/ad8366.c

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1251965d70bd..ec9a6beb7619 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1583,6 +1583,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD8366 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	drivers/iio/amplifiers/ad8366.c
+
 ANALOG DEVICES INC AD9467 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Nuno Sa <nuno.sa@analog.com>

-- 
2.43.0


