Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F54534B7
	for <linux-iio@vger.kernel.org>; Sat, 26 Sep 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437313; cv=none; b=Nf4rBIDvDl7izXb2qa2K0tMRINpD1AdOu25S5Dnut8QvNCXgvp1oM/keIUUcRpORwQXVo/AlF0WI4muLmLyso1PNLufMSYzH1QkxEDdEibeImH/MVRl9g+J0N+fX3OWi6Mco91knbINzMRxEwD2MNkEvw+vwJyHe3h+5ZRkAq0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437313; c=relaxed/simple;
	bh=boRhzYo1vp8mJ62ZfBPoq8DB5FEW2n1uhxYfp1n55Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=QlxanQyZYfMKqCPhYpO42iE2MmoPA8foYxdv5CHudYj2E/25D90oI6Tx/aoQBfYF5cwXQjK79EcSJ1j9S0nB4xznpT+5w01mRYzF1LnXp/EMMDKGE/ElSE0X/fvATfDDrgbVDnHE3sZVDL3jbdG2BANZWUmwRfOrKtYSJFBwIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ws+HnoK6; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ws+HnoK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790437308; bh=9qSwSt3Jhiots8IF9hOBrO+8UHsghCYhhmgo8FDqbnQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Ws+HnoK6dctAlBcpznW02e/1l65jh8WGafc8v8CdtM+D6AwgsQ2DAm0oVGWjWsj0MKzfzC+9MozzgOZIcoJ+2eA6TPsdjDkYOLgwsiUhQIqT2CCmiRn/hLMKyr01o+l7YFgVTfqCvjm7Vbsh9EVWyWccgjon/ADIln/Aj3tyVV/3l6AC3rzPjtbEtne/0yAZrF87Wew99bFzJEcQm84WJP7HkqdepMbeESArSbJ7cZ3CSlAZXMbqXaBryRfOxA0bzvQJj4/LdKp0oTqipyVzSFXPeXMF0T21NC6U+jjkNWwe4pjU75Gd3s60uQEetdDc9MHaOQ7bAyAuTU7WJNbfhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790437308; bh=b/QLxM1ikxnFXij3bFwPMLzFixCbMlMgwZ/Tci6HkJI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=q/Y7qH6r1VVW9ior3HPpOTdlJiygMgzohizuE21Pbk+y/U3Rs8c8KPPmrReURD/gRyoVKI1M7SLApqjx0fU1Cs25AtR8ftxcmqVIFuCOGdLhKoOS4Df3Jp/V14FtGgV7t1m2XgyHKyyYLDrw+muQowJ1CWAEYa5J4qtLVlef9cGeOBKjCkz5MMocbMoZg8GbeLdMZJgkFzkVxT1sb4IDd9ix1xB3bAStAv/PZDy5Kk511ROPDaXHtwHP5uwuHXX3Pz6YbrUTDROzlzPmQK3a/NUT5KnfY7Q159MNyqHa9BZVBjtrquFuJFK6/nQCgf7/77Txv9o1mxqacA4dYof3hw==
X-YMail-OSG: BGHCT.YVM1lOcwRtVg2kfdPxfZn7rU5VgCIp4ym2Wp2cktdNKOujmrBn7L2gHDb
 hfKkLLW1q.hJjLjHU_KkPg.4.YI_._TgZXivhR_Ox15nRGQf1fAjyx7eLLyz3GAo_yoGmIzCBQWC
 HzgNNgVfoXU2ApIobrKbxTY2Vf3xFE2lTwSiGz1N8UI824WRRuIIR2oz0iRsjLdgDgopDCh4HvSb
 vrR7zPK49LnIZ93qQjHGRMW7zeM7JrcnHskxb8llxYLX0l.CboXzXUQZl6Oiku5Pd1ZGxzCAot.s
 Kgji2nNe.Wp3N56fqA.dzc1jyC6hUsIvClHGSdYCcNkTYTB_lYPxMiTVRxb1WdQv.i3eMc3AF.mT
 .pUrgOLyMxO7_w2LVTdQjW_JNG2jCOfbeLFsB8KgFo3BHFtIIFNfX1cnrI9anXWnxaU3zyX2VAfw
 VWUdlTxtr.tNiltCQxJXW2vTroPD7LbRlOhIVIJzhe0hwi5NyMhR9wyTOxjxPeaBpi68o7dBu_Wb
 VIhmihtCnhmkz1R7q01rE9ga6UZ1kb8LSMLuVc8kxIvklUDIwf.2ckEzss9MfvkdDJT8Y05o2kQq
 25U8TkEo5GUd5qGO7finkLwY73wuLee62PjhmQQwXL4837BxZ8aqQgTS8Ee20S9F2.3zgX6A1_wM
 CD9TCDwfihSPkMf3IsKgemHNqJOTqISW3c3Prv0Lt9tNf86Uq8MI8GjGHeE5c_XZ8HeeMFSkfr66
 FMC6oQm2WVdrMlbeAf34iT2l37Lfhxny.LNVtwaWqfQkiFY0sM1fkeRpHbSZnoiEyERgY2IIlJ2I
 QVxnlkXLQTihHQWq.rUMbkycGRVLKxz9S_800zD0PntI1d4zggGz3xtIIlURaFwkslo156eC5vW.
 utT8Cau1dwxyth4cPtF6Yu8Whtg0Ti.tLYaQRFJIe9AuZlw5yKHMHIDxNpH.lbYa_Rd0IBm8gT6o
 w4bd15NbdP9lZCJJTOp5JEDYzWqcnzNjYr6caf8n8ge2rzZr1q0qN3enHPnlup0NnErGlP7mi2CQ
 yw8XLYERbwaaSy9CzgUoRsyTDP0dDf5PKNgAiMOvOnHlwBlhQEAtwz2xW0xpLyI54v5YauuV2QKp
 zQVHJyhA.mNWxsqRdIOE5l0DAnyf5JdlCEwtXQrETeooPzpkD9CPurn7cBXKoves025gxdwLWJ8Z
 HjCD6PhQuUTmorQ9tP3ZYn09IpJz.YRmcPFjNAG8RO1AXhUPz7nwEHV_AwSQuSbJ.Xce1BYGy1sq
 qInWGR7KruoHBTaZFLYPSPkXRxEoTgOS0glqivczYg16a3ClQUSoZ3avDxV9NOJ0pIY5D1R0aEgB
 _0ifefgTZa6jrQ8FNtgpMwQeenMigTnGDmNDsT.7.rKV2OGxbpeYQt.8gqZASqVR.DieHeQBGC_P
 GHhEz2XVbPjGhFfhHAm1CYX4xtCZnj6vV3ulfFJc2vZmRHFAPFG24ODjBXqT3TPjz5uN0Y.3tgcY
 K5ab0EX0SUb_mgwUnv_JKbGnIb6a7utxHqaEpnLERf.lP6ty1TPaD304kWAanjk.QRBPfLMD7N.e
 Yz1rHcUPaSJO5JUJN2Xz1Njt43wGbu_homF8VU9xFx6617toToHDaZimMuCqj58c2CCsenN2Su.i
 g94ikQ3AnGHgPlTGE_AuYhXvluSbDWMaaVFns4Pt_Vt__bczMeLKyYXmZKiafO_pAh2CYF5aq3vY
 IM1dBcWmbhxrM21HYHRCSaEzvq5RvdQ5rdvstfinRct7cYKmMw3l9NAV1qW45xpe_0IDRUIjd2tu
 A2tneTp6CQuljRsrja.MZCn46QPxqQtpX_lyBNJ0p5iYgTQt3C4rCbYZyvH9QQxZjuH4BAlpSEP3
 Myp1ON77e1Sb46p.ffpr6Q47t93_MyWcLZ2niszRafSs1uP9fEnDRVmEguPxK4F7.2r.Ej4Qh_cG
 gWuHljCR.ErWjz2vk84xxc2oFLVjGULl9._26uFX5P6V8DfTGEOtie5YZswgCu_g1hNmn.UJ9yus
 RtiWdQCezoMq4N9yHagCpnkZE3Yt3CcPE4YutZZmhDrfh
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: b341e838-f06f-4747-99c5-1f8e428b1fc5
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Sat, 26 Sep 2026 15:41:48 +0000
Received: from dip33.lsn.bf1.yahoo.com ([67.195.177.42])
          by hello (SMTP) with SMTP ID 46afa743fbae7daefe6e6367ec9b72bd;
          Sat, 26 Sep 2026 15:41:44 +0000 (UTC)
From: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Subject: [PATCH v3 0/2] iio: pressure: add Sensirion SDP31 driver
Date: Sat, 26 Sep 2026 20:41:16 +0500
Message-ID: <20260926154118.5471-1-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260926154118.5471-1-m.abubakar365.ref@yahoo.com>

This series adds support for the Sensirion SDP31 differential pressure
sensor, an I2C device that also reports temperature.

The SDP31 uses a completely different I2C command protocol from the
already supported SDP500 (command-triggered measurements with a per-word
CRC-8), so extending the sdp500 driver does not make sense. No compatible
parts from other vendors were found.

Patch 1 adds the device tree binding.
Patch 2 adds the IIO driver, which exposes differential pressure and
temperature channels and validates each measurement using the sensor's
CRC-8 checksum.

The driver was developed and tested on an SDP31 wired to the I2C bus of
a Raspberry Pi 4.

Changes since v2:
- Remove leftover development annotation comments from the driver.
- Drop the SDP31_TEMP_SCALE define and use the value inline.
- In sdp31_send_cmd(), separate the declaration of ret from the call so
  the call sits next to its error check.
- Add blank lines before the trailing return statements.
- Wait for the sensor's power-up time (datasheet t_PU) after enabling the
  regulator, before the first I2C transaction.

Changes since v1:
- dt-bindings: make vdd-supply required, and enable the regulator in the
  driver using devm_regulator_get_enable().
- Move the MAINTAINERS entry into the dt-bindings patch; the driver patch
  only adds its own file.
- Populate the CRC-8 table with DO_ONCE() to avoid a race between
  concurrent probes.
- Use devm_mutex_init() and take the lock inside sdp31_measure() using
  guard(mutex).
- Build the command with __be16/cpu_to_be16() and parse the reply with
  get_unaligned_be16().
- Use a named initializer in the i2c_device_id table.

v1: https://lore.kernel.org/linux-iio/20260919223650.13396-1-m.abubakar365@yahoo.com/
v2: https://lore.kernel.org/linux-iio/20260920164533.31988-1-m.abubakar365@yahoo.com/

Muhammad Abu Bakar (2):
  dt-bindings: iio: pressure: add Sensirion SDP31
  iio: pressure: add Sensirion SDP31 driver

 .../iio/pressure/sensirion,sdp31.yaml         |  41 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |  11 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/sdp31.c                  | 213 ++++++++++++++++++
 5 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
 create mode 100644 drivers/iio/pressure/sdp31.c

-- 
2.43.0

