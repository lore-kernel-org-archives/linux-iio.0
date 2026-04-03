Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA321A6813
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253277; cv=none; b=NiwkbnQo63WuNnRaKpwnfwXa5X8T/B76qvKN4Zz1AVmQ61Fvg8gMjvF6L1mWE/wGxDggcOX9RTpn/BVJ/SfOG4H8tzDthCV4ApbDo69FN5Qdc/3oLiv9WtQlOC+ulcGLKYI1w+gwTJt5OssT3r182RR7JNaiDJU+b71boacXbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253277; c=relaxed/simple;
	bh=4PyYqCMRHxxU5QTdFQ2bY9UFxws/ljt2W4NAhD0wt/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m34Q4nCMWlcnXGIPg8B6DmswjkWQSrMt9Zvi7H7tAkTVz/iNfa/q5rzVNu18DrPTHH/MAelnnPbaXc6I101K7X7pdXBhjy7h/YrwwaIu0xZd9lPvPLINIrA7m8KUVOsRFmmw5Q8SVKgMTu6lVFCf5N04xdFbaeVnuDMaDnvhawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SbGcCPnA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PA80ytiR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SbGcCPnA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PA80ytiR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633Jltsv918065
	for <linux-iio@vger.kernel.org>; Fri, 3 Apr 2026 21:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y9zedheblneIseqLyTu54++r
	jDJmuqlr324tiZu2S8c=; b=SbGcCPnAGCPNv/biaWHt9nHjaT5RCB4GXbpDrmi3
	EvWmYPFqdRIwO8pLUp3d6blQxLEiTkCn8520ia4PhWa+W7cQXLWjKqQWmFdXAINY
	J/VJeuwvru95PT2hgz2i1znNjyQetlACoMbXNkl9jYLXEV5hDQiHK+pXhAxplK/J
	NXfMKFOzP/leBf2NYPOrzoiKWv+v0d5AFyGOr+kLoMffEn1iVgT3yLgp0sLeBtng
	2fZXJi+eNlKRmOOnxuo6PAsGcreci7PhauKJcUMgy89+GDlMIWrGFT0BUUnE+kZU
	WNip0hAzGLj9+8rZibY22ENbLSA4nCyP8qyGFtZwK8JJ1Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dam160900-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 21:54:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5093b92f327so64857021cf.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775253274; x=1775858074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9zedheblneIseqLyTu54++rjDJmuqlr324tiZu2S8c=;
        b=PA80ytiR2JAM4Gs408LRoN/NVYo4lX0iVGdWchgt2w+OafD/UwF2VgtjEeyrLJ9/fn
         s/ghR2i/sA6LFf6rRBSEU/ia6xt9pe7TMi3tDFo7R8R8nZgi8pqgHDSAMWVribqhZdKw
         ZfmHCg4uFGOMdRFr02kakeGjgks792hiEvIeqLrBgVB9oyONnIMqJqW9W7mMdShd8XEP
         j4KZIAMlP61xKHSQ3h1vz3us6aNKUS1A98vK30ALqtVImgJaPzGo52tuG2zwPtJH0ZSP
         kNfaPtu+MLpftDZUkpUpH4CTCoKdnxx63YQ5v8j+0kUs7nyivuIqVn2opiC1BZPBUZ8I
         Ovhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253274; x=1775858074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9zedheblneIseqLyTu54++rjDJmuqlr324tiZu2S8c=;
        b=OQUraDuhKkOqa2p1pNw8iwfH73wdKHwegb72O0jW5lf1u487ofMfZdMbma0WWmLex6
         0ODpdaQEYNyG8u3xNjCSpeiQbneML1XAfI1cWV1oYVioPpB5gH3Vhh8NsMEObMLXxV9r
         ASZb3yChcDshckvU3THCx0lVzA42vXcXEEdmmOpryOqOhkvezuUCXRoC0j958zJrwKg1
         wIp3hCAADxMAU28kmT5yVpZ1gVLq9Fjeny9Ldn7AptVylHK40HvCbCbkFTYcziPnbBFd
         8z7jVr4Jo8iP8G26wTRx8cG6r0+vU8iFB6tPTPmeg7covh935JqfXlwqa2JjR9tee4FN
         UFeg==
X-Forwarded-Encrypted: i=1; AJvYcCWOIDVHazL+W1U1Gnfdo3hA4xWYp+8vjUAQtLv3odoHS1AxGY5SiA6201im6mb6vz75cvGgJZxqenY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzki6iejr86ZuEboOMZ8HjK2WFAVNldz/OR/Zk66ZVSf512o3Xg
	LtRo9vXYbkL9onm8RQJibrzL78a7yPBI/3rrYrFpfHQDqWv+NvZj1YLySDIaJnKwDUpbhwnNl04
	Krd5+gzhCh9mkU8yCfZAJ5S4mWB56cKMnXKvjXfs/zTrAvJKzvEdM+dSFm9ActGc=
X-Gm-Gg: ATEYQzzRw2mJCN+7QabTnTktVZskzQd8ui6V/ccJ2Dwrd0q7XiUN6O3NiFI5UBv9mth
	gmC6Xoi1n8jlc2Pe/RL6uNtzfxJhwNnCXXy2Pj48B/Dm6SIzsoaZ5ukxwKunLzHyzqi/IpKMfad
	OdZ2TjJ4FUkb+8w5Kz2E91aCl1mElaqfzDxxLEgX6ZVIFW30zqtrJG6wfv/jfDnn3DoQLz/VuvQ
	llU5zedGFTW/xwOHfWfnwGZ8PqxsanWSTiKbnzfPIXeD1A7UJOcbUaSdHPcZ9HupB6PwRkaq8aT
	exNehxjMozR6HGjuYy0EEzaRViRzk2w4+ujgw9kMdFjz1Nez3wCYyWSlQpcVXjAt0B8IL7GzpZ+
	0Wx4BpLZG+GNt12nycdb9QyBClNbiBDArkZ6L0Spens0gpxsuVZWDK2exYHByQyTpGOxBmSvdPt
	aLzIXV1lmweitxUdIfmo036OB6C3043VzHksg=
X-Received: by 2002:a05:622a:790d:b0:509:20de:4ad1 with SMTP id d75a77b69052e-50d62614c30mr58337951cf.10.1775253274026;
        Fri, 03 Apr 2026 14:54:34 -0700 (PDT)
X-Received: by 2002:a05:622a:790d:b0:509:20de:4ad1 with SMTP id d75a77b69052e-50d62614c30mr58337691cf.10.1775253273514;
        Fri, 03 Apr 2026 14:54:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ca32ccsm1714618e87.37.2026.04.03.14.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:54:31 -0700 (PDT)
Date: Sat, 4 Apr 2026 00:54:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: qcom-pm8xxx-xoadc: remove redundant
 error logging in pm8xxx_read_raw
Message-ID: <35urrjc3koye5zhlxatdsr7t2djuml5ueyhhazcucow3q3g5f2@pomnrrcwu7qr>
References: <20260403-pm8xxx-xoadc-label-v2-0-29b50bf821e6@smankusors.com>
 <20260403-pm8xxx-xoadc-label-v2-2-29b50bf821e6@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-pm8xxx-xoadc-label-v2-2-29b50bf821e6@smankusors.com>
X-Authority-Analysis: v=2.4 cv=Kr5AGGWN c=1 sm=1 tr=0 ts=69d0371b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=wxLWbCv9AAAA:8 a=5IoCURV5UOmB3lB6u-QA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE5NiBTYWx0ZWRfX9af+yqRH8xI4
 u7095fGPrNkGg5esaCDwOvQLQORvx1UsrwcQFxNdMazByqukxsSDhoi1iMnfYNtYq3XQMrbHGfb
 vYmtb4k9xVq+6wBv4hz79A530IJRr56AnUX/UPTWrEwLyWrjOaYxBzGBdXgUuF4ey+LvYdiioJa
 b5Oo9V3BTpAjjpXck2oXjIa8qzle1ISxM0/drWb8XLlpSa7E2FcAzbA3iOJueZNsOeJgNcp26zm
 2xCVspQSCSFaJUrlkI6p7He1Rg0Nxeg+X03DxDqNaaXU7QUuP8s6g7XhKSW4wZIaYosTef7UIWy
 zXzcWGAuxGJClWljeBU4jnnSq5tsj8XxWDRG88NTer9xff7Ih4345HAYVbvVNkfPCDwLfSQOA3G
 cqsG4VeoOGiMx7tnCN3xgAInkao3zb6nl+GHUFVivZffaHvF0ILw15c+rsBkgQFvABZur8ZMMY9
 0TUl/kMIsmKUQovLA2g==
X-Proofpoint-GUID: dMn86LFNDgzpr4GZ1T7HV0q5uKjCZv7X
X-Proofpoint-ORIG-GUID: dMn86LFNDgzpr4GZ1T7HV0q5uKjCZv7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030196

On Fri, Apr 03, 2026 at 09:23:18AM +0000, Antony Kurniawan Soemardi wrote:
> Remove dev_err() for missing channels and rely on -EINVAL to report
> failures, reducing unnecessary log noise.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Does it also prevent users from spamming the dmesg?

> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 

-- 
With best wishes
Dmitry
