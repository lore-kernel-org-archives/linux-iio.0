Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D9381E86;
	Thu, 13 Aug 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662359; cv=none; b=TRQRQtfagQ7UxYe5k3zrsHz6F7VltYMpD9MxlOMRaKPZSuKcIhdv8Fq7BpWOzMbb7bPfi4uJdi5otJvU/TwpqNz4uXkmAqNe0voB2YSNwt/rHdiXTDTdAJO2hTafjssCLPyfO6q0XvFSxLfoJ1STbHTYd0UiHyy5Q0AUKhLqngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662359; c=relaxed/simple;
	bh=nY8O5jLNPGfBqVG7HIpEpgXawFpr+h50xD0hLfDPHjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQDsQUQljBs3XOEMCOGcPCDW5xrQJmzkG/4TUqvZ7VcDAGvN7oZFvGCKZlYH97jrniSE2+vyvFIOpTGraO3wyNXdmGQwKvR5b4zLN3hLTcOfWYGoDCmS8hxw5Ajm8bFuIM+5IZJRpheqV6CXjWa5xZMcxbBlYK/VGPa2kJdqfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YwCfzZDZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YwCfzZDZ"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DLcstH2531076;
	Thu, 13 Aug 2026 19:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LQUBe
	VhUndoBSZ/P/y6fyzpfFbJsjdAFSGB4et85kRQ=; b=YwCfzZDZ6Cd6FfURft4Ma
	SUnxbopH4Vbzyi5yC++d0C21g+JBRlIk7RbJH01fZnP9SRLzRjSLf5IQmmARwDT7
	5jBjM5ILIsogNB0ZaG9w/4RfCsQYN2Gd3RW6XNLi7QhexR9SLTi6OxBqw/JMwYC+
	y679FIQN8wZOzz/WKAoHEsHG91pGqImiCSJaNYlCEA5Wc+2Zrl51uNO1Osc+HpRE
	fvdMDEYdcOxgGybTZWQy13U+apaX0A63IOsx4AmJM3BvVZPdG1xXlRHmNwZ++Hhz
	XOhSLMuHFC4520Nq8eJexMZLvQd232k9u3STpk8x7K8Y3I7TzUu4n0JLMC8mUm/h
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e1namty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 19:05:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DN5qUv031593
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 19:05:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 19:05:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 19:05:52 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DN5dru025427;
	Thu, 13 Aug 2026 19:05:42 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v10 2/2] iio: ABI: Encourage differential voltage ABI usage
Date: Thu, 13 Aug 2026 20:05:33 -0300
Message-ID: <5760e0d12184eb0d7cf6fec34ad4b6da2d8669e0.1786662010.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1786662010.git.marcelo.schmitt@analog.com>
References: <cover.1786662010.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE2OSBTYWx0ZWRfX/D1in6ZB/SXS
 I9EWYZgvoB/skVFAWIrjRSzF9LH+Scf3yGhMAMqFBPkdRnOcprgTn+kDvKer1DbO6FREYryC/he
 huqDwgfDXdw/Qf+FxFEnY+lt8BTJe5Vmf+03n8qLXZPp+oIfl6OGaXyaCYttyVY8zvfxB14zeTe
 i/nKz8izGQ+1tGaeZRLJi19GyR0oyGuXnwsdrPrEks/Gx0U04ZG3D2W0muSYb4f7avaM/EGLda1
 Ny+vRH6hhKPw3NEKainGS1rULSWA8ITa7p8+HCOmSPCR4cOKEqiUQ9YSEWR4zB7Qj0yIQpf+yjZ
 zpJL8AdDuRqUgk9qx48/u847b8vasAuDgNbmF1iSxiaIHHRkagp/tRz6oLucxWqqjBOKSqFeKKf
 ugMP+cavGs+4I+ZbeH2UguI5FboIlVRZQC9yauMc3zL8359GE/xdZIAYQ8XTZa8owzwH9wIv0sS
 jIzphe0pVE0zKJmBY6w==
X-Proofpoint-ORIG-GUID: AUSlCXL3cO7BFWgzfVCrYN7Co3yc88aJ
X-Proofpoint-GUID: AUSlCXL3cO7BFWgzfVCrYN7Co3yc88aJ
X-Authority-Analysis: v=2.4 cv=fLoJG5ae c=1 sm=1 tr=0 ts=6a7e4dd1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=34BOIcpausZy1eRHIPAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE2OSBTYWx0ZWRfXwaLAYJHyasai
 m2sZBtqBCLbnwR80sBiK6w9pgR9OJ5toPLbonZPiM+i7JuTTJJLWOHaTTzU0m8YQ0qmrdHMdjls
 kCnCFh7QPG618PcupSLRdnGMBOWoDbOBntkd9hGk3wJoIsGt15HK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130169

So far, parts that could only do differential voltage measurements were
only required to have a consistent labeling of their channels by complying
either to voltageY or to voltageY-voltageZ ABI. Over time, code maintainers
came to the conclusion that the voltageY-voltageZ ABI is better suited for
differential-only chips as it provides a simple indication to users that
the channels measure the difference of two inputs.

Adjust the ABI documentation to recommend using the voltageY-voltageZ ABI
for chips that do only differential voltage measurements.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v9 -> v10:
- Mention the possibility of having same index for diff channels (e.g. voltageX-voltageX)
  in ABI doc.

After looking at a few other chips I'm not sure either about having
voltageX-voltageX in the docs. I worry voltageX-voltageX might not provide a
clear unambiguous indication of channel properties. Nevertheless, mentioned that
possibility as a special case.

For chips that have configurable inputs such that both differential and
non-differential readings are separately available (current ABI usage),
voltageX-voltageX can mean both ADC ends connected to the same physical input
pins (e.g. AIN3 and AIN3, CH3 and CH3, V3 and V3 ...).  That seems to not make
much sense for most parts. Though, there are corner cases where the same input
number is used to configure both ADC ends (e.g. to access a temperature sensor
through an embedded multiplexer).

For chips that can only do differential measurements, voltageX-voltageX would
mean the positive and negative inputs of a differential channel to have the same
index (e.g. IN3+ and IN3-, AI3P and AI3N, AIN3+ and AIN3-, etc). The ABI is the
same, but the meaning would be different. Even though we have the left-most
index for the positive end and right-most for the negative end, that's not
enough to fully tell how a channel works.


 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5cc2e82c4997..bb17105650ab 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -162,10 +162,12 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) differential voltage measurement equivalent to
 		channel Y - channel Z where these channel numbers apply to the
-		physically equivalent inputs when non differential readings are
-		separately available. In differential only parts, then all that
-		is required is a consistent labeling.  Units after application
-		of scale and offset are millivolts.
+		physically equivalent inputs when non-differential readings are
+		separately available. Even though differential-only parts had
+		been merely required to have consistent channel labeling, this
+		ABI is preferred over the non-differential one for those chips.
+		Special configurations may have the same index for both Y and Z.
+		Units after application of scale and offset are millivolts.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
 KernelVersion:	6.18
-- 
2.53.0

