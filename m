Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272083D5662
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240953; cv=none; b=Db80StO57VoDMZDAloMXT/9UiJZLE54z6EXVyJdXJfs7eoR+Xvif8J3bpB691rAAMTiWrnrFRlj93zM905FBK4c+2+6EPS00L3e48k+NaWEvz71GETuLx5dxfx4kEfjkD0F2oMnxg10fDNH07al2dad8MWEd6uEGHwLya+RnQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240953; c=relaxed/simple;
	bh=w/t9pk85JX/c4BFh3e5c49AsqencQgHs7vIIUAy56Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD9Bsj2JDZ7n0a7Lh/3HqGFieI4sYeBPV+kcUO8IiKmNHuzBPdXBN5rtovt25cjKtHuSQ6l7Ot6C57T1WbInjEP9bAAJG3rWbHeD8+qTZbt4PR15RoGKR3BVaT1HNVEZLqt9vTxn4JF5UupDkQwfBxblDS9RDGmZFcHBXySOsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8smyNKE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BUcal/6x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8smyNKE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BUcal/6x"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GJqNX93853452
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 22:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aMqkvMMyrbHc2cj67gn2YjjerrMo3jICfUzJGpOoiFI=; b=B8smyNKEEu4D77Q+
	PAV6QlPdRIizueArTbcPUbkkXRWjUy16z8JN14WmHossDzqiXIZ2ppb/utnqhijg
	0QRFA876NxYW/zK4uF6qxrxmCQAr8JCK0ZWSGLPcZie3DQi4BX1Lu40frF5VfHdm
	VKurd7Fc3vn/ndXG9gHopBDrCPa733p4JsFg4RVFhF8s3kuudlkBHLbQdpeHD7yZ
	LXAVHypAemna8uUaY52mJs8r/aBh78lC5zAng6Hvqjbn1scxvwmzhsclcH4NY7Ya
	y6BgpHYpXyDOBHbcq/w5zIPxccQQX0BuBN2vWDxwl4PeV3+qe6d6MI4RYFhecRUU
	rnTP9Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym1acs1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 22:29:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso3388097a12.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784240950; x=1784845750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aMqkvMMyrbHc2cj67gn2YjjerrMo3jICfUzJGpOoiFI=;
        b=BUcal/6xtrxwmcntj6SbDjPWWL6VP4l8zTXOt3KeviBs7uSb9qIG+H3mh96f0uBdak
         WXyTYamd0fZZYibTgnMqwuRq+k1WYVCvHuN5ads+yTqWN4wg5mAY5ctEPOEYk/h6Faox
         an3j4h+e3qeW3xj1MmnzUSv2IQZuM+DDjDKU16GE0TsKf46VRGEvaOoTudhP0BbpERao
         7AA8hLUcbM0QE6au1Ixi4jR6E633d0z5x1dgn32Er2jdrLgl6v4hyRalNeSJAh4xg31M
         gpyogpLqnfCtWQGU63XRwiW9LUvP3ln3phHZHxZcTcvbsSc9oqdLDcB52Y5ecOPmo192
         m4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240950; x=1784845750;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMqkvMMyrbHc2cj67gn2YjjerrMo3jICfUzJGpOoiFI=;
        b=NHjBTj0Lxy1SbGeHuJMTDluO5NBUZk8rlSNwVtLAgmKUZ3YY8TmX+FD53sgeDoKQZJ
         zZyHVBk7g5fPUzTxkT3crEcxW5OHV8ExtfY29MVkefIz2OYp7rYykmxC74QBGOBxKB9Z
         /iz+w1q6/tnjOaKTvo1EKuxJsqU9V1pzuUvuVxWb/2j9o0WL9r5hOOZIjezuNsegRTqs
         FpZYeBIsgJFwjdpu6DlFa0cz/VJyRKCp6qjwO0Fr6eMc2ZnUOslnV9ldJlx4RIHvuO4S
         fXEChQzgm3dQPdKaqd0J1wOOFhGm+qy+YWxm3DBTOPOVDsWPvRM3NgOW/lwWieA1IUuC
         UMFA==
X-Gm-Message-State: AOJu0YxQimGG5mq+nMat8KfAhBha7uhpvnLnmgfbPPoEnsINmivj22YA
	RU2boB6lkYRGwdMawmtnNWTppICl5WVgCHDy/s1K6t4nJ+NESs8CxyqSSlLfbdae37mURE9lrUg
	kNmy+bJItH3Qza3gSKONURov9zUz2fcr1dSpNX9loMDHcO3SCZCWaSG+lsgbWXJYjpuYo3lo=
X-Gm-Gg: AfdE7clQ2qhDb/PVWoSE6otDb4MgN7uA10KLsW3IRoTZRbEp4NB1PfGZynfHn/C7RVy
	mKqOB4gco039RJYKlZvYGOgcCkFard8vQDlAMZe+UoNV3UtJFf/RRVojlBL4aMRGTzdq5kp/CtD
	M2QwA/NHGvwaRsgnqjjWvQ8ibqOIztk1He7yw536Cfnd2BpHOSJN/ZgPpdNHi0ko76RTpIvOVXX
	Ya81KNvs4os92XQlKjia/XlUnJtnd5y0BsXqVEOasZLyiEGWu78vbsz2eZNWaKJSQcxNR7Wo90s
	77HLIP2rbh8YyUVmqITpXmLuG5jh8s6UZY4JvKMbs1SkbuTlkDLu7RSXesyBHUD7QY5mwm7N3R6
	TMyImBVaNJs3DZ5eOcuyFpeXTMg==
X-Received: by 2002:a17:90b:268a:b0:37f:9ce1:735c with SMTP id 98e67ed59e1d1-38e46856f78mr1394076a91.29.1784240949788;
        Thu, 16 Jul 2026 15:29:09 -0700 (PDT)
X-Received: by 2002:a17:90b:268a:b0:37f:9ce1:735c with SMTP id 98e67ed59e1d1-38e46856f78mr1394049a91.29.1784240949304;
        Thu, 16 Jul 2026 15:29:09 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdcaefsm84825eec.10.2026.07.16.15.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 15:29:09 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:29:06 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
        Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for
 single transfers
Message-ID: <20260716152906.0000332a@oss.qualcomm.com>
In-Reply-To: <20260716100104.000059f8@gmail.com>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
	<20260716100104.000059f8@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a595b36 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=qd6nvyoRBA3qBgLnzWgA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX3G/ALPJ1KFdg
 7PvdBUjcrhaNnEZ1UjgKxTnyxtGX2plbAt+u/kOxyYAd8iHXE1MZeZXIZ7QTwNF1mgJHbTpEyL8
 27sHLLsxbRVeDA8OLMu3qF1YvVAyoL8iAF2U7Vs9pDdXZ3Kk7bQrmaTFcZi/qMOdC/+3fijzISw
 Jurzx2Bbpc9VJ9i461GQeG05TdUAFemavWpow8l1so6DwvD+z29LSnGAfYHRYdAJUtWWtgzUcB6
 FwdyTcsY61HMPZB1VIOoWGT3U8gF1Ij53ax9okTT4GHiXboS3MCB4+SpdKWzXCJ0CJhfeeah1j9
 /Izx/N8YtxJ8H5IEZ69FQj3y0hiFTvWBeuL4jXH/96QAA2U0P6iVg2ma3qZQZl2G1uj+gi/s0ie
 Y5Te9OOpMCPXvY9lhxA+I7T76IbYMDGciR8ctA0YQ9X8bkNIPM7rUXKuY/Fcgh3N9BOxDRmj4XV
 fso5IANXXrCbb7gU+Ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfXy6AS/gnt92qA
 ywgp1/lHfXP5oxcsDfrSsuRVa1t9KkJVsgKUtH2LCdTIgY2KoVPItLZrMVcu57j4wcof8BXXe4d
 Wpu+r6FHWVK2BY7IqOKY2jftW+QXGQg=
X-Proofpoint-GUID: jqqKBPjKx1w8HCa54QtIDtCP8mUobHaP
X-Proofpoint-ORIG-GUID: jqqKBPjKx1w8HCa54QtIDtCP8mUobHaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229

On Thu, 16 Jul 2026 10:01:04 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 15 Jul 2026 17:57:15 -0700
> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> 
> > Resend to include linux-iio. Sorry to all who get it twice.
> > 
> > This came up in a recent review and I realised I have been giving incorrect
> > review feedback for years. Both i2_master_send() and i2c_master_recv() plus
> > the dma safe variants only ever return either an error or the full buffer
> > size.  Short accesses do not occur.
> > 
> > This series (also my first upstream series prepared by poking claude)
> > removes the redundant checks from all IIO drivers.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> FWIW, for the whole series:
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Also, as trivial as this change is - if you were hoping on Sashiko picking this
> up then it failed to apply, as you didn't add a baseline.
> 
Given one of the drivers is only on the IIO tree. I'm not sure how well Sashiko
deals with that.  Still I'll give it go next time!

Jonathan


