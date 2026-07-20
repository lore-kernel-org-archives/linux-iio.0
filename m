Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A343F08E
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512327; cv=none; b=crLZH/eNq1dbUMb8MSRkB6OdydzmUpFM9QSa+tWOOPQtQxR7wH1EFMLBYhCMUK8+iFyMgYJCz157NsMi/jYu/maVTkKQFJOvIipFOPmi4xRhU/r+gjcFoa6HWuQRgcaEbJKQrbJHqlDmNEPlcccV+UaLU+VZSA8eygSGStaU2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512327; c=relaxed/simple;
	bh=xNXV7CHiESp8Y3L4f5TERtE95DGHMAcJJRNNeGDpW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCOBcpoe6LlB8UBDzLmQqFN3/Pno2U2nxKXW8eSbIUep22gKkhLbM5gEX7sudzpgvR6lrEoZeZQlHL8KSJ8qEAw5WqzJzTXYrdgN9HBUY0wpM4MKy9aYvG+QrgqlyR+lKcDA78pL9ut9Yu8SV7TvL+pGfv7faLuEg/OPSsqD+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=osy6rR5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WQoLRE1z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="osy6rR5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WQoLRE1z"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsJNE1019488
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	llldCrhMZsUoapQDDMXWdEP1Jj61RZlmintU0Qnmlas=; b=osy6rR5ywB4Cr3a1
	Iw95ZF8oWf02fjzoER1AmERjZ5yQjk7TXKfybjRmiWH8Pz4EVWfvaatisa1TOEee
	7nBzC7+MVqjIIw/lMLGgywdKlj58T0aQLkeCz8ClmWpszR8fDkTxHsy8ub5O/F9I
	K38J7MRKTUqJpVayckp6aQYpMq/64R3rAUFWDNE2jAaGXqJss4z5nap33RAjwlDK
	PJRjU0no6Apwjseebh51cLEfA/V9Xxld1xhO9GBh/Lijn0w1EzMhkmc9PaTsDtDJ
	OytVizGUdX71mquqEDMMkb/p7/o8z+VQBhp4xKSuhJQt9yM/xEYmPKxiVF2YquX8
	vJlMiw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d93wdw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:52:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84842381150so17092953b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784512324; x=1785117124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=llldCrhMZsUoapQDDMXWdEP1Jj61RZlmintU0Qnmlas=;
        b=WQoLRE1zYlmBE1nrQ1+MnlFzvn12tNJv8ZMD4qRG+3fQ0dyMcTD+XOOS3jNSx2TbDc
         +g/s0XSWCxlrwomfQw69dhjl99iPYSouwk/ivpC8FgKVaYTZJSyMEUwsqE0yIWSKJ841
         hQDv/4+g5l8ORZhysinJSwqaDGygrG7FqHkMXBav5mfv2zkU6H+T1r3ufplNaZr0l/mh
         8ZZZE47TxMJmwAz+wlWvh/A50mYG+X5Zhwb6OU+KnBQKB/S2aYdMsrmXHL2gCqJ96PhK
         X7JlAysIMiEVU7ZSuB97GoU0lpeOsPivNrEhsKu/mP1ff4FLmtOO22DiIIinfj9+2T6V
         0d0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784512324; x=1785117124;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llldCrhMZsUoapQDDMXWdEP1Jj61RZlmintU0Qnmlas=;
        b=OnWgymSRthR+IuCIOr15TrLKWDZkvltQoSm9yVDMAFmLmxXyFF7gGdjt4l6PEpwHHD
         ynL5wILb+UTmrm9Q2yiWkwQUr3cpSCD+Q3nY6Gcd1+V/W8TiB3SsHi33HhJDryR1Phfx
         IyXTkRYfK/HYarQMD5AYuQ2agROHSdWUNQRmm4vANPKgRVP7vC30sBCYiCYMxqyYjlTS
         MzhKoDKwR5mjEQWJo6iKtZ/kUvVvxvJHQIz3ud2hyjRxAi9hj8KaqOOS11qrsiqfjAQQ
         SM1R6fj3VJAaMyww5Ce+mG4dCTTeUVGMp4lagLkxARWOX9lPowaqDqOW0Q/uqW6B6ocC
         eZoA==
X-Forwarded-Encrypted: i=1; AHgh+RrBSRZVM8oxuELrlBXBgrbcCsv+dEKbVtaDJcJOP+ZzBI1NZsDFgRKepxW3GFGzCLwWg0WDD6LhTIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqhHhSvXfDCklqaEeAxzhkDrLklmUDdSCmOlRv8KcyyNaQ9lXr
	qtnfFZL/yiO3eDFn6HHolRdA0oK0xH6yafYB7dz5fTGlvcVmgQxTiFDtVYtS4EbUinEQGNZBP2m
	tg/4B9syXlgODza6Tz0QbkbdP13hzCfMPvu0U6fqG5OckrZ1W2P0M2GxtaDPOdVS4jGVZrqc=
X-Gm-Gg: AfdE7clJQfGNMTYrZjR/qpICOZBK9ShgDIQVHkDaAmvsk5cD+whIt47cDa3wiHhCsIr
	tgVLwvWe2AYnKSxqNSexcHDRLgY/F9ZpaltO0TjebdGSsp87s6zjGXRif4S87+Mjf8e86SPPtx9
	qcCaO84/ugz4KILJ7H7rMhhbwvpTE731kM/tellYVKIZIXvBnXcG8gQKxctWlfzlcBplFDvpXEp
	VKTXbk073uroeuElm3tGzQT+dTQWaqlYopaprdQUTGe9WFhbjB5OE3nYTeHxyPJPUqdXC0fNC+b
	9O1URN+G5Vc6t6jm0aQ2h9WjC6CGi46fAfLD+tgJuWbhH3T/RBLRdm8eDTFlAKDd7t8JC+pAUTU
	taESAPHvO/sXtpODn
X-Received: by 2002:a05:6a00:400f:b0:846:2f3c:3f68 with SMTP id d2e1a72fcca58-84c295116efmr11503035b3a.57.1784512324382;
        Sun, 19 Jul 2026 18:52:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:400f:b0:846:2f3c:3f68 with SMTP id d2e1a72fcca58-84c295116efmr11503013b3a.57.1784512323856;
        Sun, 19 Jul 2026 18:52:03 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af3176asm4746440b3a.34.2026.07.19.18.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:52:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:51:59 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: OrangeBlack0765@outlook.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: tsl2583: migrate to sysfs_emit() and
 sysfs_emit_at()
Message-ID: <20260720025159.284acebd@jic23-huawei>
In-Reply-To: <alk7H41lph_OxMfb@ashevche-desk.local>
References: <OS3PR01MB824492E7AFD347208E0C149AAFC72@OS3PR01MB8244.jpnprd01.prod.outlook.com>
	<alk7H41lph_OxMfb@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5d7f45 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8 a=NZmT1WVQbrE6cRaTRNQA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: d26etwkJYKi0Mg7SUpTlQ20afQN4MJwl
X-Proofpoint-ORIG-GUID: d26etwkJYKi0Mg7SUpTlQ20afQN4MJwl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAxNyBTYWx0ZWRfX02tCUaWCuRgo
 WIYEMSywKzgqYKP+Ax7V7eHRKlpxOhglFMH8UZsTpjiELShiIIptByfHXf6Pp7Im3i7pz5E7Zpv
 Ddf4B/Bp0kQMtzGbPuTpzDc+imWFp4L7I62k1Ifv5OPH0R53vfRMEFRKcoNVhKHRJaQkAW8a2Uz
 jeXTPPpxbV3Wqj799s9uxGE4exqUhBKDn300PyMBdt+l2xdzLeuIqsmhICSSOMPnSJVJwooqL83
 xDRvE0JI/E1/LHMpk7iIvIWrZxoZk9OYWUQ9thtrr06yut9/qH1lzWdAOfpJn/lAQSxJX+VDweM
 wtvgH4H1yjk5pTvgJzXGwWeesmLtcwB5WFFUz0AZ21sEC9+ptLzczmhK/oskQUOZ/iM+SMgiOuR
 Ln3YztHpj51YUf4QxM8LLesafw33Znh3+9caO5JQ6iHM083KLkU1NpW1Io2nG7pzMfoY7f/bflC
 qxSxHOWIOo+xtKYAMtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAxNyBTYWx0ZWRfX4Yr7w7Ae+i8J
 c6+7Ew4MzOqCORfUP1Uhbn9PZ/DSD6aOC5D8/bii2sIzhDnFcQSTKlaDaKSV/cb5lRzsXOeb9iW
 C6RsYXQB6TkbqXtWV9myIU1XrQTlhd8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200017

On Thu, 16 Jul 2026 23:12:15 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jul 16, 2026 at 09:04:35AM +0800, OrangeBlack0765@outlook.com wrote:
> 
> > Replace sprintf() with sysfs_emit() for single-value sysfs show
> > functions, and use sysfs_emit_at() for lux_table_show() which
> > concatenates multiple values. This ensures buffer safety and
> > follows the modern kernel sysfs API.  
> 
> Now it looks good to me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
I applied this but for some reason seem to have failed to
send an email to say so.

It's on my testing branch.

Thanks,

Jonathan


