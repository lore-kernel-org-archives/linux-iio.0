Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610283876C9
	for <linux-iio@vger.kernel.org>; Thu,  9 Jul 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608565; cv=none; b=rwegVnJ6g5mzxwh1vXhsnQzI7979zbfrPf/lyM14c9kDsaVrI1drp8XZdbqkIYW6MAV0Txth4Eg0pcjhCInc94vVq0tFbS5VjeAEbPkCacYN11uWmVyZENJofxT9eBZgRczdwF6MGKV6pTrgrgR81hwVsogy9u85D9HNpsDHATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608565; c=relaxed/simple;
	bh=Fx8I98chejCgVIaPDpoTZOG6PQad1id268swqWnYKRA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pI3/bhlV17T/FnQ2aZf51RDplVgtoGnDDTyudTj4enUL2amlNvSD3Ps0isoWMQ0YZ01AQWf6QoSp6r82DPgpSVx9utgQkJPPZPjlsFpb3bilwzYbP2hlhi52TmScbpgLJ8Y3KMMr8MVCT7ngDF9r7DjFDwtCSF8qw3j3MXeLW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJmsKPRY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L34fareB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJmsKPRY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L34fareB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669DwB9T1919686
	for <linux-iio@vger.kernel.org>; Thu, 9 Jul 2026 14:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sBlF+8E2H45VgCzLKYkd9chRzubdxCW2XKqpDUb80gg=; b=FJmsKPRYWJSKZ2cg
	r0nRuF2nXN0A8sapXCce2Yd8vnfwzxlt5yWFjrcu4Xk1i2pio7GMuhAY3pkUs5zI
	gc1pKui090o/rmxwA3jONAlV8tO9W59GuFg32i/BAZvFafi4SiJOROikNZf17Cs+
	Epw9vvX0cXKEPW1ITAPgJwzP8ASOvpS5LprdQVUHtV7KU34wpKCPd44wDerBO/jA
	qzaIsy9NHhoMPPUGJUX6YUaDbB4qw5iZ6sXPauupxMdbudzj87k1Ne6hc4KVyi7w
	tr6RaxU8TJ5ndw1XsNt8xzVf1boakbvTsZlUf1SQn6vdYK3w+xyWFYk3RZePGNfF
	dSU82Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwctq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 09 Jul 2026 14:49:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a23afcbso20602761cf.3
        for <linux-iio@vger.kernel.org>; Thu, 09 Jul 2026 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783608561; x=1784213361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sBlF+8E2H45VgCzLKYkd9chRzubdxCW2XKqpDUb80gg=;
        b=L34fareBNAih7U8j/7tQUhijVzDPKLl0nKFGec+bMPTHwkY/mvpD24D241SWzMiDPf
         01qkQdh+icY3N2iliVBZq5K7EiizZ6JQ3bU29FJRWq66kzZngsgJTkGdPMVd52mGGyRD
         jQkqeMH/JD3g0FA5BQomJ+TvobOqM/ELa0HLpbtk6K/AvYlbqroLgUVo/rRaCsl3tsD5
         ANEE4MlENblwzPo4PtGPngPJLqHrKlEZ3+2W0mOCYIRtEyRSaWxWvDooHuOQ5xHXXOjh
         GBHHDxYDdW5NOAT+gV3s4G74CohsbwMZgNAnxTDrIEJRK/H61O2pa93auvNaR6YpTdah
         RljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608561; x=1784213361;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sBlF+8E2H45VgCzLKYkd9chRzubdxCW2XKqpDUb80gg=;
        b=ncPvkFjkfDCzI9BZkbakSM/N9aQwD1VOSAO1Mt4ZqDlXEB3sShovPKZOuZl+H0F4RG
         DzJS/nJlS45ORYbLKj+bx+jBkY9uuzPFrt3qhkzLrWBTKdWPAOr2gNb3xevMABtVtluT
         FEdg9kIzMlmW17IZo5SFQaQw+smnDW4yQ4n7TIZYj63GIFZlOjwFD+U3fyOa2lXAeH2w
         Eo5bCnWy7Wt7cPJBHq5pSEcHiDrWZp/UHWJj9w2+kPAiky5HRrDLQdRZEl1lCE0P2N+A
         +4OTUhHyzws4oQY+FKp6zzMJspqR377CcIKbgc9bFtRdOjc26Yhfv2KkHBZYaWjcuP2U
         wQYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZgtvheVpj6P/7VXjvXsOtiNpkJZ3mFbkNZ3NPBkUekNqWINB3luyibXSJgrfO0tKlBUYMeiJylpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJt1IBCfg3gpjr4EoJtFc0inQEcfNkaFENDDXLIgqWcs9e9vVj
	RVKtWsATsqc31KXltKAA4eteDGtQQnCuq2X7zrttIhPD7x2HbdCcMUOgVjf/6QElNauXY2MwmaT
	A2bmPdfMMoyxUVRai2hLeVrLASxxrZsIi1xEXSpuKIpnRmE9QxuOgEuxOlXgDucc=
X-Gm-Gg: AfdE7ckKu2AdULiWlqerNS473UcBdYBfb1/CvPYQKp5DfWTKMmVt9DhCUM4wVvHcSuS
	n6Onpq7GMYNzILUMhr0Od04m8YBn2Z3a5AlPKlRn7ucM/JL2yJZYTUycGLTJSv5eM0+dRws+7in
	N+Egp39Lg2RcDvDsriwBLc66m7dRHQHILFRu/46GlUDntS7AhQ4xTlCyVITGkM82/WIdsVSv/qD
	VrvdwRQjCeGJzFmy5lVRzR6+Fo59UUDVGAohbSMrSe8zrv00ZrHbyelXP+1QOSix+1Ehva+TvpS
	5qNWhkkIhmOYNyWCeu12hYKe8Y38rT0VsuUSV6N+ratYyrIgBhI3EfKqGGlkIyOv4VnvO1dryx2
	aDvGHuQax6AGSkqcmmlfNPjE8ZBfZl4JFbgQgmoXdkLIlpXd4fxEsF69kaK/tb9t+CB6fSAjcpS
	LCm6DMmCdcX57gUCxla0TRFgXjA8BZOqFzZrvWkGNT9KwtilqF9JKOnVgAvIxqy+QRDSTkw9Wix
	U275w==
X-Received: by 2002:ac8:5a46:0:b0:51c:44c:6ad with SMTP id d75a77b69052e-51c8b301983mr79491661cf.21.1783608561341;
        Thu, 09 Jul 2026 07:49:21 -0700 (PDT)
X-Received: by 2002:ac8:5a46:0:b0:51c:44c:6ad with SMTP id d75a77b69052e-51c8b301983mr79491351cf.21.1783608560738;
        Thu, 09 Jul 2026 07:49:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd88aesm9342636a12.3.2026.07.09.07.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 07:49:19 -0700 (PDT)
Message-ID: <158aa658-3109-4b7e-8213-1cc2cbd5aeb5@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 16:49:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] firmware: arm_scmi: Ensure automatic module
 loading
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
 <8c2a4ae3-95cc-489a-a7a4-90a3ee2597e9@oss.qualcomm.com>
 <20260709-spicy-fiery-squid-6eec1d@sudeepholla>
 <dae4deba-7e5f-434e-80ae-89033bdeb793@oss.qualcomm.com>
 <ak-h8oPcL69fCUg2@redhat.com>
 <f05860be-dd75-49f8-b27a-bff7b554e71b@oss.qualcomm.com>
 <20260709-exuberant-galago-of-spirit-1c908f@sudeepholla>
 <5fb236b7-7b99-40fb-b80b-fa7e1dfccd70@oss.qualcomm.com>
 <20260709-exuberant-narwhal-of-correction-7f4650@sudeepholla>
Content-Language: en-US, nl
In-Reply-To: <20260709-exuberant-narwhal-of-correction-7f4650@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX1IoMfsmRABtt
 KtpsV1knfgrIURJ/UgTMkuVKVQytv/IgiOSjcJ00AUubFzbsmR9CppOSd/8LxIl6zMrkdE+P8Gg
 1wk6nBycMhVq0pWsYmdL84BwxkjjGaPiAmn041GYeo4tWvHZikGSb2FD8runBZz+ra0YRGouH7Q
 xG2kDUVR9Bj8DH2VNCKZY8h3gPlCfD4wCK7wsVOm1Ud2gDHPH2Kup7zLrT079QTOl1WO60iakUX
 B0tUgN6w0W8OTEuwgcUk2o7ih9ZPx5I4YWEaOMtO0ZL3Qd8yePXgoSoRthu7fGBKbKIUFFeALF2
 LEFMxANEERqBgb1h18SHfWOQdRg4irC8Q9m+PcHk4RuiAnY6oO8EKNgxpcgVTD9WjGeJ0ujld5h
 sPO/Gk+/TiiN8yoc3ar4Peq+eA8SgakHPJvvVhQ9NJez8XEpEWsFOL0mZ5lu1n61N7wQ0ub/Pm5
 4i31NBQUmjjw8QLywJg==
X-Proofpoint-GUID: NDdqDfvNbgKyb8Ft0qhmolzdM97AeZAq
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4fb4f2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=LBz1ya_SPPO7fqYsHhAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: NDdqDfvNbgKyb8Ft0qhmolzdM97AeZAq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXwydBKva4i8mw
 mmU2YyoQ7UGGLY7ZgcAiUkIGSK5W9zzGeRFyhrWeJEE1ITVyF26DY0uHrgc7lMifnIaSMD6aENF
 NYMUsitpQcA+zw87TiExKPVaz6SvqiU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090146

Hi,

On 9-Jul-26 16:37, Sudeep Holla wrote:
> On Thu, Jul 09, 2026 at 04:31:00PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 9-Jul-26 16:21, Sudeep Holla wrote:
> [...]
>>>
>>> I need to recall why we moved from static list of devices to dynamic.
>>> One reason I can think right now is the vendor protocols and their drivers
>>> But in general it was an attempt to help multiple drivers bind to different
>>> scmi_devices that have same protocol ID. E.g. the performance protocol
>>> can be used by cpufreq and devfreq/performance genpd drivers.
>>
>> Note it is ok to have multiple drivers bind to the same modalias,
>> depending on the reason why there are multiple drivers either one
>> should detect that it is not compatible and exit probe() with -ENODEV
>> or there should be some other mechanism to make sure only one driver
>> loads.
>>
>> E.g. duplicate USB device-ids happen (they shouldn't but they do) and
>> then the drivers typically figure out if they are talking to the device
>> which they were written for, or the other device with the same USB-ids
>> and then one of the 2 drivers exits with -ENODEV.
>>
> 
> Understood. Sorry I tried to explain with examples assuming you may not
> be aware of the details, but now reading your response, you have better
> examples.
> 
>>>> I wonder if we can just move a small part of the drivers
>>>> (some mapping table) into the bus code and then just have this work as it
>>>> does on regular busses. I hope to be able to make some time to look into
>>>> this soonish.
>>>>
>>>
>>> I started with that few years ago and we then moved to this dynamic
>>> device creation. But I agree if it is deviation from the norms(which I
>>> wasn't aware of at the time), we can remove it.
>>
>> Looking at the issue this is causing for automatic module loading if we
>> can get back to the bus enumeration code always creating a device without
>> waiting for the driver kmod to load then that would be good IMHO.
>>
> 
> Sure if it fixes the issue for you. Cristian can point out anything I
> might have missed to consider as he is the one who reworked it and made
> it dynamic device creation which at the time sounded nice option to
> solve the issue. We weren't aware that it could cause such issues 🙁.

Note that before patch 1/2 of this series we did not have working
module-autoloading for SCMI modules at all. With that said yes it would
be nice to get this working.

Can you provide a patch for this to try ?

Regards,

Hans


