Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEEC26ED3E
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511893; cv=none; b=HTMz+bh7qXpi6zTn2syVsqQ9AhsMFCjv80Ju1uTgM84riOdOXZYI8ZxLvxdSyoBWb3X7P6PZ0xFbe5ODCbXgd8vr8KqAYo8GUxCVwcGRMs9MLs4GxZJTwGoZvcTvFXtj6M+7p4KLICcY9LiRl9NoipAgezvwB2mGtBdRB6gZxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511893; c=relaxed/simple;
	bh=iStVGvWn8peZsqiqAMgO1DeCCaqU6NDwZ+ll0MQqFSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClFmUOU/zGGMiUgUQbxSj31gx2TU8srpHu870VRIxLM28q0wQeMGMDGbYbIMl83CzGDpvQQY7WorQ3E4rBI3dpZv6xYhoMX8YCnQPT0hjIh+oXdCz+y1gyYOn3E0Au2ncXT2SDEQPvnvlwsSgpZIFa6L4Va2Q4csupHltcIfxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mnCPvrmA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CH+xnHMl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mnCPvrmA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CH+xnHMl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsOjx1020261
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A80KOCLG2b6sD2R8+bULxsxxaaO8AzJe9I4MDEg+WNs=; b=mnCPvrmAqXBfWRrp
	wZxN5vjL4ldL9SNJk5wkxlmEyduN7s3uSfSytSGOwNO9soC6Lt8puw9fx69VhIL1
	2oxRnt7V3Kd1U3tTKB+wjXGtR1vOMgKyY+AXg0V4S8+6lT9LXCTUw/QDLp8wup+G
	gMwMKdvQXVkrBUkU/Yg28plTkoG1aHNWdMXapuyT0pA22hydksATTsvNBWnGyzVQ
	w+C1Ns5fyswf7yeKM4Q/TdT8k+GI2YBOjzIKES0aDFjrFhzHdF9FP4phYuRWoriT
	ZE1dRrPp6jJzriQh3lL6x3GtJ68fnFf+AZsGPH3aMotejfEf+MnqqqUmwLhFagbH
	k6GOLA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d93vw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:44:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848551b54f5so18313498b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784511890; x=1785116690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A80KOCLG2b6sD2R8+bULxsxxaaO8AzJe9I4MDEg+WNs=;
        b=CH+xnHMlh+/NlFN/HoA082K5nRMbfXhs1l5Yk60SqC3CjgfQjJwjlGdjYscymXZ7uZ
         AGMITNASCfRnTI/gNL3WZPZofUIAsKlDBLeb81boZ1pXSXdC+Uez64FJ5DEd9dehm7Zq
         cWuDj2nVT6rbD3cutA5zckvm5s5vU9sceHiYn0emTZv4AHiiWncx+rOcdtQCz3Ui8rtO
         ljspCx0Sb2ah4/ZWNEezxwc9nzchO9LMztzieibZzY1oJTkx+/ZKbNmFiEh0xfJctWVX
         MV01d2fP7KnDbV7bFcHVmDMnot32LyVi8mRrqC11Fcs49NQBq1mFLU44jikDJ1sx2fVg
         6I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784511890; x=1785116690;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A80KOCLG2b6sD2R8+bULxsxxaaO8AzJe9I4MDEg+WNs=;
        b=hoXIgmigJpVXbEARkjuljV0GCo0V4S8ZvnKGxDxsPKH1CVqQI7eH81WkPeRbETQCIk
         4HIqYgJtETZYNyWhxskOTw57JmfD1PMvgODuFaeEUsYbA+eDAC5SYpZWwYf24bmjUaOD
         CBfFgMvAWoO0oowkrusR8bCiQJmyKppdO9HTODtErKHHKEcbpq2BIg0PkZbGVcmixThO
         iUhHa/qz265g945dbYK9Z5uYOaESlCtumMBg4fDDF3WYFMmLvKa/haVGiqVcpYOnrjEX
         Bc51iwRxq9iJ2RWgFDiF6FeuAWi5FCyaJznqRH3Qvm2B+tKfD+2EZR3jHPSVQOqkmVJG
         S5vA==
X-Forwarded-Encrypted: i=1; AHgh+Rqm9KfPbXYlipMFO2/kAl4Vn1tYgSO81YqjN/1q+CbDP7u1+mDrpicWx52nkF/17+0AMes1a9B3fJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysk9GP7ttIq29DKNAYdXasfbsf5zWBsGEFfOCUnQkegairKRP7
	nzxEjeOMlNqFjAgtEU/2EaG6BtL4CYK5npQ2pGnh5ggz1HKoigcBl9zPki6nCLAWmJCEPdgpwFD
	ULUDnBK2VhPMsvLw902H9cTcyMf3uGqG6zVXX11JaWwCVIgI7p0RP2+BD2UQPxax3mnVheyE=
X-Gm-Gg: AfdE7ckNgxbVMqt6Gq/CSS27ZbJgQ13wOW2Y1utO4GAGwhne+JVh7GRcaL8L4leottk
	tM5qkfUtTOWBFUk+/M2VUWp7QOZSeK4zG2rk6Z92/gIkI0K4Is7+EoCbO1n0pA8SveLklX0sjc6
	hJMoSIO4U5WaW5Q86JWcjZS1iHHms8Wqq/xVKBVDN79gkiJrZpUo5wYAsla0VxTsquxOJR2wTF8
	vjyQDDhSEQ3uQiA8sx6er5mmhCZZqXZBkthXFwddg9b8sfWM+w0B4gifX8M1RsfqXLhnUuu67GS
	TS3U8nAVO1sA5nZKYom1HU4ToJRsE62rkMcommDaS0SmHrwJNRey330zJ5E8hx3yX4CTEdT47Qk
	qYBAYDL6BRarF62O6
X-Received: by 2002:a05:6a00:1945:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-84c2926be85mr12085646b3a.13.1784511890212;
        Sun, 19 Jul 2026 18:44:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:1945:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-84c2926be85mr12085632b3a.13.1784511889749;
        Sun, 19 Jul 2026 18:44:49 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c4b640050sm1946332b3a.45.2026.07.19.18.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:44:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:44:43 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Colin King (gmail)" <colin.i.king@gmail.com>,
        Dan Carpenter
 <error27@gmail.com>,
        Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>,
        David Lechner <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: make read-only const array config
 static
Message-ID: <20260720024430.2d1359a4@jic23-huawei>
In-Reply-To: <aleRBRrht2PPuHWl@ashevche-desk.local>
References: <20260714165012.184651-1-colin.i.king@gmail.com>
	<alZs-uLJug_rnRnq@ashevche-desk.local>
	<aldfaM2aks7qOz2C@stanley.mountain>
	<aleL2gmDZDJRhjVo@ashevche-desk.local>
	<58361942-9082-4778-a3a6-cd0bc4034644@gmail.com>
	<aleRBRrht2PPuHWl@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5d7d92 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QyXUC8HyAAAA:8 a=Y5yDRIdPUsbKug6gOGoA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: fa1EAI25bU4kAdrSAzRDV4G7at4_uK26
X-Proofpoint-ORIG-GUID: fa1EAI25bU4kAdrSAzRDV4G7at4_uK26
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAxNSBTYWx0ZWRfX/WtFJ1d/JAns
 WSMg3ieNGci9odkHff4dIzCAL9Qq2LWAiqm7F1topJQSQoYEoL37+hNYKOJhhxISsf3FbsYY/zM
 +Ah2APACoYHMNO1ZboxFChpK9/fXef4kRQksjl0UzbnISvts30gbg5KiTBUhui8S0QA0eUQYG2O
 K9oOZrVzFyNfxxgD0xFRmFiA4WAJV6mf9Vr9wLDm9R7VS4N4koC3htkj6YfjyX54Rd21lxMB5bT
 iqFjsQ10drJ54O5QNwEpiUFPv3SuBi5jeLFuQJ4AtbMz3HhWzf/QWsnp3BbnxSAnJQaT0jjhByb
 J7zJzXqCcF/8iu4OxRvzUYDHzzO8puf7kHlVRP1c4gXHLK7MX82bFYz5QROT2juFmrVP5Nn9l2m
 p8eot/Nhi0f5kP7GSr5DOKRrqGJ8SrhbIK4ioYZCrJX2yMh4ihrfPU+0kVOb7y9XEhcAMppSZfr
 qZtxetRXWSmBPkre6qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAxNSBTYWx0ZWRfXwxx8XWK5D+Fr
 2j0/ZzBRwLCnVe53dL6UrS7gR25kLdVZIYTHiWd8bFUU1LJABqQ+Yn5aPtGR6ixVBgdjpn0az3j
 jl6RGFyba0wjV9jp1078zNEFJqeg0RY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200015

On Wed, 15 Jul 2026 16:54:13 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 15, 2026 at 02:34:50PM +0100, Colin King (gmail) wrote:
> > On 15/07/2026 14:32, Andy Shevchenko wrote:  
> > > On Wed, Jul 15, 2026 at 01:22:32PM +0300, Dan Carpenter wrote:  
> > > > On Tue, Jul 14, 2026 at 08:08:10PM +0300, Andy Shevchenko wrote:  
> > > > > On Tue, Jul 14, 2026 at 05:50:12PM +0100, Colin Ian King wrote:  
> 
> ...
> 
> > > > > In all patches like this it's always a bikeshedding possible of moving static
> > > > > data outside of a function. I have no strong opinion in these cases (when the
> > > > > data solely used by a single function), but in general it might give different
> > > > > readability experience (it's harder to notice static data in the local function
> > > > > definition block). So I leave this exercise to the maintainers of the respective
> > > > > pieces of the code.  
> > > > 
> > > > It's an interesting point...
> > > > 
> > > > At one point Smatch didn't track static variables and it used to
> > > > generate occasional false positives.  And it's like you say, those
> > > > little "static" qualifiers are hard to spot in a wall of declaration
> > > > text.  I've never considered moving the declarations out of the
> > > > function scope but it might be a good idea?  
> > > 
> > > Maybe, as I said, I have no strong opinion here. I am all ears to hear
> > > what others think.  
> > 
> > For small arrays it's a moot point if this type of change is useful, so  
> 
> Yep, it actually becomes a trade-off between generated code and existing data.
> With a small difference that static const may be located in ROM (important for
> the embedded devices with minimum available memory).
> 
> > I'm OK if it's not accepted. I appreciate the feedback.  
> 
> Me too.

I prefer not to think too much about the trade offs and just assume it
is 'mostly' worth doing so add static everywhere like this unless it's a hot path.

Anyhow, I've picked this one up.

Jonathan

> 
> > > > But in this case since this data is const, the static vs not-static
> > > > doesn't affect flow analysis or readability.  
> > > 
> > > It doesn't affect flow analysis, but we also have David's point about
> > > amount of data to be static may affect the code generation.  
> 
> ...
> 
> > > The main point I have is that stumbling over the 'static' in the definition
> > > block might rise some additional questions and slow down the understanding of
> > > the code (by reading).  
> 
> 

