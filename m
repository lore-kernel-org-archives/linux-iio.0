Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2841836F;
	Fri,  7 Aug 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093131; cv=none; b=js9LmsprnVZnJemPByl7KnSUudkhYiY20kepH3k9Yk47lvzqeVBJOEMbO0KCcDyCOzapBoBJycvJ6T6D8fYl+spcFE8p9HmZiihfAAHqZVqRFCqTRgiRh5zmVHd2WGpwIYk6mHKRLwsXFiXoWDLpQgCXBgLw2Mvn5gLScrXINDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093131; c=relaxed/simple;
	bh=wFeY1lP7wUJlxjyl0T2pkSFmq7WI37VrU8gsVQOMPLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9QWnZODRQM/DCp/35hFzJlaR9xJkgXpJcuV7vECOyriMNhrGjxWSGWBSg2flgDVgRUt25eaTDGGf55W2ZpkpE1CuL4tMBLrhkE7N8z1VKYIcYob9qhorHU+c3EYP0OtiFMJyCAFRn3uPuJjGV6pUFYuEzSFcXd3TNHiud/v1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BcUIBKIN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BcUIBKIN"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6776TW5K752576;
	Fri, 7 Aug 2026 04:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YhJG2
	x9chrxtpiasmm31N1F0ISyOLzJ8yy5k3PktJD0=; b=BcUIBKINVnSus64+0S36C
	JiA7oowbBsE7w9Sr5BHpp4aWquN2akk5O9RnJZ9DaEFLoONN7CCL5GggJ6wi5CdD
	OREscuNnubOlnjWmXIbifMWCfg1G/Isv9uQKYM/EeUCGxXzHbc1vOoTeM/BfINFK
	gvzptoJwhG6bTX8wuBLrbJkTrhZlkTV6W/ybEBcUIRnokl+DtoFcbB7a0QWhuvzo
	SQLcYttvOckD4UTZGB6toFFJG3AgsIROSYcZyyUYuUxP7fa6y+v87cGjCmyEobZN
	Nr4EWndLuPZQNxkz/M7S66IpPxLDyiCdVfeBY2077eiRlNxM7VGSblSphi8ldeVb
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvrcpwq8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 04:58:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6778wjMj059723
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Aug 2026 04:58:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 7 Aug
 2026 04:58:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 7 Aug 2026 04:58:44 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6778wTrC022705;
	Fri, 7 Aug 2026 04:58:38 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] iio: adc: ade9000: fix overlapping scan_index for current and voltage channels
Date: Fri, 7 Aug 2026 11:56:42 +0300
Message-ID: <20260807085643.5502-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807085643.5502-1-antoniu.miclaus@analog.com>
References: <20260807085643.5502-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: N_n4vfRAJ3NXvorsLhqsrDxEH-VX4TC3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NiBTYWx0ZWRfX4cfmPN2bW3UF
 pus2BUre2d/s+ZIO3W+wgTqxM+iu4GIv1twI1hHh8fTuCYlcMDTjUBFpgL6EqqAbq+yGJiIJr8v
 2WguTXkqGG0wvmymo0jg0QnKFNLSVNd9HtIQRGi7qw2N78w8Xrce
X-Proofpoint-ORIG-GUID: N_n4vfRAJ3NXvorsLhqsrDxEH-VX4TC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NiBTYWx0ZWRfXw/0h0oM6uArG
 DYLIJa9jK7ieyDccu7oINT9Z6OhSiVjUwf5PngRn8O05peGVdqhlCVclzDsTLH5bQuk4d7xBBJV
 Q0D868fg2yC26aJ+2sjowZl+fqOlhPsh8f8HBeXXB8e1l3qylojV5EFE2X3S7umSimXyu8T45D8
 1v0sN6MhMK+XYbjnKrSfM7cGZyFTbDm0oF8wAi17jhphxOvEu3D12lQQvteF+6QLKtBsXD6Ryxk
 8ivRHdF4CyeQkfoIs+6d8NenCnQJNfTfa/kfuoIfBxCzpvr0UHibgE0irWFLVmZF5e6p6rut53d
 V52BRdL8iPJDFhdvXbyD5YcyG+jr/g2Och8fboKEMN3cOpTronXTDGYeW+7QjQ/BQoQrAK5JiUw
 zDahkILgCnfHigYQnwhvkjwSK5tagsd8lwg9RRpbOFm+/P4dL7WKJDBAiVyrCWIDILUKvwje+Hx
 OI4emL/5+0goeH2tjWw==
X-Authority-Analysis: v=2.4 cv=IPwyzAvG c=1 sm=1 tr=0 ts=6a759e46 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=iuYi8Ug5Fld2qd1xgz0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070066

Current channels used scan_index "num" and voltage "num + 1", so with
phases 0, 1 and 2 the indices overlapped and no longer matched the
IA=0, VA=1, IB=2, VB=3, IC=4, VC=5 layout expected by
ade9000_waveform_buffer_config(). Phase B and C buffers were configured
incorrectly.

Use "num * 2" for current and "num * 2 + 1" for voltage to get the
non-overlapping 0/1, 2/3, 4/5 layout.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ade9000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 51cb43755a1f..167b1f4d6279 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -444,7 +444,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 			      BIT(IIO_CHAN_INFO_CALIBSCALE),		\
 	.event_spec = ade9000_current_events,				\
 	.num_event_specs = ARRAY_SIZE(ade9000_current_events),		\
-	.scan_index = num,						\
+	.scan_index = num * 2,						\
 	.indexed = 1,							\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -464,7 +464,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 			      BIT(IIO_CHAN_INFO_FREQUENCY),		\
 	.event_spec = ade9000_voltage_events,				\
 	.num_event_specs = ARRAY_SIZE(ade9000_voltage_events),		\
-	.scan_index = num + 1,	/* interleave with current channels */	\
+	.scan_index = num * 2 + 1, /* interleave with current channels */	\
 	.indexed = 1,							\
 	.scan_type = {							\
 		.sign = 's',						\
-- 
2.43.0

