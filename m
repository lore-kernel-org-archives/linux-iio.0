Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479F3546C4
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111348; cv=none; b=Mv0LgPwcS/bGkJDA8PQjnSMWZQWWL5gUxoO6p1ZBl/TAloVF9tNM5unM6RxJV+LyJOOdo2Vi25qUJS1aSSaYGah6Xl+6g2rt7rgpmCp2neAUtn1K+rbUsDAXE2Jwck+6/S+LhxLiW3X6g9maJ8MHTUg5X4e1r0g6k2sFI+OUwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111348; c=relaxed/simple;
	bh=aGFBNu0R0Fx38HXGTTCWkfbep9h2lkJagWvGBC1mueE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkVj9GQ66qlkkiWwwljsXyPZjRCkvchX67aump6MI273LdGB/iy6flXkC2iQcdzxSP8dHWBZNwDSmEAyhu73NEO5YO5n+4JVXOawbNd2qsQyNIfVA50hqb4MOJ0Sy6JuUMvjeGxRbnn+lx1SKb4WKBKzqscCJoGymmaSkvRvpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e5j+Wd42; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X+X06HRG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5j+Wd42";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X+X06HRG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KQ0ew889261
	for <linux-iio@vger.kernel.org>; Fri, 3 Jul 2026 20:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pzNQ0CYHYvK3sJU1akzqktrLVrmX+5Yc2PEoNCfJ0C4=; b=e5j+Wd42Uo9g9R/z
	hv8aPYUKxROFIgKvUl1UK6IsYdMTqYaLJZfFogxE3EcALL7Rv/vcR6/v/SjC7kwR
	y/TJ8tDoh6TVLZOtUUFUmi8mTbKrMc85qCmO0UhZqcsmknIinBAAuQNgdlM+2xA7
	jlt2xZaw6azhicnh3SI0eaeWIlrJAcqBLSayJTJusIfpHa238aulQEPLMTbN07v8
	GeZHQuxfBNuUo8uyESc61o8CG1t7HXFMK83zDq8qTwxyZCto124Q67RAxwZKgnzy
	s5fMRITJ7xFx/T9yJTSSPI+7LCv0QFpwje98HAGXjuCJ3YqAGTUCXjKfElCCCeov
	47eFmg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682btvr5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 20:42:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91931144870so70799885a.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 13:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783111345; x=1783716145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzNQ0CYHYvK3sJU1akzqktrLVrmX+5Yc2PEoNCfJ0C4=;
        b=X+X06HRGBUQoCEeW2QM5FKLSW/d6k8Nym5BcsE6XetQhjE1F5ySI6Fzp05lywtzqe/
         JwfY8g3puh2fKIUvyCWZpCo2pJ6Lwc+4Us1s/1CrOz6uafE7RR1Lx/gNv9zzd2Oxx39W
         qzB0XKNf9Ag9MscTCM6BtSpNfNBobr/gNyryCws6m7Ewxx57yw5mED1PKi1Z/HgAvVvM
         RdFhY5a5UNP4qUE2+TUMdJ1LUr1YpPV6KUOvxezf/c8FLIkvJeIoCV6uEVosgv4LSlmX
         47b26JYL6W7ER3Myjt1umC7aEx6kSF7vEC4p81dXWDtm8PFo1WcaNtf9zj1Jp9OQNL9P
         Olxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783111345; x=1783716145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzNQ0CYHYvK3sJU1akzqktrLVrmX+5Yc2PEoNCfJ0C4=;
        b=Z3cnFTzWdpdIdTB04oSY2a4kid1GVtpVc1gl5OZaFqey74dK9KmBqXE2ysLJDCLVV0
         R0MvUznFhsifrIIV/HB1VqViAD5wTGHw/ZaWlqaTN1yKK8MIbqw/Da+tLXpbUuWpvH9a
         TevZn1WQyXBf1F60w316a67A4QC7nydxLvoKqWdt4a/YokfOjTWsam+hC8Q/SSMvjdtY
         MNpXomZqrmGJXfrrBJg8Zug0XgZlIVAUoa6icKxIQPcuvyKodgVcJ4CxTlLCOrkk6NE0
         pVAFYiMYlOE5KTjghr0io1yQgI70gYmvP0fCSgNSaWgcGwvH6Shrd7L+VkEdH+uJKL0/
         WC7g==
X-Forwarded-Encrypted: i=1; AFNElJ9iBAeV4IQXud3r1YrUQuWl/fwePn43ZnPcs91LsukIojV7M5SVyp0w5nMowIsRytHU4t2h4HslSWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtOprl5u5w4MNzOHaDLZoNOgibvjiZV6/NJGQIFDfS4V6wy+8
	ucLDvWgomOkdNlv5bz5WhQW3M0/dK/Sjg9TayATaU3IM/OYsAsws6rbjVFeoxeot6VeW8TBkLt7
	AbzljoQkgCN1CHEbkoJe22XV0QCk1NF+6LTs8yQm36DuB/vVflf93OoojHqkHtZY=
X-Gm-Gg: AfdE7clqsJw6oDrhikKwU6SQLq1spjKItd7XGY3uHKi0cgFkrGbm7eWyll4NrXYSicu
	E9g3yp8oYlifreaWgTaQ5ZdD94518jATaU5mVHw3ZRfeuPHyF79Wh4sle1bBE+57o47WhEBx2Nj
	/6wUCZYZcFCha3EBDjRaRRkU336Pi0HDZiA1utcyX80SeF16j+hcF12TngCC57ox+vTAws/o2uQ
	pOLNhRIEQl2k539RsZYs/oOqcyXiNDMErLwmLD5SAWgPhfjq1o/Jk3h4eVohZRWAsjAyVr5rSt/
	0TJU/bA8pFhCmm2SPznivcyIhq4px7OS17uXVKubUOh2jFyEFQW7HfhipJA5BRcLhZr3KbaAUHB
	+PpgsfUjI0pxmzohh7SEhkj89/8eRznIuE+NIqc4cOFWlsMZiVEN/d5mNXyWxBRGPABiSC2r/vg
	==
X-Received: by 2002:a05:620a:1a27:b0:92e:73fc:154c with SMTP id af79cd13be357-92e9a3446e4mr163689085a.7.1783111344808;
        Fri, 03 Jul 2026 13:42:24 -0700 (PDT)
X-Received: by 2002:a05:620a:1a27:b0:92e:73fc:154c with SMTP id af79cd13be357-92e9a3446e4mr163682385a.7.1783111344045;
        Fri, 03 Jul 2026 13:42:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6375764sm140895135e9.5.2026.07.03.13.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 13:42:23 -0700 (PDT)
Message-ID: <d04e0999-3598-45aa-bcee-d391ef6024cc@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 22:42:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Fix the delay calculation
 in nxp_sar_adc_wait_for()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Sashiko <sashiko-bot@kernel.org>
References: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
 <20260522183533.358a1f30@jic23-huawei>
 <a05742a9-9129-4844-87d5-14473648c4ac@oss.qualcomm.com>
 <20260703200626.40511970@jic23-huawei>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260703200626.40511970@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOSBTYWx0ZWRfXyTvJR7lA+WWG
 bEMDIDOirlhqxxiYc5obPIHHSy95Bjpn42/Xnh195pBM8prkrtOWAcXhrTSNGMGw1PyGCLeUGLZ
 PlR42O13tpIbcf6zUesdJH4Nk752MGRkoWjAMiBhldFP3fNrDHlW+2cCcO6covSnJadHSWPgqjI
 Dv4EVcwbezAwjWoHMaj6DI1SO7XOEeQn1Y42I/rnBmxcdwOGWG3Nrkj035kEOFJNaDfQBxowmx5
 kg47z8vWKkkT9SH0/WEX/v0g17c4ZbI/K5rpwSvK+xfWZ7HLfTqvHEhPgCPfXUEziLyQJaXNODJ
 KZiY6seMVb7TASfUkNygpKiTQ93D3sXxSKdW67Ip9amkfH9m0qF/NpRlJE21FS2SEU7Qu5ZziEz
 ejfGPZTIrS5YMu/s49WKUDUwfEJ8SD07HouxBa9pko4PN7S+UfHEbRCNsozqsMNwwZ+zwYqwyTl
 4Geu7Y3MOxRVzCDHs1g==
X-Proofpoint-ORIG-GUID: kJFWUKAAIr0OhJNYfsU6mpmXALlz3xEo
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a481eb1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=c92rfblmAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=p7aEG6sLlY0yxXIno8EA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOSBTYWx0ZWRfX3RoRmOPddlw8
 P5yVW29lsZsjTvvkvYQUL9jou3LD+LHalXahz1OF2+C5YzQimu3kk6mT+YrHITQyQ3/+Ur5v3Fd
 3fZDTs93qeTXwxLboJE24m4rwaFep+o=
X-Proofpoint-GUID: kJFWUKAAIr0OhJNYfsU6mpmXALlz3xEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030209

On 7/3/26 21:06, Jonathan Cameron wrote:
> On Tue, 26 May 2026 14:48:44 +0200
> Daniel Lezcano <daniel.lezcano@oss.qualcomm.com> wrote:
> 
>> On 5/22/26 19:35, Jonathan Cameron wrote:
>>> On Tue, 19 May 2026 23:56:06 +0200
>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>    
>>>> The original code was using ndelay() twice. In one case the delay
>>>> is calculated as 1/3 of ADC clock and in the other as 80 ADC clocks.
>>>> But according to the comments in all cases it should be a multiplier
>>>> of the ADC clock, and not a fraction of it. Inadvertently
>>>> nxp_sar_adc_wait_for() takes the wrong case and spread it over
>>>> the code make it wrong in all places. Fix this by modifying a helper
>>>> to correctly use the multiplier.
>>>>
>>>> Fixes: 7e5c0f97c66a ("iio: adc: nxp-sar-adc: Avoid division by zero")
>>>> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Closes: https://sashiko.dev/#/patchset/20260416090122.758990-1-andriy.shevchenko%40linux.intel.com
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> Daniel, could you take a look at this one.
>>>
>>> Explanation seems fine but original patch was yours so I'd like
>>> some 'aware' eyes on it!
>>
>> Sounds like correct but let me loop in Ghenadi as I don't have the
>> platform anymore to check the change
>>
> Hi
> 
> This one is still outstanding if anyone has a chance to look at it.
> If not I'll gamble and apply it :)

Yes sure, go ahead

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
