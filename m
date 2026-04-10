Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5434F48A
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816147; cv=none; b=IzYxq7sWeQOyS74+4tBzui7S4mGFB/580ZpxD2P8op3wm1RNR1VuuZrJW8rZgmVFquPniDCk7AYX8XVhXq8sp+I1Eckc7J9NC8dcAaDz8TSycDYvtERvVmSoG5iSk+3mhv5WPUDvXtAiY8xISMXMcQ99zLmSXtpfCbGzyZmwe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816147; c=relaxed/simple;
	bh=acKCtBBY5beJJNJxkoJd+8Z4H/GcU/gRY0KIHaFXnmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmicUrKyg6qqlMZ1i5J4VtbOeRj23y2h9txidFFNrBSkvI7KuZKihbJIzCU4NywnamqBl4zvy/0xAxHyJUZ0O9e8R3CC09JL/dSPHAFJqGZXYPuJbef/MPXop4b74jTyW2m9p7V1mOYC0MfnzEJAeciqByzBp/KtrYSHXa8d+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M7Y330Oh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XSUab+LQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7Y330Oh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XSUab+LQ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AA9hSQ2047726
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xnUoPeyCpQ8Rchdbsf90x2AVJoXX8svgOzQ8+c1SLPk=; b=M7Y330OhOedqkhkf
	VeFi11Ur0gycO8qw/fbCJ41a1u/eULKUBLQ+NOeyG+350lApkNfXxqTecd1ndsJe
	OuVdFlAA+tEdfsPohYTxLtC29QBhHCuCCorLJWce2lXGxHtqru7ULFPDl3PhHCPa
	KnSxEzV+3Bt0W+1cx6a175NHg9B6nTtjdGV84sCcI1Nfr58qn+pFRaX39HU+To5u
	vjbFCo9l5/N8C/nJMtCsNs8kYKwjUmpZZ5KYBda7UdI1pye8KIsEvkWk2TdPjINi
	MCmCot49Gy+hVP6rDIPRrXwVwVaod8ilBrqYHsLU5B/mvAJ8r3C32IiDlZawh4Db
	+q+zAA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey77819x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 10:15:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89f548d0872so5816306d6.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775816145; x=1776420945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnUoPeyCpQ8Rchdbsf90x2AVJoXX8svgOzQ8+c1SLPk=;
        b=XSUab+LQvNjixZcUvnHwykHjqQuASHx6bDSY4B5KfPW9m1fflZC3ZofBsYwhv58Chh
         fv6Zg5+NPYBlfWGMk9Q48QDiI+pvQmUhtet5nPjpVwwC1+Z6sMcv1npVElxSFhN6aMXe
         8Oo+eTyirimlTm/fApz76Fag/Y9iqP5seQTTjVAWZdAMeCEgOrlMQskwuR8MSX5SkNfD
         zl/yL2pL/GZC1wmA1dNqXF+1zFv4mwC82E4bQVFeEyhMa5Qunwj84aua1b/x/JVjmfY3
         PxA7H547xwYCTgPJtMNA9eCLsAK1TRS84P4evilrSdqiRXw8qsoUK+syTewRE5B2E3Il
         mcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816145; x=1776420945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnUoPeyCpQ8Rchdbsf90x2AVJoXX8svgOzQ8+c1SLPk=;
        b=Yt/kBfkJPsM55cd6U3GcExYCYmWn7nXMIlTYIGwvctaROO6g2PrtjrrctryeY4+h+I
         H0t9Ddv3JuyloenymM8dJx30aTzGtCEZY71Xbwk99KZj4BZavbh1kCweD/bcqV0kmpqu
         27gnksqF2Yn+XwE4jFf+CMkC7O+qR5FB4vc8t0oHzBvrSJhgRz0hy7BB1F6klMc3rh9O
         SVTb1LknAFZHdgFrRVnJWKQKFJHOL7YOpqUQpAESRkl+unkJO9fxF64vC/jLYbfgrvFW
         j/p77fMo3HQMCDkc1INCrPUaKtaAe9cOaaetWg4VbuvqSUxk/UucXnkSzDfGnz1xusUs
         A+OA==
X-Forwarded-Encrypted: i=1; AJvYcCXPE3f87oVUJXQ54lvI90w7a/FXY536FpuXtR+fei3nanZIa7ssE9Xoyspd0jRhqeoDT6QwBGoaEvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvyWNVLKQ/H5DG2plxm9/E1fyKSYes3vzLoz4l4Em0RTJVvBu
	T/6fH/iD14UGF/h4Wb3DhQAdhhRP/1iEPNsdOLGI6wwhxz6hZvrDAYcgxoCvvCg8P3i+4EWvSUL
	KCPSHsYKb0vnSr5+kGDFagVyAmi3scKNFY/Wp5Gb4dO5XaID0CKLnud9SKEbPJes=
X-Gm-Gg: AeBDietoGTYhg7RRp0TOyimkOO5I0yDaI0EE7FItoKFgMQBtqnWNEUF00ZIpJlXJTUE
	jhgw6j4fVSyvlbSrsaIzhzdY9FLO74eUilux7Dwk+LCWS7dWJwkxvVVOInN17C7bliCx0bagCBH
	hdCmAlipfFMkC6SlovEaBpxDh0OVNE15RpKV+ghHc91CnjnBi6X6gnx8EKWjzkZYYFWF/u3iM9e
	JV5Ms19Z4YHW9tDMkZnnN6JL0QZ6NKrH7zDWC22Zm3ayYQqPJQbJEwfrtbgjrbm2ixe5lOhH+li
	pKUCfD85M6GeN+qjxcx2MBVhwLvwEF0Ay5wF3KCcAezJQNKyoo5nvHGWrtipsYahhAqHBXERv9U
	P/67+h2o2c2xIWBi+XJHLjRqmPf+Ky87P9cx61icHqz04oZbfgjWE8Gdfllg2rwvSbyZjcPJNCr
	Ggp3s=
X-Received: by 2002:ad4:5d64:0:b0:89a:564f:bbab with SMTP id 6a1803df08f44-8ac8746608amr21609506d6.3.1775816145145;
        Fri, 10 Apr 2026 03:15:45 -0700 (PDT)
X-Received: by 2002:ad4:5d64:0:b0:89a:564f:bbab with SMTP id 6a1803df08f44-8ac8746608amr21609116d6.3.1775816144641;
        Fri, 10 Apr 2026 03:15:44 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f188fsm66430466b.59.2026.04.10.03.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 03:15:43 -0700 (PDT)
Message-ID: <69fbeffe-1a8a-441e-a4c2-a1fcd3d41421@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 12:15:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] iio: adc: qcom-spmi-adc5-gen3: Fix off by one in
 adc5_gen3_get_fw_channel_data()
To: Dan Carpenter <error27@gmail.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <adjM_ZXs9IoIYjyN@stanley.mountain>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <adjM_ZXs9IoIYjyN@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5wfwMYYo_Jt61gkAxhuZynolg6nj9KRF
X-Proofpoint-GUID: 5wfwMYYo_Jt61gkAxhuZynolg6nj9KRF
X-Authority-Analysis: v=2.4 cv=VN/tWdPX c=1 sm=1 tr=0 ts=69d8cdd1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0Kc_pid0jmsIozq9se4A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5NSBTYWx0ZWRfX4iHl4Y0tbc8t
 SY3AZgY0KZY57iUSmiIsjLU1AHOgiX387cnqOcKvmQ7P1IN2plhnIua0yxeJY4r+xq/R0al4Xa4
 96PBYqK15vURnUDE7kHSC90FA69VDcCz2Hl+fUHBbjKWYdmq4gxZAD/mCDX1K8DUuwivEcKfy+Y
 WzIefXbdw/Oo+d1gu2pZG2iAUliV+DWT9bM0T+rGo77fEECHiatfecUKruYTOiLzIG4N6MuPM/k
 /JMO16Zp+dkQCe4t40pl5GMcHaGVPWiZfyWmDXEUmDZb3OXKHu/bShhOOwNA67p99z4VNS4bRpy
 1n6W1+4PJXmYzKQmXNgp80itCTwesPexdKmE3cXjrHuGokfP7prwaxD3Y2E+siGSRr03m3d3tyR
 yq0p8lZkFx2klACW7Azg8YM5DA8ehbbzlUb7oCzBWWHe6OLGcBYDEsfxTZSAwrsD1guqa1hTw8M
 z2Lp2vGdyGfvusc3uvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100095

On 4/10/26 12:12 PM, Dan Carpenter wrote:
> The > in "if (chan > ADC5_MAX_CHANNEL)" should be >= to prevent an out
> of bound read of the adc->data->adc_chans[] array.
> 
> Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
