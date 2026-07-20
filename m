Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C72877DA
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514304; cv=none; b=eHJo35/ql0vFRjPndvDYidEuXJIlV1SWKMw5lbeLFYyKMxnO4UTwC+u1DRNEr7Y09CB3l/5MJkmed2JkoJGp87omUFBVfHiaxJPgUxOPjEr8EQ4bKCnyCpNNUkumHc3oentBoXao6Br5jdgvRA4R/swLYc1sa3C2tqeiu7YPcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514304; c=relaxed/simple;
	bh=JYIJ5d1Pt+MkrYEfBiCe9qCzhOKYgY7tD3X9o6dPXJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4Y5OgNXE84I0ejv8StmOn+ZCScgrZKTFFzcwPjMPhSvqSfBMS+W9hCeTauexZYP2ZN+K2wpHYrk5V1akFvg3x0oCsqZIxstm9N2QjVBM78Wl3kekHRsaHNWB/Bue3XqWGaXQMkhMySf5A4QI0N4sgsgx3wSV6i8N7T3GnEVaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VnEtHSbr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E8kXkVi5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VnEtHSbr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8kXkVi5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsPW61911515
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JKQXea+j0VGZ/Xexze7nllY4gngT3d6SKSGE8Byfq9I=; b=VnEtHSbrPw8DlU1K
	gKT1Msl4f60b6qXjC2PCITDrwMBhU6urH/zI1xoxPHqs336s3plIu7ftZ3E4Yc4N
	+OEJT0IQ/Q6FWcUdjDbwsOnc8+pfwYQrFrYs934uLjB2c2MV1qB7tT/qstGyF9Eg
	cZn+TkzJaEr94UqNfL85JemTpF4lGTf7ZMqqhaEn1aSjih0bcT7yrl0+sX1xxM8J
	wwTC5yVJuKeUPQNnuT5fHyJVdp6hfu+rE7tQMnVMcRjeWvyW0l8WlzA6oK11MMqK
	jnjixuQczH/lGrmRS8yelFofwzyDM206YNZa0meYPPAM+skaw7vmXxv078cH2NVN
	nwD52A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aauyb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:25:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8486c3411c8so13192204b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784514302; x=1785119102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKQXea+j0VGZ/Xexze7nllY4gngT3d6SKSGE8Byfq9I=;
        b=E8kXkVi5tToIHXaVOtsHCxbcbS/rpdm93bdgn54CGT+uDevubFxISFBlZ83uG44gp8
         z3baR0jI6QgtXVB2oDkSrjkSEayS/9lsdz4oTh62U7rUgIpzh7iCnUVAhR45fB1jJGgg
         tGPj427cv6oqgn+aUoB1pSGQZxvGBgN9Nh3XtQ2Ho/dZKzkBJLS1hIbVUWENNcCUSDli
         bYA38M/9nC1Mp2Q1MbjtqmB6A3d8mLah2OI263X/JS/GYfW2OhkBCJYGVdXTuPlXwuDg
         tjg5DbOUv3W9F2I9jWz0PTt31z1dSZ5/GVmdIpomHm74u86zncI/xMzZfSEpS6gkcSOH
         JDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784514302; x=1785119102;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKQXea+j0VGZ/Xexze7nllY4gngT3d6SKSGE8Byfq9I=;
        b=r/HgzMvCQy31pBuhTgWCAzKduqAODcjMlvBLu9zEqPv8HC0l+sM52mPlU+g/6i4c1a
         8KZRbVoJy6gXcitVn+u7UvaLfvBdBbZqX+AjC+N6EbyoS2E+Aa/xKSJ4xw11XXXOt/Kr
         Lu1+Phw2YAEU8VlpFj7bUr+wANEHWVHM/vOR+87GNPZbUDsPAFovofP25rj/XS5vDJFN
         p8DWe9PNw/X9Bg+eT1OtP1rBMGiwiWf5BvdL8O8LqQJBXmnhUk6dm8HMHsHJs7YCgtlY
         zaPoW8yKaXdYzzniufoDmWAScX2ZX3ifpFRx+2KymjrfTZoe/E1whkCupTHygcHHjOcj
         PmBw==
X-Forwarded-Encrypted: i=1; AHgh+RpHyvrFRAv5TwjcWCLGpEz80jv2Fcfuq9++im9SD84e1qRFkSVgUDKVRd6hrQNIbycJsaU2AgWEQlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycQ1iOS8URUXs7groIGKKAu5/52L2UzcidT8s+Dy6e7GgUFNgC
	cRtUhi+DL9zwif1qDc0VU8v2LsFVwjROoOhxfBoBMCdwasbesTXYkcRDbUjBm2jY69dIfXfdlvo
	1lDATtYwTywnPaITDrJMCEUnH0xVz44ckme9mmchde92/Efbx2XzfKyJ6v3VowUc=
X-Gm-Gg: AfdE7cl9TpMRvczjrX2CpbYmm2hOJoxFxuVLEA4evC35Gut+v6Hug5Z/RS48CauJGtc
	Dhi8ouj0qE3Zzb9kkhNBAeAzY230yGV9Y+9kqBTmOSzoJHxX4Ad0irecjiV6pvu8AXl7F8cOjK1
	iDUZvKXN5IIhQn6s0Mt6oZb0XWkZFvb7IT4+xvqsN3XUHVXRS0E8AAs2UTI66cf4Iitl3JSUD5q
	DNfHxsBCRu/WtsoftVdSLQwpSRA+KGYYwSEaIVm7IOKWNemcMkrlxxl2h9C2V0EidrvXTW+4XGt
	1cnSRojPCDAWJSbovc77dMTC2UswhawXi3omXmgFArV4+NICs+eFMLarpjZqEeVJQ1Q+Muuls+n
	hu+V+Mt2xmgaD3T68
X-Received: by 2002:a05:6a00:6ca8:b0:84a:2fc1:da38 with SMTP id d2e1a72fcca58-84c294c62c6mr11601774b3a.58.1784514301699;
        Sun, 19 Jul 2026 19:25:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:6ca8:b0:84a:2fc1:da38 with SMTP id d2e1a72fcca58-84c294c62c6mr11601755b3a.58.1784514301238;
        Sun, 19 Jul 2026 19:25:01 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de34d4sm4130882a12.26.2026.07.19.19.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:25:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:24:58 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nikhil Gautam <nikhilgtr@gmail.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Stefan Windfeldt-Prytz
 <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: light: opt4001: Fixes from code review
Message-ID: <20260720032458.0862edf5@jic23-huawei>
In-Reply-To: <alYvMZgCu5uLXodL@ashevche-desk.local>
References: <20260714113134.3445-1-nikhilgtr@gmail.com>
	<alYvMZgCu5uLXodL@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ko3hxTw7uOpZb4l_LHJCRD7QYawzAi2S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyMyBTYWx0ZWRfX7KPBaY6ZWLSd
 WUdMTnW11l+7q8nHkWe3Pqm2ySbyZoHMKUVQkf0LSMCOLP7fkkMaR4fasN9oDYaY9t0ZX2x+vd9
 u4y2gfOtljYhgoRIEo/fXzUfcXSIv6Q=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5d86fe cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=pJOmQnRRzjSJtM7k4hcA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Ko3hxTw7uOpZb4l_LHJCRD7QYawzAi2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyMyBTYWx0ZWRfX2W+C8EWMNl3d
 5FC5q4uPdAn4oYP2vLe3fCVxAIs7Ik0JB4f/4D55X558DWf6ly9WkX2JUeU8KOw65c6x9mYLyX6
 FEiljFmNg7+Rev75ezHdkM+f7szITr/M/iVVxw3k10k/oMzLvhSTfU3FyPsYqTz7gHStOIOOScQ
 WpqUTP6AEQQXs3OCV367YYIvn8wtp4KELB8SSFDDnhGvqL1k/QpIXdxS42HBy8M5hcTMynFnmf5
 R19J8UNIIMJZ0ibOl8EBfnDCWI1CinXZyCb0oyXB7Yh5ojDIWBw6wfjWlYzjglacUJoKdOGC+0d
 WNBxxXpfBr0nASBnextXvDx5C3vK+NgIRq7TFFPLIcp5DpOuTR/djq/6Ms77VtZvm5wqwN3dZ8Y
 4N9MxzVuQS2CGcRJ4y+afIrCARKepF90KzFbgNnrvL5qslYA6GQc7Wv/lBI8h3EvUKfz1fxRFgV
 to0F26IwCFmCEJt1+jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200023

On Tue, 14 Jul 2026 15:44:33 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 14, 2026 at 05:01:30PM +0530, Nikhil Gautam wrote:
> > Hi,
> > 
> > This series fixes a number of issues found while reviewing the opt4001
> > driver. All of them date back to the initial submission of the driver
> > in commit 9a9608418292 ("iio: light: Add support for TI OPT4001 light
> > sensor").
> > 
> > Patch 1 fixes the power down path, which read the device ID register
> > instead of the control register in a read-modify-write, corrupting the
> > CTRL configuration on the way to power down.
> > 
> > Patch 2 fixes an incompatible pointer type passed as the remainder
> > argument to div_u64_rem(). No functional impact.
> > 
> > Patch 3 makes opt4001_write_raw() reject integration time writes with
> > a non-zero integer (seconds) part, which were previously accepted
> > silently based on the microseconds part alone.
> > 
> > Patch 4 fixes reversed GENMASK() arguments in the (currently unused)
> > fault count mask definition and adds the _MASK suffix for consistency.  
> 
> LGTM now, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Nice. Applied to the fixes-togreg branch of iio.git. I marked them all
for stable

Thanks

Jonathan

