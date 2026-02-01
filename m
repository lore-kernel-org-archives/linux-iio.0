Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69133F0768;
	Wed,  4 Feb 2026 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208396; cv=none; b=XbfkOE3SNxb2IVfOBHNqkFbWvr2Eot22MwMjf3QkXSB1xUTZ70uk8MsrE9mGueN0SEXZJ16srGBoH2Yzt7s+SbNQsVJ41GUZLYDyam/ghYLPcUq4z/C4voS8YeixMbZ4CIFYJMhALB/wv0QLenMWbwY9HUQ1Ue9uRqzS/Tz5u5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208396; c=relaxed/simple;
	bh=uJC8XXS3KsVyFF9bm/ubPZ5NWIzB9Z6ymsM8ef+DUQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A18tKJNk3b1cVL9fpY4wYnOBi6K/RBMEGZXe9CHhC8TclwXFNXZMXsQ/pOwS6s17VoSB0SXuPZY5xydU9iSU1mF3e+BfAuQ16lrgN8KuWWafjxWPT12wgSubvFbC54yBf2UASNUeLjEIe2TdkFK7jPF/UDZN7I0ru+nSPRN6uNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bgfncYhu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bgfncYhu"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6147mdAC230803;
	Wed, 4 Feb 2026 07:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zLoHY
	UvqbPgXnu8tEki5OU+3L0xmkIG3uD4x8wb7TfM=; b=bgfncYhuZ2tsmmhrCmbRk
	VJP6d/HpnR6fl5HuONjyQwkLsWY2YTtsqZYzyWMqedY76Bg4/3weJKSfo9zRc4rh
	u5YlhtYX8behVHeA+7VOHpqFrnGsnO/hYdWCl9oZ2RwTBg2/PZaTUplSgr0m4jJm
	EWtf45VTuafVSnJxaukWPnzSUEP/YLp/FLMOICNzAZ9wefgjuQGPIOcVZelZUJGD
	Nh0BX31T/V3n3+4QuPjsf6uWDrflh8Ump7Rrm1PuIFFH4F4QgHrjS+Ai/N8uDAV0
	Fu19f3JIXl7uedbt9ji/o97HfZ+a3YAEr3SqRXfB+OFF0tR7+/UNhYuMlYbg6QSY
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vyba45c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 07:33:01 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 614CX0E6055426
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Feb 2026 07:33:00 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Feb 2026 07:33:00 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Feb 2026 07:33:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Feb 2026 07:33:00 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 614CWnTO007389;
	Wed, 4 Feb 2026 07:32:51 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
Subject: [PATCH 1/3] iio: adc: ad7768-1: fix one-shot mode data acquisition
Date: Sat, 31 Jan 2026 22:35:20 -0300
Message-ID: <c4af45393ec299d0fbf853fa8ec224f475e5901e.1769889074.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769889074.git.Jonathan.Santos@analog.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bQqkvfvQ8Zz3QMCjPfwXHNECz70_yZRK
X-Authority-Analysis: v=2.4 cv=XLI9iAhE c=1 sm=1 tr=0 ts=69833c7d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=uXKFMexyRkwL0ZmDwxwA:9
X-Proofpoint-ORIG-GUID: bQqkvfvQ8Zz3QMCjPfwXHNECz70_yZRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5NCBTYWx0ZWRfX0hliEqxdKPGi
 EoZxLq9SLynQtE3Xm8Exb4yvMD4/AoIFSV8rTmyYvJ3Cb/qSmOew+REdUMf/fo665jkePPZ52cm
 /GrQPqvkz0MLgVS1zxM1iDzozEZ3mC1a0SygpGL6q3vk5O6NFNSa3s7f1wXKbDEjd/8rD2GP6y1
 M95O/Rq0+szxL+77Wojp2q81aiE//rok/EpOTEZN0qM6aiK0KcG7aEV1JVenrPH1wmUfmwdzzop
 nc1kPu4VJejJe+snUPFQwvBJ+VzDcZKqXkQjttb+qEs12i0SJA1iLceeAuyIE3UjKDNNIY3i5Eb
 KgyQvNrdJONF9MCIPUt3AfWt/cYgRUuYqNaLwJ1nXNqIFgbviB3G9usqlR3DPYLxwZwmlILsNZC
 3LZgUALI+8JaSb5Wh5uXOsX2Tmfu6DwnI8+RS3VKBPxC9OMOhYA1lP8YdmlEygIr93x5x7XEndG
 uu+giA02mHksNjVwO6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_03,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040094

According to the datasheet, one-shot mode requires a SYNC_IN pulse to
trigger a new sample conversion. In the current implementation, No sync
pulse was sent after switching to one-shot mode and reinit_completion()
was called before mode switching, creating a race condition where spurious
interrupts during mode change could trigger completion prematurely.

Fix by sending a sync pulse after configuring one-shot mode and moving
reinit_completion() after the pulse to ensure it only waits for the
actual conversion completion.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index fcd8aea7152e..8d39b71703ae 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -463,12 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int readval, ret;
 
-	reinit_completion(&st->completion);
-
 	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
 	if (ret < 0)
 		return ret;
 
+	/* One-shot mode requires a SYNC pulse to generate a new sample */
+	ret = ad7768_send_sync_pulse(st);
+	if (ret)
+		return ret;
+
+	reinit_completion(&st->completion);
+
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret)
-- 
2.34.1

