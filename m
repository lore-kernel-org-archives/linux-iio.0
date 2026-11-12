Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503388;
	b=T0WHO86Q+weGe1H7wOyvwfQd+stFVzAOUN4Kb/lVxEqazSL5+IFYDn5M8n52HOqxkiPx
	 rRotH2qULpfhGTuN/MIvlsmryz4ayG6UK6GKXKa0ftCWXXbKud/PfKT9Prmklndzj5YBH
	 psCJVS+fGRKb/9dXPu3Pmb+DFuSG/Lkgg6cckOkn6HBJozxMVYKmrSHfo472DgJcT3Q06
	 XXlwL1Yh80lfX71oQcYoD68+9QH8s270zr0ywOo5+Dfz/XgjkZJ/UU1LIyzmr6g2cn+je
	 I1rdAziqowUABksm4mJA89WkqsGZfgZ15cnyK1151R3hj3gT+v00kG0SR3Q9oY/Wtyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503388;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BGgWKkrRQl2lSND/U2uqoO60aN3FWXpk1m/u2Tb52v0=;
	b=Ng+XX9W+PEWwU1iYpiD8uNuZq4kXXoZfOiatPKIJH7T+DsrhuiD4V+Iqud+mVufN9wXM
	 wJl8I0NuoZJfgBsR4wXpGxHdFBEWqTg26PdmnqJRUAsGCvpIZdvnx4UM8Ien1RzMtG01f
	 OOFL/benE1cgSxmVSVOcqy3Hcb7ribtuwT3Ruu7g1Un+H+F6zklwTWGQbVCGDeBUsrdSM
	 VjpYIefaXJ8it3dQAqJuI7JO+63MecIM/tolhCsbjSaadXKtQ2Jk77Ij57cuvf/oeoMRu
	 kUtDUuiJT+p4BgVpSh1alYsbs5spzfJZvuzlCZlzLrykkEyVOrNyJuM4adenBzJsAhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=pYPsXGqL;
	arc=none smtp.remote-ip=91.218.175.168
Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920F606A32D
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 17:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2920F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=pYPsXGqL
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qPsNvOqpGJ3pwA3WfkNEk+1ZJzUEL1h3NDg+2/5l8xs=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794503386; v=1; x=1795108186;
 b=pYPsXGqL45Wq3wn8jbxvE4KpZ24WxNKrk0W6akWqsfsjl7D4QrRL3+sFHXdih63yAxLJ8jBH
 m7F4y8htTxmp8KggwazeJmY7eFoJ7h8AY6bATXE7P6j73ohQYQJYLwjmzVpcY4b0FBrev8f+lKY
 bDh6xP2+qAp5KKqbbZXI0BhIBAjROVyBj0P2wyfh2XANGO2DV2JRiVySwMCe556nPjofW0jzNNO
 C3skSyunXr3EXExiH9GWYgYEXwiHA2/oH5T6gRH+J8GCWwjRe4Kfl3hsi4oiNuAjn0VIa0nNaGW
 vtNKt+CbzYRbPrM7VCAHxdXPs4+P3C0cRH3aXNic4Q3Ww==
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3082e74ed36220db;
	Thu, 12 Nov 2026 17:09:46 +0000
X-Mizu-Trace-ID: 3082e74ed36220db
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Val Packett <val@packett.cool>,
	Marc Lainez <marc.lainez@gmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: qcom: pmi632: Add missing bat_therm ADC channel
Date: Thu, 12 Nov 2026 14:07:30 -0300
Message-ID: <20261112170841.2189322-5-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112170841.2189322-1-val@packett.cool>
References: <20261112170841.2189322-1-val@packett.cool>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the temperature channel that is used with the battery fuel gauge.

Signed-off-by: Val Packett <val@packett.cool>
---
 arch/arm64/boot/dts/qcom/pmi632.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
index ab850050eb22..82b5d7b7bb5b 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -124,6 +124,14 @@ channel@9 {
 				label = "chg_temp";
 			};
 
+			channel@4a {
+				reg = <ADC5_BAT_THERM_100K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm";
+			};
+
 			channel@4b {
 				reg = <ADC5_BAT_ID_100K_PU>;
 				qcom,hw-settle-time = <200>;
-- 
2.56.0

