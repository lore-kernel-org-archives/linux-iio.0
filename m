Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711B171CD
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317669; cv=none; b=eZ8HKCvMg7OP1gmVyAdhj3Xl/w9+xHj42btQbXcpl1kfPy1sZAKtluufratUd4cgCv09kxValprhLUg1YpwlwrmvJ6YqNWJVgI+e5ir097OAZv5DPev1uZROOtWZQThdVXNCxgVwW+fUFS2A59t8xgTuVIp7AO2Pkv90SoXKsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317669; c=relaxed/simple;
	bh=SodNyyc/QGixhPijgTyGlY58ow1pnTNxCJCZJPPg7g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntXK/y4XtrBTJUpKFZhk+PWh1TmMFkBrD+qwXwI5iZ5/rWdaRfmVFgmUKxlSuDSyx9hgmVoXO5JpBYL6wSUlNKpnzDc6wlbwU+6OcpdoqOPepMNMrNbsQOWK5uyEkbVXW9Y2WsotwV/ez+7viRpTNM1gNC6mwMpEAU43zEyLfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SV44sDAt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YAIQP7Yb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SV44sDAt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YAIQP7Yb"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641ZNq3614034
	for <linux-iio@vger.kernel.org>; Mon, 6 Jul 2026 06:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c80CyQ1ai9kFfoffrUa4oghZEtD+aE9oTf/NVYfyV4c=; b=SV44sDAtjAwD9aon
	Ol0mlcADZu4Lgs+ip72IDnJIRipFqjTribvpMYCpmyoi2WE3t1hz8twx7B4d3kWI
	bWghFvHL1LLyhuhGxdo5Lm93/W1l1qBHdeYEsdCpRRBHEVUUahD/bj2gWxFW/f49
	B6xtnGTCSPO0EgC0IBZT0PTTGHRMAmqq7hJXiBa04VqovofPmbS/wed42OzaCtYB
	CDbJK3Jo3NRG35Ri2FUBwpRzE7MqaI1Sljo8U3/cm1y7e/CtiCOpdk40QcTbUx+P
	MpV8stzv7nTRDNBprkLafQRdj/dZLbA4YmZbqhW0X00QOh4MqksyspintPNm4oBt
	S9yXQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvmnnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 06:01:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e8004d60eso429604785a.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 23:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783317667; x=1783922467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c80CyQ1ai9kFfoffrUa4oghZEtD+aE9oTf/NVYfyV4c=;
        b=YAIQP7YbiF4MV1s/IktsaIsdk/s7Q20ye8aIooaWkucjw9ns542gqihNZYrz6rxo7G
         QJebhRfwCmtKELq61zOMFPAHmNytkzyVZaENj83lOK1izM+5NLOC0pOuvHCFwmdImQQm
         2C0kozYTKVVGoy7d2cvsIPl0x6Q/csi+Lv6U/+CSc3VRbL8R1GT5URuO6PY9KNJ0Ycod
         62AMp6CPqiDQU4VTJJOqaDimlKqxhcK62ag7GO8xZUxrXa/r/0jb65UV46IPQYltWjon
         uitQh9CHeZFGeUxF7X4c6+5RFkG0el8bVUt45BYnza/wlVRTN5D+40KK0OPUqZ2B8SSo
         keVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783317667; x=1783922467;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c80CyQ1ai9kFfoffrUa4oghZEtD+aE9oTf/NVYfyV4c=;
        b=OYuuhjFrqa/nP9CLwNmFNpGX8TzdypkHPJwAHMcKlXyppJr3iXdEqeUAFQk1EebZli
         Y8bNPdgE1k8DbdVY2kB755cOQco4noqmjBfPbEFznY10NVpkHYuWhCwSfGcxD1KjCBPd
         kqTBAQXIoexR5R3MbffR6EjjBgFa5R5sMx//rpzI6K6jxk5tQgnm3U+Yx4Pz43uV7Urm
         puvhtVseX+i8kgVeOHf2bhXrWTrlnW/yiNTAgacr0fkbHDMuyO7abBUIcsn2Rb0eij2u
         kzFXA/MrEd+zK+HeTbP07oSnOy3rUvHDhKE7QWEFbFItKv5ev3etiXUsoxHcVTfBsxJ9
         7yNA==
X-Forwarded-Encrypted: i=1; AHgh+RpAtXMe2aYzpJXqLx/6uhaNSnuldiamKLSxeXVoG1iX+Y/FVzOF+wtr7bd5tsAWGQFC2fo6kDc54nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5dtyapmLSujbwQdqQHchS53ytGXIgnY2tCHxTMUmUdOVmcEH
	y/eX6jgbrVwwOzo9d5LGGYeoeXtlzhmd4KJ/oRmUhuQj+uZ4oSHSy8911OCEUUx2BzaTmFqZb5T
	nDGPnwhm3sC0KgEBvsC2T19py92LGSLr9kIwQmLaVsXSL/uOhVH34yePeipBsMoc=
X-Gm-Gg: AfdE7ckATQSpDZV7bKUCosvUPPl7PFOR0DjnG+F8sG/Plz854MIE3KKzy4LYtN+KEyu
	OTvWG1eJ2sJHk8xImYuhr8cx4BjoKmQ+vFKUQA6NFObiBoR3p5Sz89kc1MSd7VLKkED2wk0hB25
	meIKWdx/YUL1q+jPUZYIiMbFUbp7kw8p0TskX34zSCa/ly2zoRtDubhpD0YF6g7LIgdpvc7ij/X
	gAmLtYALVzlSh3e9vUAqeUsTvkflNcZFFbkil1YOA15AbhVwQFychrHNJHXnQqiP9IG8A0H+9X7
	k7ZrtwR4c7LCuPgmxyrzabRiAMyOhN4RtcOEHp1aWzD7NC2dJk29OiDcFQ9S5izwJPp1Wi/vm3C
	knTstOHD9+TyvLJ354UYhZSqHjnR7nnWCBAV8qsS6
X-Received: by 2002:a05:620a:29c1:b0:914:afc1:c66d with SMTP id af79cd13be357-92e9a2f76e3mr1298319685a.11.1783317666530;
        Sun, 05 Jul 2026 23:01:06 -0700 (PDT)
X-Received: by 2002:a05:620a:29c1:b0:914:afc1:c66d with SMTP id af79cd13be357-92e9a2f76e3mr1298315185a.11.1783317665980;
        Sun, 05 Jul 2026 23:01:05 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4a343csm309185715e9.0.2026.07.05.23.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 23:01:05 -0700 (PDT)
Message-ID: <d4f55416-f5db-49b5-96ba-130dc5b901ed@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 08:01:03 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ti-ads131m02: Drop redundant NULL check on
 devm_clk_get_enabled()
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260706003712.753a5870@jic23-huawei>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706003712.753a5870@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4b44a3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vK5tWUMUpN7KhCZact8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: vxfApt8ABIMMFKas956TCW9cWtJZoWnh
X-Proofpoint-GUID: vxfApt8ABIMMFKas956TCW9cWtJZoWnh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA1NiBTYWx0ZWRfX+PAS3rFY4F2v
 s+ORs7q2v31ANdj4L9PozyckNyN8/1y5Y7VGLZwRhgR/FrtnFiMS42GlIa/EcQ2r6HOGi8m7sDW
 sNbooNuA2ZAtQxl+AXn/kyWJY4zks4XEO09zT9I0rsN8cMSLPupYMtMcKbk6btOZDepc5gpl2DY
 uHEovGKULTNCZPIzjE6+eL/Sd6PFIohe0wf4cQR5ts/xZ73ixL2R1lrsrXagcNBpJa62G5PZbzu
 HvG2kmgUbJWPAugSJYy5OmJcalb7b5A7Oepfn/LFo0StjRk3udIXGy9u8JqRhrmLo95qwBZKGkf
 lma8sls7cHsRCUUbOL0JcR4dcS9UPbpx20K38f4stSIksmMr35/dvpHunnPHDTmqXmuBGUDh0i/
 oGcRvIAzMn2JDoJH/F5jVnOqCZNjJz1CaQXbhn8ZVQTHiLPlSwP7nY7aWyCWhP3qRc/H8m/gPB3
 IM/4Zrkjvly8MYMv4sQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA1NiBTYWx0ZWRfXyxicaI0mKe9i
 fMotr1skRlwhCkajVrZYGTXl0dALdZWnW/lEymrPKgpDWGIJrS2imJpGlGkbYp9iwdAa684JEeV
 LFurcaGaZRQUPUy/OLqTTvwcI0x0Vdg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060056

On 06/07/2026 01:37, Jonathan Cameron wrote:
> On Sun,  5 Jul 2026 19:24:39 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
>> devm_clk_get_enabled() does not return NULL (only valid clock or ERR
>> pointer), so simplify the code to drop redundant IS_ERR_OR_NULL().
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> See the stub.
> 
> static inline struct clk *devm_clk_get_enabled(struct device *dev,
> 					       const char *id)
> {
> 	return NULL;
> }
> Not sure what the reasoning behind that is.  Maybe that
> clock could be already on?
> 
> We could I guess make this driver depend on one of the clk
> related configs, but today it doesn't. So to me this NULL check smells
> of protection we don't need so I think the change is fine, but the
> patch description should reflect that stub and it being considered
> reasonable to plough on regardless.

Oh, I missed the stub. Stub is wrong and should be fixed (and then this
patch makes more sense).

Best regards,
Krzysztof
