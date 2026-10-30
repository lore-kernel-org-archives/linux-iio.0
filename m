Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793386412;
	b=i4Kwgtn37vtRNlNcIrJgieuyyaKUlZXwwH8SiJ1CVAgtVwpNLzgXPUnKHKrEXNbtnmuh
	 I5z5NQYlNnD0omOJS44kaP3DqSl71AXqiN0HHQ6j9pRUGg+8g0VEMHcwAkTSisMu5S9jJ
	 N5HzrpIxLjrVDllrZa2096EXrKJS+nMR0FSHO0rR8/asrwJEGKiGS2oiaOPVd8w6HDw7G
	 8wMMNdqONdNMMdmIMcDtzs2q3MBnEqJ5fpWPP5uxc/2vp9aJxVWbb0dICLM9kQQRA2/yt
	 P4PqlqumDJ5pRQRLza25/JCelTC8ox8Ubm6uQ1Sp21M7NGu3aJ1ZTY4WzqQxGb6szEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386412;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BcTkHU3xFfurIvUDvdqPEEtdJfeCpIt93+610uspIAg=;
	b=PYcCcrOHA37Ygx3+/Got/Yk8tXtPZ0SDVvudQN0v2NkYMvlfe16izeb41PtWYtKDFySX
	 57he5GId6+N7Ap0x/LO5ivMqnjZDFJZ1DHJl/aQTErqO3cCG+LBJj+T+Fu68wBACBUz51
	 R6IP0Gh+rSlkeHPJRTuEISUYbL0IwXcLsXDVeAR1JS/s+OeybaPPk9MUWZxLWWH5ESNp3
	 mjTx0DEPu/SWbowDiuurEmNhmyPJudwhRg17pSxOKRciLncwlVeGtKm3UUdqYTUtUbt7+
	 +3RN0O12rZPSEJzL2leQ0BC7ZrmRqFOdEUMvJX+kfoU/me5cIADMjIslteBqkoD1ukA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCDbJlnr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FAC606A31A;
	Fri, 30 Oct 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCDbJlnr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793386411;
	b=BX3EQfCS1WM4nqFA2w9jlusdwIGHADadD76eyRmcfnE0E7Xt/5rc5tpJSHqC0/dVIZCl
	 Jonne6FqDZFn8N9OZIKCdf8StnlF/2kYm+SHMIHRs8CvFclhRqhL89Jtu9dMhKqWpdWAG
	 jvna9MRI7LhlCIZo2L8IoODnKdjxm0R380LwlzjL55VhC5iJxGNI5wIBcdu23UyQZssBd
	 SKoWlIn2Z9lUo1wt4qIUkuo10FouzhuXupNDGg92n5Uq86DfCGecxIIhH9FCO5rgTKbZh
	 y20Yo6VGP61de8ykl7aqQgMRfALiseUwjKyNbXpYvaAnDi8DPPhBiSL7dhfCTdikHPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793386411;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BcTkHU3xFfurIvUDvdqPEEtdJfeCpIt93+610uspIAg=;
	b=pipFxxR3vADBPIEnvvJJpD3vVLKQ34DrNj0PElldomJXm1ZlCwyqcE6xTMoPt4MCXqP7
	 3qZ/q+leswR19go9QozJwcyNRuFc05IfMDRXnM1nYEc+yk98nul8atwJHOx6vivXkqN8T
	 zJmj6xO4U8bx7FQ/jAiYQi1CjyFovCjSX+EjTp5sHEsjr79vdW5TDkAAf2BGRLBDVkd/7
	 mA0a2rispn0XHtPk+Qcs/MudlUpF/CWFfbFXjb2S+Gh/A29uvAKo7JFGEW6tGB49CRtU4
	 P4obAVXvSNUBDRkGLEy97u7VyfASy0hdF4GnshQi463VynoAJmrSot8S9QXa/FPcjUg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9B56B1F00A15;
	Fri, 30 Oct 2026 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386411;
	bh=BcTkHU3xFfurIvUDvdqPEEtdJfeCpIt93+610uspIAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VCDbJlnroZTcNRcdh5sVM4vyid2QTP9D01/OAIHD0OM9Pve/gjXopE6EB5flX7ahr
	 INQor9LV3J6VCjcGhhyVX+FVWLJSnrOjtQ7ToFIRTMYU8+aIkhQyqgE1YxeeWwoiK2
	 tgQeSpLAaeU+oTTCRh2PuE7HRikeN2qId+DdmStdbHUSJ0JvGJSR41krUozyMZ4teX
	 m3I2dJJPqD61FtkVvvxF2tRQZ/gzyS3wVGuHUj4jZdtbqz0NZsWUz2jBFKR7rlbFeB
	 5UGvTEswf6vzG8zW3QglBdKYbIeOFTMiUCkSzxTuGum5Bt8G1u+Yq6FCp9OpozhoBH
	 L+FrGYrMYaTtQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 094F344240;
	Fri, 30 Oct 2026 18:53:30 +0000 (UTC)
From: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Date: Sat, 31 Oct 2026 00:23:28 +0530
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Benewake
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-tf-luna-v2-1-ce403579bb8a@gmail.com>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
In-Reply-To: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vidhu Sarwal <vidhu.linux@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793386408; l=977;
 i=vidhu.linux@gmail.com; s=20260713; h=from:subject:message-id;
 bh=Z4qpQxGk8/ZLvR6AVg1efX2K+/RAXdyFnxmZd3Q+oH4=;
 b=Fvsp4hI/o5xpygCC1pqmvHHzL2GAaQSrcVM0HxtRmMNuelKIKy/OHE6CwptHGPNGbTzefSkSQ
 +g/yNQPAmKzCzX/bKOU9DLT0haIaOWIb+mEN8z66nvakOKxRVQ0Drdz
X-Developer-Key: i=vidhu.linux@gmail.com; a=ed25519;
 pk=xDu3Cbesz76CQXwY8lteI74n3ELVIV7wCsuYAvcX1Q4=
X-Endpoint-Received: by B4 Relay for vidhu.linux@gmail.com/20260713 with
 auth_id=869
X-Original-From: Vidhu Sarwal <vidhu.linux@gmail.com>
Reply-To: vidhu.linux@gmail.com
Content-Transfer-Encoding: 7bit

From: Vidhu Sarwal <vidhu.linux@gmail.com>

Add vendor prefix for Benewake (Beijing) Co., Ltd., a manufacturer of
LiDAR distance sensors.
https://en.benewake.com/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0ec4e481c64b..7bc9c071913b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -245,6 +245,8 @@ patternProperties:
     description: BeagleBoard.org Foundation
   "^belling,.*":
     description: Shanghai Belling Co., Ltd.
+  "^benewake,.*":
+    description: Benewake (Beijing) Co., Ltd.
   "^bestar,.*":
     description: Shenzhen Bestar Electronic Technology Co., Ltd.
   "^bhf,.*":

-- 
2.53.0


