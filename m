Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305E329E7D;
	Fri, 27 Feb 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199357; cv=none; b=BjbqD8YQwxhsO6uPsiQXNTyv2ShPdSPPES3bUjGD+VCWPbYLiXTf1fIHwsdH+Fs1gm9CxzMjhi8GI3KWYHReKgF3DNJ5tI3mK9mdnzQBwlivAWhA9S+acbK/tdzW9dAqXreSUhlXi+NqVRt2gworP0fSnW9Bc1NyZfBfKp1dUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199357; c=relaxed/simple;
	bh=OLv/ni7qaq2tYufDexD9r9Jerf7ke/5eiCXs9RRw+ew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOdLtoS86yzaXlTlMngXTsN1+FD18lNV9H9fMTphF2QfRmA37ibKcevMjfP62+IDqtLBCfarAoyOxzg2USA8Xj+bI2+np4AiRw41cB0EtrO1DESIFF6dpJsaisAJ3CLpr1+s7pUlJBkgIvQk9EMEdgyAwQDfhYcOVMUf4E2Mmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=V6I5NnsT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="V6I5NnsT"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RC0bCm3025436;
	Fri, 27 Feb 2026 08:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Wu0DD0j6wbDESy1BbdCa6qGbN5x
	sz0ka+dmENGQFhQM=; b=V6I5NnsTkVaiTy5A2bd+Bjx0uqJqXMayKTzs0038AjE
	teLpgk7SjZ4ZfAV7DHu7CdcdBu+4OJIqbw4YNCHlJeMwq+sNo+cDB1V6Cl+oyc+N
	ywOs9lkMdex+VLMhin82mMEpxQ9EhAsHR5C5JZlC6w0d5yqWbQ7ObSopAMSItmU4
	iN87FY9t93mu6IjQhgoz3ZG8AwbxPksJFjdUcOZ9O4UtIDD21HyWUDWfyVK2Sgfd
	lPiYz6k+X3KJMOWERkV5HT0vQzTvS9eqsh9OG/1uuY09kQD1+FyeKQWyRmAPbeKr
	nprWECdc9RXLxxdk6uC7kd8yuImD0V/616ND6VjtA0w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cj8tdg8x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 08:35:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RDZetC062265
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 08:35:40 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 27 Feb
 2026 08:35:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 08:35:40 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RDZTPG000372;
	Fri, 27 Feb 2026 08:35:31 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ade9000: move mutex init before IRQ registration
Date: Fri, 27 Feb 2026 15:33:30 +0200
Message-ID: <20260227133331.66968-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=NubcssdJ c=1 sm=1 tr=0 ts=69a19dad cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=nElHTjQORM6l5cS88qUA:9
X-Proofpoint-GUID: L9q_EqSp9qK8Pzj0injYMYGlAlN61NYj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyMCBTYWx0ZWRfXzmAfk5OKOIF3
 afN/7l7MnBIqaXYrakB8S8EkqNouMvJVwTBwaxUo0ntBAoWvGSs4IEVaHieGabvN+fCjPoP6u4x
 8dU45KqYEFiCGacF0IhbSBzwfruQVJDlQi0lOl9u+yOqonyrkVrN/hx0r9WC2qSGK525UdF6rsl
 Vb+kznYaqOiNz0jZ1hJp4duG/hEfF37DcRYQwW7cI/uJsXhYD1esUplB0s/gNlDbLqOdsmC4Tm2
 fu9qgBsXs3fXaVRjHpbOmPH+ZZbKS6RwS1RTl2kcpp86s5T4rDv59xQHjLTox1xVFIIJ0YOHT6B
 NgKHxquBaNDhDE1o2BTgKnL7fAZPBer4Ti0ad2oJa4p5KN5PmxnfHM+0J/tMRW/8HIruVk35dF6
 3PVpzYJi7UrXknY0gVlpxJJs4Ba4eJUGbbDtDiAJcur4uMQgbKvHgRAxiKT2W2SR34FJwvzltVi
 3yLc/r+AJcW0NwO9MDw==
X-Proofpoint-ORIG-GUID: L9q_EqSp9qK8Pzj0injYMYGlAlN61NYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270120

Move devm_mutex_init() before ade9000_request_irq() calls so that
st->lock is initialized before any handler that depends on it can run.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ade9000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index db085dc5e526..c62c6480dd0a 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1706,19 +1706,19 @@ static int ade9000_probe(struct spi_device *spi)
 
 	init_completion(&st->reset_completion);
 
-	ret = ade9000_request_irq(dev, "irq0", ade9000_irq0_thread, indio_dev);
+	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
 
-	ret = ade9000_request_irq(dev, "irq1", ade9000_irq1_thread, indio_dev);
+	ret = ade9000_request_irq(dev, "irq0", ade9000_irq0_thread, indio_dev);
 	if (ret)
 		return ret;
 
-	ret = ade9000_request_irq(dev, "dready", ade9000_dready_thread, indio_dev);
+	ret = ade9000_request_irq(dev, "irq1", ade9000_irq1_thread, indio_dev);
 	if (ret)
 		return ret;
 
-	ret = devm_mutex_init(dev, &st->lock);
+	ret = ade9000_request_irq(dev, "dready", ade9000_dready_thread, indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.43.0

