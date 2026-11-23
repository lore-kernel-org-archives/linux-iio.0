Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434849;
	b=rCl+VkjOm2cDgvO8+ZSb7qnQH5E7kQl0Bv31cw0g4KK9rU4LT8prbDlVkOAkgRv11y1s
	 4hnyt7XatlEf7UR+iZIrveRsAf8slX7L0TSIorY36aMneS8RpHRCo9XROkQy/Hv/gJeN7
	 XypyqGoxw6i4XDV019k4JrJz7g8aHEFL7xvCXUbJU6L4zqnhlfTP7qg65W29kX9L9oIWi
	 4GsFlaLeU97VTaVoie5a9CV6AkKihuL+phIutY7p9DU2hru69Eu1oK4PdctKxX30SEhDQ
	 B8/NxGGiBs+BmhrPRBeqilDFh0/nZujG+qa5o3zhCWuLmrAJfRd5my/M9GeUnUFl5Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434849;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cedkFQJ2zx9OoH69W4XimXIkNVKsnwy5H9O/ZQ2+5cI=;
	b=3O6mvRS1VwCh1EtgwLtxVb02YRK1NHBnE8yr62xBfqS70TfyomrmKdzQuMEdQSrMBD3U
	 6txZqiCW96M49Ntbze1XtFgC8MGkbVX7sRHHqR+NPMEvyEhum8v0yc3vBzkyl5xnU0mbE
	 TEjDq/hqJOFy4tNJF3/HkF/OfQ/0pWSo76lOZ5YC0Hy0/kX+JA3tR4G4QmvcTz/HlcQ3r
	 MOlJ0n/E09hAJl/eXBo5rh00yIA3p82Sg/iAco3h4/j9sgzB+q63DzHCUwFfSmqRNssUR
	 q3TaM/qa9iK+vFcXgYLyFKmS8ydvjunW9tpHz5usm6oQQlHIJwEyt4iBwxiwpJR7wzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ZZhurIpY;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="u79/PYwC";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA4606A31E;
	Mon, 23 Nov 2026 11:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93BA4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ZZhurIpY;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=u79/PYwC
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9HbrK260835;
	Mon, 23 Nov 2026 06:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=cedkFQJ2zx9OoH69W4XimXIkNVKsnwy5H9O/ZQ2+5cI=; b=ZZhurIp
	YEJ0hocKZzh99kjeVNauUgONrn2fvH04JZooep70a1KZsDBMQITBsUITUcX2uKbk
	w/iBHQORAZzGw2Eu1i4cVNbJs74WErwVn1oYiu2jyOgNypCLrf9GayHpcJJlgBvN
	MI40we2PhspEv40Wyour1feYNnK9fdDHccNlPpHcUdMXv1pk5x82M6lvSuL+VBsb
	AcSkA3VlCHEwu6MpnaornhGjEVNKkTQOrZOgQtYPmpEzF8buNOuGFM6XdFxpPG8V
	0z37lDCoALGu1Zz1l7Qru3Je8vcAaC58fESkxbSVY7xxhQfNNpfHwrh2IIgySang
	MI4E87VxmwalR7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cedkF
	QJ2zx9OoH69W4XimXIkNVKsnwy5H9O/ZQ2+5cI=; b=u79/PYwCa3RZiHZgNkPmc
	3GgBCmFwTTzCEfX1RMoQAO0rw6tXURz4tYEJWdwk4icDLUpo0S8GCWytbBmrEksY
	6owgiFIOmxItUUMSrXCXlqoPg1mkbD1I/11TXGpjfFH6gVPEHXo0MKypapOwn6Na
	ouesYkLwpoX5ZaJwIquYhv9QYbcxOc1y9gUcs/eY4SyTWzt1XgbRqD2OSUqidmVr
	Vvs7wIveWHo0AYCZbx1aDW/vTx6y6w+/30PzKEGeaGwboIAudCM+pvxg6av/rokc
	4JEU/tYYXSCSs4RztphRTI+41U81SbunefGukIrQ8gw3D8bJtzuZYnMuYUIU8nyR
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j3wgm5w5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 06:53:59 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6ANBrwec026112
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Nov 2026 06:53:58 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 06:53:57 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 06:53:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 23 Nov 2026 06:53:57 -0500
Received: from arch.ad.analog.com ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6ANBrkb1014981;
	Mon, 23 Nov 2026 06:53:48 -0500
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
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Mon, 23 Nov 2026 13:53:46 +0200
Message-ID: <20261123115346.33745-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121234834.2f6cc9bf@jic23-hlaptop>
References: <20261121234834.2f6cc9bf@jic23-hlaptop>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0NyBTYWx0ZWRfX5Xg0dEbalrxQ
 /wCLt/2gtXBQ5i58LFEE+oVF2CTrWe0sxrhv5ynvVRgZcwVNM6BhyIKnL2uDEgpgRuwyTCHRMZK
 hMWwiunZ3Gyiu2Txad+8DqDNXIapwFgv/DQg0ecf6LG4qstpFo+75xJAUWXWsoNr4g5YiKUsKin
 J3T8HgRWdl5SRy9wbLjucXV8fhDaT+M1dLpIQ+qX0zYb55DgD+CMABHYnlXjgX7xw32+GMGGSDo
 PNopvv3fk9XB0gi9TsjI0AnDxBSGbCo6wqa88ZMnos0dv+WyY1wtRbPQ/XaQTngnFmzhE/f//QK
 i6PRDDmCTxvY/Nhag7CSfg3it/defPp5eKZci2AgLNYiQSnNQM8BUjSVo3kSTyli2jY7mU94Ocw
 VwRGW4M7mZi5lhkILlYpvDGdrklDmGT6oy3bELJoPCDNp/LiCzo3ERCRfhGnoEI+hV+CqlTVSsa
 Vrs239wgjijzwznmdRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0NyBTYWx0ZWRfX+NuFvQ+4L64e
 cjPZNCVpwQMV4dsYxgn/rrUbNCvbGTJTm5u9DeSc7bgl7dr2lrox3XNMQb+cED16ZiezEzGK47z
 XdtU/K6kWZ5hxceclwoOnogGtCq/UuPYerQf9IODpXjTt1IYE8Ad
X-Authority-Analysis: v=2.4 cv=FeGiV5+6 c=1 sm=1 tr=0 ts=6b042957 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=kzxX2B-xVtcOn5nVaEcA:9
X-Proofpoint-ORIG-GUID: 1zjBW-m5To-4VQ0lxCQTyiqiXPQsbSG8
X-Proofpoint-GUID: 1zjBW-m5To-4VQ0lxCQTyiqiXPQsbSG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230047

> > +	/* VS- of the ADAQ modules is left out if it is tied to ground. */
> > +	ret = devm_regulator_get_enable_optional(dev, "vs-n");
> Does it hurt to just a non optional call here?

regulator_get() prints "supply vs-n not found, using dummy regulator" at
dev_warn() level. That would show on every probe if VS- is tied to ground.
I'd keep the optional call so that case stays quiet, unless you prefer the
warning.

Thanks,
Daniel
