Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650F3B6371
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793842; cv=none; b=mO2Q4xwsu1b6dP/kXHTwRDsawNwX0nQmDr0n929RQwzflr2JY7SErHuELQaC+vy1CA1rV07TbIyIgcsNADEp6+iKeM4jFIJ36dhyJh/CS9EKfGTgdCFIUArCu59uEBNribwveme7zCoNuUv7ljHKJRJlL6a/WlTKdc7r+6REX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793842; c=relaxed/simple;
	bh=Wi9wq6ITuBhZ0//XzAr/F1HphLRzl3ZxiOclMvD0KoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYhmT2+PgkVMZ3V1sBElJ3/db4GJmOGZV+EwXTMCuNDmdPyNemuKgcJ+EOoqOh0b4m5vPWComliKrapnZCqWbGI8GS96H5bS27fGNApKHG3LSKhNnC12pfVfwDFNNqrUcT+ySa42svDeZMftR1gSlAXtWmamdZm8vOiyoRpvSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pB1PvYyE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BC/6aT81; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pB1PvYyE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BC/6aT81"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpg1Z3795697
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 21:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wi9wq6ITuBhZ0//XzAr/F1HphLRzl3ZxiOclMvD0KoE=; b=pB1PvYyErK43eAPY
	8GRxW3u7AM7AHohNM0M3cHCMCNo1VwAlgiEmlPBRRhAH3qzvDhBijYNB8Mozuu1t
	A0lh6pes7yXko1c9nG+m9lUnW0Id2COTnlBJXuVbwlwJcKrTpdQyWe3r3T1io7Wj
	SjhPG5n4X8xvsENTS0CdPmtrRTaEQKdFIWa0HxwsCZDv1rMxb4234qxcRW5FPYMB
	6eFs8mtHEJekZQyzkcvtIws/TE/h1OvUe7QYba9+pcSqPKlYR/Ya1dKobZLgN1kS
	yEs0DqhocJ+ok1uVUHzxmQen9ZwP+lp1oWjuC5BaSko7GFzEEpB+JYeXEl2cRUyP
	AHWxDg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sreeb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 21:23:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so7177931eec.1
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778793838; x=1779398638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wi9wq6ITuBhZ0//XzAr/F1HphLRzl3ZxiOclMvD0KoE=;
        b=BC/6aT81v1IKW/jRwglaUTZ4VgJb2m3X6e9uWA651mOdjSw+TgBCXkCV7f96Pw1cVl
         wn6mSAxs4FEVjWeTtHXkzZtKjJV5huI2Zn7f+CDjCiriUFZLuPqDIG5YBVR5aldhMLXI
         ci/VRXNk3Utuwa2don0zO2DNcyJuF//bCB/n3OJc73fNuQJhS5wB95iVyekLwW1+Nd2d
         E6Uq5h+lRYDiFrhoqqChO++WST91KGaUC1AO5ucDI47A2hiC5JzpAM3B/iKZaXBSHwdc
         Qs5XTy4XIjQf/6X108DAOmE/gUwpHCQJ1bDiJkcL9Dl41ELCKjU07Fw/MmIY36QF3jML
         c/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793838; x=1779398638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wi9wq6ITuBhZ0//XzAr/F1HphLRzl3ZxiOclMvD0KoE=;
        b=Nh1hQWxjovnMbDWMH9DY2wg/G07hFuCwyjdB3wJn8cHIEHUMNJsUWxkovjZl4qgZAh
         hfDScS5Va6E6PfKNTAB7st3OjIDQVG7uj8ZHcOdIJd5SWJL2/SmBaMknOTDUTxsG0JY3
         UQK9SQSHmvlM35VBdWdE+XHrFCKMJUYqKj5LRXxWsjnCydq/EKfh3ue1FvgycGltIf6G
         dtduH7+7ySi29WN3EH5I8Gl/R+6Z/0OGOaiqrnxpfAWHHkm8hiHx8e2exROBU2NSJYO3
         OJfNfQqboYSf627W+Si7rj4bFKvWJLY3FKQhRwXhmiCgSjkXsar6UdkvC6/NTJNOEeBO
         yudA==
X-Forwarded-Encrypted: i=1; AFNElJ9F1Ug1hv8/To//grXd1/hWcktcAEnRZ/rPlTyrRIZsWsD0JfnSv80+/efb2jBrqLjsjQbdNO1my3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzro8Z9EMHyhes6j1fh637mlV/NGlNtV8hPaiCZ75bPUxM9q5GV
	mdcwEUOOKS7CtXRH6HuY+cc/cXEgOXj8T9/LHEen6Cyjlkl2HwJ38h0VT+nBCgGVYBKGLkP4sT6
	9IiJje2XlyboyJ9kRTppm/8nKZp5pdPu5JY6lo1ALMU2GBzgXBOyR2GHzBs6Fu4E=
X-Gm-Gg: Acq92OGWEAVpeE/TGnjb/UANOFrCHzh1Ceonn2v834/ywD03ip8yADl/BhaAZ/EwKsT
	jeVAW28cdzRzValzeFWMOSeFCAr/maBWouNx3Ba3LKOAlFH2HzFZUGPC/V8YAv+rmsrjNX0Quch
	QOg9mNoR7d2l63tYqs5ObBBSHUCcR4l3v6BVGFzNonegNdjGsopj8zxRnU6zBxVgAClSZdpnuiO
	IAlWSOd73NscpReYerDGlBazrIJVFhaazUwZ1/Ys9zczI7NbrMFof9/htXL2Xs0mrp9Wncvtb7N
	FvtfvD3Trug308m0DLjVMDLPuAGpCdsjVInEbK6NEZrTunR525BwO4cyCYI41gteGq8FXwP9os2
	aSrJPVq5l3Qc9FcIg8TbZrVpqiYoOw0HbG+fTwadxCpXPqIgph80ipGa/DNkCSwRPG9yOdklK+M
	Gm
X-Received: by 2002:a05:7300:724f:b0:2ed:27a3:eae2 with SMTP id 5a478bee46e88-30398189fa8mr789533eec.15.1778793838370;
        Thu, 14 May 2026 14:23:58 -0700 (PDT)
X-Received: by 2002:a05:7300:724f:b0:2ed:27a3:eae2 with SMTP id 5a478bee46e88-30398189fa8mr789513eec.15.1778793837795;
        Thu, 14 May 2026 14:23:57 -0700 (PDT)
Received: from [10.73.236.148] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302946f2149sm4468333eec.11.2026.05.14.14.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 14:23:57 -0700 (PDT)
Message-ID: <8857fc71-aec6-4682-b4f4-0bd463f367c4@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:23:56 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] scmi: Log client subsystem entity counts
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jyoti Bhayana <jbhayana@google.com>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
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
Content-Language: en-US
From: Alex Tran <alex.tran@oss.qualcomm.com>
In-Reply-To: <20260514164422.0eba9a61@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIxMSBTYWx0ZWRfXyQq/7z94wn5G
 XezIIr0Q79yhvZCDopGWy9N4YBjbkmm2/7sTnRreupG1Q0RvWOpxlLuOFuvV1ZKx93/zxtJcRyC
 JksRqbNQBdChETe6W0MkxJaD6USGmTR6oIRY4TgC80nPH8K3YyqzKJ9JTmInoC5tPGkR03qwunQ
 Qy2NRpvtFMkL89wf/Y5yUOGvEps7ApcoQr39P7hEhZwWbCA0bwme9Bv8Ek3PzvEAxVxasxwjJnN
 rpExI3LyVOBTNJrNeWqwcb5N5jFBXIyA5CXRtPRrVstZxr2aiH/XApUsx2PbiGy2WpT6qeHD503
 IEPiFMOu0P5KQ9bF80qeWOi2G1MxZse9Reqt1News1SsA8N/Ge/ztlSjDjzNMD9S18KYOPIvMBE
 g3PXuK78xuk+ugRH93DnCfT+fITmRfrR2BF2IaZlte1fKOwgOKhUqgK8gf5t9dWFaWZ9nn5/d5a
 Ug2L8vp1VClqE25IlNQ==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a063d6f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=yQWfTViADuQTjb5oKp4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: lH5GKhah1xu2LVrWmV7t-UU8W_HmGtZq
X-Proofpoint-ORIG-GUID: lH5GKhah1xu2LVrWmV7t-UU8W_HmGtZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140211

On 5/14/2026 8:44 AM, Jonathan Cameron wrote:

> On Wed, 13 May 2026 10:16:53 -0700
> Alex Tran <alex.tran@oss.qualcomm.com> wrote:
>
>> SCMI client drivers do not consistently log the number of supported
>> entities discovered from firmware. This information is useful during
>> debugging because it shows which domains or resources were exposed by
>> firmware during probe.
>>
>> Add logging of the number of supported entities to the SCMI cpufreq,
>> pinctrl, reset, hwmon, and powercap client drivers after a successful
>> probe. This aligns these drivers with the existing logging in the SCMI
>> power and performance domain drivers.
>>
>> Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
> Hi Alex,
>
> Just curious but why +CC linux-iio and IIO folk?
>
> May be you had a false suggestion to add them from get maintainers.
> If so be sure to check it's suggestions make sense!
>
> Not to worry - we can all hit the delete button ;)
>
> Jonathan
Hi Jonathan,

Originally, there was another patch in this series to add the same functionality to scmi_iio probe but it was dropped. Apparently running b4 prep --auto-to-cc does not prune stale entries from the cover letter. Will manually remove all entries and rerun the command in the future.

Alex
