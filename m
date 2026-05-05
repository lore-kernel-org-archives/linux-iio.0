Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D93E0C54;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966308; cv=none; b=MEPq7UwTqsJZe9xgv3d9quMwPxi/h7yJqCZP99rEGPChA/gEFV0iuaakJzESZM0rih2z8RCEbHgGKoXKDwxsC5O6poleMPk23gpz6XlIS/qU2x5Boc5rT1WKyWmFJB0WPqCYRjdSO91DqZTFrtTIEhVGKRpX+swRXGEV/pHuZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966308; c=relaxed/simple;
	bh=QYAYGJEwMW7Jf0TxlLN7LIeOzPE0BP4v8GEXu9kKBR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYf5oXkF1WNq/jiRGLt3PCZ3ghMKQ1ip9QPeRxGtZ+WvvtMOPPatKMEvyej/S50bludEES4RUJf/a4g0+NhVpRxZVy0HcwnXenZ2HOntX24pUcH2MGMZasCg1alBN1bjgb43GONY8S9Gme8l+cbmdzsqDWjR+2CABbXuiDsPJ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPIT58oK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPIT58oK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0A7BC2BCF7;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966308;
	bh=QYAYGJEwMW7Jf0TxlLN7LIeOzPE0BP4v8GEXu9kKBR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LPIT58oK4KddT//BaESYpCJx8uIBWr+Djgatozq8s8ScE/dCQbLRZqsHDKXzTtHNy
	 +HZBQpE8htZZJZTMIdTZcLLfImX4vAkPFIOAVMJmcWvkE39XU/uGmK0fLmYJvl3Lsi
	 AUd4vTT9WBM+m6fnrmy1v8+8fOoEd8CWcWqSXy0ycm3XWzjuMW/PdNfnipfJXbnhKM
	 tx38rcd9TnPHOYrTEB8rIlsh3o0AoajZkRvrIVxd7vLRUX5z1aAhTRpGU5OTW7UDTq
	 iu9RRu9GMEQfokZsIXYflUXzyWvI14/19noGvG+AzZmg1wXd9Ic8PyMXz989jrDvQT
	 GKSA4+dMBg10Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB67FF885A;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 09:31:31 +0200
Subject: [PATCH v5 6/8] iio: light: si1133: group generic <linux/*> headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-si1133-checkup-v5-6-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
In-Reply-To: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
 =?utf-8?q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777966306; l=967;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=CyDeEKtkFccpwJ3bAqhSZpMHdjVdEnGrKvEeSFlutZs=;
 b=UvL6fjz2EWCNauJqsLzZy3tO4q6Kcq5xo4G5XqljinORp7KAnbhH2Y3m9IFBdjxrFYGMCyloB
 Bazw7FygYZcAMobnKxH8voSbrHPW2IWNNl6e9PRpyN/+rjpfaLV4KGG
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Group generic <linux/*> include headers to improve code style.

No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index ab66a5a9ffb4a89bbba7474b6e984ddb61cfeebe..fdffdee16e493277d95c369ec2f6c0678cf9f61c 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -21,14 +21,12 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/util_macros.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include <linux/util_macros.h>
-
-#include <linux/unaligned.h>
-
 #define SI1133_REG_PART_ID		0x00
 #define SI1133_REG_REV_ID		0x01
 #define SI1133_REG_MFR_ID		0x02

-- 
2.47.3


