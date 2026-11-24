Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520855;
	b=OhHO4VfyU/XZrU80teoZC4CX4mc1ognSGHIJ5LAGTsowRMoY8oUReIPCRe47Bkxfrcg3
	 wYArWuWKYpz48p2Ovf0YDWbE84RTJDBeteACXafNTCTf0L/AAlx9uP+AFVsTgVQsd8Pwm
	 j12VPGmh0oQE73zCQ86coB2iFBYlaF1ePf5LX95tbhqLpzK0XXjUvnsvxnwoNLzDU0jtR
	 0HM2NERmsygYn9WUPgJTL85U9Hx4zFn4sh0npSZC/urw70mEvSApC+8iLfOJVwD0Hs06U
	 /+2P0WMSblup7dS5lwBJc4r+ZkyD7960JEl5pBtxfabE1BTARmUZ1cymcRitGx8Dzqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520855;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PxXNXQhlWE76TxbccQPB852zciVhhEeSOPvt0/FHCy0=;
	b=CbthAM82SYUFK8L/LjzhltFzOgC1ax7+59kVbjXNi/Tkt5VE+uOAUCk1s36ZOdBVSR0B
	 eKJWcxo7wKd5GNyjjg+WMPV4uk89hqrera5EHyAEXn0XRFRQGJlfSQg2bat9S/iNUZAsY
	 eXYGL6OSx+KuHEIYoaq9gaNXuywlyV7miUUyWZdrqckjvaJYexOrMaMN3gEN9z2p8wFbw
	 gislYTpw4fQUcUg/HLPoWFzH9yILitgsujEmXmIIgBCVP8vy9IaAqphWgfdvFvYBqThf8
	 HS5HU5FDrQlvpmA6PUUEm4P2wKHBjJCEW+MWzQ9cTKRTv3YlbDNVA/AzCw9zLtIj3mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rBtP9M4L;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=l9JfvTh1;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E43606A322;
	Tue, 24 Nov 2026 11:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84E43606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rBtP9M4L;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=l9JfvTh1
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvjsB1326267;
	Tue, 24 Nov 2026 06:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=PxXNXQhlWE76TxbccQPB852zciVhhEeSOPvt0/FHCy0=; b=rBtP9M4
	LiaJANMOWQm/MgBSIX3PJpsPKFGwivt9py+balSzDxghkCZclFiuSu2fnmyU5Lbf
	MsPo3lTAebr+KTngb0x7XthaeDVjPLFffB8d7UWLsuT+b+c95B4A+qHXuQdAFIjk
	qyb5Ccws+BAVDwi+/DLyt0b2OD0Je67Xtf8Uxq/oJvzjJ8RnaimFu6/NO/U/YJ8b
	8BkjuPI5ZMxpZ+iNlcu+hRWgYKPLRBAgtqUdoEiIgmJtQNabuOMzQcZeE2ZclRxI
	9OfcW4lLQeBoX+lvq8mDmi+z3rjfF9tTbM/hq/MDyfYRZp1BL8mBolaH2uZXK6mg
	e80Rreu1qOhOQ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PxXNX
	QhlWE76TxbccQPB852zciVhhEeSOPvt0/FHCy0=; b=l9JfvTh1OngqiB1Nz6sGA
	0I6z3jeLIDTI+Tv8VV7e5MB72ae6AcuXNC79rDwomoCCsPQGVGlJM7K3m5888Gjk
	l4NUuBFKKQDdTSWn6XFxLFr5eObqVeVEhM9uG7qfC/fyxPh/ToOmJ6TmQ+rRiph8
	j8+H5r17CoyhSJQifXfWmKiBWCfXey12AMJ6dxYxFztaLzvqnDjhRAHQCS7C8y/f
	RfHK8UBl74HzqSsfffjX9r5XNn1zwGo46oIwytYHXQFixo3xktCGVZPhBI2CBb2Z
	jn0uaQi7+pmzwUhKJTGcIti4II3QS0jaDsNTTuf5D+drCKjeFN+kdC25rwqF86t/
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j56d6h3sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:47:26 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6AOBlPK3045159
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Nov 2026 06:47:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 24 Nov
 2026 06:47:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 24 Nov 2026 06:47:24 -0500
Received: from arch.ad.analog.com ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AOBlEM5028793;
	Tue, 24 Nov 2026 06:47:17 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<michael.hennerich@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        David
 Lechner <dlechner@baylibre.com>, <linux-pwm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Date: Tue, 24 Nov 2026 13:47:13 +0200
Message-ID: <20261124114714.611570-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <awVki6lC3SxGfqSl@monoceros>
References:
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NSBTYWx0ZWRfX1WKxs0rT3/xA
 D/Iu9R3YTXXuna8t2tFDdgUIYIieIzhKkDNTTr/xyYxE/aV38a7K94Lxobw8Jp35U91PO+QD8Zh
 HXTd+Xe6FLGk7IQB9DHYbDsOw5S57HC4eYqVb1xVCbyPSEeFL3dPtHGbu08JCMrOQmhphDw3SyB
 ksLZ4mOi5vDXpGs1Ua5+Vfy3aAeC8UFQB5fM92K4MkAnYWKjMs5+da/pUrtj7iGJH5Jb7crGoaB
 iRZa0JLd3wUMfNW7b0tAyNMsrtfq/Uk1H1yiiU5LdKzR0F6t3cxYF8C8pEzI+UvHUS0eai2njyD
 84cQ0AuECBSSCXWJ73glJEuujyr0aX8l960MgTraMhIxttP6aHgsXZGCG682oAISVGbSnai0/w8
 mFXjVSLx/GYqN7bYTcIieCklW20ELy6i8OS8HwKTJD3CmnU3/7cVabZmZ3qJ8yjNX8wy+owO1Xz
 3ASYQKNGWSIg/+xYcbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NSBTYWx0ZWRfX0pZcvygjWJwj
 Y5uOpA72sos1fp5+QS6HU9eVzr3AuVnSHn7/MsRhHcF3eT7GhuGNyfb0leu6tHc63DLDTBjbKSg
 2LR4uMKmmHDVHmFfEQZRAqZsxCWibGqWaHgqVa5tAZT4Fqk4CdkN
X-Authority-Analysis: v=2.4 cv=bv3Zl0ai c=1 sm=1 tr=0 ts=6b05794e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=U3T-FbH1YiWVhoLu_cMA:9
X-Proofpoint-ORIG-GUID: koQIfY1DvMwyQsmmVxbduQjlvXldjlm6
X-Proofpoint-GUID: koQIfY1DvMwyQsmmVxbduQjlvXldjlm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240045

Hi Uwe,

Yes, that works. It is how the gate duty was set before, in ad7625.c, with
DIV_ROUND_UP(NSEC_PER_SEC * pulses, rate), which gives 34 ns for 4 pulses
at 120 MHz. I'd drop the step API (patches 1 and 2) and do the same for the
new parts, but i don't have the clock rate, and without a clocks property
I don't know how I should get it. The PWM core has no way to report it.

Conor, Uwe: is a clocks property on adi,ltc2387 acceptable,?
If not, how should the driver get the rate?

Thanks,
Daniel
