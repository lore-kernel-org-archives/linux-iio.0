Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697E3A8759;
	Wed,  4 Mar 2026 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627131; cv=none; b=mVP1droXgNvtOiyAMAJRLWRL95hHRN7H2ohDCMpfPLYvDBgFSqKPF14Hu01Pjp/OmYlI3yPW/ypGAoqYKiDgUqgEn0y1j91s3FkzFXkPKaAxDGOpvFY4xYMPYRaxZEhtGKRLIKBsYokb07vvEC/Jq+H+bSt5uIrdqN1vfI5V5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627131; c=relaxed/simple;
	bh=G8igBIVTchBZ041owGbUTDtGTE7yN+xHJ8lRlDj5+uk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lz3/8sP2a0GZPtgZhbFKi+WKBAeuWV25LQWDSD/mRjvGUfRDnuRC8rqQAutuoxrohfDjC0+ChasiwoPC8HgdVJYyfcjOMHkWQUdZQnqPBMldjPKcGQzEhniLLgLRDqTSY8bFqCYf/IvVtWmiq38xzLmQvQS72j1HTDRPhe2h4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=le5KxntP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="le5KxntP"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624Am8bZ1132828;
	Wed, 4 Mar 2026 07:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=N4FSoebN4MBpmuGehumnGAiDWkq
	GNKueyO9YFhw1xng=; b=le5KxntPAXN+AZnrgFpEniV1jSBxXOOd/S1aLih9LRu
	MPRnYdaJYxSi28tsqr6PEIcABYuSeqqhmaV62Tz08+SpxWiQGoyCZhR0483MdYlk
	fQLDFy0s+8kkiUSj6P2nIe/P+mfJAbnOrO941ruX0CPNTk2cF2LV/9exKXfxqKcY
	BgDlQBx9sjQNGRn+4hClXjukzEzIVOT1TWBs+dfr7gKaQNJ+SJ7sJWc076ADkLyP
	jjNnojl+JDvUTs2hC88lGizs43R+tFfg8Dd6V0ywyyEDfF+/oQx2Tpz1VpSfg0ka
	dt2gUbJ0sWOMecKm0WAxxk+6yyAb73dud5CHG7w8q4g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cnwnnnh38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 07:25:25 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 624CPO2n032243
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Mar 2026 07:25:24 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Mar 2026 07:25:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Mar 2026 07:25:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Mar 2026 07:25:24 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.32.144])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 624CPCsB006193;
	Wed, 4 Mar 2026 07:25:15 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add support for Analog Devices MAX30210
Date: Wed, 4 Mar 2026 20:25:07 +0800
Message-ID: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LDpBgNaQ6J6HLg1s11LzXBErLjYFA6M3
X-Authority-Analysis: v=2.4 cv=dY6NHHXe c=1 sm=1 tr=0 ts=69a824b5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=pFtei8h7-M_u3W7gWLYA:9
X-Proofpoint-GUID: LDpBgNaQ6J6HLg1s11LzXBErLjYFA6M3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA5OCBTYWx0ZWRfX14NBiqUS3K2C
 8wAiaEsicyvypijBoM84aBOywqx07Win61m4ZXMl3rigDsH4T+9XF4oAhsin2m8k28Psw8RAUKF
 AtsSj8WZfP/TApjRHF/OMV2hJgIX6UeEtE82iVPFDmdIVJlTpisg+zVJ/YpNFY7+/ilzeyfOWY8
 mvjw3Js3Ud06/ozNMtbpjSLoILqK6Rzz5Itu6j0strqRw6+LbN5Fm0vqtVRps6kfHp9q+xjtsnV
 s2SJxndqy4nyu6g0KyE130VyrlN+9pS1gkF6qLUdYBZ0mNhLAqcH84i2gI17+7iEP1Y4O1fQ9+j
 ObaejBxWQAUQv9gez4F+QFyvfKG/Jl3Y/3U+l49aBLbokmYSKgHhVqETbCmO7IrhEFdEo2BL7Fm
 HT6nJc38+XfLS11pyjNLbLuvw0lXak6tH448OND59gdAnotAYW0sdUTOVsAyT2Jg8+nyQZNq9Bq
 3q6iPTJeM2SmfmGaRJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040098

This series adds support for the Analog Devices MAX30210 I2C
temperature sensor.

The device provides a 16-bit temperature output and includes
features such as a hardware FIFO, programmable sampling rate,
threshold alarms, and interrupt support. These capabilities map
naturally to the IIO subsystem, particularly the buffered interface
and event framework.

Patch 1 adds the devicetree binding.
Patch 2 adds the IIO driver implementation.

Changes in v2:
- Improve commit message to better describe device features and driver
  support.
- Simplify devicetree binding description and clean up property
  descriptions.
- Add MAINTAINERS entry for MAX30210 driver.
- Rename register field macros to include register prefix for clarity.
- Remove incorrect IIO_DMA_MINALIGN usage and switch to proper __be16
  handling.
- Replace manual FIFO byte assembly with get_unaligned_be24().
- Use dev_err_ratelimited() for invalid FIFO data messages.
- Simplify event read/write handlers by reducing nested conditionals.
- Fix write_event_config prototype to use bool state.
- Replace MAX30210_INT_EN macro with regmap_assign_bits().
- Replace deprecated iio_device_claim_direct_mode() usage with
  IIO_DEV_ACQUIRE_DIRECT_MODE().
- Implement conversion completion polling using regmap_read_poll_timeout()
  instead of fixed delay.
- Rework sampling frequency handling using lookup table instead of
  bit math.
- Remove trigger infrastructure and switch to IRQ-driven FIFO handling.
- Replace triggered buffer with kfifo buffer implementation.
- Use regmap_set_bits() and regmap_clear_bits() helpers where appropriate.
- Improve FIFO buffer handling and push 16-bit temperature samples.
- Simplify buffer enable/disable paths.
- Remove unnecessary fields and clean up state structure.
- Add optional hardware reset via powerdown GPIO with software reset
  fallback.
- Adjust scan type to match 16-bit temperature samples.
- Miscellaneous code cleanups and style fixes.

John Erasmus Mari Geronimo (2):
  dt-bindings: iio: temperature: add ADI MAX30210
  iio: temperature: add support for Analog Devices MAX30210

 .../iio/temperature/adi,max30210.yaml         |  62 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/max30210.c            | 664 ++++++++++++++++++
 5 files changed, 745 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
 create mode 100644 drivers/iio/temperature/max30210.c


base-commit: 70a9ae59c5b1f2f5501e78e2d85bfeefd153f854
-- 
2.34.1

