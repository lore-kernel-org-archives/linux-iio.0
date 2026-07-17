Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8712352C4E
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784332216; cv=none; b=iWKiy0b34zeR3EE5ykdfdc1mcFSf5e1J2m1wBN9/OVLtgf1/faqRouUS9QqIEoPv2dBPExfqX5bc7OQ1nxHKRYcmvFQq5jAuQt+E1dvr4YQxIKg1DzbAFwU/4L7vX0H2JFmuG86teOSKfqwwZVbdhIv4M1CawI7o+Bb8Ry5sGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784332216; c=relaxed/simple;
	bh=33V8cq/BGKv37Mhviu9kCfjfR5ZQ8Fj4k7mX7rHq3tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTZ9ZYjQpUXsWEKnl7HYwlfLlG+9/0M65sqnwmrLaK7zOCeg/E21WuykburUmyZhFTqhRjGm4zEhRUl8a1krTTb/mWxbbXxGomi4+KtPxHdp/nr5HguNKmOdTvMIztJstDOVHAMU16Lvof7hEXy2Z8c8AjVzD4g1PnSxhKMHX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SuQTKuw0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MResrnqz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SuQTKuw0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MResrnqz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNELHb3023734
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GI0G6fviO4/XaaAPhfbl+CsWRkJWwUodGeivNieijC0=; b=SuQTKuw07h04rJYJ
	ktwyjQUzrEJIe/0qj6iOtSEm91BEn6UiSXiQp+s8IA9W+H0Px3JPvONbFzvqJYsZ
	f6R8lp2DTWftf44kIPuPlq8BjGxw81juUmViICmM2Sf/uVfINyrzoCgwn4itoK71
	e/P9jyELR6nOFK5qbVOR8Cm1mTYb0P6iU+BGROjlyG4Dsw2xQWR7uPbuLB14ZLn7
	CEaTBbH7RcQXPGxZHxZfcE/L7qr4UYVos4dtW3oUqiM7IZ7yxnQc3RHxjB4/Kw0O
	QPqdMet6ZNzdCvpdcxZw4Y5pM4GDSjRekA22h31OcXNJnhCihP/PBktYyTMoKDXC
	xvPnSA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrp8s8j4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:50:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84854c2f888so15089626b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 16:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784332214; x=1784937014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GI0G6fviO4/XaaAPhfbl+CsWRkJWwUodGeivNieijC0=;
        b=MResrnqzD9c2zHekZu4wjEKMOCcMXYkShAk4G0FShtq52z3Ls4gwIabpe8b1cBOcRt
         m7FtHclAEZmS4IhF0vMKuvJ5x2UR8rQk71a/JcKy06U1slTlUVbK9l4+QaeAYXNrUvVK
         msXgfnamUl7zmrU9vAN9YldOixBf6BX6VtCkt5SgnRdCfp/9N6ENgq3nrUu77Rd3ekQL
         e/m4nnwuN1t5ykawhxRVJHRRHpEL0jaeVakHdUKlCWN9jeWzfbRFmy1N5vomaTcNElUo
         AvNnpy6PaPmyNHQHNKHph6OnCRqbPoiJttHCX9+8HZD0s20KMLk1ii9pB84RRKFj0lIL
         8WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784332214; x=1784937014;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GI0G6fviO4/XaaAPhfbl+CsWRkJWwUodGeivNieijC0=;
        b=KjTDPi8FaPC2RFmbxRk8E1gcu1UP49by7lRzHkhB0I3rB8E4EEh8AA536S8o3Xc27f
         +0E56YaJ5XCWuEcYx8pylcdK3RDHNRuh6OTX8Ft15Z9G+lonhw/3NeugHEaEqPEJzgS6
         D/KWsks+5V0uLWbVKebK+ihXZpd0ygJ6ukw2NboLa7M/ougBsnsRGh2yPfNMdpVvkYZM
         jJRIbi+ltKfd+XdCdABe1L2X3vtqU8nd9aACiuiQo1ID5737WNcSOoAQNEJe0Rl1iNkl
         tv146EdPblgUs8UyUPjFxrDSw9OqeyJ92MSfM/+vfDrkn+2WFPr/VftsngRDq8UgMTY+
         tlRw==
X-Gm-Message-State: AOJu0YyUi29mypSWwCoEuIRxLaq11iF788Ue+WwB6kuxks74cMgxslqX
	MbPP15TiUOkpllr5pCVc36cabJi1wUh80F7aHbiii5bqah4lXd8M0t95elJhHgULqOB5TNw1ItT
	dJBAnVyh0JSa8opymtUBMZVee+bizoxSeUdLwNzhirT2SE2Hw2aWZQeChBxIH4U8=
X-Gm-Gg: AfdE7clanIbVKl3upsSRejCp3BRXRRzhvhPni8mJ9RvAlo8EN8Evep5d90d2R/uczeU
	eGCrmG87Lkn9kbziuETkMsQszfBbC8gCNxP9odSiArktKoYtsnev46QGBWunN6mo2/SqZTJxZ2U
	hCaUzZaxJXwxfPpi6fYJmUMgJIdm7Vb5J7WNvZXlORF9YyeMndAq1Vd6+6TjMkKzYfPdR7Gkgxl
	ZBOz/bULqhW6V6ejNxYLbOdJNiIz/IgdR4Pl7ba689wlifIP3AQijwtRNz3PjOZvPPD8EjwQH9L
	9SBJQOQZ7eZSA1sAvq0ZnCamWx7fwxGFRXsI0ri41dxze5FRPwZwrOcQ844LRAHcY1PE5wDxbJj
	t9T9AgWxXew13AFj2
X-Received: by 2002:a05:6a00:a20e:b0:84a:2c46:3fe2 with SMTP id d2e1a72fcca58-84c2948b0ebmr5112958b3a.48.1784332213685;
        Fri, 17 Jul 2026 16:50:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:a20e:b0:84a:2c46:3fe2 with SMTP id d2e1a72fcca58-84c2948b0ebmr5112942b3a.48.1784332213219;
        Fri, 17 Jul 2026 16:50:13 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3ebsm1837498b3a.46.2026.07.17.16.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:50:12 -0700 (PDT)
Date: Sat, 18 Jul 2026 00:50:08 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <nuno.sa@analog.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260718005008.5d4779c6@jic23-huawei>
In-Reply-To: <20260717123852.1140893-1-stefan.popa@analog.com>
References: <20260717123852.1140893-1-stefan.popa@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0NSBTYWx0ZWRfX/sDFNrygjOWz
 CzG7wAoaJysW+LMrEDSArj5JhVEi1cikF5XVsMmbWALuJGN5GuD7Cbr0JuT8oOEFcGYINFEYEZt
 5622sK/vu14xsB2xAmn/1EW3nzRYvIM=
X-Proofpoint-ORIG-GUID: GlS6_jgFkFlnNIoYwH5LMPeMKdMIC2Fh
X-Proofpoint-GUID: GlS6_jgFkFlnNIoYwH5LMPeMKdMIC2Fh
X-Authority-Analysis: v=2.4 cv=fMYJG5ae c=1 sm=1 tr=0 ts=6a5abfb6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gAnH3GRIAAAA:8 a=Uc3r_U0CyWEYo97lCO8A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0NSBTYWx0ZWRfX+LGTFeER9PCt
 niQ+Pc29hsuPWfuhaRZ6RWjcXpfRFE1n5ALXVFqNuovDQJZ1mmS4EA4s1fM44DJuC91PIvCBeB1
 TCkWTC+3HK3MaiR6bw17b5Ui3mPS82+TyPDbJJCY138bMAJOLCQudEu8vJEP/0gTA96bfxf2CaL
 ghbNOh/mBm9F1ySfXJHjHooO9DJeQ3sjXXmGPE3fDXPSLqcCDMrwCowuyIPDwOqATUA+0FDLTxE
 XHMjQC2eUnyf8HSyM50gFXJbhM4m/PBhuhUt55I2226SIRh3jUuVBAOQunMqXnAjy386c5VK0yS
 NWn6yHi510Bv/suUJbo9VyzZjhOzxXkXR6S2HhQIWhNuLDumoxqIAf2sOn2bA2tkYHSJoAKH3QQ
 3hBk/GH1dyHWdov7W1KscR9g+GzPqA/c/YGD0lXOWwBDszDUxxfinylNFAYIilGMLbj41xtTDWE
 nysKpxY28rFv8LNMC8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170245

On Fri, 17 Jul 2026 15:38:47 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This series adds support for the Maxim MAX40080, a bidirectional
> current-sense amplifier with an integrated 12-bit ADC and an I2C/SMBus
> interface. It measures the voltage across an external shunt resistor and
> the input bus voltage.
> 
> The driver operates in direct (INDIO_DIRECT_MODE) mode. Each raw read
> triggers a single on-demand conversion (SMBus Quick Command) and reads
> back the matched current/voltage pair, so results are always fresh. It
> exposes the current and voltage channels with raw and scale attributes,
> a configurable oversampling (digital averaging) ratio, and PEC-protected
> register access. The two selectable current-sense ranges are exposed
> through scale/scale_available; the current scale is derived from the
> shunt-resistor-micro-ohms device-tree property.
> 
> Tested on hardware with four MAX40080 devices on an I2C bus.
> 
> Regarding regmap: it does not support SMBus PEC or Quick Command, both of
> which are required by this device. The mlx90614 driver uses the same raw
> i2c_smbus approach for similar reasons.

Why IIO rather than hwmon for this driver?  For any part that is involved
in monitoring I'd expect some text on what features etc need IIO.  This
will sample quickly but if you only intend to ever do DIRECT_MODE that
isn't being used.  Also you'd need to support i2c modes above the standard
400kHz one.  If it is remote borderline also +CC Guenter and linux-hwmon

Thanks

Jonathan
