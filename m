Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233244;
	b=1VkT6tdEzwtJlbib2aPPMdeO/NvLtEmRUPPHm2rMwPoFb0HJHCCdtAE0K1BOwgcVPh/Y
	 S4LLEEnA3l2q3G5N8+qGJPe0duLHskquRfzfJv9/de7CWqwYpaEFYqhnusOjv8lX/V1RA
	 sqSkLs2QQMvmlvb3dPNJdCWfcNrSsMO3xCLNXkktpjx1iejYSUYH43A/9PsJfUA9KUuQO
	 zCMgmWU7240yH6mBEjrGCuN7xARbqle3x2okC+mX0c92T2tFiGm5L5dNIwZ0PjbtwtCuy
	 ghi7aWXFlcRl8PwQ2TPMGUJULy20nUAouwYh7SGQ79ATlX+zCjFgdgVUJ6H2jWwlv/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233244;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sZ54VIWwPTffonIw/b3Aj+oD25UfGrjKXoh7WL+7pUU=;
	b=1FnO1hxXAGRCALxCWhQ500WNG7ZO3j3vyamVYYxflGAQE2cMdrCq6s18fmdVagxF+E2x
	 uSrQAUPSUHvVuedzH1fDAz3iu0sCqsuQ0xKzEbjNQCT/RBojWwJCLoN06zuqm+E0nSlhb
	 WUE6e0B241eyidY7YoTXxnOCpHnhvcynlGcA8caIgkGnU9l0N7IRsxoQVejVvCOt+i3MF
	 GzB3I5f8G6eMzAWla8NQTNyC2yEatnX1CWPb6ZQiVWY/MEFakh6fsF6ArUMqfODHd5wL8
	 i4g+8GrIOk4g1lHnNeKmL676iETKAPjacEIAOg4IEQ3oPUXrDDlEL9lxn/VG9+8GcBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BsDLVWa+;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="xBK//R12";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8742F606A31C;
	Mon,  9 Nov 2026 14:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8742F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BsDLVWa+;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xBK//R12
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DHM1s1279825;
	Mon, 9 Nov 2026 09:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=sZ54VIWwPTffonIw/b3Aj+oD25UfGrjKXoh7WL+7pUU=; b=BsDLVWa
	+osjWEGoW27Dg/dCowBsQhK1x1kIzrjwi/lkZNx6Nep7CnMcf4pJI3mhPXW9fuos
	gSDsfBDiW69ms5dzpgIWLyAsPgwNotUqqEpuTicJBImbIBd/lj4V5uQH1nLMlOS9
	lMnsP5ub0F6/mcfkmuFf0wjanVRzyLqGu28fqFSsA8iMt5eo70gprICAC8Pf4UPZ
	1l0x1RbO1TbvQ0Hj/a/3NpZbtIJHGA5VGoEVUUkL1yK9OcMdVUI2amgHqapMjSNe
	1b0GBSG5zE3Lk720r/fyKOX5vrcrQICh3SkNQZkfry3z9B7L5d3CfYgGNs1R2KsX
	AwnNgmJbNFzGV2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sZ54V
	IWwPTffonIw/b3Aj+oD25UfGrjKXoh7WL+7pUU=; b=xBK//R12bQeDQgDXfpl5d
	DHS899wfSbz6+sCH0BBWZNToLXE7mBMw+aL/AfgR2JzQ4jl/m+hz7AetfuAvLHX5
	VbshlrdqL9g4DOEa7dsIlNq6g6XLBhK0oyhy4OQoyDrkqaUCn66HzwjxTC3Iaf3t
	3yve4iVu5MPD/liQ5nzbRKarLFBIfpeswmIPefZFiO1lpMGqALcCI/JZli1qy8mM
	g5zY5JnT/OaEfsJrlKvSiuhOVNv1Gf6q7fc27w8ym8Z4qB4jfeahkhiCrOiphljA
	kkT4aH9k5W0wELvZfG24ZvZqxIrl4zPJILeHzpy/l39ckmnottLsGmcc5m8KJW0/
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hucbv1kh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 09:07:20 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A9E7JYH019020
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 09:07:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 09:07:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 09:07:19 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A9E77SP024964;
	Mon, 9 Nov 2026 09:07:10 -0500
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iio: adc: ad7625: fix sampling frequency handling
Date: Mon, 9 Nov 2026 16:06:49 +0200
Message-ID: <20261109140649.36565-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107015008.45a94af6@jic23-hlaptop>
References: <20261107015008.45a94af6@jic23-hlaptop>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfXw18yDv+U2fmG
 EcfqI8mcMQA3ahU93eqkEofEPiZTw8FIYZHYml1uNlIbzQ8+qWzZ9OytBkGZNdhbWNWQG0pH6rq
 qb8v99FRuykq42UUWFMdVgN7JdjY2/v45E5LhQQ/QI6c8KOJ/VDuxpSSMLArfMbGXiZZx5ydPwN
 U6U4Rw0p6WlOr2Hhpju92wsrEe2L0dEaejoM2Q3b6y5rX8GlU57a+abpu+/nyMv2FX7fir8Sarf
 lybllFyTOwnnHB7KP97s9qn7Q6yIu4Wm0YjY8kY+QpJESJKlry69Sg9uU1QdSkwKhzLRiYqwAI9
 67ns0E1LXi901RY7t+BwTMm4Lshj4nDKXcwfF/cN4BRFd/i+31yTi1XJNDKFQBGpLZqNtQyu73i
 vCbs9RnQ0ILKBqaeBYaFw1eVDUa57d0NGX63bManJIehWYtf46zfgamoinaEf66tSNwLcwPsdoy
 1z223y61rvCXBwu3YRw==
X-Authority-Analysis: v=2.4 cv=L9aI0OT8 c=1 sm=1 tr=0 ts=6af1d398 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=93yvAsL4Z3ADVUGlgg0A:9
X-Proofpoint-ORIG-GUID: 5oezVQw_SI066wnlEmSU9Na0Dpm1_4_P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfXy3Os9Px7y8Sz
 5kkJNyl6VL4BLXDAHBsQPyEoUrsYd2ab80YrbZWWKWi94iMchnpb5bqJ26Gm5HuqNfXCNA4NRWd
 Og2b79Xu0YnIKo2VVa5oF8nF3I/AdsObGQ/XxbzaPkHFry8sZqy5
X-Proofpoint-GUID: 5oezVQw_SI066wnlEmSU9Na0Dpm1_4_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090056

Hi Jonathan,

On Sat, 7 Nov 2026 01:50:08 +0000, Jonathan Cameron wrote:
>
> > Fix sampling frequency handling issues:
> > - Fix issue where writing 0 to sampling_frequency caused a division by
> >   zero. Return -EINVAL.
> > - Fix issue where a waveform rounded up by the PWM went unreported.
> >   pwm_round_waveform_might_sleep() returns 1 in that case and
> >   ad7625_set_sampling_freq() passed it on, so the sampling_frequency write
> >   returned 1 and the new waveforms were dropped. Return -EINVAL.
> > - Fix issue where probe() continued after failing to set the initial
> >   sampling frequency. The dev_err_probe() result was not returned, leaving
> >   the PWMs unconfigured. Return the error.
> > Fixes: b7ffd0fa65e9 ("iio: adc: ad7625: add driver")
> > Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
>
> These are all clearly bad.  Are they affecting known boards
> out there?  I'm wondering whether to try and take this ahead
> of the rest of the series. For now I'm assuming it can wait

No reports from boards. I found them while working on this driver, so
it can wait for the series.

Thanks,
Daniel
