Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9D78F3A
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904012; cv=none; b=P1+5ZieNT4AlTPdoovWpoHn+JpXEPqFX4tgBOVh+PffHT+rx2/GuvU6fhK1c+Aso7JKpqPS0IcYB4OpsJRCUQmUWn79koahUJR9ln3NLx38wfLhCnOHaohfAv6F0faZjRMfCMBx1WeZJrPRAkgT6UFzOj6351vOoZHEj9M4PRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904012; c=relaxed/simple;
	bh=NOKl/2FsOpUDU2KR3IEXpajjEC9SS61hl/FuBauFTR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqIjcYd0M3PC08/3KfHkhaaJ15eSdzB5q7y6zzORGjCSST8bQq9ZHYt3AXYTkpvnxU5AGL0Z50w/Bxs3m2bVJg1FM5WT9gMNfewB20qP3PrDzL5D5kd+JvagzNFH/qIjGl7Z2BrkG8Bu6zIIrf0l7nXUEZffLmKGaiGpTVXjqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TT3IifZE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KogstQxf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TT3IifZE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KogstQxf"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D0kKru4067370
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DEm2NjDElLA5IULCO3hBWJcbnNmUCSWVAsvH9Q8gQho=; b=TT3IifZE/S82HA3Y
	3JuAlGTQdPPBpkKjpAlT3CvkbEjR712B4AXnFZNCUfJUS7n7lIxF5uMcxdK2k9bK
	TMM9FNoG3A5ofatc+ejoE1TCQW8FBsumt7yik/ncW/AecFWl/05hHpA9zb6BDIQU
	MyFS4Iy1ZPeisC1BSV/EhK5ySagZlqacFJjSM9Rg6nzfpXlH9LuOi7TXmglQ4tPY
	xHuo88o+lrLXi0X6TLT9UfmC3XbGFusGkMD4N57sn5vAhEI2iK0HY3hr5Uvw5J4e
	Pjlk8hA3XuX2ARurhp1CqSm7qQtYT6fkVPfja5Cacjc2NxNkgm5Ic8g4AdygkIqC
	Vq2nAQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamuuuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:53:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so1616377a12.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 17:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783904004; x=1784508804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DEm2NjDElLA5IULCO3hBWJcbnNmUCSWVAsvH9Q8gQho=;
        b=KogstQxfaCVUVP+Bdx9LBtUG7NT1ieGsJZ9Qy3AS3NfIl68mLeH3pnNnUVATfiG1hZ
         sF5kPBqvjh1iipZnERsiW7meVuqhMijusmNdRyEkfCBmQtm5S4j1kdzmY6u/3BxGRKUh
         NkphIB3/nW0x2WNTiuF/c/ymkzkueszTLO1ET+oBeoxhD66XoR3h+JNgkvSVWwwikRqu
         2hC6CzYaM+4q0/AvdOO4AK2rQHhmYIgzACNYT3admsoj70DfZJv3JEaLnZFD3CeuEk36
         AxAZDbabCL01NxCgS2J09zMyc9wFyuOTRZ8kJwjlsNkHm1dHFBx8p6T5vfb1W+lCNoY8
         GcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783904004; x=1784508804;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DEm2NjDElLA5IULCO3hBWJcbnNmUCSWVAsvH9Q8gQho=;
        b=HuiBIKOdAy1gd/BO2aeUZei8RvTiG0aJBD1qN3r+JFkkVUtDcragGaAKtgKJ+TudCG
         zSBlEtMgL4c8jpGVwZvPZa54yvJKtYIvJAdz8B8gWzMCJIllhIUZ04GWhj+yjgjJpCYF
         SYb+hGgSVw2A0bDN7ke1rqDFtwTKa6afogjKbPsLblonfKqj/hVjB6qqqNxXgNszSGmt
         rnjgCFCjf5ey9TLfFbFLYPU/8iiwX1lTyys6ZRboFeDUGCZDt2J8PLn/Nd/JgOHxmO48
         7x4oBca3WrXO8MY0+CRNV5VIqjUS1Xws4EGN/jTGmoqBcvz2FaNTfHteUNBCamMc45+S
         EevA==
X-Forwarded-Encrypted: i=1; AHgh+RozIIldl1SfhA4Gc7NFfJp/r7G2VNrunvpmhWjWfM1rMjp1jLrc4VXL1aN/12lLJtLoefAc8NNpGpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89+hQ3I3lPEqi58uZdqFUoKkD0U09ynkT8rrSJrMqXJbbOENL
	8MEjQHfyHPtthyGfwE4n7JiXIJjIINgUpHua4dibgjduq7T3oKl+bKs82LBE8u9typl7s1mTMCW
	bT1UEdPyAY8gh6fulyGPDs7etsE4PLmMgnrBxaAmBVij+h5qSLiuaDC9BdMtAG6Q=
X-Gm-Gg: AfdE7cmZZh8L6ydfZ39ac8PPoeLZf92ozXxomfgz409ytDWB7ihEEPpAVGevWY8zpE4
	d9JWuxDasnhF8zQb4MJDkQQaeTbV5kzcfgFKn63z1q9bKm5ZOa3gDwyqJEIQQNm/slC0Npz8yR3
	ajVcdr4r+PsNWwro62E5erI+6lOgkePW5E3oNHFs32AWemhnATQus6ZGJ/27CZRrcM1vl0WTts4
	E14I2EX19w8j2mUte4J3lCyzNzKPycSU+1B1cJt770X5IUMe4mmVmp99VJzEltEt67G3ypHVw0c
	13dZ1xAp78EejNJa+7wa8HPHQcZZi9VgNI8jKMkSWqfGu2icPqoGADNDupm8A/mk7LuHnEpNu7E
	fr0BrymWQi8JCOE3V9fzr91i9ujI=
X-Received: by 2002:a05:6a21:b8d:b0:3a2:d316:de53 with SMTP id adf61e73a8af0-3c10fb70319mr7960289637.0.1783904004303;
        Sun, 12 Jul 2026 17:53:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:b8d:b0:3a2:d316:de53 with SMTP id adf61e73a8af0-3c10fb70319mr7960265637.0.1783904003876;
        Sun, 12 Jul 2026 17:53:23 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162b59sm7525127a12.16.2026.07.12.17.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 17:53:23 -0700 (PDT)
Date: Mon, 13 Jul 2026 01:53:20 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "Maxwell Doose" <m32285159@gmail.com>
Cc: "Joshua Crofts" <joshua.crofts1@gmail.com>,
        "Tomasz Duszynski"
 <tduszyns@gmail.com>,
        "David Lechner" <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open
 list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: scd30: remove kernel.h header
Message-ID: <20260713015320.10153605@jic23-huawei>
In-Reply-To: <DJWTEQ1M40J2.2UGCYOWS66B57@gmail.com>
References: <20260712164225.358852-1-m32285159@gmail.com>
	<20260712185237.6a60e112@systembl0wer>
	<DJWTEQ1M40J2.2UGCYOWS66B57@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAwNSBTYWx0ZWRfX2kPsw6KgdcnS
 NBSXDvNUd8eX5+COyY/V/BSJ1d5LTiXZ7bPE9Xeon3MKEGWtIZO+fbkL19rOmM6IL32ZNVdh4qU
 Ocqnplrlfz0UD3y+jIGPqkfxXU95NBg=
X-Proofpoint-GUID: cHJm5D_VlNh2wRDj4SAuW9e49G2l2HM_
X-Proofpoint-ORIG-GUID: cHJm5D_VlNh2wRDj4SAuW9e49G2l2HM_
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a54370a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=OOtRYDRuGAbdYZyHC38A:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAwNSBTYWx0ZWRfXwv0EnxlJDtq0
 T1mKKCrjxKRrRuJXEAxqZdg2sQJfNoS5bTD3e6B9lteGBbEhdaYRVfThiAVtKkrH0DS3mSyroh4
 kcyVLDAMWGYwcjGU1x7rxl4K9+V/74ewqjqv3nfSKPQ8UlgScKJh6p+NQzO7pI30hC80JfnfxX0
 kOKC+H1O0yU2AEjC5YFH0H6t9O/rQ/Qj6f8xWE6Bn0bFTznRgUl0pKCG1c4BX2vTEDq6xgbAcC7
 9xPA3GxKD+F+DEDADkAyzFphWUGfQPX+JePBdiQEIBZ3yLb/avzq2SbU2Yb1ZYS0fGUIUwoEjV8
 5sahVmLGIUhu1tKsSL0+/rMckLGFyacj5hiJoD+qNmzMSns2sYDCRJzDvmm+oJ0N5zPJYpSIipU
 XieP81cJN6jJLhMoZqqRL1tDxjkznKU0yvYCwZslTRvJIszSZ/6dMhyYwmpDr/QxjeL+mHBJyUp
 H2KBmYrydEKHtkJlCAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130005

On Sun, 12 Jul 2026 13:47:24 -0500
"Maxwell Doose" <m32285159@gmail.com> wrote:

> On Sun Jul 12, 2026 at 11:52 AM CDT
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > On Sun, 12 Jul 2026 11:42:25 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> >  
> >> kernel.h is no longer recommended for usage because it can cause longer
> >> build times and pull in transient dependencies. In addition, it's not
> >> being used by the SCD30 driver. Remove it.
> >> 
> >> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> >> ---
> >>  drivers/iio/chemical/scd30_core.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >> 
> >> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> >> index f85cdd8bd84f..40bbf26a667b 100644
> >> --- a/drivers/iio/chemical/scd30_core.c
> >> +++ b/drivers/iio/chemical/scd30_core.c
> >> @@ -23,7 +23,6 @@
> >>  #include <linux/interrupt.h>
> >>  #include <linux/irqreturn.h>
> >>  #include <linux/jiffies.h>
> >> -#include <linux/kernel.h>
> >>  #include <linux/module.h>
> >>  #include <linux/mutex.h>
> >>  #include <linux/regulator/consumer.h>  
> >
> > Since you're doing IWYU stuff, you should also remove errno.h and
> > add err.h instead, as the code uses IS_ERR() etc. and err.h includes
> > errno.h
> >  
> 
> I tried to set up iwyu-tool to no avail, but I can send a v2 with that.
> 
> > Also consider grouping the iio headers and asm headers separately.
> > (separate patch though). The include list looks overwhelming!  
> 
> Indeed it is but we try our best. Good thing is the more we remove
> unneeded headers the better it gets.
> 
As a side note, (and I haven't checked it)
Sashiko had some interesting other stuff noticed whilst I reviewed this:
https://sashiko.dev/#/patchset/20260712164225.358852-1-m32285159%40gmail.com

If anyone has time to take a look the CMD_TEMP_OFFSET / 10 indeed looks
obviously wrong. + I moved that code without even noticing whilst using
guard() in this driver :(

Jonathan


