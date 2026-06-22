Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284B346E6D
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156680; cv=none; b=b7URq8rH3ZXdLp5gGQtCtD9IjWrYi0b7/hKCTq+171gKQ5wIOeG8Gs2V8J1vaCLOLuxAsMKxiT//x2JkflfLJ3xVrtFbdwyrqG4jXxIzhz/KBFg/2Au++fGTcf/JUaI3BEnddCpvTdemIjzRDuBaQZFDabhnaY0NN71Irrfqfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156680; c=relaxed/simple;
	bh=dytCTAQzHC8hMl5sYZvCxtaRWqUzt7axoMBTmx/q3Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUpw1BTni3w5Qc+mvPCOFCGLsiWDvt99y5Q/v1kAox6uogLFO3LJnfuxF6n7XZTykYBvkqOkQf3uOFMnlbf0pdSM5kYWngw3qFh0xXhxhf1BqifUxQVR5z+9/hbW+4cTVE4DsREWfszUtVu3KAwv84WmsmvwsTDOabtaqf4+BLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQp7d99F; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQp7d99F"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-96358d0a024so3631526241.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782156678; x=1782761478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xz9m7MJOrM1OPqcawfhhbeWWJ61HCP0MFw+ABXgkJM=;
        b=QQp7d99FFX7keawQ0QMNGSQU2uCk6pGUdNk608LiOAi3RrGFzVihOb4gjbPsSsrElW
         AFHsqUmh0bAL0frKuHS4ogR6e1COVmi17qYTzRyYpfM10V80Uk3T072MD4v+qAfL+HB4
         uASijaUhDu7GHx6s/wNACFcx7cpQjeBLryyxyuF35ULEgXGzw3HLrS7OTygKyNqkKD1Z
         gpeYtOvh93fPhbTMdEM6mrsZRce9dsbOJ9agZkPLCoKUqwvtQDvBwc4UVerrDyOe4y0s
         6ikp36h84H0VQLgALiyzLB3bKwU20zCSlhIG8QcU55zaTDkNDzu2Jf7cgjOuhxUxC5ZO
         DTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782156678; x=1782761478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xz9m7MJOrM1OPqcawfhhbeWWJ61HCP0MFw+ABXgkJM=;
        b=W6DBCLTXjO9lalAih2pUGtgBcnp8eE+5KqfoXxX3FU0zzMMktUBjaY5f2sAY36U6x8
         m7qaEaAsyG76SHvvhbOiid6gUpcQnAUWd2AFcTEQYnO46WpF0bn1X43icFof/MEV5x/Q
         bz2x0P6QD6ab1tPLb6NZ1ScZNG/jq6fDIl5wCW4kjxv2Y0DFNWc37drks4ALoivSYhMw
         PNS8Jq8y/fZXVkEkK2naNLJJ4lXzXz+sEOr3ZClervmcoloUMEwYpdYAmN/HaA7YSDZS
         ggLu+lWRlXXkTp+mPt0/705uW1tsBSrjMjMZgsSDLf8aDaQ9VCrf6PS577g3v0MmRMCe
         SGkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qKLSSDKQRblvnKHEdH9zteRsJ9JvzhSRga1fgJeCLfKG0Mn4uPOD3y7I5Ad96AO28pAGrsD487VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4OPvloNhC+uf3bDX6Vt68j2YqgZtajkRCwKztGZnflHaB517
	JgjQAPnL4ivjGac4NxxqA9cx0MTnEMm49z0jbTyDrZw4SRRhNz3K5saV
X-Gm-Gg: AfdE7cnzDtd0z7hPVtyZkrbQ2a7QKPO5sA5rfOR0SoBzw3TwQzt3+boPvwDJoJ/2Srw
	vF8wgx+OA48VRHzIG2rlO6qV5d/bELaKKfe60WKqmY3u+A2T+sAaEgEsyrEclgJLb3IyNF3Sou/
	TwaybMpzQZBrT1RO7+5MdFwSQ97UOzCfAJix7WNufT49ac9ByqCGswQj5bKYY4StYk3KtWj8Nnq
	xkjiihPC4wQOv5K3VCx6XGLRFQ6WhsmljcfTqVvy30wPSz1k+X3a/tKkXKLuI7OUizP7ZXlnmrJ
	47gBesRtQW/lTvBFHAYbU9qSSx+ahKvoMut7OcuQ/zsarYSb3WWymyffqTT73jqql5eUsWl7bqQ
	BbqIuTOUZpKpLh+/CN4R3KdIeQVXJSky81WwtXmjVnSfBGLRXnPdvcxmxWeP0BIx7bDCyupayyC
	zziN1ZOzonr1aC2kg=
X-Received: by 2002:a05:6102:148a:b0:6c4:5bdb:5e34 with SMTP id ada2fe7eead31-729fe6cfc76mr11303769137.0.1782156678502;
        Mon, 22 Jun 2026 12:31:18 -0700 (PDT)
Received: from [192.168.100.222] ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9670c0e484bsm7227910241.2.2026.06.22.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:31:18 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 22 Jun 2026 14:30:46 -0500
Subject: [PATCH RFC v2 2/3] dt-bindings: iio: adc: Add excitation current
 sources properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-new-channel-props-v2-2-aafd5369f253@gmail.com>
References: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
In-Reply-To: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=dytCTAQzHC8hMl5sYZvCxtaRWqUzt7axoMBTmx/q3Sk=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFmWvQ27mZdsfOXoZCeqoNy7Ot3iU9Mb+aavk6at8rp9W
 eOHk35PRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEzkRjPDX7Fny4oVY91b3vCe
 1jv/ZtcrqZydlbef6Xzpyo+x399pKMfIcDFMo6ywJFfAeMp27unf702yd26frXjqidAWib4l937
 +5AMA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Some ADCs incorporate current sources that provide excitation current to
resistive temperature devices (RTDs), thermistors, diodes and other
resistive sensors that require constant current biasing.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index fdad6b8276c934c..160a8cfa9842a86 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -86,6 +86,25 @@ properties:
       source. If two values are provided, the first one corresponds to the
       positive source and the second to the negative source.
 
+  excitation-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors, diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the mux configuration of the excitation current
+      sources.
+
+  excitation-current-microamp:
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors, diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the current configuration of the excitation current
+      sources or the single matched current for all sources.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.54.0

