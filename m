Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503344;
	b=2WzRjwc/UIwYX2lv7Ba7/AxF61JgymigBKcQ85/8YaE1z5BuPHu7851V13EwppaaaX0D
	 h4EKqFk3kTUYxf9fC35zOrOcFHnj3N1TvMIOboO2W50sWZCLd1tKWMSN6hPGoBk6k1mUP
	 6pmaEtGqMes2c4Pp290kLhWSBtHTieh0MV0pfpqh+xK4lglWPhVGVEoqtMUavOvXa8rbc
	 T4HUJWcoIvDZOYHs/fGv3y750k/Od8vjA35M4Hiks0b3Y4gpTt7qIfm32LivLv7P35rzm
	 xDOj8FyCrhrqz4r7U1HfWejRkN0LlYoVlT30MJRfhGumge+Jilplfjb7lbOcgZZeKXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503344;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oj2TNmHu0aGvGVnFAhxBXVtL1PvBAFJMiuWObtt4eU8=;
	b=jIpsvN3pHFl/1LEAMninLYEpt+Kwg19iej2Bcq+lRgLdDtLrfpz7Lp+IkrD61nvhaX3Y
	 5qovSi99PfTWQuF+Qwy7L+dg7MzNz124BkkDUQVL2e3QN+hrYTByCSKnqAKJrsR4a+PVE
	 4UHz0NX0GPpX/PP/ZKhO8Qo7cNJLolSwUDf3YV9HcmAQ4kIwja9l7Ihd+iteEz4Etvimj
	 Bxnn+FffRKFDSKEm5uEa8i3RjEV/B8EwmDK9xf64eRt+vZwTcQBzYH2rTI5HkH4P+eC6+
	 T+932eS9Y23ssFfBHw+NLFapMVGHj7G15gcoe4ah7igVnJ6538NKlsVJ+bPEpXlqZ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=KNTpMS5P;
	arc=none smtp.remote-ip=91.218.175.118
Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0169606A332
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 17:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0169606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=KNTpMS5P
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W6VeXoYsDeuooRLOPur5oKNEUPcbNXvMYUsUnI6yMhQ=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794503340; v=1; x=1795108140;
 b=KNTpMS5PiD58A1ons/DpdJZmpZOCajmxxKBM5F/RE+ZjoQuNDaELQmTkqYAwdvagMjqJPCOH
 VyVorLwW83zHYFDRVk9P6fnbphJ1ZPIVuU/7JmkCTfDGeBw/ma+fwnFbeaP6RRKc9ypS1qR3P2h
 ipGeKR709smjl2/rMw2zt6CDTkzPrBN71Ds1fLAaz78BUPpwF+3E83msDbhgNXUZh4jt2ri2HIj
 Sak3LhdsE0QAL95+jlxE2NM8uPvNuHnRUNWNPQa5+3MHZsX0n2eNmAk1Nr1zRLXLyh7V9Be9bEH
 Et+M8i7ydeO2Z0C2nSxkkowNxTqr+0WISXwIcDxn9lV2Q==
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cc99491184bea011;
	Thu, 12 Nov 2026 17:09:00 +0000
X-Mizu-Trace-ID: cc99491184bea011
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	Marc Lainez <marc.lainez@gmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
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
Subject: [PATCH 0/5] Add driver for Qualcomm QGauge (qcom_qg) fuel gauge
Date: Thu, 12 Nov 2026 14:07:26 -0300
Message-ID: <20261112170841.2189322-1-val@packett.cool>
X-Mailer: git-send-email 2.56.0
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

Hi o/

This series adds a driver for the "qgauge" battery fuel gauge
present in Qualcomm PMICs like PMI632, PM6150, PM7250B, PM2250.
The PMI632 is used in SDM632, SM6115/SM4250, SM6125 based phones.

This series was tested on sm6115-motorola-{cebu,guamp}, whose basic
dts has been submitted as [1].

There have been two attempts at making this driver, the first one
"WIP! power: supply: Add rude driver for QGauge" as found in
various development forks [2] was rather infamous for wild capacity%
swings due to load variation :D

The second one was submitted to msm8953-mainline at [3] by
Marc Lainez, and it behaved much better thanks to the use of
power_supply_batinfo_ocv2cap.

This is a continuation of that work, carrying his From/S-o-b on
modified patches with explicit permission. I have added the
SDAM read via NVMEM API, fixed the batt_info leak and did some
general cleanup.

With the SMB5 work also going on right now, we'll finally have
full battery support on these awkward pre-battmgr generations!

[1]: https://lore.kernel.org/all/20261109221453.658316-1-val@packett.cool/
[2]: https://github.com/sm7150-mainline/linux/commit/76879bf7a71f4f8f66b9bcd7175069ca7bbf4274
[3]: https://github.com/msm8953-mainline/linux/pull/242

Thanks,
~val

---

Marc Lainez (2):
  dt-bindings: power: supply: add Qualcomm QGauge fuel gauge
  power: supply: add Qualcomm QGauge (qcom_qg) fuel gauge driver

Val Packett (3):
  iio: adc: qcom-spmi-adc5: Add ADC5_BAT_THERM_100K_PU
  arm64: dts: qcom: pmi632: Add missing bat_therm ADC channel
  arm64: dts: qcom: pmi632: Add battery fuel gauge node

 .../bindings/power/supply/qcom,qg.yaml        | 105 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/qcom/pmi632.dtsi          |  41 +
 drivers/iio/adc/qcom-spmi-adc5.c              |   2 +
 drivers/power/supply/Kconfig                  |  13 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/qcom_qg.c                | 807 ++++++++++++++++++
 7 files changed, 976 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,qg.yaml
 create mode 100644 drivers/power/supply/qcom_qg.c

-- 
2.56.0

