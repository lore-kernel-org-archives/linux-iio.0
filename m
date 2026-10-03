Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0547668C
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043823; cv=none; b=MBA+3FvCyfZIVhTFfCEMk9qcUNVK4hLFDN+tBlpaTvdUyOYb4sUb2OHrVDdwP7WtT3u25QNKczze3PdzVoNDnLfcVq9QWjd6znuO5DHVPG8dHOVwA2fdHIL0z4CeSJU+lJRkJ6MLAgqqbeNTsc6Iu+LNOqCEuK6RyZAOuXhOg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043823; c=relaxed/simple;
	bh=qEcfC7+lBDdUI/1qR4OTk/G3nCA3uGTQJcqec/VzSIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=sL/x6LenFJXSGYN7B3ckcClzSb9pc0+AjRNa3+ECkZw84WbU36hA6Htd/9UbGhh9Fx4txHhLGweLqNqU/TFjQXhTp7077MoyVlABA6kqdDrdZp8simnoi8DxvLFS0Q8uUighKc45cUBBm3viMGftrY0V5Iio/d9cnbNDbn3udQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PYpbtkz5; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PYpbtkz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791043812; bh=cTlTE08P6zOTrMluqQHEdgkKFtrrhSvx/vcFnuhWH8o=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=PYpbtkz5yIO1/9sWcqgJWd1ePZCmep1gh0FiU2AcMeo+yTCQUzECf5+1AFhsejLhXtiP37ZQ2ycxZmNF0RyO0c8dQioR71EcbA6Ayp5iGT72xzjRN3nxDVahMt85wkcQBglXXzYcfdBi626E7N3qIjYwsp/F6C3Mrv5aS45hqciAGYlqX3jOv4dPaXwDjzU/i6ivzERsODOMszNIvZkWG9nm6iSalb2uHNwtmp2+oJ3kk5DJDf29Sz8TCQ8G9HRxgzT5DWuOKlSW/B4ycfUcc4ID/37EfTONXC2s3YuPbzjMa+uAuKeKrE9pQEXy732ahsEg7wGWNWar+SIqAfS1YA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791043812; bh=JZWiY/FvpMb2VJUCA7A0hXiZtMnm1dIrxKXl0RmVNvk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lyPb1SHYWBEEv/GHQIBTgrTwfg33e5qos3SRAl9KGNVV3cq2rbZMKZKRlFUQq0hp3gyPX5he6SysMOYwyPAOtUVbL0L7cdrwLPUYdKFzMgnW5AxMrI8XtLezpO72wCCNSof3PCyFogmpFdBJCJF7PeOPqu/+YW0ycJTS+gIQj7FI8nvDMVsJVUWVNo0ZWNdliu6w4/xtW8mnkNtlaFF3b3PFQSMyKGKaGXWDHAcbqULvXEwozrqD5i8vT2pb5i0fmUDDh6Lf1L2jG7TjN7595WcdLCXKXKMSGsqLmIcmSwnS9rBlmNuvmlQnT4Ru1uW7FIQfN5kq11UwA5qBUWcUSg==
X-YMail-OSG: jMeK1CsVM1l9dE4ZuLeUvncsx9fgvP2iKdyYCuLgw7w3yt2o7VQFtxBT18XgYHj
 wOOhcv1PGYbYrmVcw_t.BubWI21Z9xfI7N3lwLbI1WF22GA_FMgZ_9oVuDF7SDGeYaT5T6LINTua
 9Q3Q0KbIZrEs0bg5bwHhv5c8Rrgvlt1JrO2K4TEn4w0OSZ2bh2jUOIys01FC.UOcgC7dkmCALQhd
 sGT.7ZFYeE8ZghYoDKoR5k04NfEjHA2ss1HhNzNRFq0Au9VdzuQKaVxKv.mHsLcRhOsXHuz27QOQ
 tqpIsQHAghfuuFc2bSYXj3EWsM.DGgGHABzjYe0MWYHu4UC1aL.eqnTwB_IiO_xPoOPp_gyginbO
 it8_PXweBGPN2G82MkDiYeBQTekcW2zHHLDy12yjY9vR.FbIdj0w3vHKnwNrgf4ee0Z5etk0k3ty
 jATsTK4e._dFlGWT9_eVxa0op2PA76nomDzxChjVac.ypnoI17H7J9hi8lXUZE3r7tVrb3LJW56W
 rEh3FGyBB05pmxd.L8OP.ocbQ.PKw2y22KttlPuhgGXkRAN0wmBCCRGUfJXKMdCXOYKl1vLXJXGY
 R2Jb9YWRNPNxhJ3NYJLXpCZyq.kbEqXPpSZlMHo_ur_ARdHKUKHc7qP8NhNiruCSj07.ZOTjtJkG
 EwlkqSDBLITU37sinu2NQmWPzCcUZkPfVcy_EreUMSGOXLqDccQlbgSLdW1e2lQAT1HHfnCOfniq
 _Ko2QUh_hNUfE3tC4I5_TK6Oab0UFtk0U.dpNfajfQAxDHr0WPdeaq4gasvV0vAF0Swx6qUUvmge
 5M6wqeGR8lonenWWggGwmUPkmTst4i3cc5BNA7kaI3kgXtiTDcAPoD11VWbu0IbF80PBzcR3nSHj
 nF0wiCHbf1q.7.rs8os_TKNw4hlsterj5H3T5NDv3oQkuVJ2enK7W_PQZiG8zCOXaNu5KQiTc6Xw
 d490MI9_IVa2wwoleFE.KSfTG9rVLVXHn.AUt3p2dxzsFgIRZrM554PwUkMfhgNQPKUGahieSEAP
 MBl4cbvP81xkk.GREDPdrpp0yrDj.wOkf6FffEat1zxJYeBYtike0l2SpvGmd0W4ft5lOvO8moss
 9y4mnSdW4a05teM7I6PnLn5JpYJjQMWFdH4dbflmfpi0IDtdoshOgdscG9Wd6GOF5pGUlRJu8wdl
 3lWkpsHyRuOybTLaTe0xATEWyYkKhq.rSL6EeSKJ8Nny8uMq9U2AJaMNc7d7HgkJgESCl_WVwsnc
 F1nhIYumF_Vti0IoelS2qe4.TG8zkdaV_TVnC_XFC72GO4PT7Zh3kkhH7OqbTMMCBm6DoJyOm5I.
 tRNO0lcc0ddQvpHWXndASf20rb3Aqo0BdyQGzXlvwz7MB4UDoL08aytruF7spFWM7K0Ijp9p4Q0f
 24GlPA_0_.Mk4ueuoVCcjJIbRJGFtsLW5N7I64hrY1A2y652a5zliOm_vvcu5EcbSZNZnW5lbJLE
 W_5YXPPbPF5FjiO_jBVIjihsGnIlS6A.csOnkgS0PKmssGFIwt52l.EUwqzz8Y0XjOnBBu0qy8U9
 6o0Ee1Iv75UAWfHLs_9xl5xWg8BpUUqzzOWc3KvygxV2ebEbZ9bSoV_eEHOF1qU3QIVGE0dXmjb2
 4XNlUS0mOm103IX3hD9JvYC1mSh2Ng6lKYacm6YKqa29tjo0iBmx4zmGEt144GBxx6WG_vISKDBa
 e5Y90rr59zMxmuxdB2lMtFwK4NWz7RUnBCsoa5kLwkO78mAo8kdbseQfd0fs6uF7Kv84oNlnN0VW
 50F..S2lyw.pqeANUsM1YN4QSFCV025Oj7zdyMAdR6RSwDIPIrVoOZtkquamraWBA5KAnL.fuQ8o
 LIIgMYIG38EQvBZPOzG3m4.44PCCxNbO8d0vg_JUvbKWZZEx.aYD.I36a73QGHcDMbCmjufnrA1f
 0F61dZABt8hk_kxKhPeEk4gFWDp1TmJbWdZFNfmJ4tnX1ktbTvML2hffem8FeNtAW7x2P1XTT40d
 AfbmRRkGn0e.gYcuPHXASlpEK1o.TkKCvlyUQpJ2PXED7
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 6a1849ee-2cff-49fe-b546-8f7de5c879ce
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Sat, 3 Oct 2026 16:10:12 +0000
Received: from dip88.lsn.bf1.yahoo.com ([67.195.177.97])
          by hello (SMTP) with SMTP ID d1c6d9a7cda80a7ad7051028df1df544;
          Sat, 03 Oct 2026 16:10:06 +0000 (UTC)
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
Subject: [PATCH v5 0/2] iio: pressure: add Sensirion SDP31 driver
Date: Sat,  3 Oct 2026 21:09:47 +0500
Message-ID: <20261003160949.4657-1-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261003160949.4657-1-m.abubakar365.ref@yahoo.com>

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

Changes since v4:
- dt-bindings: use sensirion,sdp31 as the fallback compatible for the
  SDP32 and SDP33 instead of listing them as independent compatibles.
- driver: match only sensirion,sdp31 and report the device as sdp31.
- driver: include headers for everything used directly, drop redundant
  casts and use KILO.
- Add the Assisted-by tags, which were missing from earlier versions.

v1: https://lore.kernel.org/linux-iio/20260919223650.13396-1-m.abubakar365@yahoo.com/
v2: https://lore.kernel.org/linux-iio/20260920164533.31988-1-m.abubakar365@yahoo.com/
v3: https://lore.kernel.org/linux-iio/20260926154118.5471-1-m.abubakar365@yahoo.com/
v4: https://lore.kernel.org/linux-iio/20260928215422.3720-1-m.abubakar365@yahoo.com/

Muhammad Abu Bakar (2):
  dt-bindings: iio: pressure: add Sensirion SDP31
  iio: pressure: add Sensirion SDP31 driver

 .../iio/pressure/sensirion,sdp31.yaml         |  51 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |  11 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/sdp31.c                  | 244 ++++++++++++++++++
 5 files changed, 313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
 create mode 100644 drivers/iio/pressure/sdp31.c

-- 
2.43.0

