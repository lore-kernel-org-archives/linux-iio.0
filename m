Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B83B83FC
	for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406286; cv=none; b=fCn6f8ynjDwVpSt70oEh5KgUlAB9GVbqAh2fXI5lG/iDUyEQjk0puNqprLqqRNtajIekFkHPTlTIyHKMFtZmulW60j/OyjXYklsDGDCocEEztvB/JdtBklNbsZ40IgMRLK94r5av+W9ewY0axpqH22jEJUyRETML+pGhreGyLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406286; c=relaxed/simple;
	bh=rxFBALBPTY1RUMpju+vDz4IJa6RsK6gHijCBdFBtRsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=TdJN6hy3c55rt1wktNsQjbr/F1FG1ulekYCtHUBs7FIUctgDn+5eXUqyudB6p9dXYW1faH+iu/oA/j3PCtZ8Mz8u2VMck3BO0fvCGx7N67Gj++IDI04v9YRY06eTQv9d3Ni2hSjuonQYvd+2nk4ovnuh2Cpn5JHSsupgbqgGuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Cp0svJm3; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Cp0svJm3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406281; bh=ImTorsRQNhMdTDKCNNnzzSmUx5dJ55T/lsthkrf3/7I=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Cp0svJm3IFl//7autp8PjFl+V7z1+zR1T71hFQzc4WBQskKxT1+sVr30vZkfIMu/qf+cyBuDthyLEbOAeL8sf7uvQRb03iexi7ikeQl8FfT3oJpe3aguoFre/RDhprgosZF5nfewskNGy5KPwRLMGk0zrLaCq51SGyMMabMZKiy21+XAXW5Rw6O4ViQJvHIk+rrnRcO3jWvyrEeVEu737fLgmOSozCR5spsJzcu8aftZuiHWNGH5yQU9ik13+zl7aI+wKrSaslWZV+CQEePcGg663Dm1cVtsqgSUZO7e/r9uK+ZOmsic8132e2BNb3Grie3l8WxfbneEPBnIsoYRZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406281; bh=VOtGqr0CXqcrX/JoCcmpg/cQzGTlHse/EvXf0NbHcnH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ag6n63ZrVBZshIjI9NNdlxkjiQGM4s0UC+fCexK3jRgsd8xa/EdZUtMM2s2shT0+opGQVEab1hBwc0eho7B22nlW0YTwoPYqYWrZ+i5Pu39gqEIkHnaN6pcEs4W9E8/znD/mPQYOi+vNO8cexyDxzO8Gsxywudc/6JUlFmeW1nzgCv0Da24f+QuegMzDeims0MpKh/racDpO4ot4rmGadUtfLBkv++Ko47EXNDIhiaMsSTeUWsnssqETgI3aP0otss0JSCzqyXE3BAfs5PASzRH0hUke8z7i3KYEDGJrJMK+8Q5mTx7uAbJW9LXOAwk/ZAd8Sf1ObSUBEPvtoIoacA==
X-YMail-OSG: BUgbAPQVM1moyNlDLW5yw8KxyKk.WprXtMcW8R79Z4k1qC6LdmFWjHXXAycIkkX
 dSHpBW80F82ucif5kaclm1rw8J9UnFWidNHVP5JYtzuYglfqAzHT6myE_YKnVrC9EIQC5nZRg11D
 mKn5ybLcXciKgWzo7xo.cXKZRbdQiIQ8EqoSvM3infBcTMykiXnHhj7WATEBDHhtj4nOYQo.pyz2
 .QopbgYH2wPxOH9O4S.3MS3h.K_gm5uS.2_N0Z9el4ZoISJtYDfCyzCoTExDakaqLc1DqfAvxpfF
 TlMa6vCBFGF1b6Vr_vSV5XrTOxQ7jVh8GKrbSVFSxwQcdMiZ5BcC7gaEXAcvgw2NJWs3xJyhXoAF
 bFJg.u3jVXh7TNP039YN6Pl_jTHTX9QB9uizgC7vjthYlbnUxm0yqo5any4twEdA2VofkcjnlQFo
 qSyZxrNoOrGUc.a360ciIll1CI774VM9L9VrZdegKXKJmqlNvMdn7.quLqFiD5BcLoRlpjWJ5v0Y
 NzsOf3CikC1nAZoTPL6cgu2rjr5Cc.HKldAKMod1FBEwCTmCuIDGVxbX2fnc77Vej3zI1tpUY7wX
 TkMzANVlx0gxgEfpgWoZTzkhTX_4giQEOpn2n8Yjyt9CdltH9TLOOBCBcIkjrvxkouHbZzn0WMqZ
 PQSCKH716KYiRQjQmb7hyDwy2B.o0XM.sfmKdQ6FQ0uu.FaUy5sLm0WRucMauFn26Zj3S6siyloB
 iEUj7W2pGpJxtjWeqhSbmhKWjGyzPri5iQHl9l1sK5tDIQVgQdICq4N_8ynOKVKRwjX5eKG60q0Z
 dMUHnlFDurHjPUSX4PVtT8seBnyjkhVbeAfKTw9HKThT2ZQlnceK12OWGU3sxi3bSnK775FXwZWW
 c6L59Ewxp4utlVng9I7SpgTWXg3M82wy6tP5sr68lt9ybl9GD_9aiYlqKU43rVn_np9bgwDtCKa2
 vvh18IAV1gP.pHnqz1YWBUNsSG.d7Zj3TyDGv2eWypO31E.nzeXywPXzzhsdD2vk_VI2KGeNnmUb
 n7rp5aBnzSJPYyZl.rAX1crSdrpsR_XbMRmpJSNj6FAGC3APbrYC5kOb3.yiJluGm_Is1_kEvzLs
 5nEvMWh5c1QAWgITvjBZ3U8g5UdJ46FrLvjM7PUajSu.l9QuQKonx1DjH0GrY512QvPIgu5gW1ZN
 nNSbDaitDdhlgXzftBPpO7dKHeWgTCrlDpNH1bQuahbNSCM3In8GUuQVk.hV3Lr.97MhYJkGSs5u
 UFmtA4gcpefZV8LPeTMQnanKxTyeCM965Zzb1tGKPvzYCZ2fS7.crJv_be_hulIw7TsIerfRj5Yd
 eIrk2xp6eOZI3WS1ZniAPP4Gzq5kbMRBBqICW2X4hQTpyRfVb4ulDCco9B.zIJF__nZcCa4zzE6i
 sSGw4KCSB_OkZbbmQt4CeG2OroqDEGEpGNQjvwSsxn.S9y.QRitE86eFAzlyBXSK6BYX91_gnSZQ
 Zm12EG3hI8VS35jQ_VtyBY2pH.qaWVgOYOO6Zdx.Ifc0f_ln5FVwyroE51m48elOZ8yg8EdusTyd
 5eBrKsGOWvXAjgIBxzZLUt_y0ywgJQJt_0Gb8Xng.BOPxfxzqzVj62MeXmq05WKVC0TrFJgLb993
 sniGQ95dzYmtmCz8bQ.e__NGW_Kr5ueZ4dfNTlgZ2oUlQe7K64sjLzuKo_4afWI5ezcK4G9LSYFD
 EnTZ79s9f4IgA2raA.eo21509nfe0Pk.tVoR3E7tqJyIBT3DM2NQD.BRjlbJH7Y2oPXL3wfVgdQ2
 0mUwKRiEXMxmWc_uomVvMhrIksgrwccpG48XJALLeD7QcCz3iUBgu0FlpcJYk.C9DlX7zNXQOXpb
 Vyhg6Zh7RppqEjjDpKEIh34WFMlyvRnhMovrTGOU6OMdFW2XW8nEHxJ0sEYv1BxWGiUUFBslhElm
 qrbHTq9yMQddXSmNvGqJXASOgRzf32urn2JPbuLeIahiJaswToJNBuY0kPNE1cb_VM2lWh427CdG
 8jOwc_AgM4jH83fkFVd.kisqbR_6tPhQ_CCObF.GosRE2fQ--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 98935a8e-1e5f-45a6-ac7a-202085a466c5
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Wed, 7 Oct 2026 20:51:21 +0000
Received: from dip106.lsn.bf1.yahoo.com ([67.195.177.115])
          by hello (SMTP) with SMTP ID 91bb27b55516d1fb42642a09b5dc36d3;
          Wed, 07 Oct 2026 20:51:14 +0000 (UTC)
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
	m.abubakar365@yahoo.com
Subject: [PATCH v6 0/2] iio: pressure: add Sensirion SDP31 driver
Date: Thu,  8 Oct 2026 01:51:02 +0500
Message-ID: <20261007205104.4694-1-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261007205104.4694-1-m.abubakar365.ref@yahoo.com>

This series adds support for the Sensirion SDP3x family of differential
pressure sensors (SDP31, SDP32 and SDP33), I2C devices that also report
temperature.

The SDP3x uses a completely different I2C command protocol from the
already supported SDP500, so extending the sdp500 driver does not make
sense.

Patch 1 adds the device tree binding.
Patch 2 adds the IIO driver, which exposes differential pressure and
temperature channels and validates each measurement using the sensor's
CRC-8 checksum. The SDP32 and SDP33 differ from the SDP31 only in range
and use it as a fallback compatible; the scale factor is read from the
sensor at runtime. Tested on an SDP31 wired to the I2C bus of a
Raspberry Pi 4.

Changes since v5:
- dt-bindings: drop the literal block marker from the description.
- driver: drop the mod_devicetable.h include and re-wrap the
  sdp31_read_measurement() prototype.
- Use the plain "Assisted-by: LLM" form of the tag.
- Collect Reviewed-by tags from Krzysztof (patch 1) and Andy (patch 2).
- Fix the links to earlier versions below; previous cover letters
  pointed at wrong Message-IDs.

v1: https://lore.kernel.org/linux-iio/20260919223854.13437-1-m.abubakar365@yahoo.com/
v2: https://lore.kernel.org/linux-iio/20260920164724.32019-1-m.abubakar365@yahoo.com/
v3: https://lore.kernel.org/linux-iio/20260926154118.5471-1-m.abubakar365@yahoo.com/
v4: https://lore.kernel.org/linux-iio/20260928215422.3720-1-m.abubakar365@yahoo.com/
v5: https://lore.kernel.org/linux-iio/20261003160949.4657-1-m.abubakar365@yahoo.com/

Muhammad Abu Bakar (2):
  dt-bindings: iio: pressure: add Sensirion SDP31
  iio: pressure: add Sensirion SDP31 driver

 .../iio/pressure/sensirion,sdp31.yaml         |  51 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |  11 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/sdp31.c                  | 243 ++++++++++++++++++
 5 files changed, 312 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
 create mode 100644 drivers/iio/pressure/sdp31.c

-- 
2.43.0

