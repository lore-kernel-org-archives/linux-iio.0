Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE63B95E4;
	Mon, 13 Jul 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932098; cv=none; b=E5vZMmt0cpuf9Hse/KSv7JwrWkj6H2q936KLpUlPPiedsLx+1WJUomzRYdFW1bMAKyTVBTkUWhQ1LHV7bBsYTmZV3agqToPTAPSTdaX4+p3bgbiPJsL+xXA/PWqgxnKtsIGpz5oNoEWzd+kA/Ak7eYE6D5f/FAjPgAkmFLm1sNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932098; c=relaxed/simple;
	bh=NlNXMybj897usjZOjrpf/osq+l1Zhcty/Bh12KChu1E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bBEda20MDoMNUtchKRNCyxhd5b3J7vGo0ePFlmCTrL5hugJxtkiebKy/zTzUI4l2mi/6PP9lZy9+ymBrnDxTj6MiuZR7v+79SN11IXXKnU0M8wLxpSGVsDkxV0KdorjG7EASFUwiXd0qaau5yi1E/gfV8JfWsAOl/Dv6qKQpOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Kw1a6UgQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Kw1a6UgQ"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Rp4F2787756;
	Mon, 13 Jul 2026 04:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=S8T/mb1k9Eess/dndXW0+XoVO9p
	1//Kk1lWiq7QAS9s=; b=Kw1a6UgQv4z4xBYO2kjBvUVqaYQh2SjS5lsoyGzoBVO
	IExia3hxPjLMvjoEKGsx6YwRkuyWnCML2GgvxoWotvTSyHtKXrC8JUlZp53gwRdx
	0/qWUx7KdrQ9rpOsmYFWUFBfWKOITMKKmzWFI+A09e7Kxf4RhwB+VN397qk8jNeT
	o9bQ3SySPvZp+D5la/Yxqi44g4AeJ+hD4H51d8gypMEXADCEXSJNSUqKHAuwW4RX
	MYb+NHAhujThkwIb5/hjm6kTji1ThWMLjNEtBfLU3QbKtWw2MQIYmRtzuNk4r/7I
	GEpxKc6+Mynb6rdY8GbHYqSTni7JIG80e3tS/rRZ+5w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fbjr15gqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:41:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66D8fUwA047358
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 04:41:30 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 04:41:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 04:41:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 04:41:30 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66D8fIA9015758;
	Mon, 13 Jul 2026 04:41:20 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] iio: adc: ad4080: add backend data size configuration
Date: Mon, 13 Jul 2026 11:40:41 +0300
Message-ID: <20260713084043.10856-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5MCBTYWx0ZWRfX+CCcYWHqok2p
 3RDVczwievqKZJ968ss6SGD2/VXL+PIbVFmUyqqkYl570WHVcE4sFVtrfozLc0EsbF+xHJEf+mL
 H+xVO/q5PAQrfn82gx96JiHCIGUoIs8PAu3wEyfxRyvuzAbhB7vh
X-Authority-Analysis: v=2.4 cv=Ovp/DS/t c=1 sm=1 tr=0 ts=6a54a4bb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=wI1k2SEZAAAA:8 a=Mtvq1wGsQdfWT3MW8gAA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5MCBTYWx0ZWRfXxvPC7z4FUmCa
 gtC7VIQ2tplqmr+eHtvgC2dUGcDLGSolXtMlAIcNihbDcGtlWhkUBPWgdX1bUKtwfw7DKArS5dj
 +OevAF1yMc12Xxgs26gWFBIbqZ5HC9QVZ2O6vQ0L6Cp9ZxssIqwE91/bKLr/scJMk+qQZ46+Vvm
 hCJlPLB32giSYqxAVWyAEIfvifcv5W1TpmnxMOvhqvTuuZYfNFFUKAPpU8ryUt/va/tPEqKeQWi
 yt7SAO2ywMZ/wekF8nTupPStSEHOM3yJaDnrJ6HC3qQuikZiHyhhuG/yAJ5hlCet0+NXlVQxb2y
 H19uEQ/NQklwm570EdSRFb8+MHEWdbg6Ghi/rY6hWCMkalmer7lGZprsI8Cng99/oo6sOkbcXTA
 xdkN//fitQe3zZ4Km4Bun/ZyGQs4526TyRrAiviwcfvHXNGYtgAWSEIt7eDvW8H+WTe8FrMpn6+
 YWL7oV2jWBbId+j0RPA==
X-Proofpoint-ORIG-GUID: K84qH0Cd8mFu_uVyUzBP9uhxzAfT2mKO
X-Proofpoint-GUID: K84qH0Cd8mFu_uVyUzBP9uhxzAfT2mKO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130090

The AD408X AXI core can pack sample data on the bus using different word
widths (20-bit, 16-bit and 14-bit), selected through the packet format
field of the CNTRL_3 register. Until now this was left at its default,
which only matched the AD4080 20-bit resolution.

This series exposes the packet format through a new data_size_set backend
operation and has the ad4080 driver program it during channel setup based
on the channel resolution, so the bus packing always matches the device
realbits.

Patch 1 adds the data_size_set operation to the adi-axi-adc backend.
Patch 2 calls iio_backend_data_size_set() from the ad4080 channel setup.

Link: https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html

Changes since v1:
 - Patch 2: expand the commit message to describe which parts were
   affected by the wrong packet format, and added a Fixes tag.

Antoniu Miclaus (2):
  iio: adc: adi-axi-adc: add data size support for AD408X backend
  iio: adc: ad4080: configure backend data size

 drivers/iio/adc/ad4080.c      |  5 +++++
 drivers/iio/adc/adi-axi-adc.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.43.0

