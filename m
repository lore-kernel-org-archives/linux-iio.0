Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5119CCF5
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034983; cv=pass; b=Z+KT5Q7SnDmQndbxlNTevs3DlcOt90GANsCRuN8QfNiZZtKsma6wK5yRcbgShoyQqcsRP0Z1Bh/gHDNCcRiR33/g0ohaSikH92w1NQBDgJiTqgAzs5Ud+vvFtrTlDHj/8OPMis78TCegJ+FfeJsoof+u0EEkjzOFOhAR2NMITmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034983; c=relaxed/simple;
	bh=Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5E+NepYULisSrXdEOmN9DQ5dzhiR/BdO8O1ZOiIegladsO7xeN7r5FbpBqw/hFQSt5HqzJIkV/QxoFUnzFT5+bO7uZKNcK9pWJDD9vA5abSHi7jwS3UygyToyXSeF6XUZoB4V0wltT/AKoJOogxiRd6Qx3IR8Vne0HkR0n/4LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jeDP1noV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cioL0yS+; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jeDP1noV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cioL0yS+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBmolr473949
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=; b=jeDP1noVY97TJJm4
	cIhajSXeAsAmHOxUZ5w+rrnFsmDqOKfN4qv1NciKwvl0a9vv59ESqt6/YuJgOXKd
	2U4f3xsKnro776B5eQXUkzzonn9zUj4EjUY0CcmNrVrEgX1hsU92QRCgcXc88Zk4
	AtF76m99A0GiWR0qvmuA/OQHihEj2e1+CtLRE0wEH12PxEsaH+fBoJe1xohiHUcX
	R229DzrrEXb5VIR1CijlNq+5VjsfmV0mgJza7rCEwLCI9oqIAHjuyOO3YurOejU1
	OXk05tjGT7idOG9xzgxgye2BrDtcmOkjjdNsDeOVdRx43SKY0RtvrJ1yvDvre5qj
	UD2uKw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq0cd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:16:20 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-904ee4473a8so47973876d6.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 06:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784034980; cv=none;
        d=google.com; s=arc-20260327;
        b=gs1hdvWwL+dF2Ta/eVo322eBoPvq4UIOzHcdKRDIRVOBIr56vbFpiePPxyhcHsJEHS
         aJZ3nOd2LOhDXbu+OwZHYL0gB3GA9DTVO0pKxDMB2v+KIsyl3ow8gmkADKT08LYhuBev
         PQdB9jQ20FRDLIeV1K0QFo4KIvThU9pMJVvWzKbL9ZSGbD1DBzaNO3O4jQNdy57xEis1
         nJr4Je0crVOyGlzYlMhZHufXg8lJLV8mmX5uMlz/BCa1RSEHsO429JW6nlUBHbn00UA3
         rgujsgK41NhHHs53hXdUp+RWVQd+ZliIi6ebzGu5XRCGmtLqpDYmLnRqVPBgdCB3IjGO
         2tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=;
        fh=9/DgOAV2Erm7XwOi4pfea/vTQijSAgfCX6Vl7v3KQBE=;
        b=atebzM+nTzhrdZ3R4XVRymCnMNHRmPX/FGr4drxAuFUv9W6rKoJGVf7kSgIhex2U95
         G6q12TrafIy3OxsBOz15seDT2EMjRkjjsxElPmYQ2pj5eYddBygQauHQhr49gmZRLG2U
         1NHVi1KiVnsNks2ZbOQ98W4ExaVdu/8uNS78gZiVsqk1/ecuKDVRx0SeGVm0gNJG/OCe
         y/I4arwwxb9Y55Vn981QXD3fan27xEYkveObBCaPHW164hjpLvSOE03EyXRzgvyA0uaD
         uBKwr4wgHhoQGf2J1UxkETC2JDWI2ZiDPauFz+rbgJQvfH7mWNN9D4w/m/mIgOr5o7ZF
         DQxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784034980; x=1784639780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=;
        b=cioL0yS+m7iQ+Un4y9KPRfCvUwbZxC0xQRu+SZmRcgaQHlaMpOuyJETcrk+xsCydJS
         rx/JXZ0vlPSJ46zxZ/moLbkLzEFFO0TXJ979XZx4o6mPym2i9kzroOI5kygxFEe6Bi5R
         LgVxo61fu3nXasj+kizAbtRICOyjFgRCjtp6XrZ7uzeP0UIS813j7bgUxON3fRhe9zGY
         e7doqxvCPS1+FdTC+4IGTzIMO34POO2/rH3keQo332wYpg9bskUCjm7FIcDtJLzWa07O
         /D1x4xq5YKRCc7P8jD/k0p8unDHZTD20lZwtiaqEydbmFKT/XzVNkmPqitS0BB28LQTQ
         x6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034980; x=1784639780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=;
        b=L66u9N5HJN4YeFnKKnLxKwJHh9cCRh/FA/wZqBucPY4AevtvF2Z1TKTR7YA7Oz4pLc
         7FE+NgwbrBmkjS+zyov67X6iO9GtH9OV9xT2tDe3F6Kj/KtRt56TiJqSegL5Eh0jqqu+
         PEhDVC2RsMQh+owflIojLk2mqXsF1j8TTD+fdKSY7jjuahHh6HYERQMbdzbvIZQ0MolJ
         ykZkp2DnDQZ1/6nd6we0YfMqz4LZjBogsZmsK8puy2fE4dUc/W2f3jFhw4AhD/3GHWrJ
         h8kaMwavQyi2zVlSlBwZV+QcOkVkVpOp3ZQGHa62iFh3bmd06gDl/J92OpewAt4AbU+T
         O04w==
X-Forwarded-Encrypted: i=1; AHgh+RqguwYvOyG5mG3YAMCnrP15s01eNjHvL8A5Z08c7NMag3t36u+mCgSN3s3iBRPO4dNW4Gx/fESybFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GFZiODBlB7wANecLa5aZPIOLHvVUHCvOzoXELHh75PYxvx7z
	WmPNvKW5qhTP0zrxlXtQfALAFYYN4T2YXT79IrlVy/hKEA9DhuToawhhyHrhAgNVlSHb7AbCqlR
	ZW+9P7w5re4tVxYB5TNh7jvApToYfeR+FOkrqCxTd6OvBxIPtbzHwG1aBQuXvgYII1CAvpo/2jg
	Y74TwzKhYaJhtJhjA9Kq0FjvTonVSgPnKGiTwHmA==
X-Gm-Gg: AfdE7cl9TDCbgDMlhnUjvCjbfHREbJph09OB0xV5mAciufKVYtRJEp6Mh1YvLe6DaDm
	KeTgzW+j+cR/RESZ9pkSnViE2Zp04u03o0z/gtcCWQm/MUr0hXfRMEK9kInUW2cbm9P10yafxQA
	aM14DsZF2iqGziBG9Ym9eqwCatsbUU4x/ypiptnUfHDaWds+R1m+88vfaI+s11ee7O0kBV
X-Received: by 2002:a05:6214:2689:b0:8f2:67bb:a37d with SMTP id 6a1803df08f44-90747d19fb5mr45880646d6.57.1784034979515;
        Tue, 14 Jul 2026 06:16:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2689:b0:8f2:67bb:a37d with SMTP id
 6a1803df08f44-90747d19fb5mr45879656d6.57.1784034978901; Tue, 14 Jul 2026
 06:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
 <ak_Eu_eQKalPMwo-@pluto>
In-Reply-To: <ak_Eu_eQKalPMwo-@pluto>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:16:07 +0200
X-Gm-Features: AUfX_mxKzpq6RPl9OYBnCrjfKgjOcnNPKcB_AjUZghzaf78uP1r8iO8ekjIwd1s
Message-ID: <CAPx+jO9KMcxnmt-wT5jaApj9p7s11B6eSG6K08Jt9J=-vXxjhA@mail.gmail.com>
Subject: Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, git@amd.com, vincent.guittot@linaro.org,
        Souvik.Chakravarty@arm.com, Alex Shi <alexs@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        David Lechner <dlechner@baylibre.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Len Brown <lenb@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linusw@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Pavel Machek <pavel@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yanteng Si <si.yanteng@linux.dev>, arm-scmi@vger.kernel.org,
        "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
        linux-arm-kernel@lists.infradead.org,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:ENERGY MODEL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a5636a4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=7CQSdrXTAAAA:8 a=K75D1l0-MnsISjLg7T4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: BWZQAdFB4A_tL1qVDIzq_bS577tfZ8F7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzOCBTYWx0ZWRfXxYGCFmj2dGye
 0mPWBzXrjWCuiuAnBW/VvOB8G2XcSN7KujSw8vUCAChc41kS9edyUT4aUtABAUqc58FDZoY65ad
 te8JRoCp0uPYlzGT7yXERLiI3JjL9+MH+yadM0dCGZy/pkDZgU4kyaJrWGQimJR8YFioA+nnsDK
 Qcg6OhwPytFYFnM+ywM1oY/csNOPOjDmUp6o0zt5DqJ1iwSSiNUzykH+Y+bmKiSUYdGIGvqpAK8
 kMg/nRXkrl56mH7noeaTgjxc4RY5D1RJhI47/ym8bZ/RKJ+dVdAmxAmYLV+51/3mmb8g36dyHD7
 1xFh3VtbkAwNDcL1yCvikY+dZC6N8XrYgBJ9yPUStbwUK6L3eDUHqnVJA4X8crlFTyI4+zD8gW6
 0Z3BOE/V2IXGj9LxaNatAoZMbNhe0qVV3qAknDXzbs526Xl5mhTh0llftK/tD24+J3HKDbusqj8
 9aqmJHVDnQzUB/UeegQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzOCBTYWx0ZWRfX0+/Hs8tHOV1Q
 lGj5OwjZpBvbv+6QjmgQSWfZK2zGMPBT+5dA7BvgrMXkIZbEffC2O/M5+coVumbKXv39T+sH6fp
 Qk++NdIF+rF/yZXppDT8Tj1YGERU4fw=
X-Proofpoint-ORIG-GUID: BWZQAdFB4A_tL1qVDIzq_bS577tfZ8F7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140138

On Thu, Jul 9, 2026 at 5:56=E2=80=AFPM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
> > On heterogenious systems like AMD/Xilinx FPGA there is a need to talk t=
o
> > SCMI server from different architectures than ARM that's why remove
> > ARM/ARM64 Kconfig dependency with also remove ARM from description and
> > rename folder to reflect it.
>
> While I understand dropping the dependency on ARM (I always wanted to do
> that and test if it worked at all on some otehr archs with QEMU), I am
> not sure about the whole renaming party ? why is needed just for
> cosmetic reasons ? it is at the end an arm originated protocol so I dont
> see it as a being wrong to be named as such even though used by other
> archs...I have not really strong opinion on this...

This is certainly not my call to make, but I have to admit that I
fully agree with the above.

Usually we don't rename files that indicate a legacy platform name,
just because a new company/platform wants to make use of it.

>
> ... my concern really is ... wont this full scale rename simply generate
> a lot of un-needed churn for future fixes and/or backporting ?

We have some git magic to overcome most of these problems, but it's
not always straightforward, I think.

>
> Thanks,
> Cristian

Kind regards
Uffe
