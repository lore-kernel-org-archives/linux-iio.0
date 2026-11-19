Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087516;
	b=sZ0+PS/FnEv/FkU01QE9wTcIkGAoguIvUtRikdjs6vyyORVvDIH7ksJ3dTpoYqH++XZv
	 mDG7nTeLQKo3zINkm0AVOQ8at4iZSX+YDir45wcyMo5J9WSG5HlayVGWhhbpR9A/UUqae
	 r6sgA7MS821DH0z+GuiYCyEmHNZy5bV13oRTyPGbS4BVXQqMA3fpGEFPqtP2/YM6w8TA7
	 w+ZgDqThtUBzqd67DyGoeUjnoa6sXuDkV+uNbO+uUMfyJj5H050AUh98eCCXNgCBRQP7E
	 XRrloRn5r+MTI00zzCWsHxj87IT3RiuDTLfrSwnQSkIOnBLNd8pnsRb/MeKjOTtuDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087516;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+cNwt+gUJSYsLFI9L0pTVdxeZNg0s+CZpU43mw4icwE=;
	b=QNN8LogZRVVI29gpq5uhMcmjqyyiG5/sbiPsZ+JOQHn6mj9Zm6wPS7YAoIPnJCv/hzhj
	 g9r0fl70in/lh6nQy9ZRFTAhK5uqhBOxc1XKQbqloN20/19ggQ0iyJTZ3ui4r3iiUZGGw
	 12PgwAzFu8yx7s1EnWE6VvPmb5lZuGE2NDB6OJEGo8EJSSjdwI/e5F9yJzzkjQnXwMPW2
	 NemtelGee1zZRQrrQ17h8HlEi3bcxe2vtMqaFJCzs149fAJv8SDuiBh9wiXjxQDzRFszS
	 kYdz5qBhw4jVZSY+p+9m3gahiORV7bup5yjyB1We/Edmgyjkruq1LoAluVs7uFp0DAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=XOzrEsXM;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Paf2KUJK;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02460A2605;
	Thu, 19 Nov 2026 11:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E02460A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=XOzrEsXM;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Paf2KUJK
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJAxZs63113110;
	Thu, 19 Nov 2026 06:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=+cNwt+gUJSYsLFI9L0pTVdxeZNg0s+CZpU43mw4icwE=; b=XOzrEsX
	MdTbYNeBvExp6ZMInvEixGzwxc5xvymc2eWYFRKn4qMBRrYsFIwsb76fsOpgQE6n
	wjpCvsV5lCcbJFOgw3pcv+uZzhcmWYOunoSxZkxD0D3idc9X+rx1XfQdhTzITzLG
	P7Dgg3GtxHR72FCvtLwTgHfsnx0EDDaJBHZ23Bw7a3ogmtIxTnEWQbdAdx4A/7hc
	6UMo3GY/NALTxeb/p9jkK+0D3Texo8CXrIBxZ2oXqqylvid8q8/5C+nHtdh90S45
	OXhdbWiG0XrlDmeBi154BY2aT2QvERLiykIcNngUC5arVKJeFR6356tE2UIw0kGm
	7HRQXqdgEm2vJPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+cNwt
	+gUJSYsLFI9L0pTVdxeZNg0s+CZpU43mw4icwE=; b=Paf2KUJK+UUz89WikJwrt
	AnZ1MCcq+3LfOyclbVDGjbjm96yvjrtvTJjoq+HVvfk5nKNDgpmTrYfEDRsmwTaP
	0peEw4aU4RyFfrCxmKkzrVgexaePDXVTkISEwPC6/n/3IUiCp/QYB5bhrHyCLzPR
	hrVh/W9vYpYDUwjQajlLWXyDTFSS1usyFkKM62yptw5RikXjeOoH92H4sVb6y+pM
	lb4I7/BIG95WFwx7RMuGrCKa9FZNO4qmmr+ZlyKoqRAkkZqU+r2JuopVrreY4jAv
	SKQ01UpgAjKw5K+JtDNVGKzth+7dAGPr2aA3DYj9Qo07oZlvAjsApZ2TCq5lYglL
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j1pbqb8as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:25:13 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AJBPCIp011118
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 06:25:12 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 06:25:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 19 Nov 2026 06:25:11 -0500
Received: from arch ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AJBOocJ010881;
	Thu, 19 Nov 2026 06:25:04 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolae-Daniel
 Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v4 2/6] pwm: axi-pwmgen: report the waveform step
Date: Thu, 19 Nov 2026 13:24:16 +0200
Message-ID: <20261119112437.197306-3-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-GUID: zqYp052COcYJ3axTTJf8dQVns4zcMtH_
X-Proofpoint-ORIG-GUID: zqYp052COcYJ3axTTJf8dQVns4zcMtH_
X-Authority-Analysis: v=2.4 cv=LNzz05W9 c=1 sm=1 tr=0 ts=6afedc99 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=aASXySr_LHO6eXd1yVMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX0xgxCv2ynB1q
 epRttps1d9MC754IrvrcwXtx5jiWjtMaRy4D/fWlAeGVTw7a2KodBoUACt7yhTa3vXxRZCWMgAg
 x+F5KpZcdpbQbdFBlZp7Q3itFB/uluRh1UpwxcZ/ihpHvbeEe9wt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX5X2IzNTj7Rgi
 Lw9aIOTJslWayIbphPA7LboV2Itm1eKJDjKZK+mvvXd+EWeoNs+invL/S6mCZBNMU/Q2bJRwAHR
 5oCONYOUZXbE/gC2RWZJEW6PQldUtzXI31dFexVF41gf9GNE/jn4DPORWSL6JSbzohk+sNLzJjG
 W817UbAhMNmooSxRzdIVmkQZ5L1+FNMZqRa3fodUKNwFF9U0g8uc4cwCtRULE+51a7jjkxQr/Im
 0GK7rSWbUypASnrBDzSIcZKTj8vQOOi2Ku0z5VC0rcDHAty871qzFuzGmyjaoUbP1Qnh15gpLke
 fB1EuRUIF+0wZpHDPq/oIb9gWm7AJDce8bIwT/KtuhG2W12Bcsi8nDgKZe2hTQOmnndaG/iXain
 kXvwSChrE2qw1f2HdzT3yjEKRSZlA5GVBjlYHwHR/dspTKbacPKLqBnfgI4uP0SYywnvjSbHnyJ
 UXimDlIfFDYMGlaWYTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045

The period, duty and offset counters of the AXI PWM generator count cycles
of its external clock, without a divider. Report that clock rate and one
cycle per step.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index b40522f01002..6b15244efabf 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -136,6 +136,18 @@ static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_de
 	return 0;
 }
 
+static int axi_pwmgen_get_waveform_step(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					struct pwm_waveform_step *step)
+{
+	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
+
+	step->clk_rate_Hz = ddata->clk_rate_hz;
+	step->clk_cycles_per_step = 1;
+
+	return 0;
+}
+
 static int axi_pwmgen_write_waveform(struct pwm_chip *chip,
 				     struct pwm_device *pwm,
 				     const void *_wfhw)
@@ -201,6 +213,7 @@ static const struct pwm_ops axi_pwmgen_pwm_ops = {
 	.round_waveform_fromhw = axi_pwmgen_round_waveform_fromhw,
 	.read_waveform = axi_pwmgen_read_waveform,
 	.write_waveform = axi_pwmgen_write_waveform,
+	.get_waveform_step = axi_pwmgen_get_waveform_step,
 };
 
 static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
-- 
2.56.0

