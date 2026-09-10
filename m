Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B1391E7E;
	Thu, 10 Sep 2026 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078357; cv=none; b=jqZL4fHUrJpgRchF+6l+kQmcy26lP9dU6JOq9gvTayLGIbBCSzHEMXULHl923vMMaytoZnj3HNTMnBsZNp2hanyKzbNb7KTPUYh0CEifBp3axEEnBVNMqB1UT4o79OTmLAM6yl1dMW8kDJUO0gFSm21A2dAdW3p83TSz9q/o584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078357; c=relaxed/simple;
	bh=OR8f3f28DJUgBbXZUMtVRJDuqX/LidHSQUMXmLv9x0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pc4k7MMNgptqZVkumC6V4wSjj0K99kv4Qto5cO07uOaYL3N0AdGSV3ll0B4pObzuAwis5YYFmWcLj2X+g+W6ShwjC1DPTl9yFYJpqaIE5pwOWIdAiIaV5OzuVKnSxUpucsjqGAO+9lCLQRamMG4JRN4x7/OVR4tIyNWd3HVGqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XN1pQFRJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XN1pQFRJ"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALWBil1089906;
	Thu, 10 Sep 2026 18:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=T5BiH
	q/Pjt54V+tlu51eq8FCe+U1mKvQWFvrYpUreHM=; b=XN1pQFRJ03H5Bv48pTlcL
	6LaQOzZz6ii/iSb44OfsRVJWk7UN6hLzRbVzveZK+oWAg29J5jopN60SnNugxgjq
	E3+1ImW6pcXU1KdIxOcbAO0GfFT0/1/E8T8LiXq/H0tPsG0oPXz6uMOHptZC3/AM
	e51lxvxB3847VDPbmzzkQLrDbzHkKIrKjr+GRIxTGKqA/2fddUSKwRmPCwyGtSGD
	E41Z+cqyYD98VTfuS5x6WRy5fRVOckarPmCS/Q+JT991jMRNeIfT22XkKVDiIkm7
	lQp9upivQzJ8AoSOJR8kE21padLlgwTUwvXhURYuSUjpa1yJ3gUwdjSUnSf+yB18
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx962da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 18:12:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AMCVjf010771
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 18:12:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 18:12:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 18:12:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 18:12:30 -0400
Received: from JGERONI2-L01.ad.analog.com (MABALA-T01.ad.analog.com [10.117.222.255])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AMCIkN028000;
	Thu, 10 Sep 2026 18:12:21 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH v3 0/2] Add support for Analog Devices MAX30210
Date: Fri, 11 Sep 2026 06:12:15 +0800
Message-ID: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI3OCBTYWx0ZWRfX7MFOMj5tX2IO
 ykqusYVn2OpEa3ZGhKiJKzn4vxt8R55dHXUkBnGUXeOGrfewx80aoZvdl3tqqs2//5uniUlZblU
 1v6RkAVd03MKSpxA3Dq3+nK0CkCNHRDDIfPE2heEUutx5JbEwKZg
X-Proofpoint-GUID: QtqJBJFhtV5J8qtx8tIEdJzu0GrDgAwP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI3OCBTYWx0ZWRfX60WyRjsH5hqV
 gfUppqnxgumrMacl365fNi8tl53QrvYJNcsGPzJ9ftmWOWpOy+C14GPHE15XFN+ulBnFioy8j7A
 2DTXI7I4bGg8a2RZSAFtvHQE/5VlTNX8j+dXcs0T+PrnI8rgszCZ2MFEO4RyYaEiSoMuSdHglHN
 DN6gE0AHZiOSkq9taSwJKmpCQO9coknOfh3vCOyt/VQ0EecvUD6Y+PkKK4aZlsOw/R/9iQ2IqOD
 qYFTmWWC0s+bDtsFd6Vi2phnrdWZe/BsCUHUu2c0lGe+W5jJani3Gd83C9a4aU2+kLRKwBT8EO3
 7AeYwL8SbP/agyYAoWSUj9U+KCj8j2r0wNRlfYOJqLNI9UdKelzr5/4+depqP3WQdd3xv6nBnqF
 1qJrXqvz1jLdolFafL5lfkzmHDfJuCr5/NhNgBrLfUzp3kvOWf3S3/j3AKsVOoeWRaUqsylJB9Y
 aI+5Ftl4AlxHBBCdeRQ==
X-Authority-Analysis: v=2.4 cv=G8CJgNk5 c=1 sm=1 tr=0 ts=6aa32b50 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=6_3VhsULprTN-6r2Hc8A:9
X-Proofpoint-ORIG-GUID: QtqJBJFhtV5J8qtx8tIEdJzu0GrDgAwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100278

Add IIO support and device-tree bindings for the Analog Devices MAX30210
low-power digital temperature sensor.

Changes since v2:
- Fix FIFO byte-count handling and sample decoding.
- Fix IIO debug register read/write access.
- Validate event threshold values and sampling-frequency register values.
- Return the correct sampling-frequency format and reject direct reads while
  buffered capture is enabled.
- Clean up the Kconfig entry and device-tree supply declaration.

John Erasmus Mari Geronimo (2):
  dt-bindings: iio: temperature: add ADI MAX30210
  iio: temperature: add support for Analog Devices MAX30210

 .../iio/temperature/adi,max30210.yaml         |  61 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/max30210.c            | 689 ++++++++++++++++++
 5 files changed, 769 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
 create mode 100644 drivers/iio/temperature/max30210.c

-- 
2.34.1

