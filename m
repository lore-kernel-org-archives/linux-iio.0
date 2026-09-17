Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74894ED185
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659679; cv=none; b=GLK8jy6eLfJkjWlRh265cqRvTdQ5NYPoeL2d9ieDHBdxFgR+AV00MPVvdw/bnORNEuvZaHRR2PVNPXMHw/LkjvfpGLMz6znqxIMhCDXJFkSSclL+T/C4sg/hFMlx/BEqwSW4rGt8K1EpzA5XXnm8Y2Et0cSPIO+zk3Tey2sfII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659679; c=relaxed/simple;
	bh=niHJvKcGc3sXIxEu8fC5t1ndvGH1g95O/YBiVkFfwJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUgsU3CKaCtuDV1IevS7SzX+/r3OlpcixIO8dJtxPg3z/mhSk0mE9aCqqP6tdtXD7i6xFTZNIfz1zjUd7Ifr20m+/RBXjZ/DTobGq8Aa49m6AKNLvhUo3dW+z36BRGZu71mlVCWClPLEJATFa4DU59X5FfnXPBHsGHqVPL+LDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGKB7onL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWBQRiiM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGKB7onL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWBQRiiM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HF9wSn2024669
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 15:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kv+f2O5HtP2UyzQFqxgl0Ck7
	X1yB8VDtNQPrqEOFNsU=; b=KGKB7onLVmzH2nA9sBMm60L5L8sxKuiGItypEMRi
	mIBVtN6RcDV71YuJ3n9O56uxKryNptHQN7FmDKTrDePq4VI+GVvEBAcubco4eDcj
	h3mMQXaFEQ61IUTZalhGat6QW8GVeALeNR2L3vsc+umk8EmhCs0Ez/mRClKEVRJU
	oQ1gj0G3tBSWWR7EL1/cuRHsHQjH6BERl6WsF25FxUrvJqia3bBWFWMyNSOk1GGV
	O3gMVtlUBChNqh/07gLFswwJi0VvNUvSCaPyITb+Jv6eNRiog8podyT0Ie5gt4U7
	tKzqyFNElAqLPR8s0gJdtmgfsDauX29PQ3UbcnW47j0t7w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjkt04q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 15:41:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936e393061dso155141885a.2
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789659666; x=1790264466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kv+f2O5HtP2UyzQFqxgl0Ck7X1yB8VDtNQPrqEOFNsU=;
        b=BWBQRiiMXhF1HwFET0v43wpLH/xcy5Ohq8pzXEtLCQKgeEktcAIRGOiTOObaci8hjG
         /TTLWAiqWDwc/HzUAfGmSQuNNmTN2H0+6gfzsuU3doV5wy8bIlaexq5e6aOJK6kj1JWS
         yMQPbbC6E07ufG82hh9jVWtABp14Xh9xjoKeHv5ovfSXGhnb6oyFWKOJOITc20+TIYax
         YpFllMbo4dTN3B1x9i87aMDyTLrDBoASI9lq/SZEU9pZNT6BFqvpef27PSZhAGjaSBe3
         +ARpy1Tohm7v2xSr5VVGqvPEnt60wcG1mLwarFed9N1CJnUyHAoWYRVpmJQocOl1aur4
         AGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659666; x=1790264466;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kv+f2O5HtP2UyzQFqxgl0Ck7X1yB8VDtNQPrqEOFNsU=;
        b=qzsAHcFWsE91C0/j0mk2KF9lCqozH1s33VIsVL5b7cWoNEG+krHYujd9FI08lwxjsp
         G8hPr5kUrSk4KzhjTD3TAM0jdYFKQnYpThaQYlP2xmWBP53QOLYLwQDw1yIJC6kvZGBQ
         vp/glZIYh+juj54IyQhjG58GASyp1cYyGbIXi8pQZGwVsWVcivUZR7Ddz+O1bBdNh0EF
         Qux2IcCFM6Yye06GHblo4kq1CWFv5J787mEIv1C8/JDpRiac4nQsYV4zYO6bj9n5cX1B
         CkYPLnSB6PgMPXfsB16D8X3oi7Rih69cB8+STmpZGtG1roF32qduvhcL9hbI5c5BVbI8
         zr5A==
X-Forwarded-Encrypted: i=1; AKwUvBwt9Upb7eZGA2W1PKR8ZzOjjguIgT3KtM1xotuL3/ToiSG+9rAzIfw26V4nOpGvMeW9JPfXyJJmWcQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lxN9b418FBmCsKXJes0TYw4ILVxg33ZgDd/n+Jedo707sJWS/C
	2BZnSpt9aUdQ7IPntWV+t7bmcyAIXuEnTn0yf3bnSMM3zv6r/IVtRhDUnuGMiMgvLvk0wrlZ2yJ
	BLHr8OVfmDNau+4JyEQjWEFImR5QOn7sfTB7iQJnBQjZfAPQh5buDFidVSXOk3/k=
X-Gm-Gg: AYBFou0C4qCfgMA7/0aGGzWZiE/5zstTPlpnsrdc7JKWqo9/6hkLJq86FYdulZ42L0a
	09W96TIeO7fnWZegk7ShF/V3pLufTl/vM/HCy0wA0epT5xCDvar4FX/GJR+2PoeV5DjPGtG90bk
	yf6371BD8nuSFCfV7lExmJyCC2PYuDXNl2i396NMuN85RHstxUnIpkNCsEWcDweIaQRqT2IshrC
	PZhrO2pLwDehRCw1wraJ5sMvpsGS6IYx3Vc2HaH58zppmwNz4mPsRX5Th7F0EaxfEqGTUEVN8bW
	801NkNa79jEjuhqaXQ5o+9uGYclavj/AwLAXVvdZpvFPM/EpnUl/8x2XmzYdMAnG840/Wm1G8oz
	NCcr7ACrhk/2pug==
X-Received: by 2002:a05:620a:4621:b0:939:deae:8ca1 with SMTP id af79cd13be357-93bb793775cmr1229081685a.44.1789659666344;
        Thu, 17 Sep 2026 08:41:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:939:deae:8ca1 with SMTP id af79cd13be357-93bb793775cmr1229075285a.44.1789659665701;
        Thu, 17 Sep 2026 08:41:05 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24034esm101548365e9.15.2026.09.17.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:41:04 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:41:02 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, sboyd@kernel.org, dlechner@baylibre.com,
        nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
        neil.armstrong@linaro.org, sre@kernel.org, krzk@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
        melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
        ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
        luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
        mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pm@vger.kernel.org, kernel@collabora.com,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v13 04/12] spmi: Remove unneeded goto in
 spmi_device_add() error path
Message-ID: <7xf6fvsmcpqjpkto33g6o63ejagcbyitoaetvxww6pdijirbkn@etvrh2weic3p>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
 <20260721093626.96264-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721093626.96264-5-angelogioacchino.delregno@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyMiBTYWx0ZWRfX/81iO7l/6s5V
 YU6tYEZ4Py6dT7Sv7Vm1fEo7N/NPo4Ud3KRi9pARCWsJ1TvNDUYy6Y2caUtp+Sog0Ecc+bf5G2z
 390ic0jcqj+ExU2wmq68ngOqWbpVSF9/j0aJykzzKMDh+VcOFtDkvV9b9HwinMpM1qEDCVRqsqA
 Xq1+eiQhL9aS+49ELCch+gvFEO5RPHf9hOAIGWHKW3D+msGBmgfxj4BbzFvmsZ5WmWuNTDs7Q5w
 C2HZVu3A7US4cByZ2I4Y3CsSDq1Xxqgj2vO+pl8OqDMny8VkajPqKoYIrP60rLxdgitcnsPGXOZ
 QSPUcgdPbSL/FHymZhQTmBYF6eXX9OZ0YkB/YNcnXczK03Zlla4l8dT2URlmbXyHMc2lUfmxSQP
 mYjI59yhTT/q1UYZfvJHV//7iIrps/LOroJd966Fx5ZvsYtlh+GmRzG7i6oeM1B3lvBCpbK5T6R
 4Iyv/6vWQm8QID3+kGg==
X-Proofpoint-GUID: kcAUlkTvLeMxW7qO84ywxH3fkW9vR0HF
X-Proofpoint-ORIG-GUID: kcAUlkTvLeMxW7qO84ywxH3fkW9vR0HF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyMiBTYWx0ZWRfX4uC8AaJ+s1Ew
 xQKmwZ25QTtvGgPIOZAToiXdwGUNcrnfiK74BW++kQxNBpl57zOr5gOzNkkTxLGyaGzzvij6E5Y
 waH5xnm0r92OYAfB/dydf5jkae84d28=
X-Authority-Analysis: v=2.4 cv=Y/VtIReN c=1 sm=1 tr=0 ts=6aac0a13 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=RPqXdwRs98PbUg5oA2AA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170222

On 26-07-21 11:36:18, AngeloGioacchino Del Regno wrote:
> If any error happens during device_add() just return inside of the
> conditional, as the goto path doesn't do anything else if not just
> returning.
> 
> While at it, to improve readability, also change this function to
> explicitly return 0 (for success) at the end.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
