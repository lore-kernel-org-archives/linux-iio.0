Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829A354ACA;
	Thu, 29 Jan 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708604; cv=none; b=HBRM1PhdqEl4ti4R6dTlj8rwqvaDhxx2aCqV8llpghk43B27uxHoDsrxBc9A617Qc9MlG9I7C4vuY0zSD8xRv1ZdOzVaud9BPpC/Sd4QAvPe9q3IToNfRc2W4X1kqbSHXRfiMulHPOAKk0e+S2DV8zbh4h+EaA0utvqjvZS86iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708604; c=relaxed/simple;
	bh=WrDvInolzOTITOVpVJtdS9rlV4+LV8ABv+WshqTpKtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdJvAtNTmYUq62LdZ/BphtpYxP0Ev226n5RjcB3h3xMwXwUjNP/89Ro8OckTpSBVCg8PSIoW1OqNXHJ/4UgLk/cUSqzBVqa/JzRSYLhq6EgtkTPNO+WDJ3S5WIkoTLXcuH6vNmOdC7mU7z3XF03wfYlNonUIdxayK6q/GeR+xmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=W1Xe1wN5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="W1Xe1wN5"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TFEl5X2649162;
	Thu, 29 Jan 2026 12:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wfIpb
	IXpBchFjFOyNEK/LPnc4nnS1/WAaLzojJ5h6Zo=; b=W1Xe1wN5Xs0kQBTgUngZ8
	ZuP7lP1MNzm6bzjyg1sC9WmcM1jx6+5xnt61HfssvKiBMLG/gr5Y6EjW0DHefw6Q
	ItPF0/l83MwqNN+lGwXu7jF/PSaliul4w/leEX9MBqAqWO26gtDHJFd/IBzSCluZ
	cHnKtXMz3wKKSATE0pMKjNxO8Js4eAShjuxRFn4sIcv2Lcmxcfc3603b3M+UOdLA
	2/0ABlGInkK+PANguQGUL+G+B6fJE5lFiw1Z1I+4YlRXW4FVOkFAeiYEL7hRn5El
	xZSMTgkefzXLJDADtnqlujtXM406hTcvKtpR9GYzz34C5/4Jt6q0N6LkU2+28zEA
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c04891xsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:43:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THhE0j057586
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:43:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 12:43:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 12:43:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:43:14 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THgsL0009203;
	Thu, 29 Jan 2026 12:43:07 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>,
        "Antoniu
 Miclaus" <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: imu: bmi323: remove unused drdy_trigger_enabled
Date: Thu, 29 Jan 2026 19:42:36 +0200
Message-ID: <20260129174253.39574-2-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyNSBTYWx0ZWRfX25ln8FAU+367
 E9/C1Gn139yXe+eRvWGtnQTClt/z4xynbr94Hvz2ozHm/UNee0uLcSeR01IZCF+rvxaD//uESh3
 rm5KWWlREtKS5igGQNtspJsub76ufxVO/IkQWyF8mKirEOrCRiNq/h6cCL1s2dDVhi68MoYMa9a
 XmNQN5iaws6/TCdya2/5xTkjAETwPea0uaTCnm0k9u50Dv4ZdvrrdXnbHrWYPyBr50E9Hb/R8nE
 BPTRWppnVV8Y69MjN5oBLofMPZwp3pSbNHzG0ga6VyRgAKOr8jM4R69AS6HFzT5oeE6UYDK/eEM
 wE3TCylUB7s9W3O2pVGSqsx/z1PxYeG0YIKfRf9rl1j7/5pEpxA5asnn0NZz//ynFrOKoGKPKUA
 8Vryg5IJlQH3ZmYBS55+dNIh2dod+0aopvlEX+OL2o8S0iL0SuTmmFOsVkh3cubo1PKy9Z7hcNS
 xShxzs0Jc4pA1RqvnLg==
X-Proofpoint-GUID: 0567WB9xhzihfFqQx5uhpZHW9q5CaLvF
X-Proofpoint-ORIG-GUID: 0567WB9xhzihfFqQx5uhpZHW9q5CaLvF
X-Authority-Analysis: v=2.4 cv=dq/Wylg4 c=1 sm=1 tr=0 ts=697b9c33 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=PuyMK2twWGwiWQxPHbwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290125

Remove unused drdy_trigger_enabled field from bmi323_data
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 6bcb9a436581..f3d499423399 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -156,7 +156,6 @@ struct bmi323_data {
 	struct iio_mount_matrix orientation;
 	enum bmi323_irq_pin irq_pin;
 	struct iio_trigger *trig;
-	bool drdy_trigger_enabled;
 	enum bmi323_state state;
 	s64 fifo_tstamp, old_fifo_tstamp;
 	u32 odrns[BMI323_SENSORS_CNT];
-- 
2.43.0

