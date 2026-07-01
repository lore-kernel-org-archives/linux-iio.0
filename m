Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8C3AD524
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936919; cv=none; b=cXP8Bo5c99Sp632Y1TVwCideljsXIhma1Kw6t3ZyVsS+wykBlDdmYTNA6U5aiJg8lOhTPFdSLN7XCT/L5dCtoZ+ByGA6WU8kng4yALdmQuRfyCqIbbgoSlUvRPXHBKDPrVrkDNKYRLTFQTbScx4CZP00tTQaMdJmZtftZ6gd4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936919; c=relaxed/simple;
	bh=qbknqAYZmPxfRwbqcU3Sz00LFa87wd+S4zJeOJIzXSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svBbg9zr90gePrcr2TXBkQRnbmDh7XOzAlazwshYBqbvwiZBokGsQ2ypla+g0lalu9SGujfkp2bJ7ySis7YWoGK7IHfmP+85W5UUL66X79CZQ8galNriW5f2F1Sy3y3R5kEPWyWe2sPRQeAK8Zr8osCOBTOMfyLwY1dYN+CtlsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJMD/e9z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BZ13DhTp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJMD/e9z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BZ13DhTp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GnHYt1709733
	for <linux-iio@vger.kernel.org>; Wed, 1 Jul 2026 20:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qbknqAYZmPxfRwbqcU3Sz00LFa87wd+S4zJeOJIzXSg=; b=VJMD/e9z7HUThUD2
	L5GjT4qqw3dMF7M310mF7xsS6p0DOG5vuvctFE30BDECahkwx10QRUoRQ5EOfh8G
	Um2bGmtC0UxJx3Ep2kcZw9U72hmyDIcp0WtXq0U6eleoVFGubytVTqNSyOkPBpjJ
	TxOmt9KfIxnhpDoizQvnC/kr6hlp0+nOrPuMN8aUh17YUDL3tLvTzX6FwDYuIq22
	I28OIlygKKqLvsIGWWKPlRTb4skRNPPhofsOSWx0PAeWLppy93RqnXuZRdDIrswB
	jcWHyHZi2BHl/0PuMdK3rMuI+TFJIu2nGF7DoXehJRyH4eBFwdI0quB2/29l+SYY
	iPhylg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqtp7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 20:15:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fbdbc4d03so1292144a91.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782936915; x=1783541715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbknqAYZmPxfRwbqcU3Sz00LFa87wd+S4zJeOJIzXSg=;
        b=BZ13DhTpB05mvoFmjf7dXjhhkN+iOSro341hQqAxxpje4t5ET985ZXYji+wkiaUXxQ
         aKtr16KYEWkxvSA0cPmW/R8cJJ39kZeTFjA5V70FeVQfB98g/zXx9Nb6VhKyO3YP760n
         5P+W7suInigpqjCpMeTiWrDnEBhBfPbTLr/pbA5Q2I6KvH4TZCnbjHqWIzzWqSGREMS0
         QJsXt2AfwKTFbZjwROV29ZlIkTSngKX81h0XJS8inZKcDDoOU0pl7JSz/i1cYlI5li45
         be1j5Z+8dAG64D1KiprClPzwrSRK0KY0Qm6+4EP+YXZ0OkyabUVw1r9G0MpOVROzH6o+
         LXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936915; x=1783541715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbknqAYZmPxfRwbqcU3Sz00LFa87wd+S4zJeOJIzXSg=;
        b=d4hNf7jeaLkk3d1cZ8uhQIMxwCINfGq0zs3uKQu06pKUFIUKiCEwTa/YayJUJbzrue
         qxJSJSsAripJ4+8erdNgt87GDZhHDKGbu4smh3BJ4F3uBhndHwjFIk4j9m2S1dJd2moL
         dWXjfnRFF1WxW+PHokXznJOjGl5uh4yIeONu2qkEziRxaq1akH1Il7GBfZHKcvKaf36n
         HEWhT0Z2D5vGQ3UKzzcuaqyhvhwKk2GgCMF4TY0J5jUWv5lVxByW/MFb3gqFLR150csQ
         ntPVlQ+d08o4pirwQsLXOIGiMS5dvDboQrjcJoHxKGkHjGGR1ASOHne4BASv/A4GT02H
         8eDg==
X-Forwarded-Encrypted: i=1; AHgh+RoXcePRKxNhsOUjODHgYiSGtQai41GFR+IzrUbl0S7vCPtDDlq7wRxV58bF78dtrN1HSeOCo+KFlJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrc+ak/3l8FSnY9sGTLhtCMEdj7naaKFvRtTaZ9u+2HjPhcqS
	Phepannyd3oCCfuz1zmN7M9lOPoFGsucv/NJeOlRGrAG+BW8gizPNr4dbEFxuYRUtVYKam3J6x0
	Q+6fXJa2kG++22o7Ki/J7jk0HHYty8QqlzyzC4IEH1gZcU9NPizzHiQ8O3RfWoJY=
X-Gm-Gg: AfdE7ckwBAmUgQKqKHiwm3aK+q0XRTZP57yzsenS3WfWu1hkD75I4GMIdzf8Qtl7126
	e6X3FnqYt8lcjkfP1QJWI8FBFTg7U5tcdWsA4NnPD2gxEnO6EQjQUPL0hlU48LPEKO7Qr+TI3K4
	bfz6Bugkj4ZMqYpbiBg8MtBsTjJbPCP1m8nhLkoPpc4fxcVH07deiteMutQyFZ6DkBSq9ICJXBb
	qjovj4z49AlE57y6pNO5pSE3MBlM4Fah/XH4fUVHFYTzbMLusu24/oI+AWUclwmlraip/qKuHFd
	/4MmqU7J2FIYw/XtALC5F/hTHvs04YamFRpAXnBIWHx2IOelDFXYNmOVAdu9p3Z83gD/a41JZ9q
	fzEJFlTRSzoxtO24mfsBZ3OfWXAzeZ0tmjVyG53DC7gyOwGoShk1JnxU=
X-Received: by 2002:a17:90b:3e8b:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38069c56f8dmr6708434a91.15.1782936915336;
        Wed, 01 Jul 2026 13:15:15 -0700 (PDT)
X-Received: by 2002:a17:90b:3e8b:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38069c56f8dmr6708381a91.15.1782936914545;
        Wed, 01 Jul 2026 13:15:14 -0700 (PDT)
Received: from [10.73.235.220] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc27e0dsm872064eec.27.2026.07.01.13.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 13:15:13 -0700 (PDT)
Message-ID: <50fa76ba-91a9-4bab-ae85-46f7a8a9f1ed@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:15:12 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] scmi: Log client subsystem entity counts
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Jyoti Bhayana <jbhayana@google.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
 <20260514164422.0eba9a61@jic23-huawei>
 <8857fc71-aec6-4682-b4f4-0bd463f367c4@oss.qualcomm.com>
 <20260515-strong-lionfish-of-effort-f74c7a@sudeepholla>
Content-Language: en-US
From: Alex Tran <alex.tran@oss.qualcomm.com>
In-Reply-To: <20260515-strong-lionfish-of-effort-f74c7a@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gtztO9_3RuoRSU4GnNijSshF0e1QmfVU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIxNiBTYWx0ZWRfX8X1lMWh6AT/R
 YRUJdZFWMDsOwMW8Ux6nkit5uU/SLRDiNGJ2mR7mpBtWPRSlcAyfyFjCugZRo4rt34Kbtz/FzAd
 s0h24LXVCb1apBexBomyDbHU7XWm1zo=
X-Proofpoint-ORIG-GUID: gtztO9_3RuoRSU4GnNijSshF0e1QmfVU
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a457554 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=vxRzfglfhILO5636UqgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIxNiBTYWx0ZWRfXyMqVD1kKQ73+
 hxER+Ran6HR7Rr9+CxOY0cXp4ygQpOGTYQxsdvClasx/ABbqedTb06LpB1nGxe4Io5hYIld5vXy
 jxhWpeAFj97SB5KjFq9h9SlwtDxIx3hA9fk8Cuxaa6xC5cg43YvdoU6vcpEKkGvEPq9JudzVNaw
 NQgCbMQptcWcP6ljMI2MAGotU881KnhnaTSQH6i4I2HHC9xHkKGombqSiJSGP2G9ZKABmgmVpDc
 fOPOyZcilS+Ic78TNIZXzHiE2h/sUZ1KGmhJitN4JUx1wvttc9XzdlisIeNpnVrCXjO1iR37Xe/
 IhX0eqkhz21LJzvr1QxD1FQt+3XXeE+7pX7PGQkEfgr8wqGpdReW9/BoEta/6YjJqj7pnT/sCCb
 YXhAbFWYiNdrRfoPc6CjkLrchUDHbjTQ7OrE5GdlovRw2WnAel7nfoI8x8DXFQLmlg4P4yOWDdR
 jYl/GOZLmjitdge5UNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010216

On 5/15/2026 1:29 AM, Sudeep Holla wrote:

> On Thu, May 14, 2026 at 02:23:56PM -0700, Alex Tran wrote:
>> On 5/14/2026 8:44 AM, Jonathan Cameron wrote:
>>
>>> On Wed, 13 May 2026 10:16:53 -0700
>>> Alex Tran <alex.tran@oss.qualcomm.com> wrote:
>>>
>>>> SCMI client drivers do not consistently log the number of supported
>>>> entities discovered from firmware. This information is useful during
>>>> debugging because it shows which domains or resources were exposed by
>>>> firmware during probe.
>>>>
>>>> Add logging of the number of supported entities to the SCMI cpufreq,
>>>> pinctrl, reset, hwmon, and powercap client drivers after a successful
>>>> probe. This aligns these drivers with the existing logging in the SCMI
>>>> power and performance domain drivers.
>>>>
>>>> Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
>>> Hi Alex,
>>>
>>> Just curious but why +CC linux-iio and IIO folk?
>>>
>>> May be you had a false suggestion to add them from get maintainers.
>>> If so be sure to check it's suggestions make sense!
>>>
>>> Not to worry - we can all hit the delete button ;)
>>>
>>> Jonathan
>> Hi Jonathan,
>>
>> Originally, there was another patch in this series to add the same
>> functionality to scmi_iio probe but it was dropped. Apparently running b4
>> prep --auto-to-cc does not prune stale entries from the cover letter. Will
>> manually remove all entries and rerun the command in the future.
>>
> I guessed so, but why was it dropped ? I don't agree to adding them elsewhere
> just curious about why it was dropped in this case.
>
We could not determine whether to log the sensor count provided by SCMI or the number of sensors that were registered in probe since the driver appears to only support 3-axis accel and gyro sensors, skipping the rest.

