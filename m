Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816448;
	b=s/V6nsAlY8mJkC3ww+vUXzfCsedtDPLOD/+pLYz+avUXv9Kffww4YOuDEc6Jy3khfXzm
	 4AMFB+obAcLN+GIoJ6ILvYLd+78pFZ40RfDgUvPcTqDI5cy8ChbUxrZhuNgFVUh0Y/bAD
	 cNCRaaY2bq1rse/RrI6jS75f5nUXdv5m0eRB4eix0L4vKc7EnXj+C5lh8iMpeRP5YzEKC
	 6oY+sl53XTEUpYbjvbgcSFM3MLfIjHiLikxv+pA5+/TAftlaBH5AzIJ9eGacpZgWo6bBo
	 HLRMdZCtDfo1uzYq/yXMluBqdS4PMpIZ3k8hjbRnlqmfDZxBPLcDGfwyS5vbabbpGFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816448;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=w2Vh5evGoxKnGltIYFFmyH+wwz3QvzAphxnOBMowFZI=;
	b=L2YRsMcw3VTH21ME31SYBHtBayUMgHgCgMMLH+AygcISrg38sLz4eRf+bvDIImrUehvp
	 BXaQ83X6Nl9br0LAXHAVUodHytloi+XRs61tntgQFR22OfIdUOz6y5bVT/akGLUmzxu42
	 kVsP/okAXgW/GkjLrMg94KyjdyJZV0xObRCtrnLEqY24i1LtnobFy1qmuqJNdEBUI2mOb
	 yT29dnCNS1fVT76PX/fsXNH5X4JG/orZD6twPybta2QVNDUZNiljtUqZ349+OUr/I2zsf
	 yWMCbmvXOGmzbnJUjAUc8+5/3BpikIom5Ta+m1sI9rnfl6pWXjEjFdrfQU7wFJHEzlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="dvWmU8/7";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=t1WyzJdp;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712B606A31E;
	Fri, 27 Nov 2026 21:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C712B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dvWmU8/7;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=t1WyzJdp
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJBtCv144025;
	Fri, 27 Nov 2026 16:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=w2Vh5evGoxKnGltIYFFmyH+wwz3QvzAphxnOBMowFZI=; b=dvWmU8/
	7Owq42oK3uQHStkLrKw6KGlsxH6Pe048wGnGw1KgHeENp6jWBivabNYGD+aCqZdk
	3XrpJO5dzg0rhw8O5LsF1+qlgnP7BI7ETp7ybATf7pksKHw6Hl+9IazOac5Z98fs
	JXKfIKQATl/WvdL7B5YfOyK9pcYOZwH/e0d6pk8r5WpoSKST3ST6/7KNtllowzN+
	9HnMRsIHjx/A4I1WnvSHXoZFgfOgzcJ2dzoiQ65SZ7599KhbqKiz8M2Rq8m4K085
	yvfZjt4vE4Iuit7x37t06hbYiabfYXA3rdmUsR8QxHlgN61OL3xg9o/StqOMJ+Aw
	wi7Wr2R9uYMRg8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w2Vh5
	evGoxKnGltIYFFmyH+wwz3QvzAphxnOBMowFZI=; b=t1WyzJdpb9kAb5UscYeB3
	b8KUbHnGwnIW8FpGpV2OdVQPoQ6F/tqFMCv7WUf6Spxz5/idQvkmpp4CBxk0wSGe
	F1rTs4yUkW+IuaR2xg5ufVPT3PlcGsmewIYtExci8xviJ6u7z7hNiWAZBdshyeJk
	MWJXZ4DKT3K3IlF9Y74V7uGWBz6ODc4p/CTwwkd+/TI9KYfp5sHIn6lP/i+1S8OL
	NZM6DowgWXedPmRrdq6Xx787IIN/b1bs35i8r/79U0gpzEFFG3Nx1k5eDeWbr0h6
	laJECNmj7f7rklPqUh0WWCy7S90JJMAgBIE/5QJbP3M7ZkuCCVQTzt6dCQ41ViHw
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j6a88j48k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 16:53:49 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6ARLrmNl014124
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Nov 2026 16:53:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 16:52:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 27 Nov 2026 16:52:42 -0500
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6ARLqPRw018633;
	Fri, 27 Nov 2026 16:52:28 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v2 2/5] dt-bindings: iio: adc: Add AXI ADA4355 IP CORE
Date: Fri, 27 Nov 2026 18:52:17 -0300
Message-ID: <aad249cd23d3ee7ae117756ee9564dc56ea81333.1795816065.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795816065.git.marcelo.schmitt@analog.com>
References: <cover.1795816065.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX1F6uG9kafZa+
 iLaNSJAWRnV1+6cOCfuNoNsrkRohqt/h+8G0nehTF6q4kfRBlgbebzmWPYQhKrcqRzVTqjeUe/W
 C+GeLKhUoTtga4iFwEsEf74BQAgIj7fPi6AvGscry5gC77fsfyArtg8ce62Oq35aAIwkIAOcTkg
 bnidzzVWBYXpM+y/yOXZT3RZLGtNtJY/i/AdOA8kMsIUJgD/3QHSaaGtMUU2DyBZ4Q40azHG49T
 CZw2wfEYzTNmoSrWsy+6+TAiTSzdDJ1TY3Hk74iznQXqa+htykoBCIpFO0+xleip2c4l/VGROKx
 toKQjmQgH2Ifqx/agCxNuBSF9/D4zIhq2DJeHBZ9kUq6W+udwB+tF6BkgaMf4/Fna7uTumy1fjA
 oUykVPEEaqYWSyVe1WHwvwUgn8GMD001AvnjXrBGwOzI9GVhhFdziMVf4BQjjIpuJ2h5TxrxcDO
 Lw/BhGeAa5TUQgOtAxw==
X-Authority-Analysis: v=2.4 cv=Dp/Da2/+ c=1 sm=1 tr=0 ts=6b09fbed cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=wI1k2SEZAAAA:8 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=kTU3qjJN8_a8PPivjDYA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=6HWbV-4b7c7AdzY24d_u:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: dJXIsVXaPUwr4vK9ezLCWj_pIcpKR4QG
X-Proofpoint-GUID: dJXIsVXaPUwr4vK9ezLCWj_pIcpKR4QG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX03CAakbbTvdw
 fK80Vy3UKxlqRQzFgSRNsICB4xLs0lV6fqZ6dBpYPulzMQJdjROpLOuGxjip52sengsrGTPgUs1
 v0zU7jmh1Dqgd/qULq+RKYknKTyB/cCEhwjz5jKzcgX+IGjzfzIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270087

The AXI ADA4355 IP core provides the HDL interface to the ADA4355 and
similar designs. It differs from the generic AXI ADC core by including an
extra register to report data synchronization errors.

Document a compatible string for the AXI ADA4355 IP core.

Link: https://analogdevicesinc.github.io/hdl/library/axi_ada4355/index.html
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e91e421a3d6b..fe0f526b0ee2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -38,6 +38,7 @@ properties:
       - adi,axi-ad408x
       - adi,axi-ad7606x
       - adi,axi-ad485x
+      - adi,axi-ada4355
 
   reg:
     maxItems: 1
-- 
2.53.0

