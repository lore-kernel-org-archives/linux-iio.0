Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C957348C7C;
	Mon, 12 Oct 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803684; cv=none; b=B4bu0uVH0XXjbNdynNnbNVgEWqyYoZL80g52su13GuFgyeCiq74IOptah2PHJac7Tf7UVeWbujTqe0BjWxTTy+BbVNOVanij59IgG+CAo6bN4J+rR7fMsq22mNABykoka//SrmE+ZzE8j3pg81jMRMt8VAVV1LZKIHiX2pgcMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803684; c=relaxed/simple;
	bh=N+NXNeeF6tmkrSLCHeIcT72zGISyHoKN89pOnrviI5w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TKVmWQrdDn2Fr3qCMuXSvoyyDV8+Qgon6bUoNHEhEPnuk5WiMAzKWOkRIVrLRXdfqBvaZX3QUIKn9M8vq1BhMc7LZXU6UKARmoqwT3pFvCm414gHhSABM+A5QlR9Zw9GH5AzJfbauUhgdfeP3op7nPX13IaHvOon7mOpwGQlRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=dbxffbpd; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bjpqnLUZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="dbxffbpd";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bjpqnLUZ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8NtEs2416616;
	Mon, 12 Oct 2026 07:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Kkr+u9K7tLpsIy2eKM1eokItiFQ
	Smh04iCQ8qn4qUTw=; b=dbxffbpd1XrwMszYsRw7U2+FOiNLbnCNdra48S4xyig
	DjXSYdOkVi0Qg6yzNrlEgYzRcAueI7x2hsUM9qoHbi+KhTCKBT2Ivf+XE890gVdW
	sefIZDVySWPQSfuJtiE9Z9ckXKLfwkjbMd0OXiJXhsZ022ERyFjuedCmxdk87Oea
	mTesA8t6TNi4GQvlun7Mq98BI8EKhchKInTVj5v4IubklrUT7LQUGd5yD1kWPdSL
	FEHMCE6JRvgwTYdDs1C7MVOQQBMCXcLBnR51IYj0I2ZXIZ84nQkU53KHsSFNsJsr
	VsEUiNDcx9tsyWfrLJToE9MwGsXBhxE0Rqneb/Yc3xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Kkr+u9K7tLpsIy2eKM1eokItiFQ
	Smh04iCQ8qn4qUTw=; b=bjpqnLUZNPkTI9KnKCFtxMJOE/HO/D1NbzuxEMsSsOM
	eQBywrEdWt3GiwNH7MhVD+lvojrLLLUin9K8RFxVv9MIeF+kAKhaniAe7bdh+4ja
	3k0twvKBssKw1fSpDcJfFd4zhU0hl3TPhTS+K3eqEqtEj/EpRVe8uYzpZN03Aqbz
	RbmdnhzUDxCespFiwHbqVKnDSW3UDVTAQj18iZyH4ofU0DNtoEdKC5xNohUQnCk4
	YaN8YIYB69SePE9DzMFX6Q8QiSElgrXVkdCv2dkJT6GrDjteEtA8qfiVI57umLiI
	gHJdYxQx9slnXNzDspdEHBfnfWuXfmvJGqS4TKjJOvA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h86peehn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:14:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69CBEPKN046485
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 07:14:25 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 12 Oct 2026 07:14:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 12 Oct 2026 07:14:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 12 Oct 2026 07:14:25 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69CBE1Ww024898;
	Mon, 12 Oct 2026 07:14:04 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Janani Sunil
	<janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Jishnu Prakash
	<jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 0/4] iio: adc: ade9000: add support for ADE9039
Date: Mon, 12 Oct 2026 14:13:36 +0300
Message-ID: <20261012111342.48040-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: WIgixS3IIe7mdDPuc_ZSl7zANdIYJjqK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX5N/SjsrB3YDG
 OYi1g0FE42iDRgkBt/6UBoKkpzukciN4j0KopNTGN9NZTxoV3Kp8I+JhBrD/lwdw5lGXFgm7yKU
 wxaVGVx+kjfmqAwwKiqQ3K73hFMq6W/oosjJxdbEC10cSJ4bigqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXxRbNHOjO8WhN
 qQhC3KQBoZDhPbvZ2SggD9cL+CHyPefupmXygBMREKVWVLx9PPSPLI3X0Nz62jUePTfUV+ZiLrv
 yE/aehmfRXWbeSMcw2v6X5ylTYryJ6wPnRJPcc1A6+KLYwiAEuzbrYPFz16dctEWk11iGN8P0r1
 4CF2AxnJ2obmdgh7kH4FhPIjf6kz1ymp05VIjdLGodfx4yZlI+i7IP4I9SNnCs9JfeqJNGFIo6c
 lmr+aCM7vp9HyJHPaAsDlabSBtNr5UHJv3bUue5lUCh8GyTugkRf2Ug1gMRpWLgbWvzaED1x0xJ
 ohYqj8C+67fnjKBLikZOt9wDskFv6yCE/CEvknmpBhncwj5U+2uWIVT7yTwFixMpc/3sbrHN+Dt
 c7fhvBovwyyDJWDgh/X2Pnc04zX6O5ihl+JqCpBO7e/BMrEun+LEjDtsy819s995YNrdxZvu22n
 RdGPTYN6LbMrr/3XBzw==
X-Authority-Analysis: v=2.4 cv=QfPzLcbv c=1 sm=1 tr=0 ts=6accc112 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=ZeZCvmLWdsUojSwICS0A:9
X-Proofpoint-ORIG-GUID: WIgixS3IIe7mdDPuc_ZSl7zANdIYJjqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120044

Add support for the ADE9039, a polyphase energy monitoring device in the
ADE9000 family. It is register compatible with the ADE9000 for every
register the driver touches. The differences that matter here are:

 - full-scale codes match the ADE9078, not the ADE9000;
 - dip/swell detection and the digital integrator are both present;
 - there is no total reactive power: no AVAR at 0x211, no AVAROS at
   0x010, only the fundamental AFVAR and AFVAROS;
 - maximum SPI clock is 10 MHz, as on the ADE9078.

It is the first part needing dip/swell present together with total
reactive power absent, which the channel-array macro could not express.
Patch 1 adds a second selector argument for the reactive power entry; it
is a no-op for the existing parts, with the preprocessed ade9000_channels
and ade9078_channels tables byte identical before and after.

The missing total reactive power channel is omitted rather than
repointed at AFVAR, which would make in_power[0-2]_reactive_raw mean
total power on the ADE9000 and fundamental power on the ADE9039 with no
IIO modifier to tell them apart. The fundamental reactive energy
channels are unaffected.

Patch 4 also clears three stray characters left in the ade9000.rst
introduction by the ADE9430 merge resolution. Happy to split that out.

Antoniu Miclaus (4):
  iio: adc: ade9000: parameterise the reactive power channel
  dt-bindings: iio: adc: adi,ade9000: add adi,ade9039 compatible
  iio: adc: ade9000: add support for ADE9039
  docs: iio: ade9000: document ADE9039 support

 .../bindings/iio/adc/adi,ade9000.yaml         | 29 ++++++++------
 Documentation/iio/ade9000.rst                 | 24 +++++++-----
 drivers/iio/adc/Kconfig                       |  1 +
 drivers/iio/adc/ade9000.c                     | 39 ++++++++++++++++---
 4 files changed, 66 insertions(+), 27 deletions(-)


base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
-- 
2.43.0

