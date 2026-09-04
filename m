Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D1C4A8A17;
	Fri,  4 Sep 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531368; cv=none; b=ZByeUHTYYhS7pCaqQNJy+UZPBUCOPjIpOuGIxDOfX21El4fcQoDR4yESon1JDErlZtdNxQbCdZ+t3T5EGfRBvgb3Z2DkqGit0BXXvI55/GPYS7KxNhmR3M7liL5XIOA2YNCjpyeflPfX+h26WB3bz77LXCnHWzVY+Td3YyphRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531368; c=relaxed/simple;
	bh=FGQG3DmM+7X/giTmbo/iKtzgJp69jhePuib7JGtlpCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lD9mlfX0HmPMml7y7iiiNXKhHJnhiCHZJJtTud1Uwz5N2IXMO/sn8R8iUYt0HQ+8BBlKkJTRcpQ8GWJOByENVqNkWC9jgi+iV6TOyKoEFCtpYUwZ1HsqPEgV5LnWEcy1NBoINsZoj8VWgJ0lr1Pms4rAffnZIQCDsxTPZ8MI1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Lq6j/3Mq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Lq6j/3Mq"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684DgPSx4068661;
	Fri, 4 Sep 2026 10:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rxmPy
	wnjcLCbFsxSJFUDwnHHA1K7/8xkNzN+tJwpQgI=; b=Lq6j/3MqE6lCjX/RaoWo/
	99D77oW/BKEC3Jbu6vHy/owl3BOfaOuiLK17oDli9aT5JrqoNzyI0Q12gdM5x9fD
	4BnuotsajV9evOosBudRIYCfgFyaspR+fIAg9M2MasU6bwQneJJCqIkc4/ILpK55
	zmLlU2+lejWqzyq+xJ9VZbPmRUwEM5BfbA9X1/tB2YqxDVV04zvCTYOfUZfdxWmT
	CnrO1C7W92Z7aOFGYAU1d03KKueZSAtRiFy0u7EtK9UWq28YYKekr3AiyGS9b5V/
	Y+Fro2PoJAviPI29RHzxtm1+HXCHbWCBIKPsl6GFaz1JYaECvSZJokPJFc7yC0J/
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gfxaw0d0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:15:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EFQBT036061
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:15:26 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:15:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:15:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:15:25 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2d5026210;
	Fri, 4 Sep 2026 10:15:18 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:14:53 +0200
Subject: [PATCH v6 01/17] iio: adc: adi-axi-adc: Initialize state mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-1-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=1021;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=FGQG3DmM+7X/giTmbo/iKtzgJp69jhePuib7JGtlpCY=;
 b=2b35DldDF3ydUbcychk6QzezEG3BNsPaYx8h/vNjPptfL3CIIo7jerVcUGOPseFYqWJLM/Iap
 EB+L+qiWzz+BEvyHg1z5zjZKilcbNzmL/RQv1kCRL3pIf9b7qwU8+2P
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=UNnt2ify c=1 sm=1 tr=0 ts=6a9ad27f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=_ljTvifiVFBlT2kRk7cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX4AGs5En9tdyo
 oAciCPhq0YXvb8tNl7jLDlg0NcZm+glt8swAKU+EVeo1jTEciWffebTcAucYyN8llbNfK8nwP9m
 3Nb2x9KfDvwinDzGiurmGouQgDi2vbtXPi1OxCQN0sEPNy1iKQPI
X-Proofpoint-GUID: 5QT3f8zbuzDyqcjld90mTGtO44lsbLy1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX7o4PK1vcPKmY
 SzbPwJBbuMU8DkJ+lcH7wkFzlax0vKEL0vd3AbSALaob3ZSoUXh2ZlsQNVYgBVd+8ZPIwExEx3M
 lPCCfAMycbT0PTPS6XPGgTlsIkjl/UXWjwfaW5xD4JvRKrZREj1bROCmkrXgQidNYMEx9s87CXX
 WMwnbqVaGNgH/5uOfs9kUDQaBAIFaHeYcQ3Kn9IHTZP7RzWbBh15od8oBQjA14cmINyks2jWMsa
 Rh7y3Aea1/byf3wI5gxlBd9D6lGlr5hLCmch7H4X5fBlhLDf9fNYh+GnlXPcKCFnFtdsdPDyGQn
 e1c/EbhoaT728ElmmeMLT0a8QecAUmbcNZbUnguev3ZhhgeDxBcpqZ8cbDgnvXqJ++qG1mbZrUE
 yTDHgR8eCnh//EKimtzEL17sSDYsP84wvaGECJf7+8AEoPkEcpM2GM0uOcppcaZE2eTA7sww/EW
 NApmKO0AEy9pcHegspg==
X-Proofpoint-ORIG-GUID: 5QT3f8zbuzDyqcjld90mTGtO44lsbLy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

The AXI ADC register access paths serialize transactions with st->lock,
but probe does not initialize it. Initialize the mutex before registering
the backend.

Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
This patch is already queued in the IIO fixes-togreg branch as commit
040c2514b25b ("iio: adc: adi-axi-adc: Initialize state mutex").
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 589f03618ecf..fc7cc92b35f0 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -714,6 +714,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.43.0

