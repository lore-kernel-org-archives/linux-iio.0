Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D34F7CC0
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632497; cv=none; b=JwyHT7PVtifuiGnvrQhtmEkretzQQMkprJpBfS6P3/QYdCh57b6MkT2xLaPRA//7jGpq3p9SsjUruI2j8Sz1CwrFucDySOnaNKBqAmSO8yEAxplYvcK9qJYv3fLFm3znn4n+rRpGWH/I5G39A2Mgf+/yCIYFJY90mv9wZNX/SmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632497; c=relaxed/simple;
	bh=jCL4z3TqXM8kEezxfX4y2YEX2K7cxLQC5MpNZiieyno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=U104WofkbBuiT9rxUNZGWBTsfnqa8QrwTSoqOQOG63dG9BcnfcfgwBNsxOdpaUmbGAj7LsLQ0A0maX7IUnMfyCKeWq59n3JOI9fg4Y9/n39e7Hj+E/EwoFsWaUnsLZAnmi24SnITWPcz77+pG2S4zRINOr4pnBKxVrA+GahNCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OKynxuW+; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OKynxuW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790632491; bh=zO5q4LkqU9FGSgnhhTg/0N9HuMtDades8t3AQLFFfCI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=OKynxuW+wBRX9cQ39oE+03ybphcQH6/5yJQ5APWbVQqzHBVrcgW0GHpFgsyxUjT3GrtWjSS9D5fcWSfVN6o81y/bZaj1okZyLSPjKHCbIw8FqYa91tES+OXkUJKU1+9mq0fR4Wvp0H0j2wz7q3lSdveMkFKUWoKBkQD3msmRYw9+stv/Jf9RuGXq6ll4co+OTg6iQwGdBAOTBj1TbdRaT4zflOp7mud9M36myLo+fZI3HQ9BKYCi9SVTzN/DLc12uiIJNDHmf/d1KlT3ye+TbtzDEpWyxtWn8ss6xtC/exzVhrG70UW21Y1UMZzGzij53nUhX6+e3ceu/4O9OoWrUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790632491; bh=Cnx9IoA8YsoWFYObYmBbbjthH5LUXDOW+qGCM8TIoxZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=N1a7LQ7lEQOPCyM6OZIe+7roqdyBk/WSPtOMd59q1Ne3Dhu4L/N4GxejSv/XDKVjR9eCR3baQ7VkgJQKzqgPsodPPnlTdqhxa4nP9xv4OSMxKPbhxFUn5OIQnqAckzsncdRdVWSrlYW2DsO0Q/RNOHqhtoNETn8jqA6Hn26ch3htMje0bR2EtCU0qyYSSJQfqV9uhNwFfLR92IIxxwqQshvbzXOaDG1MoBthevnWpJLQKAKyO/lQ73R5vglxhCFODs/fqUvT86UDxVI/emyv+w4GrafqcCeHQPFlzkoQQ1dggHdumuIEr9uTX/kPYc3Iqw165j0OGQM44IZXCs7nZA==
X-YMail-OSG: aOYKTKYVM1lcMskE9FR4cSeG_dSVaLo.GDeuGvOcus1mP_A3brvWve7YZFCFoNp
 Rdqps.ILl_LMvoG7IUrbm4ELF6joC2aMObWg6pX1xYCg5mzlFl3.JZ0LWeIN55ntX1lYO4I6gHbS
 iW9SWB3tnA2iA2AtdG8FGxW50Z6AQKWXmbxcgQxGIf_xwl7FyRR.qtAgZOAPFHr1d6mmXMSxmCyq
 P1PT6jpKEqTTcP.BsLV6eWagmMLDahyILVjHkSTS3m8XDMDSDGaCSp4RH9_eTbNpWWQ7zOw8D.Y.
 9ei0kqN.2xbhurA9uUfV2pF5B81VpbPUjP9MHhwUvJMWwRnfTgXhI_Pl.202VUCsbYin27kB9NwK
 UA07kfLJKTGMd4KKCjk0pcsxaHFXDMDO1pCGU5Pd8avgdmBAWmZtzFbzeG4eAacVJFhJ.S3BSLPJ
 ytPiAi0XwayS0hiGJR4nO_JizMRoNzuRJBzWCk_rCRLINPDGopKAXDclUDWk06hMsK5UoTwsBPik
 I3.3nnvAu5OzttZcte5Uu60zJBsHD8mWHe2kmphDQUG_Fqeo57iexvE2WKi1NfX89NltMwVKPoym
 STERXQDFiLTGiPGQoBGtSTyKpQ94RYqtTyVMrv9wJgglXgwPwSD9dJjfeDPaLqv314Plt69GVHBa
 bDyNlL.TaO0gGOJ4v8V7c_X40QyaoufBSsWXfLTqONkusUEnv7eLOJrwMqYUGjP13stftNCdIOYM
 Mv5oHeb1QzjtUvs.wfMKxxq0wyrFlrqwdJgVdlVlV8YZ.7zN8rOfSJj4n1LRfMQmAdEwwB4W6qS2
 V9yJZkflZDZUROcsek29FqENROpH3tNidji6gntWhhDsHA9hJgGGvL8o1ifUYSMJO3wgrf8B4Ihl
 7Yg26TFZufNbhRlM3v9mfqfkidPk3wUPh3CDEH5CLUIqA555tT88wI9uDsZxY7ksMUoN3vrGne5l
 6jeG_c.j.PIqGnaPVhSyLhlYuJ8VdGoAc_uXxuMBGEHTzmZAv_AdVHXkDuuUmK96gyECYRbef6x7
 ih2nKV154lHSgZSK4Rg8ziFmQw_.oYJucTTUirxINr_UfP9kn0VDrSDARUsnqOp6qyJCFreRczvr
 _rNwlftcwkze7GMKlckOnYu_4qRTPv8bWDU.Si5dhSrW8QxKlds0f204cZQp_Ele3S5X3Esa0pWj
 YJOYRL9i6mJqLZfX4rM1tHDples79BSu3CYDGA2aKICFjBE24eeeAw7WDkQi.0kCGBhoJSuCuqiq
 OCAa.85eysZlV.3PX3u94f9tDvPC2VtvJTTnfBvubmv8kfoGneXdJOXYf23KEOOBnkpPHYdbrc0F
 nqZrgRZ_g9ZqI9b1bOX5KG.nrOx.l.VbE1BbUZzzRfmFCdHkJdDw2ZyVcQFVMQbA8FZKl0iNORQX
 qDNA_QaTAwzOOT3JJTx333ALnxtRwp9FGYlDXzMcsDyjEd51xRwZmZfPOE0QeplFRstghx0kWxx6
 e_lRr6vUtFhZseQ2UrdW_jairz0PkBpgIZkOxfJ6Bvq42eJ1kdvmTEf0X_kpLdPn2YnNfGnTlZUf
 _C0Y95cc9VcCNHmejyBsog3fWMr92MKb0njUeAQg4Kf14J.kWBDXizMiJrwIYIjnd8VtmBPk8ENB
 8gVCWcmuY82OKwUQFLniTczIoxMNepF1v1pZ2LiFNJUclYwYoBad82Ai1TeG99bCKuLN5QGOcTJK
 ODa6j4P_vnfYIYluvryVHqOcoXrlaQTbw94HxZIBZfNhP7l8H3mb3xd8DbLa1o.X1aaJqUvaq5rO
 OCFfOscHpoURrgBODpFjy6Vt5JTaL0i61ReO9BneF.AxXD6Z5qBBpjvr3LgtpQHI3ifg8gj9RuxJ
 Yb1OAQF8yjEJlnoSR3QXKbPNR9tohDwN3PCJocmk93W1mRvae_4Z9Y3cszB7h75W1HD.Rh6LlIfv
 kOKYMqmpRITGsk1PKOkmmyGfu1FGgeXLFwlDOWzrGIpVSZ89nk7aRl9tGTK4ybLmZN606uQD2Ogo
 h700sfyTpO.NN8GbtRfcutDGO9Z3bWiIJi.VuCl1M.cJ9JMdakojlQL8V
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 4587f15b-2661-4a40-a739-321f1891aa3a
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Mon, 28 Sep 2026 21:54:51 +0000
Received: from dip75.lsn.bf1.yahoo.com ([67.195.177.84])
          by hello (SMTP) with SMTP ID 76ff639862f4e2dcd2f1f2eb210a11ab;
          Mon, 28 Sep 2026 21:54:45 +0000 (UTC)
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
Subject: [PATCH v4 0/2] iio: pressure: add Sensirion SDP31 driver
Date: Tue, 29 Sep 2026 02:54:20 +0500
Message-ID: <20260928215422.3720-1-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260928215422.3720-1-m.abubakar365.ref@yahoo.com>

This series adds support for the Sensirion SDP3x family of differential
pressure sensors (SDP31, SDP32 and SDP33), I2C devices that also report
temperature.

The SDP3x uses a completely different I2C command protocol from the
already supported SDP500, so extending the sdp500 driver does not make
sense.

Patch 1 adds the device tree binding.
Patch 2 adds the IIO driver, which exposes differential pressure and
temperature channels and validates each measurement using the sensor's
CRC-8 checksum. The scale factor is read from the sensor at runtime, so
the SDP31, SDP32 and SDP33 (which differ only in range) are all supported.
Tested on an SDP31 wired to the I2C bus of a Raspberry Pi 4.

Changes since v3:
- dt-bindings: support the whole SDP3x family (sdp31/sdp32/sdp33) and
  describe the optional interrupt line.
- driver: for a normal measurement read only the pressure and temperature
  words (6 bytes); read the scale factor once at probe.
- driver: add sdp32/sdp33 to the match tables and report the matched part
  name.
- driver: add a file header with the datasheet link and drop comments that
  only restated the code.

v1: https://lore.kernel.org/linux-iio/20260919223650.13396-1-m.abubakar365@yahoo.com/
v2: https://lore.kernel.org/linux-iio/20260920164533.31988-1-m.abubakar365@yahoo.com/
v3: https://lore.kernel.org/linux-iio/20260926154118.5471-1-m.abubakar365@yahoo.com/

Muhammad Abu Bakar (2):
  dt-bindings: iio: pressure: add Sensirion SDP31
  iio: pressure: add Sensirion SDP31 driver

 .../iio/pressure/sensirion,sdp31.yaml         |  48 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |  11 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/sdp31.c                  | 241 ++++++++++++++++++
 5 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
 create mode 100644 drivers/iio/pressure/sdp31.c

-- 
2.43.0

