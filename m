Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644AA3AEF3D;
	Tue, 16 Jun 2026 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610610; cv=none; b=I50GjKDeLrYfE1HUhtWZsbsi708L31F0+sY3fdMX90xeeFqInaL7/E1BORxtFg02VTDfKZWRE9oX06anYoLXHSWBp+TGBgsSbxnsCGLWvjkX/S0JA7XaXX/0wgG8QYptNLd7qlH8OnXExTr5LxR2u4YYJgH1LguwEwSgsPJkYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610610; c=relaxed/simple;
	bh=Kkjgn6lxKvMHZb5UZ+giBB47q4tMxB9uz1DlQ63bAEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpImFyNZITYM/nn4921og77QMVyJNn8EQXkXoL7tw5Ke/59e3rCvxTSAoU83NYe7bXanPPdwyQC0PySZUZlxMtjs2/zckm4TrP3of3etYFxxLITXcGLsi0VpqxCgJcfmqhvQCCoRbtRKVuJ7nEpXqyL1s8AM44jXUL1E7YBKjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ovKw2zBt; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovKw2zBt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781610607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BBm3mPlMh+SOJi+AUYaxyeokxNjz3c7hH7SzkYJo9Q=;
	b=ovKw2zBtAGCHzV3upGpCB5Ol7D/0xKTiZ/BCcQrPX5jaIKTeitnXgENib7VDFvdIO7iq3I
	PIu065G7kXcbHACxXYzS6JU8NCXGMUzXw0V87/puE3d16+BpwvfCXh2RcRrkf0LkvIWn9W
	7uzi2q85WkC3PxdD1nfz3Gl+V/HC8RI=
From: Siratul Islam <siratul.islam@linux.dev>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: siratul.islam@linux.dev,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: add entry for qstcorp
Date: Tue, 16 Jun 2026 17:49:37 +0600
Message-ID: <20260616114942.37241-2-siratul.islam@linux.dev>
In-Reply-To: <20260616114942.37241-1-siratul.islam@linux.dev>
References: <20260616114942.37241-1-siratul.islam@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add an entry for QST Corporation Limited
Link: https://www.qstcorp.com/

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Siratul Islam <siratul.islam@linux.dev>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..11aac47f90ce 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1355,6 +1355,8 @@ patternProperties:
     description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qnap,.*":
     description: QNAP Systems, Inc.
+  "^qstcorp,.*":
+    description: QST Corporation Limited
   "^quanta,.*":
     description: Quanta Computer Inc.
   "^radxa,.*":
-- 
2.54.0

