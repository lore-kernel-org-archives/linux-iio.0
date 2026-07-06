Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BF3E0C5C
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320950; cv=none; b=aHfE1dCNrX/dEa89f8G63NzWLI8IQCjrH6RQhS9ATo4OkOJyePiJYbe55gdDXqs23g7yA9JntjlYCeqWkP3yW779itajnNHenkB58e9YU0NWIzy87h2/PE1ngwd2X/d9U6pPPVkaFdC8ixUZCH/vbxgfcHWmCD3vD8MEi5+yPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320950; c=relaxed/simple;
	bh=ZWUN//6kt1UVkygdM6j9pSLImi5gdV2ZEjwwpjgezYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tg3H6nlXcRV0De5080TAxGK6gX1CA17OH7ofYc3yFgiSBlIzTEOYiJGhj2lgdtqDT0JukA7rQN179IDXgAKS3DoaGZmCMrzYqJ80soAbte58FKmTUDhE1z964Scd8xZ1tz9f3Yt+lzOWEiKmGn/avqZ3GfgAau50ugLbubU58dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0PWeSF5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZv2KNrb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0PWeSF5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZv2KNrb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641T4l3470434
	for <linux-iio@vger.kernel.org>; Mon, 6 Jul 2026 06:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h2J3KqWL7UWHIKxrcfay0863UvnN2o7JsrX7op3ymd0=; b=E0PWeSF5Qw1O78LP
	rnC31TbsG0O+g66MJ1mLH5asHD5NY6Sp6JaT+Azo5DbXt4x8C/xapE4184wT7LIp
	YYiuZdNybIKJwCWCFi+e6X/965lWXZB/TuQ2qpurZRhwH7OVZkM9dUqJbFaawPOo
	kIjIefOuGLZZYoXYjvrW+yRrSPzW9GgLgeEqdugny+ePP5M3OkdRFYu/JgxAnEw/
	Fr/1qvPso3kn5E4207WTFbFtO4ZrA4aLBiYjd+Upx2/CYx7MO1vQjV7CYqzxk3fU
	Gym+7ONZTdei5lBxHrYxpnegqT3OhXPRXgblMQpAvYYJL4okELvddlTUOg/W21sQ
	MaEWbw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txemsm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 06:55:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915f6ff639aso495629285a.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783320940; x=1783925740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2J3KqWL7UWHIKxrcfay0863UvnN2o7JsrX7op3ymd0=;
        b=DZv2KNrb20NhoOHw1foqY7Um82yPDLq1NOtLe9qq8O4gcXbTA5tCyBMbDzU8gw/ZFL
         vW0Fd6k2TV9iExNtgHJAMhwug6BVGiy58w2MdBKdYdgmka+RYgjEX4un5tazlZED0N8z
         Vd7yngTdvi1oq+HLvA8ugGJwEE5nMZ18x0OffHR4ar5vM6r82XJtNxMbcVgncRvPsQtq
         qxdXJMZRKiWhFLLadgnr+rQMtkS1aU0R9uC4bUVfppqMQCjxjv5cu7gCchuqJlSwtGdr
         +7QZzOvDwHnXq26NjqJUDwiHx/vz3GxlCbhU9ZBQqtNwHW9tvyltVnSG5ESUDUuHIkD6
         cuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783320940; x=1783925740;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2J3KqWL7UWHIKxrcfay0863UvnN2o7JsrX7op3ymd0=;
        b=JB/PTXD1rdvIC9envi23nTQywbPYkx2fg+C5g8ox20Wn4akoqHnOqZEVRG0Q+Q42qX
         5L6g4rL5yVkLsx5nd4whrlrPWEbeqPeN6zpSBOKASAkRZwBd7j3Rdt2d63wCjaC37tFQ
         ISpIiKz8FoSm33tRy5PWPmycT3Wmupe7ac7okyMCjNsHikcHaoRojAunjSb3LhREW5IX
         dJQDsL2Z9+TPMTepGwro4TxAyKGuHDhYdHqgMSVFv/zqykdJ7Q3ZEfK3h19tpOcieUAt
         QIzWXBe9qMAZOudHnIR6PddIaRRpRNnkuudGSrEyzp7XcDmVaqrU2gsE/sC+hgQYKSIj
         ME4g==
X-Forwarded-Encrypted: i=1; AHgh+Rr1HngVJ1N9JBKO8aP9VfmrOY2rZCvCCPnfQzybPaiN3IhAdImvhAJdGgWurR0rJ53TjKCwX1s55Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GV34fXY+55B12u54mNwQv5KzxbqU0/K/91lMndepBkG2upvk
	n9tg1eMlxBD/XyZyHF+udkJH9J1YvyKrLlxGtIPCqEpPPS0/O5jfw5RPhBe24MuN2dON3ph9kMR
	IUaKr+FnJLk8banGJjsCZlmgSO089inDpnbnsUKDdrBArhmz9ziKYTIYiEiydx/A=
X-Gm-Gg: AfdE7clN1o17s/hB7GfRRTt3xYL+rfgShLu2KD/b4tySKOKUTBVVOIEbtopzTsBBLVP
	m0rMYjZZbJx6nHd02soRmGybHQy6nyvMntDqROk8P2oIwYOgeqBNXJRlSra94JvXamwXoxluuKk
	N9jVQjDidn6vgpBuQEWv4c3iB4OtPu/7GlMrb6alrm5NR7Axbu7AShJ+lSn9FN0q87/Er3zviUu
	xQWByjRS2RX334KsXO5BdQxDy1II0v+0yNIHr9VmWvZuPwdXkNfUJ/uAfxJVbchs9BcItrMEta8
	JE+cHQhloKIlLSk6HWu+NOsYAmNmTol5z9jsdt5DdfaKgMsPhn1ayNyEJzBtrkPxtJrXe/gR+jR
	N4zXkSDpFNRlN5XMO9Lvj3gCWhM78sGH9A+diPL1g
X-Received: by 2002:a05:620a:63c9:b0:920:6061:816e with SMTP id af79cd13be357-92e9a2f73ccmr1247014685a.7.1783320940258;
        Sun, 05 Jul 2026 23:55:40 -0700 (PDT)
X-Received: by 2002:a05:620a:63c9:b0:920:6061:816e with SMTP id af79cd13be357-92e9a2f73ccmr1247012685a.7.1783320939874;
        Sun, 05 Jul 2026 23:55:39 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6da9sm21693759f8f.12.2026.07.05.23.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 23:55:38 -0700 (PDT)
Message-ID: <11ddf106-9b69-4872-8635-aa934e4dc20a@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 08:55:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ti-ads131m02: Drop redundant NULL check on
 devm_clk_get_enabled()
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260706003712.753a5870@jic23-huawei> <aktFUqFUR0-Zx8uJ@ashevche-desk.local>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aktFUqFUR0-Zx8uJ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2NyBTYWx0ZWRfX7kNLAerhbAJ2
 sGDejU3gE1kv5BtEn7+PsK2zFzqogWVbNVNWf5+EnGb8xuvt2Bw7DJw/2ls1qMLajpw7H70K7b1
 QCsUHr7AR0+RlelmlRHcM2ZBMonLRYc=
X-Proofpoint-GUID: ABI0y_BNc_IcuwJChDLLjHuDIfS_ghC5
X-Proofpoint-ORIG-GUID: ABI0y_BNc_IcuwJChDLLjHuDIfS_ghC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2NyBTYWx0ZWRfXyDhiLCeKmdsp
 velovxY1jtX99eBhHo4loh6SO0v4eBzWVDQH8QeQNcytVRMEmZPpxm2tCcfuvcSwuCQnQSqR98a
 SXXwYW2WYB7oMu3wPS0otGR1L5lk8cwV6xMtGLtkrOYMcSQuS8Lzsd7NfWUm/bIA+gCfRLdsfso
 JIdI5Hl28SiGNycdthcJ27ghaAYTiTdoRxWB6wH1MM8I0M4GXaIrYJlFVBzK/Jc8f272D8F2tim
 6WFyKIAMWQbD1VdRsHBGOAganutZiyzhrmWz7uOmpE1R1t6A4hm2ly0Kq5gxELbyKdydAtj3EcU
 UPF4OL/lFFkIvOGClocQ0jX8pkDhbv2mBvxkhOGfqVCp9H5U749e/RHdxB9Gdz9UOQvgKKbNhKj
 8oKMS3fCaNOvhOZzCEfgBpgcj6+Phv941l45aahHahfChReOLM5nTE0mLKEaaKh/SlrskVIoyXL
 ZeYDqO7wilPaSLY93ng==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b516d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=RKvKgnVovDhdWHIY5mQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060067

On 06/07/2026 08:04, Andy Shevchenko wrote:
> On Mon, Jul 06, 2026 at 12:37:12AM +0100, Jonathan Cameron wrote:
>> On Sun,  5 Jul 2026 19:24:39 +0200
>> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>
>>> devm_clk_get_enabled() does not return NULL (only valid clock or ERR
>>> pointer), so simplify the code to drop redundant IS_ERR_OR_NULL().
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> See the stub.
>>
>> static inline struct clk *devm_clk_get_enabled(struct device *dev,
>> 					       const char *id)
>> {
>> 	return NULL;
>> }
>> Not sure what the reasoning behind that is.  Maybe that
>> clock could be already on?
>>
>> We could I guess make this driver depend on one of the clk
>> related configs, but today it doesn't. So to me this NULL check smells
>> of protection we don't need so I think the change is fine, but the
>> patch description should reflect that stub and it being considered
>> reasonable to plough on regardless.
> 
> Ah, good catch! I have thought for a moment about this possibility, but I gave
> tag anyway as the stub thingy should be addressed separately anyway as there
> are many drivers (I think) that do not check for NULL.

Except these ~8 cases I found (I sent a bunch of patches), no one checks
for NULL...

Best regards,
Krzysztof
