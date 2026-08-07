Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509DD40926A
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104449; cv=none; b=OAuOQAY6vdvTdxJC3WxcjwW/IwM+JADdskQ35EA+TJyR8szKHVL997dS3nOhQUBC1mDfu4hpoRbrcAcyCsIy9RZTkzqlkeZBSiJSxrV/kddT3OyBSSwgePzEIXsspxO0H09+wqZ/TW7Ui7O9K643/TwQY5AOiqnMzQYsRvdBL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104449; c=relaxed/simple;
	bh=ehPxIFQ21Ol+ZycPPlarMM2wALuLgzffeeMI4q+2ToQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cM3YrjQknPAYIR+b/7iB7m1gbcz1M6GLdLOyLJcSKorK4gKaRWnBnNKwu9cW0wn7M3qm6qVVUnhdtVRn2JQDmXN/96yzcqWlSsvjyDIYLZntv8nIKi8U9n8bcpWXlesZkSVhFq41jDwf/QChxRNIFZe1mMW5XcOc/4aErGu59c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nD2LLTVu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ob8KhSJg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nD2LLTVu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ob8KhSJg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777ltjs3822023
	for <linux-iio@vger.kernel.org>; Fri, 7 Aug 2026 12:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J5PnJPw5FcNJb0sJKMIKFrFpB7jUpmhAZkLfowS3CEc=; b=nD2LLTVuf553t+ER
	LM+hUnXn1yDSGlIUMYMLHCDOv+jUeoJiBeMnREcZ8wLtQ9YEvIORaGGNfx3wyLIj
	J0t7r/w4Jfdeg9Gs9cEfRMjiFsW4b0f8a9iLD/TcJ8gNN2+6yW++QuRekUdbl3IK
	PpaFaYsTbKA+4Sg1cLC4c+9/tnf0ICB3UmrKDmKKDz4cOmvqVttR/VkBdWFUP0VL
	neKD6ZffuAr0s9YOvq4dmZyfUM0qu7mnMRJRr+ZHapZoxF7mRknpoTpXgUSMEoFp
	lu0P3DptBnANXohS6z9fdCY5gdp3cIz1AINmYvACbO3aah87abn2e5j6WxSnU4fw
	9XvvHw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6guu2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 12:07:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e695a3b28so197864385a.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786104428; x=1786709228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5PnJPw5FcNJb0sJKMIKFrFpB7jUpmhAZkLfowS3CEc=;
        b=Ob8KhSJgrOFmVg9jiZPxWD3/XQa1lnruOMTH+pkOKaessR3LVZlRua7vL9rEg7vefs
         eM7NZB/75OOIUE4q6YqDWDNtBB6/B/N3JauC7QSKPbNxogKnp9pnCi6JYOlU3Mj/sAV5
         +HzFtEYeSlhjhkYbSe62HMP6PhrlSlyhh9XU7zH7fhQHm4G7UU+tOOdlXW99wPmK9deD
         zcSeG8w6PpM82gQ3s4CWXeRW5+LG4PJ7dctJvYZBuvutWa04h1TPabqzA74xOco8Hsd9
         0Op3YA707ntdeO3thbMVl4CiKWkFYxWaYUIDQLMR6El2+ItXP2YAsnu6SIAfQfjbgAW5
         Nubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104428; x=1786709228;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5PnJPw5FcNJb0sJKMIKFrFpB7jUpmhAZkLfowS3CEc=;
        b=aX62yWYPS+jqxFL3Fbh8aJTTTq86yTDkzJv0uSzYtA0n8JWp9urj2E+pSsLU+J733o
         zBLzhuPWlbdzVVQ4nkjZSwzYCtU15xUgMyDNHXI9vXywCnsIUuN4cZwazFtqysOcNGCB
         NfGjyigeQ8I9srnF3ZGSIuAS8hAoiC6MemAIzjQoPLNGrW+aPkG3DWLgm4qhE6Mg/XJ9
         nUGC06d8vwJ9i95XAORXsSvf+dUPOUXzVfBYNCDHs0sSjoFC4GztU++x/qokXRiC7l+J
         7K6ReHeluQGcRP6n9/Ar772PEWcOWL3MUIXBERnnWQdIcu3nf6yPRxOjlh6q45Y1RvZZ
         ktMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBtxNzAxLg1l2QoJqOcyhVzOsrHUSHnqZkN/m+AWEiBxOcQwpO2GMbsRcLAakmvrCPLmj8O1kto/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MBLZKz+c4HM37LpmOxpODq1MJLSkH0p0L5nz7IDJnXBjkGD7
	3AVHEcru2WxVP0BIimgZzawpbQ3/XqnUBdKfZ4bUzC0oEr+GjNyrb9BjBo5WH5oMHtlLi5memo2
	XAcmmOMxGLqiTnvD2yuA1nUn2TyXcLxpFqCSD4Ff+kyXaVDYro6fXEzqFZxgFs4A=
X-Gm-Gg: AR+sD131IhEcFiEydYUCOGIHL+eyF43Ee0u1mzNmwFEQCECjdnFz8WKJ6VpPvIASBaY
	8jVYhYY8BC9yj+9Man2jBoMvgmHd+I7a/RcdaeXA+zJqt0mNiuIvsb6IUwGYacnZrk3zdcHW2ky
	T5LhELJgkgSICeuaE1ZP3ITDPUCFvhFQ3KZGfBIHJ9gf9OxlwkIfUoIM5wVMWIurQcT6cFXN0zR
	/OkT2Pu6ZK/I1jkZ4OxDE3cR8p7/RpUZfEo05JLBDlOEbHzspzl5m8PEXY9GSLwz4Dn0S1UPNux
	K3lulO0QiJwpF/etq9X0mv8CI6fqwi41pP6GzxYQovHEoxJGsK+hYLWWnJITTSxT2CuMmSLVCDv
	ZPrX0cSFTsNcR0J+ZfrXlDw5NDDSFKgVkAmoHvZgcxkMmIw==
X-Received: by 2002:a05:622a:1646:b0:517:63df:91a5 with SMTP id d75a77b69052e-52cfb04c58cmr151076151cf.19.1786104427873;
        Fri, 07 Aug 2026 05:07:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1646:b0:517:63df:91a5 with SMTP id d75a77b69052e-52cfb04c58cmr151075161cf.19.1786104427457;
        Fri, 07 Aug 2026 05:07:07 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145966sm5365813f8f.5.2026.08.07.05.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 05:07:06 -0700 (PDT)
Message-ID: <70f39b10-c529-4a7d-b1b4-6d0f04b2e38f@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 14:06:57 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Maxwell Doose <m32285159@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75ca6c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RQz9wGa70jnH9Rp9_sIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: D8-2AgH6HB81eMr3Kyp1XMIrMpFsbg_3
X-Proofpoint-GUID: D8-2AgH6HB81eMr3Kyp1XMIrMpFsbg_3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5NCBTYWx0ZWRfX25DEG/67+X1V
 p7c3CEsF6ytSO9iwLFycPytmDjUb9YaLWovPCZ3oOUE9XMZq8uGAZI9a8rG6/5qeH/fnzgT126F
 U3nyVMmUdILgzQ2BY+L2Ua3fNslGer0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5NCBTYWx0ZWRfXw2LDQ7Mwe3KA
 4vQE9a59dK0UYP1rhGyKWcib5ae3d0hSfD9I5XkWHNirnbf2Nvb012LPG9iO4x783v1LTZu2LjW
 Im+yrEy29i9hRH/KsvuvA1Aq26blY+yZR1Sna4IPpOerDqz1XCv3BJoVp6MddmSiJDKel80/Ksd
 knFaiZZMgwewHkDQiG4+TR9U3g0BwplQkzRWgao943VbetffrNkdS58NNVsrAotuO9tfR237XuZ
 WDNakaCY90Thxao5DMjrJJySCD67/UBA0t/iP2XzfIWwPXZTjwONx+u/vYoj1swJ5vUSEt0gww2
 uRDL2yx73cPpJOEye0x9FV1VHfcsuyXrNticQSPW+Y7+R29HuT6iM5T0G2fGM3z13aJwetJ29KN
 yplCwZYLlOhc8d4Ua0sq4afPNS/bTISEWeuUPOXqzQ7bGN4gJvcHmzeyjmtHD+5FcIRCleiT6GW
 rLu8bKXcqDIhyIYQdSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070094

On 7/22/26 13:26, Jishnu Prakash wrote:
> Support for the main PMIC5 Gen3 ADC driver has been merged now.
> 
> In order to complete adding support for the Gen3 ADC_TM auxiliary
> driver, some more changes are needed in the main driver, mainly to
> improve its shared interrupt's handling mechanism.
> 
> Patch 1 removes an unneeded print in the main ADC driver.
> 
> Patch 2 simplifies the interrupt handling in the main ADC driver
> by declaring the interrupt as a shared one and dropping the logic
> used to call the ADC_TM notifier for handling ADC_TM interrupts on
> the first SDAM whose interrupt is shared.
> 
> Patch 3 adds the auxiliary thermal driver which supports the ADC_TM
> functionality of ADC5 Gen3.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
Applied, thanks
