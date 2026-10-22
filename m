Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667934;
	b=PTZOxdZS0rNhbOSoegbMpmx0GNrhyeFKbdEcu7OMsZjoimc3m2wYM7mzvotrh84EUyIm
	 dWnsh5cSfBOm7/JYfNRUi+ko9Ykr5WSdbNqBo3Eafz5Z2w6eKltNeCEVoNk84qnIsn6ED
	 gunjOPV2EUzsuVe7hyZ2ksVK0+UISYHOLGatzl5+IuUxdZlGF7imR7am19IBEeiHMjiwG
	 uEq6g+yiO7knxd0apHh7sz+q1sM0sYrYlJwcmlB4k9q1xACctGVH5Y5CTZQ0tUj5tSsZS
	 0yffraabR3BUHGvoCQJyTyovPtp6fFEgbPxwo2tdw/g+HV792phgM+Xv/1/+Sdgk/6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667934;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8GPDfPCRDLmQ0iFqQn52ItYyLSJz6fCPXiOj/cPSZDA=;
	b=G06ysoVvArOEl6/v4p8JZfEbW25VqDPjI3QgKW0eht2/Q1Fj1If+BoROhmuWWVCd7RIC
	 /IdzJYypPfI9mRB14rgpHi2HXJCVKMzn7nSoyXY/MR0DKcnbzs1GONEcSIGt/bjedtoZB
	 1zIdSrsLg7c+lM6sTkHG64kCI7z0IAnhQRqkX6RzMC1He+4tI/1FgYC3FNMtV+aJ/bax8
	 EfhtYkW9lr8O3DZP3xLC5/oWTl1a4Z1kPHkyUNkKLofU0EJdAgj6GBy1jCuv7fz4c4zA4
	 EZjgVUrYAHp7OZhJ1ozmQ4YIDxNwZxVxeDk60Npr9jhT0jGKAxI8MtqzsVMuJllCcBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Mi1SC+iY;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=waeHe3jb;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B58606A329;
	Thu, 22 Oct 2026 11:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B58606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Mi1SC+iY;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=waeHe3jb
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1hbq2803362;
	Thu, 22 Oct 2026 07:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8GPDf
	PCRDLmQ0iFqQn52ItYyLSJz6fCPXiOj/cPSZDA=; b=Mi1SC+iYCT9docmJYDv/M
	vQAK5uiSTwdY1NK8FnNYFn6mIXxg7pJyfF7dhlpLf3Kji/9Ui6QhKePxTJ49QpPp
	t5kd47AmZoy1p1AKirSNFBTZlcX6Cf6e9kqcm2dWO2C01ZjttGNstXZO2OOiNPWl
	NUhcSl5JTb1wMPstFc8TSeQxWky6TCREFG9hmVrnkMQ8M2gTIzk5jNK2NcMYG4cH
	lNoUMz03t31+JJI+MaFilxxArR92NMEZUSyh5lCgYuDJ+PUn6c5xvo2gRVVqGefL
	Ur8iSPOdk6QWGd14ln0y2uyA9mjlBrTB1G3eEy8GQzoI7NWMZi+KxzsXwjtvPDBY
	g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8GPDf
	PCRDLmQ0iFqQn52ItYyLSJz6fCPXiOj/cPSZDA=; b=waeHe3jb76A39QmRsSQLh
	S/T0t1swWo9zlOFiTnJ0psRcPKdWRduK0j2V9dqot7hXTOsmF7q1sx49pjWwCeDt
	47FwsjEjwU7M17AkmJ0OQxkGF7BkELvb1fRWdDFjrxBdqkbL4F8q5IX7TL80Xzm9
	GpBdVULJVoqMe9XyMQeHtqr0+f9+6WYbKFtEfKD1CItq0rVK+3DcDCb1C3GZoIIa
	vrJgSMWMffekAvLTrNJ9GSuGWPBjnQvpykH3HWrdAMGsAtalYDIRrkpvIBYi8Wnr
	HtG1sIg1TmCgA7P1xeCMObly5PPbtyvMo3BTuEM/YZ0iQA9DJ28xBMQnwWynF/w1
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hf927anuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 07:18:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69MBIeNq055334
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 07:18:40 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 22 Oct 2026 07:18:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 22 Oct 2026 07:18:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 22 Oct 2026 07:18:39 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69MBI6LH005667;
	Thu, 22 Oct 2026 07:18:31 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joshua Crofts <joshua.crofts1@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Radu Sabau <radu.sabau@analog.com>,
        "Janani
 Sunil" <janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        "Jishnu
 Prakash" <jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 3/4] iio: adc: ade9000: add support for ADE9039
Date: Thu, 22 Oct 2026 14:17:56 +0300
Message-ID: <20261022111759.6019-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022111759.6019-1-antoniu.miclaus@analog.com>
References: <20261022111759.6019-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfXwLmxqal6Vcwg
 obL9NP1tLp4+JmfVM1L/v5/gGKZK3hzikGNy+j2fIpOUVZ30MjASogRZxxpU+yRAAsjrxXE/qT3
 Bs0fhgz9vyla9c8eWSF9EnNtBCOYevup9kgL6t5j44dKpSPjRoor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfX17xcfogSTggr
 wpvrSjrDYTs9G+x6NZs6c2qsKmITMIwnh6aHiOusFPfV3YTXoqFNJTUByAgoKuQ6yKcYYtriPJC
 W3+opEM6bzh3YYdEZ9bN/mNqwhbwdBhAaCaQkETRNx1vKBN1FKX2wQajN5I7a4BQX8W8BuiTFQn
 yH2oxb0JQ1OGadEkM0h+zj5DYRyDRHxdGLyoNLk6nGGfLYBxe+CEaYgfHfl2iKTCKFEK0qEhF0V
 1qBzEa81UArzvexzo7yKZTX9XKCsRnCznVpW1cBkFcTxC4yOuwNSsD3mU16k7gy1nfPPIq5a2bE
 tk9dqyg6qqgzVb2F8HfNCkfaPcf8qNdw9+N8rIaQyXvqJDF4+sFzQ63aGT+AdZRm5nxEcsvooU1
 sRQ4xa35DgODgh/cVw3SDNZ+EVRkQhWJdsIR3EqQY+C69WYZtsW+Ym3yCT/oMNrI/s3UBM8km1K
 K/Z11ub2wZV2SOMr2Qw==
X-Proofpoint-ORIG-GUID: g3VAWT_1rY3HITJWGinzfJaCBRZwbf2y
X-Authority-Analysis: v=2.4 cv=WYKZ+EhX c=1 sm=1 tr=0 ts=6ad9f111 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=dAPqizKKn2ozKx84YB8A:9
X-Proofpoint-GUID: g3VAWT_1rY3HITJWGinzfJaCBRZwbf2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220044

The ADE9039 is a polyphase energy metering device that is register
compatible with the ADE9000 for every register the driver touches. The
differences relevant to the driver are that it shares the full-scale codes
of the ADE9078 rather than those of the ADE9000, and that it has no total
reactive power register: the register map has no AVAR at 0x211 and no
AVAROS at 0x010, only the fundamental AFVAR and AFVAROS.

Add a chip_info for it and a channel table that keeps the dip/swell events
of the ADE9000 but drops the three total reactive power channels. The
fundamental reactive energy channels are unaffected, as AFVARHR is present.

No change is needed in the CALIBBIAS path: with no channel carrying the
AVAR address, that case is simply never reached for this part.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
 - List the ADE9039 in numeric part order in the channel declarations,
   the chip_info definitions, the SPI and OF ID tables and the Kconfig
   help text.

 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ade9000.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 02de4809ae31..238957243476 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -601,6 +601,7 @@ config ADE9000
 	  highly accurate, multiphase energy and power quality monitoring
 	  integrated circuits:
 	    - ADE9000
+	    - ADE9039
 	    - ADE9078
 	    - ADE9430
 
diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index fb69cbbb38fc..b7a29d6b09fc 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -681,6 +681,8 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 
 ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL,
 			 ADE9000_POWER_REACTIVE_ENTRY);
+ADE9000_DECLARE_CHANNELS(ade9039_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL,
+			 ADE9000_NO_POWER_REACTIVE_ENTRY);
 ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS,
 			 ADE9000_POWER_REACTIVE_ENTRY);
 
@@ -698,6 +700,16 @@ static const struct ade9000_chip_info ade9000_chip_info = {
 	.has_digital_integrator = true,
 };
 
+static const struct ade9000_chip_info ade9039_chip_info = {
+	.name = "ade9039",
+	.channels = ade9039_channels,
+	.num_channels = ARRAY_SIZE(ade9039_channels),
+	.rms_full_scale_codes = 52866837,
+	.watt_full_scale_codes = 20823646,
+	.pcf_full_scale_codes = 74680000,
+	.has_digital_integrator = true,
+};
+
 static const struct ade9000_chip_info ade9078_chip_info = {
 	.name = "ade9078",
 	.channels = ade9078_channels,
@@ -1883,6 +1895,7 @@ static int ade9000_probe(struct spi_device *spi)
 
 static const struct spi_device_id ade9000_id[] = {
 	{ .name = "ade9000", .driver_data = (kernel_ulong_t)&ade9000_chip_info },
+	{ .name = "ade9039", .driver_data = (kernel_ulong_t)&ade9039_chip_info },
 	{ .name = "ade9078", .driver_data = (kernel_ulong_t)&ade9078_chip_info },
 	{ .name = "ade9430", .driver_data = (kernel_ulong_t)&ade9430_chip_info },
 	{ }
@@ -1891,6 +1904,7 @@ MODULE_DEVICE_TABLE(spi, ade9000_id);
 
 static const struct of_device_id ade9000_of_match[] = {
 	{ .compatible = "adi,ade9000", .data = &ade9000_chip_info },
+	{ .compatible = "adi,ade9039", .data = &ade9039_chip_info },
 	{ .compatible = "adi,ade9078", .data = &ade9078_chip_info },
 	{ .compatible = "adi,ade9430", .data = &ade9430_chip_info },
 	{ }
-- 
2.43.0

