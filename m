Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE32868A9
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608417; cv=none; b=dHQg5oZs8dZCd8Mar53HTS++YYYqPqg7yBqVPuimnsYTFHWzYoute/sOGtUNftHjN7yx1+LKMyszZ5b8ljTnSt2XqRAW9hLyfNP7uwaZq0pg9NuDzAvVnao2fDk+mRxEVLkpiLgv5Uzul53zgNbkvV3+2ZDkkB7IFwp1d5jmmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608417; c=relaxed/simple;
	bh=lTyWo1eRqW5DX8yvyPANL+LdjOU0rOclI0glDjp/zjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JI/TVpnkSZjMVIl2iwWze6sYXwhcy3BexzLjgM8YLWCnaYFSQnPSFpIxcIwy44rOW6DqPbOsx6tAZh8O9rKnt23aiyvYPCr9iAvG3Kaso0OUT2yK2NPTI2oVkydjx4wF8iFRd+mWO50w3G0c/uaxVUFra+qPY48uXulT9MxDfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcjeOIit; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcjeOIit"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b8095668ebso347513eec.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 19:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608417; x=1771213217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7q7E97msZ/8P2TSodtOWgOAxfPDU8GUA1EnXOIGpS0=;
        b=AcjeOIitcgH4PTipgb36UlpWjPr3pfFP435xd67nQnD6fnGOHYaUuehbjAS8SBmfJ3
         WBli1qqapoExjSDKRP3UmfbL3qONON96HviGg9I/RoQ2oln0gwHkkp/yC2V2WI8eq+Zd
         7asZGWyPz5ncY6kzbXAJ0FnLbJhUvh5D6jPBBITEqY6STbnOG4uqDIkFy35orOjRPN/C
         9X2BOLSJ+5SvWkh60uTS9Qy1ZNXfXu3AM1NGiXq2E/ArDztCAeZd4tvs4PxIxUo57Mc8
         H8QuAeJ63bLeDHmh0qi7haH6T7NhsSnoyNwzct5lgfkvvF+2u6U43minvfxNXIW+7WB4
         iNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608417; x=1771213217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7q7E97msZ/8P2TSodtOWgOAxfPDU8GUA1EnXOIGpS0=;
        b=iVtsPvvjaBNBzMY8Ru+waWdi15vhWu3VrJVbsO1TRVvPJdZyLfpg6lMcsZcse7Gtv/
         7V1DO2nT27NxVo40nlzMIjOAx+5ut8AVfCQ8sAnPveSqwTy/D2jiaTEc9mq93TDKhBGi
         BmZ2m3dnInQDj06nowsy8Re71Jn7UGAUfASgADwCQm5i8J3dExuZNB6w23gY5iDfj3f9
         dpHydbz2zVRLEWUYlarLvchDqHT1I3DnT98XjL2zTZFJCI4pMKUvMEy7Xfe4Gw0xvM4g
         X6fd5yZJFpZEgC6VyfMVVVKI5fIeCEHwj8bcv2TLkdY32wPs95TrV2NCjtu0HwsESTLo
         i0Jw==
X-Gm-Message-State: AOJu0YxKtQOEnDOMmRtDSWCv5qB2MBH22bvvZSTdp7XazQ2WtOsM8mms
	bAgpr1m+56bAMd1zNBrZoNuRPIT5/4RvvDTQl6j/0Pr8Q+3/z31uP+nF
X-Gm-Gg: AZuq6aKFp+1Xo21k4C3+i0Gj/CjwEB3ynv0ZvddWeD4EzjgUMBLAAiyCtG0QmQcvVqL
	ESRT51I5JEDmk0vMWKCPCpOF+DKBBhimkk6EfUPt99vtDdXXjHx/ZJd5HNW3VmLcrny5eO2Tc/6
	UElcFGy6TMMG0UVMhky9cRk3ItphQpfPt1SIMITpYs73iNzQ6GFebz/EQZG2ftMi+MKMxL3b18J
	KDxWmaCezv/0d9wxfy3NHoGIPk1GUg+nCDSzT5MJJ3nkZ41DBM9Dhzna52x4CqVcZvg81hwf5IZ
	haVFl2Btv9MJO5euc+G12CaSLvtacbrhzymHaqQBonezSmk58tSWyg+Ymv0ie9Me1iqIieExy7G
	zNEGjPchp71P5UCI1Vi+t82iIIOY/Z9hdDoWjoH4o95N0m+TyH/bGH6roVADUHS8yev2ZmVhcRt
	2iM9C/275N6/I=
X-Received: by 2002:a05:693c:37c7:b0:2b7:3678:2d1a with SMTP id 5a478bee46e88-2b8565160dcmr2739568eec.6.1770608416595;
        Sun, 08 Feb 2026 19:40:16 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af5ca2sm7682073eec.8.2026.02.08.19.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:40:16 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Mon, 09 Feb 2026 11:37:05 +0800
Subject: [PATCH 4/5] dt-bindings: iio: proximity: hx9023s: support
 firmware-name property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-upstream-20260219-v1-4-2b4d74e309d1@gmail.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
In-Reply-To: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=lTyWo1eRqW5DX8yvyPANL+LdjOU0rOclI0glDjp/zjY=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJmdYT83dhi0L6wvDXt1ef2nXU4L13tc0D/84NH54J7DB
 9War5j6dpSyMAhyMMiKKbKcef2GNV/14Z7g364ZMHNYmUCGMHBxCsBEnLMZGY65WFbFXOsWKJic
 8cJN4hHv45tWj/rWnbohrfGJrfPY3I8M/6zluT5WbLlV/ZTf6qYGz+HrAW7LeA6fOsV9+TWHSM/
 r7SEA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Allow specifying the firmware file name via device tree.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
index 64ce8bc8bd36..7e516fc011c6 100644
--- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -28,6 +28,12 @@ properties:
 
   vdd-supply: true
 
+  firmware-name:
+    description:
+      Name of the firmware file to be requested by the driver using
+      the firmware loader interface.
+    maxItems: 1
+
   "#address-cells":
     const: 1
 
@@ -65,6 +71,7 @@ examples:
         interrupt-parent = <&pio>;
         interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
         vdd-supply = <&pp1800_prox>;
+        firmware-name = "hx9023s.bin";
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0

