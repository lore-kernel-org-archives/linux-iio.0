Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3719ADA4
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784500412; cv=none; b=CAsu4vQZHgOg3Y14WaXY5QJ85XgehOz+A0xoFaV7eNYAv3yNMHoQOnG07/9IMuUhMxOBdlpsq1A4UGuSnHCI9iibvqiyxcrwbJRlNlwM9Z2aLY/oYHhA73bD4R5Tt0gDiQg6RcPL4Gzl2JZkaUIGPYKl0ZNBTr9G/M2eke4fjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784500412; c=relaxed/simple;
	bh=A+MAGlHGc7639clWxnuKkMWhNYoOyugnRs9JMuPKD/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmgVNCy/BGTZnNuMyinbTCAMrNtbuBZ0YBAxJhpCRz2hY/eWsDG2S8r7u92+cfpdvUS59M4Z6hWvxBQVnvPM6rOo0vpX9/vsim8PQdAm4AkG8jZTeUpoC5EdaW35J8E5OoIEJ10u6Sh/7cEaDhWjDbIgfsuQDXuyMi9bdbZjByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OUyZMrGU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O/nyKHJy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OUyZMrGU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O/nyKHJy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKRFP8236911
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mHpQegismISCBcr0pjd8FGRJDhvoNvDy8vtUxFm+3rU=; b=OUyZMrGU1w19adXO
	Finc6n82WIiQkm4WSRF0dt9G413+aOIcoHdpvWtMuRVHiJ2vNVr6+/U/BPMkp+TD
	6pAmyzdRsJ+yVCNen1oRGj1V5wQcgWIWK19sy8V/fE8hWfbblqf/aIxrJcgZZqQb
	8VcHPdgloh5g+rMuibFTm3rgPjRCBq7vaC6mKos9Ct79bog90Nhw7aWsEDQ4Bf1R
	BRp4xExEDvSqJqDXyJJmoE50BmrnaI4rUM/E4cQ5VfeZ6Tz0oh7W2m3+aSIkNdpg
	fdoYDhjR0PEXStcZcRegjmgrfFG/1iY2qEYvBeTNUwAmczGzT/v8vurNHDYCy51Q
	5fizjw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chkj9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:33:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc88e22f92so205184995ad.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784500409; x=1785105209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mHpQegismISCBcr0pjd8FGRJDhvoNvDy8vtUxFm+3rU=;
        b=O/nyKHJyJksHOscpfzYTkFrzWC6KSdn4ZnrQCGq4n+56Vf3kbuaDiTlkCRvrhugCQ1
         EnhJ/K/YY/T5xKmvw4+MiTDiecYyx68HUPU+6iirCSMrDwCoOAOPWR8T7FhGiHINSS+T
         w+N3j/vtBZyUw+kO5H4S8SWtjoArfuXJCO2ruUSxskwVqsSrA78RGchnqMvWSi8+O7/n
         1KNPJYFiBzTu9MLhSuE139bAFRPrOhYxvf5wrejSTomvBw/9CJCvTo/pawCpViXWksnO
         WiOdDd5a4VcboFpZD7HVHNHemZRkSVOcipVjJf3xf5Z5wSkGaEpXtpJiXEw+GIdlk8mZ
         7HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784500409; x=1785105209;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHpQegismISCBcr0pjd8FGRJDhvoNvDy8vtUxFm+3rU=;
        b=Bg5UO/6cjoJ1pAYins82MvwkvtNIhbQZ6/J/LkS2sTFKyWu2iiZAQfGsbw4uhyH3eq
         X57ABkPFXWC6I7patsFXXnfs35GWC4no5REVs2UOHNlkHM18fFAxKJGzI2vZrTX8i5Ma
         dINXa5mm048wu1tnXbuSZs9AtScS19uIO4z7jmN0ve6qMJROlxHxZLRE6A17kp6oHFC6
         ts/9XMoClENi6HiLQ8mT1k7LXRcAyr3RFKCIul0fsC+cS5874sAHkP8aB03Ut/IgPIhY
         n5AZ2yP+z+BJ7doqgO0QL4EyM0dfZ+Myp1zAEHFn9sMRpdI4dtbtAgyysvmtbQXeouEY
         vIXA==
X-Forwarded-Encrypted: i=1; AHgh+RrZRsVdzacDcEoUNVxuz2w1vYGzTQ3y8L3sBxy6FsBQ9kjVFJNUjecAnl7MOF+/KsiP6meMJE8WVGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsRTUPWKLWY1tjJct9fz9sgSnib2cfdmjVOys+ahSuMQHrCxN
	lnmWR8Kgrute8q+enGvzylvYg60SRTEcc/n0FJv+bHoUWODV0R4SI6thKaz2FUE2QBMRfCKV445
	IBAVUEALt0/h1dHPkANcUmwGs2tgBjXpljZZhJ8SBI06tedWo/WVJ331Xb3CYLNA=
X-Gm-Gg: AfdE7cnlk+VZAZ0Egkc+JA0JyDnwatWN+KX+YjNKZ0etd5dPjh1f+A4a/ylca4TKWy1
	CP2fH9/A4L3QTyTNl7wFANn4vZU889Y0L9fZH9wluAJPWn810DInNsK75FOmsu3EkgA0om3dWj6
	FjzMusMLsB+ZNuL3IoVe6ptQzGLcHOVYY8metcsqnccxoacuwfC2EV231kFLnPZFqZ8E2/faorH
	oeplB2yBAAyM5Pq22YmHfbFzT2H8aNE1fbEXbc9pbP8S7pALiTJ/9jsRxAAxuPenqVJ56bsjtYD
	cq7nYI0cDNEplFbcRF9djXCCk1KRl9ajnsRcomFCojXSbUzawVZRZZgT2V3QiF87N1RRG43lT6Z
	nsYZ4BcwrlgedFqfX
X-Received: by 2002:a17:903:2c03:b0:2ca:3df2:919a with SMTP id d9443c01a7336-2cf349c24c8mr130707445ad.33.1784500409327;
        Sun, 19 Jul 2026 15:33:29 -0700 (PDT)
X-Received: by 2002:a17:903:2c03:b0:2ca:3df2:919a with SMTP id d9443c01a7336-2cf349c24c8mr130707155ad.33.1784500408875;
        Sun, 19 Jul 2026 15:33:28 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9bd5sm46160675ad.45.2026.07.19.15.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:33:28 -0700 (PDT)
Date: Sun, 19 Jul 2026 23:33:23 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vidhu Sarwal <vidhu.linux@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, shreeya.patel@collabora.com,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: light: ltrf216a: fix runtime PM reference leak in
 error path
Message-ID: <20260719233244.0a3fd246@jic23-huawei>
In-Reply-To: <alTb4-sg0ukY1aYI@ashevche-desk.local>
References: <20260713022829.234370-1-vidhu.linux@gmail.com>
	<alTb4-sg0ukY1aYI@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI1MyBTYWx0ZWRfX+tMEM9qL657d
 T5JdYpgK3k0reiyK6sgziNrEcb9fJOMxYszgkLehDGO079NC8sf+cHWVsAUto2mQcWySh0CBBbK
 0BzVtJBkglq+EdgWw7XZbEUaIJLc+eg=
X-Proofpoint-GUID: 7NlIVnR5jzWfEYOJqihCXIn6jW6QnaLY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI1MyBTYWx0ZWRfX09fwfsOH25us
 Eco/m0AWehIjLhahN3+aCpwMXwDgQyDOi/M/IF4ZId/NNxcLCPpdrAH8nSOL6iC8OCBlc7hd869
 zrcJ4ncFld/mkx3Gzah+Ppzo+Nz7Xo6tvD3iRhJmXFpftSEj3lEH0FDC7WG/2kvGYCkF060JI28
 T3FFvVbQj8iaqLu/eZSzOwR3iPBlpTauV0WQ5K7u7easOt8tNr0fV1/4MMdcLwc4DBdckIx07pA
 T1qO6z8LoBjCHf7qVrNVdpgRl/w8Ka289rj6axfHtVKF+eGb1iGjO4XHsMP0wSWtMxbsGpH/a6Y
 DVXiW212jAWtcP6Alq3n5OqyPq4J5aLYM/982zKSKZXOf8q3++LybqShw4qW30tOMNad9nGJZrU
 VoKg6pL6x6VUB5U4Q5sDC2RzSzkSU92Z9m2Kxq0lwh8IBUGzNyP+HysxpNt32JlEE9ZRkCibkaZ
 ilrAja55KoGC91F3bBw==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5d50ba cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=QyXUC8HyAAAA:8 a=jVvKgFSebWTF7iFRTjoA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7NlIVnR5jzWfEYOJqihCXIn6jW6QnaLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190253

On Mon, 13 Jul 2026 15:36:51 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jul 13, 2026 at 07:58:29AM +0530, Vidhu Sarwal wrote:
> > ltrf216a_get_lux() acquires a runtime PM reference by calling
> > ltrf216a_set_power_state(data, true). However, if
> > ltrf216a_read_data() fails, the function returns immediately without
> > dropping the reference.
> > 
> > This leaves the runtime PM usage count unbalanced, preventing the device
> > from autosuspending after a failed read.
> > 
> > Fix this by releasing the runtime PM reference before returning from the
> > error path.  
> 
> ...
> 
> > static int ltrf216a_get_lux(struct ltrf216a_data *data)  
> 
> >  	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> > -	if (greendata < 0)
> > +	if (greendata < 0) {
> > +		ltrf216a_set_power_state(data, false);
> >  		return greendata;
> > +	}
> >  
> >  	ltrf216a_set_power_state(data, false);  
> 
> Wouldn't be simpler to do
> 
> 	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> 
> 	ltrf216a_set_power_state(data, false);
> 
> 	if (greendata < 0)
> 		return greendata;
> 
> ?
> 
> Not insisting on this. Up to Jonathan and others to decide.
I merged a slight variant on what Andy has here to keep the greendata
assignment and check closer together.

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index aad96fc91565..dd8f3260b1d8 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -248,11 +248,10 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
                return ret;
 
        greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
+       ltrf216a_set_power_state(data, false);
        if (greendata < 0)
                return greendata;
 
-       ltrf216a_set_power_state(data, false);
-
        lux = greendata * data->info->lux_multiplier * LTRF216A_WIN_FAC;
 
        return lux;




> 
> 

