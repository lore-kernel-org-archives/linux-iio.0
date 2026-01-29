Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0112238C1F;
	Thu, 29 Jan 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708609; cv=none; b=RV0sykIsmcZ8Kcv8OTiPGeakVtQuG/2PZVHyhcgPOsoDVGYVY9A+wx6LAuROQ2QGE0T0fY69LjGVEE9Fu/mzwBQ0GylFSeV5zSge6PWNTTNN4v//MWtESxpvJ9Ua5wfb8ST+DQpqNyHRkfcHkCuSvV/6MySPQ+beifibEFjKUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708609; c=relaxed/simple;
	bh=7qWQqDdX/1AKkasHk8/nndS/mF+kXw7v21eIMeGkBe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tug3eWkqyrZZeNcnbmk5cMQKfJwikEMHoUfpBgr/wUpMJJrXFY6B3VtjamGCb88lz8fdfRG0vrWcTvbvBiRbeB84aEk+8k9n8sFCRELcUOtIh9C5WISlnmtq9y98r/ndz2TguhSAnxn26impIFtc8iEdMeu6pgWUORDOhCOom7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YQB4NSXu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YQB4NSXu"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60THg6uB3783141;
	Thu, 29 Jan 2026 12:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=B6G8V
	Xyeid93eUQrnKAke13aOpeg41TZEHNPw3nR5sg=; b=YQB4NSXuceS0hr7RsKa62
	/1fVmQpZdhBw1aCvTKY5mPmnGRfanoyWWOAXQD2auDeYNAQRbwqy7tywOR3RlHYk
	HHhWAOX1AbYhaX0CHpst46/s794JrRph1n+FstdbXBg+NJmnyFm5wfKJAX0mWb8N
	Pp+fiMJHhvX1prd22+vp1KSul9O/Hb+oOzypZr0zRgLhKtb4Cl3S7U6su3DhAlkr
	W6DHsCeX7XID3HuEM4Z31aYI0DKxH6FSAbVyC25v5RTV0KKw+zsoU943BKgjVob9
	IWe9qj5Ti7/d2FuA+hS+fUS84meqw1WzLqD8lv909JnUCzIHGZMsKoix+iqBJW3J
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c011bjndh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:43:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THhIAF057592
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:43:18 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:43:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:43:18 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THgsL1009203;
	Thu, 29 Jan 2026 12:43:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Eugene Zaikonnikov
	<ez@norphonic.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: light: apds9306: remove unused nlux_per_count
Date: Thu, 29 Jan 2026 19:42:37 +0200
Message-ID: <20260129174253.39574-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129174253.39574-1-antoniu.miclaus@analog.com>
References: <20260129174253.39574-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PvmergM3 c=1 sm=1 tr=0 ts=697b9c37 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=U6HZdc0VSqgv0MtM4OEA:9
X-Proofpoint-GUID: VQUlzSIBkl_-SukRSVlFKNpOREljNqIi
X-Proofpoint-ORIG-GUID: VQUlzSIBkl_-SukRSVlFKNpOREljNqIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyNSBTYWx0ZWRfX4yOGo4984RTn
 txbmjs3VjK/6FArOFTIp4ZX60fsJ7So5icLVgFZ1tYqk645VHFETDmD+twdB/dQfknICF2uEzOQ
 xkx0OVh+SKASkrLHteyLCDhQ7EfXRjMtEGgYE5TgBdiykZ3HR7etf6jSXHcTGJr8i3DFz87OG/A
 hghA7STvrevuEl+iRwKKM4El01qzURe2BTQpx9ocWJ6aoMYOQzazfdQpsL9Gs5scdGfm6pPuA+C
 0FEsJD0PMcstCB94n1n3l4nNHn/jnbrxQWrY77fnARo0kLhS03w2e5+lkMfCa7+fHENExa0Evon
 o0xoI/USqwemZrcD8CGWf8NMBMZDvt9gdYzjgBKuWtbFKib+qz9UcCjJhg6wKQ13w2IRs9C0i90
 wF4iwqhIcK7ue3nUXta194PHkqUhHaagUkFNo/5Y9UwVZApvbGT+f0uGgh+zsLVRG1iFWFK+WvS
 XBSvXj1JsCljrodJgmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290125

Remove unused nlux_per_count field from apds9306_data
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/light/apds9306.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 7e68cca0edfa..ef6429bde193 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -168,7 +168,6 @@ struct apds9306_regfields {
  *         respectively.
  * @regmap: Regmap structure pointer
  * @rf: Regmap register fields structure
- * @nlux_per_count: Nano lux per ADC count for a particular model
  * @read_data_available: Flag set by IRQ handler for ADC data available
  */
 struct apds9306_data {
@@ -180,7 +179,6 @@ struct apds9306_data {
 	struct regmap *regmap;
 	struct apds9306_regfields rf;
 
-	int nlux_per_count;
 	int read_data_available;
 };
 
-- 
2.43.0

