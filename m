Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3043E09E
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987244; cv=none; b=bhHFfTMW2BDf7NMHRCV0CmumFYjzWhSrwhYCY5A5f3+XoIcZnkecYHpxfjss+Hnv2F+Lmfv1cmipFEahBIPgQxv7lq0rprvamusBddnAhsVbcx0XNyBqGNhtpsxSst0MSj1aXyw0SToLs15mopVj4ecOBTsAzsx3e67266AqeD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987244; c=relaxed/simple;
	bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWqtBPxsbi9RX8Ai/t1bPy2KMtBrQ/KSR6wGvzgzk43hwmAoLzf/pIunqAmKBvhtZZ/cxJJVHwH/8dxnHQzeUvUqaUCnTNys4K9x6ztUXzF5bY9tvV1dGtPdx++L95uvHP/sHkm73/k4m64lY6YGn6DSXEQM7zhJGO/VrR9MgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=HdQvl0Eq; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="HdQvl0Eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786987240; x=1787246440;
	bh=sNcmNScEhpmF/4cOJIi/n2ntDi0iE/3WYicZo1sq86I=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HdQvl0EqauUAtdfrQ9lVk5ku8tvTR3rbjpZvwIdw5G0jpr+0bx1pLQA5eCEpf5ISB
	 BRFYqk0/dLFO4bJycpdOa3hbI+GQ7ANd3E1yuorFETsYPseXsWY9JYeL2Rn6U1bWIe
	 Tz22plTrw7Aex+6+H4Y3kpYj90cWuJRLWXfe716xf34dDzwfyXV3Q+VboUoFqhLZOT
	 b8mNb71/wwkDChC+UXRqsVo9iVTGGxh9o524QVxcNlUTjgIFxCBe7Q15SBhi+WMiyl
	 pJEonHqE/RQ+qTwAzquih8NpqRrq9RIsaGLQiHm3b2s8CUjngENFIeNye7r4HJZcvC
	 eyIbgTiLqpG/A==
X-Pm-Submission-Id: 4hP038606hz2ScXW
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:20:23 +0200
Subject: [PATCH v5 1/6] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-mma8452-open-drain-v5-1-e34e872d7d57@geanix.com>
References: <20260817-mma8452-open-drain-v5-0-e34e872d7d57@geanix.com>
In-Reply-To: <20260817-mma8452-open-drain-v5-0-e34e872d7d57@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786987234; l=1037;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
 b=cll8zQ/JZBnOXB47YqwD0lep+8s4rdFB+6PEYwpGGqs/NVMBwuYF5jr2qUHZTr3hSNT2A8TXK
 qqVP9glAcZ1DqKZQwW7T2OmL4mwIXKKBTyuV6YZ6dQ2FmYtVylcxoNP
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Add new boolean to configure selected interrupt pin to open drain instead
of the default push-pull mode.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
index b0dd2b4e116a..20701aa725d0 100644
--- a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
@@ -39,6 +39,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  drive-open-drain:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: the interrupt line will be configured as open drain, which is
+      useful if several sensors share the same interrupt line. (This binding is
+      taken from pinctrl.)
+
   vdd-supply: true
   vddio-supply: true
 

-- 
2.55.0

