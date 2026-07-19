Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDB37F725
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784504366; cv=none; b=iWX6NaO/V7BxHlrMU9/CfliDLvmV36UJO8v63+ZSzZVzWZpDmJyknmHmAaswIExBR+N9UrI4N89LRAXq2xDB9zMQp7Dx/LIkVQyFvAuSuY+GmuVzmHyPOVqz18YXO7atWVazBSo5s95qQD3nf2Ej2PCe9llt8d5l0Jd12tyHSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784504366; c=relaxed/simple;
	bh=8w4crvEmjR3oM8bLzNIS95cjBAOb3yWExJaES3mlcfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp+lGQvawqRuexNT/1A51rtOln/NzNP3N5FBedSRVypDtCoCkHFDLiw3R56YqrFVNg/stEQubf133NddRtVPDF/RUglcrJLP/Q1clJeoBsqSNT9bdT/lRPcG5B8yW4YkdMF1nEyL2kP8PVti4YlDETsZi7hxZjes6THyg5vhCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pe+6Ratl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eOV60XTI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pe+6Ratl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eOV60XTI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKQsMB379352
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lbG5223pAlCmJ0cHKAs6HSKraEFHrYbRDxsvzBFwDFQ=; b=pe+6RatlWfEbvNvC
	beBUvZYqbWgpf1RZxllZWpyQdYQjekX3/2dcpFjD1emq1/l42k44OubN2+Dn3c4F
	bG+qKvv1C5pXRu/z+mzPiBf02lOT2GQPOCWNBrMmaZNSGeZNGv9dLRIPZzjNCTmC
	jHwHFjNrc07Bhlz6Q+5af3RrFEnKwadFRsPZw8RbcotTljd67jnni7Tv8n/T0chl
	GMcNNn8Mh0JTYnaad5Qu2vRwMte4rV6XiR7FF15j66SJgu29BINB2U58tpFQ4+OG
	HkpTU6lk9S8FNlffGJA+FIVzi+0G10Em18oObBqdVQMZTslsrNtw7NG0FQ+oVMYK
	fQR0dA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04tnba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:39:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc88e22f92so205944635ad.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784504363; x=1785109163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lbG5223pAlCmJ0cHKAs6HSKraEFHrYbRDxsvzBFwDFQ=;
        b=eOV60XTIJHpNLm/ZFZJaSGt2ssCVi0eze/sH/qJtNN7wpNHrTvRC0UOyi9xBURjkGl
         s0C322luYEsvVTUzx8h12b+hFIINhasFt+/q+A37Ak/VfdndeaIGEf4fzs36edY3XcPb
         kuwmDajNHf3aPdsrSgqkrZDgqEY+t+1zicYWYLgc/Hz/b0Aeo1Uy2MGn0CuZPbr9sbMY
         BBH1YSgGXOJ1KVQiOkkLDuHTQMwiSJmhxw3CaQ7TiaaKC35xPLpXf7wuyqOWUvKo0gN7
         L1SEh9C8k2lzcR9ZCgUz4TwwFwOT3j+4BJy6npVUY17jQQ7XXV0h74FSyU0uSuCZf4vU
         dKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784504363; x=1785109163;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbG5223pAlCmJ0cHKAs6HSKraEFHrYbRDxsvzBFwDFQ=;
        b=L/op5/nMPbcGphLgJU5roaFjhC1LnL6dub9YZVBI7okKIuuR0v+fsIKeYZ6T7vJZ2d
         gVcMDU6xJrNjFqzKiJWpGYl1Z5TbcDE9DLB2Ar+psKyiDXDl3r3dbzvL7IN/r20IpfzV
         xgHJNNiApNvqB3bORQP3QzJz1bhzFgxXlrDKDIDZArbPOBaQo7cSCEFSbkVYGbt6Aqun
         PP3V5H++7IXyH4LnQk4QkRjBr3K1WqizPeKrAsYAIOFhfZ9+PSsGhqHBK+lgKdlDnUjW
         dabfR88qSRY7awaleiFtO2btkzE3LdWeIrOzm2a3R/doNKhURMmGHjTaten+ZjCEJLt5
         LsIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdNZpC53dKspbhKtLABITSEq1DHsfkOVvHrJcBcK0tLCzm9HSEkTDpOCqlIDcv6EAQl5K33NahKHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztH3ErRlvL1h70mMnPlExxCWkTL8I8RJV4w7Kg9FuV9EOmfm0i
	PRtIhgtrwHD/6IiCcHSaW98XaN+D9sWxZgDuWAarPb3Tacxxg1Pu0sSXIT7ZhJ1BQlgovewUH/+
	sVqHBRCalSdAO4buLZzwAgdPvxni8kUTU9R07LSUsqkIZOZEavexMirO9fR9zSDM=
X-Gm-Gg: AfdE7ckDD6rqPCvOP/YXaapzN+K6peA39n9TCUhJ1pG0hUGwZHVkgseM5kTiafxT4Xv
	p0XAWdbBdknmoplyjilInSiMds5FrR48RhsicMeaqTfaXDlUBL7+gLseHg4LiIH6Jeu7X5UbtF+
	Eryjw2nzIqt/DD+WSY4aDE1tGtMvumlo3AddJgKJDLI79/MGRIFsvdxLHoT8qbHVtVwWNvV9n0C
	p/pN99sJp6Jvmk232djBDzQt34lq1TTug94PMKaoaWO9bwBt/MjvaQYjmDLxCTDcC/Sx6Ln3zJj
	0sf0ZIVlnOQFWA/9/+u8BKrGq0fi3TcnjlO8V8x2SphxvhLbq3QARs17HvuSbNFIkjbLzR+wgdy
	dXJgcfbsezzdUGJ1Y
X-Received: by 2002:a17:903:244f:b0:2c8:2808:3ec4 with SMTP id d9443c01a7336-2cf3497ab8emr123925455ad.24.1784504362795;
        Sun, 19 Jul 2026 16:39:22 -0700 (PDT)
X-Received: by 2002:a17:903:244f:b0:2c8:2808:3ec4 with SMTP id d9443c01a7336-2cf3497ab8emr123925255ad.24.1784504362378;
        Sun, 19 Jul 2026 16:39:22 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f12e0sm45849815ad.31.2026.07.19.16.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 16:39:21 -0700 (PDT)
Date: Mon, 20 Jul 2026 00:39:16 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>,
        Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>,
        Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 5/8] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260720003916.0e4eea01@jic23-huawei>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-5-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
	<20260714-iio-adc-ti-ads122c14-v4-5-25f8e3084485@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5d602b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=IpJZQVW2AAAA:8 a=Unddr-AOr8soC30lnCYA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI2NSBTYWx0ZWRfX2x0J2Tiib+GL
 DQQaWnha/oMKBdc5SS/cH9eMhS5IBQS9nLeOBmhVpWFIhNjjQqeZ4FicIRbGC3zad5S8RcYYWH2
 JxU5SF/brcID+ah1HurxsOeXjfnTDteKWhI5hzV/Vq0bvTMXYJh+m4g0skTFidDA1uXrz26Qwsb
 qakpclty3FoKLNy4M4NutlnC02gLNJ/0bZPuwxftzbjz2hUhJxFfS9lSHg1LDYSrcTBHxqdd4xo
 KMUh6wjAo+O3IRYZcSKLncsY7jbBMfDuz1b/duNUMs9S8vafxmqXzQ3gvaZcWnumXJcHm/nVv1F
 mwom76410lbJz4vsCRigJCop+6jjKPyG9xNEtCl3piGtOF+GJC5JOw9/SyJ1jfLUbbKVejq+Opf
 NPsJRKi1HZMNEXR9tBxmNKHVP6LJiwjx1FwHFQhdweUhGOZfJKk0gboSaw5Z93tvXZrb07V2ceH
 NYXhrCIZegxuJX33IEA==
X-Proofpoint-ORIG-GUID: FV-D-6wUllnIlkEjijEm8B748L21K9f4
X-Proofpoint-GUID: FV-D-6wUllnIlkEjijEm8B748L21K9f4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI2NSBTYWx0ZWRfXx+ofIdLjAIHY
 1j2dY+c7cTzCodPSauhNI4Dr9Pk9OUw4IOaVTKSmEyST0iTnOmA/iFfv7N1ubl0auLW+d4cV4u/
 lGDrWY0hxU2mjRZdYgh51MqElNCBtZ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190265

On Tue, 14 Jul 2026 18:21:27 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add new bindings for ti,ads122c14 and similar devices.
Given the binding is named ti,ads112c4 better to use that here and
in the patch title. 

This briefly confused me when I was looking for the file to apply the
fix you called out.

Jonathan
