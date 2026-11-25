Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617755;
	b=fg7B+Wj6Xfu89cT4UwaP6v8vOBOziXlAd0BYjTthRYxw/vDrK6D/hxss+oF0p6JOp7mJ
	 EXt2Sd9SaAwPeV5FhpzX7Y7CHCMI1tvGuolwCo9C9cFybwhekZ6uGOWeAQ80WKgaEg4lB
	 RqRYdHwO0cnNlhFjdDI8gmvLkbUsWkp/mSmFEN58Xx7Ni0OUOsb03JTVamoVMU1HI0dvJ
	 VidWMvcQcckUb0cTjHeKWcmZ5tbl1eVfPMJwsnxkqTSMY5sac5CI5y7zjPoGNWXGVAWvH
	 JMMtQPUIs73slDyj0z9LRQrSqCDJCFS0rEvdkAO0q+03mGCRWBKOjFNIo2AEkKTQYSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617755;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=M8apm6+/Anpcv1K/Z8JQmpNWT75T1KYBT9tWUntqgNM=;
	b=rC1qkKDQxkCZSOolIENHsMFw7n+aDHZ1D8DsyStR01u89q5EWeOjruFhjxGi59VTyjNI
	 7YsPMFkAESRz2NX5APsZ5Vv/ik2lrGDhuWj3ocQeG8Z3LNlB4ZJx6+XF3G30D1h7DfUH8
	 leenP4SaM/adretqJCMVDec3La6NEAwWyLIu2kg93UdzDF092SSuxtiPNiHUH2310+X0x
	 IWUWI7zSl7M0V4n4uU+N7GJfdlpHkgF3NCJD2G/I/9FEXAs0LyLM2egsw6cyTdEK3Srnx
	 12wN96Ubi1xY6wPpQVE83t7hpABSkYhojWcufJueYW+jFNkvOc/DBoVp+h5BH0gpSIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GXq3d4LR;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="I0b/4nGk";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11267606A31E;
	Wed, 25 Nov 2026 14:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11267606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GXq3d4LR;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=I0b/4nGk
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEKKNW473283;
	Wed, 25 Nov 2026 09:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=M8apm6+/Anpcv1K/Z8JQmpNWT75T1KYBT9tWUntqgNM=; b=GXq3d4L
	RU2ls2DNi8OUlefODnfdNzjWmfV3BjR7BOk/yuufxqFOQ95FXUd1bw89f48qTLSa
	yEScg3M06vEav9N0A5pZbrj7pcqBUABYgyi7dO1EkHUomRRgHk3OqphBark/8C6c
	6NjZyZ0DVuxKPet1qy3yuJi/A3h9jTJqNIjwJcxh9FWcs+yQ+/dB+S+ZO66ESI8N
	MeKP2uJVIzcg4ZpLUfnE1JY0Jy/GfYgr8kqadPIeXmjWRYS7Y5ke+z5rjvwBaiH2
	IacVgeUL0Q57Ej0lBpebkeoe3Bbssrk79Jl/LrKGhVD7LigLtuC9Jw/+z206ecvx
	NS7bNb/HtlNgGjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=M8apm
	6+/Anpcv1K/Z8JQmpNWT75T1KYBT9tWUntqgNM=; b=I0b/4nGkAYaq8qxZVhkTl
	zG2bsKafZnTBkTBToHPbM655AdwJj9t8VW8vF7X1X5ccDJEN+vNRaSPQoC7OgPHo
	cWgUSm2CwXYegnINWmZ9ap64bYy0IeUxG8/T9yJnNZO+LZXgNSqzC5Kt34UsuWgu
	13An0zJ7p5sfa+HTYJ8q6arpPBO57DfhaXJnHkJ2/fOokpgug43H0B1NLdTFrkwM
	KBotKhlBAPLDG6evCejyYY4Ho9K0QgWUbdtv9KMWnARcw7t20rZ6VgPb8Tt1mN27
	Za9vGFVIgSHLC8db0PI72Cw34Tl3UNv8wCXOMlSwiErAd+wLSdekLIhLErhTbX4x
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j56d6rrg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:42:23 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6APEgMew055415
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Nov 2026 09:42:22 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 09:42:22 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 09:42:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 25 Nov 2026 09:42:22 -0500
Received: from arch.ad.analog.com ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6APEgBDa006155;
	Wed, 25 Nov 2026 09:42:14 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        "Jonathan
 Cameron" <jic23@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        David Lechner <dlechner@baylibre.com>, <linux-pwm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Date: Wed, 25 Nov 2026 16:42:11 +0200
Message-ID: <20261125144211.78018-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124-bath-runaround-dccb788f14e3@spud>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX3i1Z3bVKtcU5
 CnU7Nclodif1utEt10Mn9JYE4hp9LTLZS2sLqK/bkw3oxEfQpnuxTqySyKrAynmSdd7YkGVnATA
 RC3dy3S5GFWlAoG1KNKu7NtZlCzdgJYUAupTkQZnWRSeba79hZYEIQKfAZxkQwEbuAdM+o26StX
 RPuXraiYKMzdldq+lewqAMcpm2L0s8lthrZuAvR7gN9rDPBYf+oktqrHi2loA5LGr8QwIam81gD
 f0HwJRE7VRxSKyaRXI4fHOjGNCrqcSg+kId4VEMZ9GlFcqCOe5Bj0xeH6XIbtyKBGgmK3Tm9fy0
 hWl/TvMjVTyqtppW6gj00I4GPlG5HTlgFka4Tcod/akcnTN2DCxd7r/KybvAW4zhXOofFVfUhW7
 nPl09lezEDn5zEaV2evJUnhyMbozmK0MwxtTuB5MuHz8EuV6mCWSQR6BI/hqyEzZhABUmCl720X
 ttfzE9+23eBo1UtPEwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfXwxV7eO3pH5BV
 XGG66esWolKB7dXINt5CfVrGlEiVOCH71Pd8cCrKpgpZjJlSn1j6UQc6aT1JudWvKcSYlQ2hOjj
 jElDyl8+oxGITWzn9D7fxGAvfbR5ZaaLapxieDx3gghJia3DmXWF
X-Authority-Analysis: v=2.4 cv=bv3Zl0ai c=1 sm=1 tr=0 ts=6b06f3d0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VqRfdDP1wFJwDKpUaI8A:9
X-Proofpoint-ORIG-GUID: Rok7vR_z2ZMCIFsgvFZGwmLQkCpl7igC
X-Proofpoint-GUID: Rok7vR_z2ZMCIFsgvFZGwmLQkCpl7igC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250058

Hi Conor,

On Tue, Nov 24, 2026 at 06:34:13PM +0000, Conor Dooley wrote:
> Using the pwm generator input clock in this way is also inherently tied
> to one implementation, since assumes a particular relationship between
> input clock and output waveforms. Were a different pwm generator to be
> used that had a /2 divider between input and output to be used, the
> logic here would break?

Yes it would, I'll look into whether that burst can be generated
in the FPGA from the CNV signal instead. If it can, Linux would only
program CNV, the ADC node would not need a clock or a second PWM, so we
can drop the step API while avoiding the clocks property.

Thanks,
Daniel
