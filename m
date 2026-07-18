Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40E2080C1
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339518; cv=none; b=I+wGu7aTnVnuRy9HouxsiCOHRx1IJzCyTi+jmeKyreFqYYXW9mQwZGEjq5AwlFXmtXDpoil0P+utegIssFXcJyvnKje55DzQUugRHAONEEG/vlbxuLbBLruJmriuMyCdPsYKIuFwRK8Kp/tcaPm0bj6Ffv6tTsqmvD/N9qUD49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339518; c=relaxed/simple;
	bh=uktmRHgaHId2Z3bEN8aBE0IcMStiNYNfmwhY+mzHKeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maEpuC9F3itR2qBND4+uzM/3+Ang7Eyt+Xd1p4d2yliChp8XfGgoMi0049QG83U/Tn8F4D9H3bSznpTkJf3WJeFnlWUdGV85T7VM6Vw3+qt2TtOTOc7iVMd4zX9enL/lOA2FgPsI/muyzwE9lHUtzQ3IFzdFimSRWFDlwPluZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jnb+ttwr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BTnA1Ihy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jnb+ttwr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BTnA1Ihy"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNELin3312511
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gju1xgVLjNEMVzQtIE3O1WK5Xxgr/j2HRmtju0PVRAw=; b=Jnb+ttwr0jhyQepF
	1aY+6NDraVxHWPo4ouu6yuZju56xL5DYWE+S1ktRFfQtt2s31HcI/U2gYlM+R+Zo
	dZpP76YpxlDlybZEwPKwufwN/0rF29/O6ep5+aHlD4qSY/tUzFMno3Eb74CGDXbj
	YF9io3XqDxmcbBG2BON+mjBu3A0yLrTJ7fZpfyz2HTPRo4R4iy0qbTztpsciGrm3
	71UT90oayi3ock8q6O/JbjjINzTIDQDSCPk+qHqWcQ2lMRafluZH700/o3MMD3/N
	+JX+9iaMrz1wN/dNP5hc16at6vb8Sj5gzw5DVTOsTXCAYx1QHlv5W328GoWj1aZe
	JvxpbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfkatv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:51:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cea6a46766so117909475ad.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784339514; x=1784944314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gju1xgVLjNEMVzQtIE3O1WK5Xxgr/j2HRmtju0PVRAw=;
        b=BTnA1Ihy7v0q0ueOiRiKyncnTxzCtAbu88gtB6uCUfQbbzJyMh+ZG+hgdoXsDY8mzV
         n8KL7RkKIs42bCQJthqObUPM2lv6RTlf7bHno2yQoW5Aa5CYrbIrGJ9KnVPHbys8tEUI
         Z4DuZiVBtGwBu/mNmt/BWwG09UWsAG0Pl1H1B2+d5tM0zMdfaYY0GzB6aptUKh0IKDmR
         dzM8Doxrx6B3vtfd1O37L4LtShLKuZ/IDB1vAK2QysER3RFX/PVU38gvxT0LiTwHFaD9
         CoVxDNMWycyrTZVFKSm8GELrfy/XymmagzNXWGO5EAd4qrBmXIU8OjtYDUFFO5TcvczB
         /Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784339514; x=1784944314;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gju1xgVLjNEMVzQtIE3O1WK5Xxgr/j2HRmtju0PVRAw=;
        b=qOmMoxhTQhdKENpVDBQ3akBoLObnsC+ctuSoKYZv1MfRoojsadcdfqpMN0dwBlqc04
         G0uXZK3ubk7CtH2UM5XPH1apg6GmoGp7yCEqpd2PImTMXp0dkT1vL4+DjwaewL+Wt+kC
         Zyg/bIhMwzC/vttQb+fr2k7A/YMFus3bRfYx+VlML872ZeT39vwkA1XLLsKFxG/r1wdA
         Xhs0D7+jk9S4wmXHnTTMhiF0fG2x2e4ncXgfwUukBU/Bvo53jugxK2gNggBqnmX08dWA
         DXY8yGq77+zy/QsxRZJKYzePrVdt0p2N/mDi3TD0ep/yGzRcb19C1vnqHdn/dTaCWqr9
         Njng==
X-Gm-Message-State: AOJu0YyuJ/IOFzyrnLfWEXIzan2UT+XVTD5VuemE/6sWJyYFJn9cuazg
	Xs+9wRA2wKSDYQR/s3+1ehnA5m9YXJGC993JDvU6s7BzQCO8dzjYlzHoloGafWVsadtrD4+jkWM
	ZZ1+tj/180CrN9vlA/J5xCNKtgEhD4cmoyIMp7pfeullm3uCfQDq7knL34V9LHHo=
X-Gm-Gg: AfdE7cnfLDGdnJMDLh7gnVj/ZKYJJVADq7OjEXLkyZwer0KHRC+lK+4M2nlO3jjli60
	IZgZzpXGJuvjRKD0v9Lrl+jXDYxDHkzGfYPG2cA9Sg+UhnQqhi8X07J3sN2ds2Nxc9SPZVDeHLW
	xlQAv/2jLSMx0AhBpa17TWWRaeWNteGYlqMyZ5VcOpO9dS1cI+lKNtNjSEn998gO7hLHedVDv2L
	J64VmdiuM81gXeMLr5jhbgVdhn5UrNN5/AXkx2uyscwRJhWu5GQq93AaeHrkFAMhLm3bESQjzWP
	sXDqgL6vnpx9NH0Vdql9RoJBJavabEBXC7lS1vwIKkHLWPf5ZCSQ0GeLtVvrJIcRbAKou5npKk8
	0KKlv5MMl8eNpj4W6
X-Received: by 2002:a17:902:f78c:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2cf348bee75mr57045945ad.11.1784339514220;
        Fri, 17 Jul 2026 18:51:54 -0700 (PDT)
X-Received: by 2002:a17:902:f78c:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2cf348bee75mr57045745ad.11.1784339513767;
        Fri, 17 Jul 2026 18:51:53 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3471eb94sm20636455ad.62.2026.07.17.18.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 18:51:53 -0700 (PDT)
Date: Sat, 18 Jul 2026 02:51:49 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v7 2/4] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260718025138.091beddd@jic23-huawei>
In-Reply-To: <5108c89986ae8723139419058db1b2f2e74daff6.1784235595.git.marcelo.schmitt@analog.com>
References: <cover.1784235595.git.marcelo.schmitt@analog.com>
	<5108c89986ae8723139419058db1b2f2e74daff6.1784235595.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDAxNSBTYWx0ZWRfX6hpeqdNEMt+p
 c0YBdJGmjQgOMdlofvAQhytbBmneAfIHytPbKiYPazbfiD3BbZDu5t1o6SsMnpSVfsqqFhK5K6z
 DKcJZqaNYkyGDcJTbyvgyK8Us5W4Kxu4TwsbDOBVBLAd8PmNpKi1ypumEUEMcquPsXvQcYIuY2X
 xWwWnsVc9TAaQ7sXZ7xyKUFw5xtDKwr8BbpSX/Xzei0dDcVbsNvswfEbxBWHrP2PQiwFwK6aFdA
 Dtc3YtJ4Cnq5tT6Z7qvJHOshoelmh3AFBc3fuG+Yh/Jr0MFX3fkNfG24/URudMaEmzIS0ddF0Y3
 4Dg+4Qxa7R1QNs295yfp9S8ec9idvpaLJNli3C+4BFvAVubjxVbRprE4Hae82AgrNmoNhuU/vJt
 ot4diLdOXrBIZteoG2ImDkC4s5ItokArVhQXmzfyfWf9w39AV/xnmTOjvwvYPTrK8C6b3rtuURr
 gQUdKjadhjDSj0n5AjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDAxNSBTYWx0ZWRfX/ugYYga9rczW
 GlC0slV8jncIXHVRe3A16SRVGPyhPS21nzIbfKYmsxFyi3BJSFavHnP5K2Dh8kNZ+jjLLxU8QzY
 Z5hZ6dHL+vNIC7QoZjxamnUin71j4w0=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5adc3b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=U5XZBdOWIMhTiLln3IoA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: EYSYTpb0hXVwPZrpivbJCDPlvtPL_ucB
X-Proofpoint-ORIG-GUID: EYSYTpb0hXVwPZrpivbJCDPlvtPL_ucB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180015

On Thu, 16 Jul 2026 18:09:36 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Support for LTC2378-20 and similar analog-to-digital converters.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
One entirely trivial comment.

Jonathan

> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> new file mode 100644
> index 000000000000..5600c820c7f4
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378.c

> +static int ltc2378_refin_setup(struct device *dev, struct ltc2378_state *st)
> +{
> +	int ret;
> +
> +	/*
> +	 * The internal reference buffer amplifies both the internal reference
> +	 * and REFIN by a factor of 2.
> +	 */
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> +	if (ret == -ENODEV) { /* refin is optional */
> +		st->ref_uV = st->info->internal_ref_uV * 2;
> +		return 0;
> +	} else if (ret < 0) {

	if (ret < 0)

> +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> +	}
> +
> +	st->ref_uV = ret * 2;
> +
> +	return 0;
> +}

