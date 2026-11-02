Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585626;
	b=fjID9IuQdxSAsL/TsUeMy38QhrMAzvsngCdLi/r0C9aO0vcTbI7VNcpmVLRIe3Pbyeha
	 NBYKDzBCAmZMCvjNfkzehNGMxzS6UvjQUm/vic2vHjlW3dlauuuYXCEv+l1jYQxAEnqRs
	 /l5CLvsP1PstC68Y0HBbWEJT7BVav0xn9fOLarOzPj4G3yGlSRI8av6dLqr7ZlQXxXX9r
	 VlmA8Ps2wwczCqwo7nWHcXlbFz5VmMwVPcNK/0S2K8asVydUFN9R7SOhQFJqCWOk0yKwh
	 O0cp2m2Mm3ATooJr2ztPGB30QVpn8RBB8ajv2XCaflH0EZkRHlRoGYuD4XgILNy5mvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585626;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CkYYGAqg8fl7tW61urXAeValgTYo32o6R0BiZ9jB5cg=;
	b=OGRhPLBg1Yy27bDpx+hEM7+8A2JuJmkvfM+B/gJnd+Knso5NnG+FnCQ5b+FShpjSJ5wi
	 nKDYQgV9ARqRZZyLVrt1alHViKA2tfZMAWE3Ktr4CsiR/SoRZ0M6QOtdpF25QelQ0T59f
	 yfS8f8nDs3ppXXgf4zE/sUTTJa8/9ahV5tdgq5bIFz36q1mlokJsDOTo1cztRp54P5Qqi
	 JiApnkE8/MZT/S0GutjFM9wh1qpjD4WewhwTBurBLnjsr65GkXCUFCEXB/yxhc4+ZXcTa
	 pPBDceOAt9V66KJlwMCkNhxPk54+Vi0y3z4T34F9LAVuDFbEHD0rGHboUzoFGQ07j3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VWovEoe0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="E3lRvh5/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B66606A32F
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 02:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B66606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VWovEoe0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E3lRvh5/
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20JxaQ1732969
	for <linux-iio@vger.kernel.org>; Mon, 2 Nov 2026 02:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CkYYGAqg8fl7tW61urXAeValgTYo32o6R0BiZ9jB5cg=; b=VWovEoe0k+iWjMIe
	u3c7PxU9KbQaLLPVT3T64pUfk7g/Wk9vPMn08hnkhvlaf9AYaEQr/E4dEJaygDSR
	c/aztUXPirbv8pYc0AGtZLXvF/q1h8N7JHmjD0a5/WLGczA1yu5CXlP6rT+QCCjy
	MY/sa1Lkb1cnr1KYdJc9B7+1W0f+mj61/HIPNCPMidptc7D/IojnQd4DEdnAXdSX
	fRFlEHusU6tFSiqUPAvxlr8Qy0eQZ7Tf4refEV3QQTUKxPuvUTZc/3+fIDMyzi9x
	U+E/bzHgBws+z2/417pT0Fe5zMJ/vWu9ls8YSHuqTvFNhHaZmUoMYjZRUy44PyIH
	jCIrFg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn93emmkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 02:13:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eb362d1f5eso27746055ad.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 18:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793585624; x=1794190424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CkYYGAqg8fl7tW61urXAeValgTYo32o6R0BiZ9jB5cg=;
        b=E3lRvh5/Hr30AMo6TpvB/uP+pIsnh66cQ0vXKz84MgwxoSZUB2bu6fT9NirtKszoX4
         sES61PzMNfmIss1ArRZ8j6VzqwToI0+h7Q3e2WLlP496Z0Vwr1ZEuNKAca56yLsjkwTN
         HuzqAE1c0rGxmTW9JoVZkJZceb84k8emClb8aAfYX4QWArFVaUJ/cxU7OrLjcwsaPXGc
         T7FXast/7hsUKFLp/a0Wn1/uNHkaITTvsl+EP7s+FyNowCVR1Ux6TYJzswFChLI7I38q
         hxa1miuK1O9KR+/XTurtWVkZsMk/w41zw8KNw5OIlzzspqzYRMkmPs1gDL1x2AddRvY/
         30Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793585624; x=1794190424;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkYYGAqg8fl7tW61urXAeValgTYo32o6R0BiZ9jB5cg=;
        b=yL5qpzilROd3s9yPsr4JCBM6df6GY1jbVt/Ary6uz2q3AyA46rYyeNFx2P6eafV3Li
         nXF9ZGR8dbX1UliqrBMmKYuewOK8LHf/1JUgN9ud8pZvaYqKDaOM4w6zUKdc7ZR+Uo/9
         9TbwWL05HVkxF+jTZRuXOP807vdjW3QLEpP/P/hnZ9Rt+M39O59RogJwWrwUYKVhiTnM
         92Fl94rVvvWphorYJYx00IAPod/RnjL29KZaqCRH5osYZQpsBfCJmzwetzb9cPCkTDYn
         LQ/khtcTM2uHSmLJPaFadeLwIqJ2OSBYW1hZFJP5C5M1P6MteBCVWSq8ALhriA7HQlf6
         1xgg==
X-Gm-Message-State: APuU4Z8aSvvm6B3126tJ9n85RH0FLjpSE8evKXFjZ5SCaNb1zLGIT4n7
	Iv2aAvUPVTKoBUd+CJZsbl0OJmvzOLjyujW0mlABbGWoLGJF82dcNOoqVYEfnY1u0TD+tjmuVUF
	WvMAamE0GyNGs5ZE7iwPSUKMJlrrKyNOPRDCT4eFvq4O/iNBevBZq6k/RL6y/Pvo=
X-Gm-Gg: AYBFou2DONy35MdTgVmFBMnrpJWqFjUv+qoQlvWh5Z4lSI33S/GBlufEkGEf7NPRNwE
	yPnGAbp0sZSaJzT4N6ucAxUxlkdQeha50h8jRYDeWWLWfDJR60si6ldPo8r8NiHbUZ7eCvViAlP
	KDeB7cPhLmv1bisOWdNdhFJ8YP5+NgH549FE7xjisY3jpePZqI1fVZp3wIWaSXZGxAB+8M8gMYo
	AsU37hYKuRXjawKQXW9ets7d/MLgkFrSnHJ//8dMVA0EBIhGyS+AsA7+q78RH7ZIBxdpWr1AtQZ
	pV4tcsafUO8lZa5DSBZuGxwwIVdH9vxg8Q0AJv0BIRkNA7RSruQnsUTafxJK2Gg3GzXEtkb34C0
	tap0SsQEy3JNgP0KkFjoF9jpQDP29HErE0WrPOtKIBY1oL0ay3oamL2PkEAay3on/Yw==
X-Received: by 2002:a17:902:ccd1:b0:2e9:4b65:369f with SMTP id d9443c01a7336-2eb364ddeedmr83150315ad.34.1793585624287;
        Sun, 01 Nov 2026 18:13:44 -0800 (PST)
X-Received: by 2002:a17:902:ccd1:b0:2e9:4b65:369f with SMTP id d9443c01a7336-2eb364ddeedmr83150055ad.34.1793585623840;
        Sun, 01 Nov 2026 18:13:43 -0800 (PST)
Received: from jic23-hlaptop ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392ae011sm20111635ad.69.2026.11.01.18.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:13:43 -0800 (PST)
Date: Mon, 2 Nov 2026 02:13:40 +0000
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 12/39] iio: proximity: isl29501: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261102021340.06c2825c@jic23-hlaptop>
In-Reply-To: <auBfMhYTESe62Ejv@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-12-8b136778eedf@oss.qualcomm.com>
	<auBfMhYTESe62Ejv@ashevche-desk.local>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAwOCBTYWx0ZWRfX9LfJES1bdPfX
 12OU9Q17xKFx21v3yGyLlP1rfJuGtT+hpuWBb2Q55iqkx4qdmHxPnI8eOrUQAwl8nKB1dqqGQve
 LNzVnoNW/LeABf+Hw5fILPZ+I4D8dmBYQG2/SbTPrUWTOUl2UcAbcpBvtxIGV40Sh93aQpw2S7J
 2UKcxp5id0uWHD5qM5UoS41HLP4NU0CaEu91WVbn2ZG1MYKPfu/ee4ITNADjSoD9Tcbse7WixMm
 TFFg+6yvkYIG9WpWverLSYTyNDs4r0iEKWyCPd5OO/pvNp7AXDqYv1upTL/YS3NBo8skxJ2VbHC
 0DKnqkM4xw9N0HUtOqJMq09lynpI0U/k9PT/gNPTGXNCt7/a44w9tgiHcM2VepLzNBaMBeoW1fU
 +kAhWDKnpmPvf0vRbkb87rgElXJxqC0ONA3yFBLvI187WPrRm6TRrCDc70AXwSgR6FzY/2eo+iJ
 zFtn/K2l2xBTHaMC40A==
X-Authority-Analysis: v=2.4 cv=FciiV5+6 c=1 sm=1 tr=0 ts=6ae7f1d8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QyXUC8HyAAAA:8 a=QDRxda2ohILoPe6AuXUA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: SSk9ORbRqp__RBR1YWmZdEvRV2mgcnHt
X-Proofpoint-GUID: SSk9ORbRqp__RBR1YWmZdEvRV2mgcnHt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAwOCBTYWx0ZWRfX/VysoI95GXuk
 JZn+AKDE5JPh/ufYDLn4BONrzVmrmoeIbHfRz4wTNX5za92ZLr/XHXYgtGEyQEOrxcXlPbqO5go
 IeydlC2mC0iK3VnE/Vuruunq+ltsWc8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020008

On Tue, 27 Oct 2026 10:22:10 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:30PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.  
> 
> ...
> 
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> > +				    pf->timestamp);  
> 
> I would leave it on a single line (83 characters only).
> 
Tweaked.

I'm also not sure why this one doesn't mention it's local and on the
stack so I added that to the commit message whilst applying.

Thanks

Jonathan

