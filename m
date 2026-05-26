Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5620459A
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799731; cv=none; b=uCHq397SuuBQIQRAnx0eIK8/RFxgyf9xBSaLI9ePvpZFNUGArXKSut+sPeO6VgOK3rtP66sXx3a4RmDYpruAndZwi0iLMj3jvfteddPQPTQyvNy0cckWjkwQnq4c/dukmFLeol/pkRCHFX2WLbLrX+JKa/JNxyaBjsE4qFRAQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799731; c=relaxed/simple;
	bh=MgcqGsOTsbrLGvvzk0BqJ52GgqrrvT7L8ZFa5vy0vXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRx0RSlNQbhucIDb40P4vb/pdhRfvgmTGl6MltsMRvaBEl2lDgwUa8XM62sowi/CQs/BCHVJGTx618upfFEhtNHyGCX6x7NbbmlNuZpJpW5IBPdOyV61cPGT/a+O8QFTLnHAdYgNMfhCREDdNFRYMqcGWgkgZshzuytARWBJ0CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2v74A7v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ckyRSjPX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2v74A7v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ckyRSjPX"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QC0j3G3263593
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 12:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2ScsSKO8Jlk0Ei0kSKnjz9Rj8bi+tWPZetkZ3Ogg+s4=; b=F2v74A7v0Xdpu0mJ
	tyMrLFfnvvN2rEH5qexogIFGRI145wtjA8mOgLIp2wtF1h7qQtUi2caVwnaSqGZU
	ALedXGMxynLoDEvvhblPelSzRrWe2o8/FW4hhAA8TmmLpnuv+FqmonJKtUYfgCR8
	jkzOo7u+lzcej28rcCqLJZ0qgLT35+7/T7ds3drbMpssL3yuZa0KLc1vJ6MnwDh3
	W1VgvdYLEmeQDufrSPCJmAeZsorQcd4ywmC6ug2k/fl7dCnrKYZ0l2AIitNk+DpQ
	zXguDGzol9OGSoB6KOVD6WKz9f+CAlH+aLqXcOgnMQqQpQhIraGLqAPSqZ/dbjni
	U9G/4Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs4nfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 12:48:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516d58f74b0so48706081cf.0
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779799726; x=1780404526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ScsSKO8Jlk0Ei0kSKnjz9Rj8bi+tWPZetkZ3Ogg+s4=;
        b=ckyRSjPXHTJgqqtWP/RUf87Jr4nMnVzh0T1GkynbxHd8GZ7gbaW3bh6NwE2T4+VGEN
         knIccS2prrQALUwCh5KqQ23Ssulcu8VEGXdI33zwfivsFjmAwtOOpSYYUZrTqUeDEyaa
         jrw/agYdni2cv48bGlMKCynm/ZlkjnmBq5dKmsWpkBZh/jSP9YksRNw/4gtr4RHwc93d
         9m7gsNeMBvTjTDMbFCKKPeKDxpsSAOqrMgjBFu2KNhPlEjYbuUHEJDyiXCbweJnFkFmc
         m/KKV695xPCVm+2oqGIgrSfu5Vsy+beGtyjuAkebp/B/1DnZfqoJgSPWfszpTlYYGV4C
         H/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799726; x=1780404526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ScsSKO8Jlk0Ei0kSKnjz9Rj8bi+tWPZetkZ3Ogg+s4=;
        b=kEYYpJQDhwfOLohlBSweOhxQKuul2s5Zdi98p/P45XAjpWf+DBO23W9ZKnw7tTvAZG
         Ioj6Nj9Y3z7CFnMDyvEijjV/G3BIoYhz7qbOJiYvxAaNNglGASz/xLe3OlWzGWF9GcjQ
         pmwgqwynsOapaOVX7kh5dxEvwAt0GzuFIN+7AVG9dNf7Ea+BJyPAT3SYpCLL/SDT3LHz
         o+KlOZurlV3ampVScCnVLA10vxWYwNIauUSPSPi56ehUdHOSqEWHwbxZHbo79VzM4anL
         YPYNr7Hh7vFnqSq7zKXfOHTilJLHnOriTUbCShwNglkitxLec9ptzoo1fHJtHkG167EL
         r3wQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NmwzqXpoxZExYM3tjTVjnS7UnyRs1WTHiF/5+ssgRZAv+Xw7u/tFrofA3FezrC6zTzdx3DD0ge1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJy202PDN3QDZ2M2Fcwo1T5+wXFRZqMvwz6wXN79HwfG92D0t
	CfczNxzV8yw0gDC7FV0nwsH3ESnd2xhuQd9pma9J5LTWOrrH0lcACFtTIO7AbY/Q/Jd1MReKDvk
	+3LUTvMBqE300PA9W7+yG7tbaoNAwtzGV/9pcEo0RkSHDw0RcvFEu2AqLQ8ao5tA=
X-Gm-Gg: Acq92OG/50d6acqRuHJqB8wZi3UzDQ3XmObeTCv+46NHF8nlbT7wE72MC5oI7dUnnPc
	Qn3gacMGBDDT1BC2WVv5/81uhaJURnPDM4jeOLs5M4CHQ8BK2ieRecD2UoXLcd0+S6mB4ry2Iz4
	/rlDQtFQ4TtAyKXd4rXqwnqWVaQky0ZSE1CeFayEMmcFW6YEdSvLa6VSoiMhzzE/55PDIr0GfwV
	OgMbiaeBLs28JyQHgAZoW3NV9YuRTpqwf8uC1MIUOmVUsl6Rre6XmE7hDFqJA64XlNjRPrRCfp6
	st+WxECYZa1/4S8AN3+5wSWxeVFj4l/88bHeLD396Cbu8Q7xAIyvHYU0Wnu7oGoi6RpRk7MyFJW
	7/FGacnPI6fHRSNDbOE0ZSLQSMVAEOFSzvXFnHshmdSMMNN0b5MvLTkCH8lE1fRkswb+Cuv5zKF
	0vLazXWN9ZNJFZORNL
X-Received: by 2002:a05:622a:8588:b0:50f:b465:94ae with SMTP id d75a77b69052e-516d436b6c5mr190811411cf.29.1779799726506;
        Tue, 26 May 2026 05:48:46 -0700 (PDT)
X-Received: by 2002:a05:622a:8588:b0:50f:b465:94ae with SMTP id d75a77b69052e-516d436b6c5mr190811161cf.29.1779799726022;
        Tue, 26 May 2026 05:48:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1? ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904179826dsm144813045e9.2.2026.05.26.05.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 05:48:45 -0700 (PDT)
Message-ID: <a05742a9-9129-4844-87d5-14473648c4ac@oss.qualcomm.com>
Date: Tue, 26 May 2026 14:48:44 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Fix the delay calculation
 in nxp_sar_adc_wait_for()
To: Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Sashiko <sashiko-bot@kernel.org>
References: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
 <20260522183533.358a1f30@jic23-huawei>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260522183533.358a1f30@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a1596af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=c92rfblmAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=L32Wi0nctVyipasOhfYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 0fC5hKxBT76gdnbFVFm-tEQhF0uUG5xb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExMCBTYWx0ZWRfX43jB0XzIoiRl
 K/9fuFmxjQ5qGvsZjCsiSaaffm/WLvM7u9sEYJUjtlIUqpTLXX1flnO2H1yebjZ8dT3IKfTOWTh
 SILq0HWU+AIE9+aKGrpT35nMqJTtBK2Hdlf8+ceTrSLJJkyByaTwawaSUoUVoXD4PwWeeHuo8FQ
 FZmClzh1JihDdCjllJyAbCoGzlJ4sB1n4Ozw31bndsV98nar4BfZL20b8NdGt6y+oGt9kA5M7q9
 XviWMcfmdmucPfvjpkp3+K0wQ0hTu/+AzesKtE8D2wOJ6ypGuy81dJYfxMmbiPUtJF7QbJOkyqW
 6iHvboqA6MMK434g7UULr+08fH3VTBtR90TmBrPPvd5+6djn/FNgBSQegCyBTTqDoFH0hu2fRws
 nRJU7/9Q9qmQaepveGdHJ2zXWteCgvsDgC2yxOHNnrYJ+/A/Ei2DsJt4mkg3h0c5urOycqxTiF+
 Uc7c0HuEXWY+TieNFUg==
X-Proofpoint-ORIG-GUID: 0fC5hKxBT76gdnbFVFm-tEQhF0uUG5xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260110

On 5/22/26 19:35, Jonathan Cameron wrote:
> On Tue, 19 May 2026 23:56:06 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> The original code was using ndelay() twice. In one case the delay
>> is calculated as 1/3 of ADC clock and in the other as 80 ADC clocks.
>> But according to the comments in all cases it should be a multiplier
>> of the ADC clock, and not a fraction of it. Inadvertently
>> nxp_sar_adc_wait_for() takes the wrong case and spread it over
>> the code make it wrong in all places. Fix this by modifying a helper
>> to correctly use the multiplier.
>>
>> Fixes: 7e5c0f97c66a ("iio: adc: nxp-sar-adc: Avoid division by zero")
>> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260416090122.758990-1-andriy.shevchenko%40linux.intel.com
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Daniel, could you take a look at this one.
> 
> Explanation seems fine but original patch was yours so I'd like
> some 'aware' eyes on it!

Sounds like correct but let me loop in Ghenadi as I don't have the 
platform anymore to check the change

