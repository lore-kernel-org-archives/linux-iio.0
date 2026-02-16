Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A91D63D1;
	Mon, 16 Feb 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254026; cv=none; b=s5USYC9jvUgTlTE5D2r69naqH5T+MvGuFaE4PGXuygU+vNVUe2c1ceeiE+VzeANgx2y1f5mzFo7o9hyaa6yuOi1z0m7ai0kM1aWfFg0818TqK2oOfFPIcqHSlH5qF8qQozIe7MEuq54eXHgdzOlxeuVC9nJWDG5Euc/owJHp8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254026; c=relaxed/simple;
	bh=XJkNSCpbb/+31mi9/5+Vog1rYhMJb+IB2Sn0g2QrlDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McbYVM8qZnQp3IPjZgAGybSPVEOSTcV2c8V1luo0CRz+MZdGWsX9q3A8LmDKnpH/aG5rrLU/cmuKqyZkL/MyV5TDP4TJuY+f9LMiTQKCQ/VU4bu89YLClaNRDJ1PnxUVEImKuvteeUCcQuPSitRnWsJT+dUD8BdLW5x2dZsyQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D8ZCs4MO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D8ZCs4MO"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GDRsSX4079294;
	Mon, 16 Feb 2026 10:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q+Fm6
	x6wWvp8CmGiOQuURI5HRqulzAEj0xEQmWw1HqU=; b=D8ZCs4MOEE62ID3d4IcDP
	KoNobDcTP/ibxQBYpfTw7A/uXvwm747POs2XhY/bD12qaCH+ojUN9JhUTnJx83bN
	G7Os6OfyvtOvOTJ5Tx5YVu8QeXauZLJ101nnQ/knQq07F0QZgpicazTFfUoJKx3f
	cTeRbIDUS9kXM2OqY3JiiEyCiNXrajo47v4+LqlzSgMVe50v2MyGvqERMGxwCoQx
	e3UZ5KOBBkFuCnsO3eLYmjrq+lVQbYabz1dSJiQ2djh1JRpAfT3GfnCqTcpdgFV5
	/5x0fbOPqldfVkyA43GzV+eC9zxD67C/81pd9s+P73+TOHGzaFP4mixS7jtmKUel
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cbn8r3d93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:00:18 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GF0HnI019825
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 10:00:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 10:00:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 10:00:17 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GF03GL016103;
	Mon, 16 Feb 2026 10:00:06 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v9 3/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Mon, 16 Feb 2026 12:00:03 -0300
Message-ID: <135fbdb7357171662cc4da4c6e265455d48e269c.1771253601.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1771253601.git.marcelo.schmitt@analog.com>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: dwiuhiQh1umePXhDdd019s07xpqECTSy
X-Proofpoint-ORIG-GUID: dwiuhiQh1umePXhDdd019s07xpqECTSy
X-Authority-Analysis: v=2.4 cv=aIb9aL9m c=1 sm=1 tr=0 ts=69933102 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=IpJZQVW2AAAA:8 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=DUOLLnRY7vFq0fwDtzIA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOCBTYWx0ZWRfX08VLdN/FwFMR
 Qjj37BbZuCIBRks6SqmY4IMUzWdd+b9Wj3QUlolHcjYY5Sp5MEXPO6KuSVmkXO6z1x0Be2aII7t
 AD8HBF0VVu4fmVlqGoFIPEbnMh6Bzl9Xp1jvLvwrALI1LtCWMe0Y2XEbMTIXmMyBIW+aVX2jr5n
 7IqN5iQkAUoUXXmQeMB/V+v7VdSTHJ2KBPDr+r+4VkS4aMibotVJv4zUMPPyfA3N5QVGAtzgIId
 ITCpyYGP817M3TAfzpWMSnuftLeRfr6lWhSsJ5ctULkTkhqAoexj8BCLU1xNrSpknbL3exHZacY
 dgiz9Pzx9/4s+StzP/SX3hKwi5HmDmoVh0joXsrN9UrGgPXim1K+vqlGqkGyLAc4rSSB66zf8nu
 k8F5kFy5eC8zCkMOjPNlnOLczmHCiK4x2bC+/IjZmbs6McNo/hgaO06L8h8hq2et1yNcXWLCzmf
 uUNa+BwSzvlDXY2zdoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160128

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v9.

 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 29e266865805..a135c66142df 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -72,6 +72,10 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     description:
       The BUSY pin is used to signal that the conversions results are available
-- 
2.39.2

