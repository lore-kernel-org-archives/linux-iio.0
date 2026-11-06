Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950810;
	b=qkzg4mUHfuWmV2G1jrXFEp5QN/HZ9CjQagXo+OmXLvnRnK+7YWembGcrQC8a9Fivdu88
	 ntakx9fdlq5OgzzluOGizIIbPeLC555QDo83sQkmxD0J3q8g/V154MDe0HvWN2uFTqFUz
	 ulptpSknokJ9zi2iX1lJ7xMCwWf4YdYiY1BHfdZiwmbBBKX/wH2MunBv8AglK89sp6A0C
	 /Kj8v8AZrG2HscBXVj8+HoOqfI6/xBNLyI38wOTYi6L1KsNrY1gcaKPjKSRihsOUEbxPf
	 ti+HSZZksnMtCTNS7uLDo/upuJGcORTsvvSAde1Kqld46Sy2NzC9hx+bBmqTF5nATiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950810;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9zKZss/Z2aszpq/pWEN2DKKlaIlBC4vciUdzc98+3to=;
	b=04sKX9/b0Rh/cgI+Ln9CFt7JvITiBHsSK0k/8NEavMNoVLaObY1hQeFqvnNZWx7Rjj/J
	 CrBEfd0LnZLfZ6uO/06X48vUb+VqVVX/hFfUei5OcD24LPHB8wDhRt7B+T+qbWzftg8y/
	 EknH2QDYihtg68sjFOaBtHUV427k7OLki7hRMrdqaAHp63gnGWsgfm1jh3cF9HQtQ/vm7
	 iOLsc81yM5URjTetnvU2w1QzW0f0VUKPsYxF+1/snvoUYk8l/+szBE+SEg5/lCltWzss6
	 JRt5Eha1c3JY0jJgH9DkdBXBsix93EU1qUrz9KclnB97ASB+9fEgB49R09zbmKeXiqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UuJd2jCn;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k6aVm6hk;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767B606A328;
	Fri,  6 Nov 2026 07:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C767B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UuJd2jCn;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k6aVm6hk
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67R1N03163839;
	Fri, 6 Nov 2026 02:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=9zKZss/Z2aszpq/p
	WEN2DKKlaIlBC4vciUdzc98+3to=; b=UuJd2jCnvJ/XxyAsrXY72D2ASyRwEpbX
	Hfw4+Ntyk8W+ZJBxu2PMia/bqWkC+LVHuwHzi9JGlpc3lIZtxB43l8t+BLhxmFFs
	R15ZKVQQnOMmcbMCFdlwSw8KCjYZcNfbqf06V8C+jpyU9Ii61TVnNnGPtZMKP/qQ
	S1yLarADdd4Khm099o5lugAKLTyvJNaMC/8uyVXbbXbeovPDIkdySf7dZAQ5hIs9
	ziUkbNkR01ES6IyuXLWgwOzu+Fg4NTG9j9LFkbWMx4oLjWVlTh5GKZTJMrbBwc6e
	8NmHB4etyy3ow8e9Z/LvsSjMYjzQYWhjfTuinYvHeYDE0oMS7KtTsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=9zKZss/Z2aszpq/pWEN2DKKlaIl
	BC4vciUdzc98+3to=; b=k6aVm6hk4My5HV69/qI3TZ64+ZYt1hg1OH4KaiGmgFM
	hrGOKF4Qsvq6wQ9FWJuPOdC4vwdH2JhryvjK6fYTdO+o1f+2AXkTDONTz7gQGXyy
	9ijn3osdqfI3mwvOlCaFg67+amYg5l+UBE4Ub1kD4Xvks/hZ7ckXXe4WzWRze/mC
	KMYZn0F2OcWg6wXt9lUGEbGViUH/hg2DhPhIRIcWA5PbvDUBplPPcXyqNlnPVT4X
	y1KjjtVr/WDL2XU2837UhT9Hz9jTpvwuutmbhEfNr3XbbJI4LD4iIAvGIEEIT0Ft
	C7LPq6kptsgAOOPBtE5gcMYol8QlW1F3gTjj5Lt0Eww==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pytfpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 02:39:59 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A67dw1Q010319
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 02:39:58 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 02:39:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 02:39:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 02:39:57 -0500
Received: from HYB-0FPP35J6CsI ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A67dkI4028684;
	Fri, 6 Nov 2026 02:39:48 -0500
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: <jic23@kernel.org>
CC: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Dragos
 Bogdan" <dragos.bogdan@analog.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
Date: Fri, 6 Nov 2026 09:39:35 +0200
Message-ID: <20261106073937.13927-1-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMCBTYWx0ZWRfX80L/p0XS9U/Y
 5+ICUU6hlkwUnLicR4yQ3y3v2MHLudqdbDDl429zDRonyFnxA4OLSnEuFhsgfEUvrMnLU2GXzG7
 FDmJSjIBVe9DMx3tY/Kd9pEF26A+pmpu0ybxlDFDAdkvSyImoYZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMCBTYWx0ZWRfX1ZWXIJKp2fM0
 upBocGzs3ZhvFTeo9Y/OodcBu2cW34k0xVsPOkYpMVLt1F0UG/z+LPa/KRYNaNMcvhVULUwRRIG
 iBoycyrVxRzxuzTSc6mjVdr3v3ST2uNGtaCusgacXo3l6qYHYAH1gsUoMKYeA2OkMEAbZ3MxEaX
 0pXWpHi6NEeH4Dk1wxHBw2xNjUXs+w8Bp0wVNkuTtUxuMSlPuaaOCjNp1jAolFmSzKbCvIUhVVK
 A/tYaO/9itfsTwHSlcGwa7fdt0igw4me3kM3Upeu8Y4rrutXj5pFpQJ/sOnI/MH24NNH656CWho
 +8B0g3uokoBBgk6f9XNymXLDVDOwsjoVv56WUZi7P5n9JqKC9Gc6Hhzp4hbxalapK6lEAxsnVXG
 lZs8pPQd5ucduFa9tBuI0vRFezrZtFYLAEqguNYjhMa5apfodQ90yeeHJr7Csx3kX4LT8qy6v0X
 V/CsZ94WNT/b3TnRGnw==
X-Proofpoint-ORIG-GUID: dJlV-IJ91d6o055izD0Zb2pdP1J6L5iL
X-Authority-Analysis: v=2.4 cv=TYcDJhQh c=1 sm=1 tr=0 ts=6aed844f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=KHIhECFyK12KdMBMZhQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dJlV-IJ91d6o055izD0Zb2pdP1J6L5iL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060030

This series adds support for the ADuM7801, ADuM7802, ADuM7811 and
ADuM7812 isolated second-order sigma-delta modulators to the ad7405
driver.

The parts are compatible with the existing ADuM7701/7702 handling and
differ in input full scale and maximum master clock frequency:
  - ADuM7801/7811: +/-320 mV full scale
  - ADuM7802/7812: +/-64 mV full scale
  - ADuM7801/7802: master clock up to 25 MHz
  - ADuM7811/7812: master clock up to 50 MHz

Pop Ioan Daniel (2):
  dt-bindings: iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
  iio: adc: ad7405: Add support for ADuM7801/7802/7811/7812

 .../bindings/iio/adc/adi,ad7405.yaml          | 25 +++++++++++++----
 drivers/iio/adc/Kconfig                       | 14 ++++++++--
 drivers/iio/adc/ad7405.c                      | 28 +++++++++++++++++--
 3 files changed, 57 insertions(+), 10 deletions(-)


base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
-- 
2.34.1

