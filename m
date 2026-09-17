Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1374ABBBD
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659601; cv=none; b=UMx+MTyVVdjT3K/iNcaZS8Q7sAWeTBnNus4EPPfy5z5AXX8KpD84XdimpNxxR2MMTVb0+hvc/TwDVUqF/tftfk/gMAmRwbb1WuG2BmFC537fPEq6iMwNs09DWWphUm31Wsv8pKPGTIPrm7+JsI31KEuoZDiRyePWHF+3TzH4uWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659601; c=relaxed/simple;
	bh=9Ndxc1tBAF8mY91U3vV5DmTzD+UiZfbWF3i7EviwBno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayFW+mFlu9nXMTIoNjScvh92Gij3ydLhqDTM4lDnmpBbjqHMaLbAK7luYke5tBYc+YKVGrLnwZ/aMeX8OF3skictfwas/agBr61FEihFxpnGszVWYJFPUc0L4K/cxb1TqT21xu2yzg/T5KNmj9ZDvA8Qo9pEcqcT1K9obu6uYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KF1YJoNl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bv5C7xkm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KF1YJoNl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bv5C7xkm"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDjTpD2266805
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 15:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+VM4DE4C72pbzaP9G45mgFYM
	QivvqHf7bmdDimV4fuw=; b=KF1YJoNlSqs6+b171E4rtkq3IQDMjSKvd8JXOO0A
	moQIU0hjbwBAcLfsBRMDP5bjN3WvcmliaoUE4Vt/4WCi9O7q8HPoP6yNdSCDtgVX
	5KOPP2cRZEE08pCzv6Qgj/OOPBKmTgctcKzpvXtVX4xkh8FiK8PnGpFK17Y0QV9J
	sgEyZ0PZUOcbKSLSURYmK8lDrJ5UVptKEARcBDgh+AVO0YpArXf+t9ZPOhdsXPmb
	YozoPS2vBxxYtSQijKwLsVpBy6VO6Q5oJGu9ECw9jm+qRFw+bzko8vDThVwcwnnb
	WhN+LR+F470P2QV/YsxYFcu41jtMpuWDi4A2pJ9USjyLmQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfpph2u9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 15:39:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ae8e7e546so184913185a.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789659589; x=1790264389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+VM4DE4C72pbzaP9G45mgFYMQivvqHf7bmdDimV4fuw=;
        b=Bv5C7xkmSDxq/vx4QSeR4QMbR0sgMQ39AvlJ+n2DHibRyLBJMrY6/hYkjTlR2jmmjN
         U5Qf8GkhJPse/6i6IAIIifjqDil3aZsbapcvGc7q6DihMXC7Ba2cyuYZeCuERxIZgvKf
         lqUJVDZPBrvveQhvmR4NpChNve+AbKJrJ3VgewX4mPwC2NWeHviNVzIpwGPNK+qTP6ID
         23G7WFm8rFVI/I6y0xVeXgJgSj00gKnb2gM7BO2ovGvIXTJHhsDXhd8VeMRsv6ZG+mOC
         BJjOg9kNFRhvRWdnhI4gOwswYU3bZQchtWOSie7Jxd9GaJCRQ0kdqVk54xSc/mcaRimd
         netA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659589; x=1790264389;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+VM4DE4C72pbzaP9G45mgFYMQivvqHf7bmdDimV4fuw=;
        b=xuPZSOVc/U67rDpn9kqjDTR3DXt8pRgoUwL5obPQPqoK1I5krvy2YUZu8802Rwa35z
         LUhb7LxbxyOJh9BsK4uXHNRalCT4IcSOrOJJbxIyEUmTGGVYhAoYuLkF10HVS+sazVx6
         BhNVF+8zFGYWqflAG2EmpuS9m8Wf4U+gXY6TxqufYh411iSblMIN08nJwM2z1T3iHOpW
         bXz6ZXbwzOTPiduH7Rmg8SGyugAm1YuecyYSvQADXNR2SNKi4na5z+vZluSY4LKXJPEc
         sGfVmNS8uQ+QO/lmFjZ/P7LjIkYn1dckdmpX+TqZ7JXhL4q3O5zTzd1QoXP6KTZF5W0v
         Weuw==
X-Forwarded-Encrypted: i=1; AKwUvBxcOe7AK7p4u/7sabpR4+PB5xQXYdHln89ijox8TyKjcaO/KsN7zTozuDEMjtV84C3DjJFhJ2FKXF0=@vger.kernel.org
X-Gm-Message-State: AFuF++kGc7m4g6dObxcgwTdu6JcisGXJneu8t/W4bXYrwQi0H7ppJj04
	mGeczU1ibiuu0GvmoP7qcD/2Blj+Rca7TkYGjtFfWtPjZcnq2tHIijuqpt9x4Pi0XdqAmr4V7r+
	Qo6suV4LumRElEXMFP2Suk/SMuBPuk1LKNu+04Mt1KJ0fJUxjZS/NgfmzcbEgDKw=
X-Gm-Gg: AYBFou0+PT2UQRzYKGzjDIDfZiIbmRcrLdUymTgbxaqlHnVsQ6C8mTUujRyoFOzh1e+
	TBuNoJUnGptdVHMW3FQN0YFyXgwbmeFum4J0djmoUtXTitYi+4cMZkZ8DtqboSrX493XPFLY0H7
	upRk+1ZeYAXZRrk4iKwhc3XDanOSKGAM2ZLQE8YosjYbZ8aNPsVDgUTiltsuE8fLwQHkIxR9U8f
	GKu5dNF/099JNC88i9FBe8rCZH3QU8e62m179qfaL98uqn1eAPpEW7HJ4uX6yF7d7pYc7swoIwJ
	mwsde3TzOt05gCu2oeJ3e07pWovb7kV7gKGoQ+8IbuIO3i1k+UATPywaL546upc4b2o42EGg6Fk
	rLYYtUIFB4NYNBA==
X-Received: by 2002:a05:620a:4049:b0:93b:d79b:9a59 with SMTP id af79cd13be357-93bd79b9ff0mr126532585a.58.1789659589091;
        Thu, 17 Sep 2026 08:39:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4049:b0:93b:d79b:9a59 with SMTP id af79cd13be357-93bd79b9ff0mr126527985a.58.1789659588511;
        Thu, 17 Sep 2026 08:39:48 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd204d89sm98570575e9.3.2026.09.17.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:39:47 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:39:44 +0300
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
        linux-pm@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org,
        Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v13 01/12] spmi: Fix potential use-after-free by grabbing
 of_node reference
Message-ID: <le6lnvwdpwdvfcnjupxalgpehqbuwerhvg35inzr43hie5mfvg@743uv5ppkpg4>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
 <20260721093626.96264-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721093626.96264-2-angelogioacchino.delregno@collabora.com>
X-Proofpoint-GUID: PZcqqt4d_oZcjbWhfABFr-9A1IHuyqGB
X-Authority-Analysis: v=2.4 cv=YcYodARf c=1 sm=1 tr=0 ts=6aac09c5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=QX4gbG5DAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lMp64ggZct2OJqWbRbcA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: PZcqqt4d_oZcjbWhfABFr-9A1IHuyqGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyMiBTYWx0ZWRfX+idN0IicCz1L
 GwhtVisc4MlpnYOvET8WYHcNvnWVeRIoVZgFIR2E4HpzlRDaa2kVjvQHxMgvidljg1/ULmHzS0G
 brAaLUSbpaGzMsFCKRCbflOAHhy8Q4Fi807MjFmlKNuYT//vZKxZI90xC5PcxEGwQ/xjyZPMF4S
 8r+yq2+tw48PEzJDQhte7HN5H3VDTe/eM+Sb+ZMcqlyRhYEt2EfXvvIwssjtJdPIqySYbnEQAnu
 G5j5szzbRnDM2cc7vzVIjDcV8JcVW0Aa42NYfqajgdBHjxKdeFm5N9b40zw2R3+N4qzolhg+RDn
 kh/+bjB65zs1iNc2DxSX3ixMp2Uib4GQaf/o5rXZMX1yPVJ/EYopfu4Uq6Ap+cw+tvVW1gJDS/S
 HltSMjNKwzqFnbCXCD0TAcDHhgXsFyxkiXboAJkQ/aGQymmQLBmArhPA90RHkzU+BaWY9dVuGMN
 /9BuYZvXtDtigPV9vKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyMiBTYWx0ZWRfX6HDI1K8B2S/O
 s3t+ioyEYUv5SASA7CdaYO1wKdcQDrWXk+O6nfEiZO70pNCY9AWDYaXQiSPQ1Q097HF7qbog3aA
 aw/P1I3SG8YI6lReNnzAipM/07HhVGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170222

On 26-07-21 11:36:15, AngeloGioacchino Del Regno wrote:
> As noticed by Sashiko during a review run of an unrelated patch,
> in of_spmi_register_devices(), for_each_available_child_of_node()
> is used to loop through children, and to also assign a node to a
> newly created SPMI child device.
> 
> Problem is that the refcount is dropped at every iteration so, in
> the specific case of DT overlays, a use-after-free may occur when
> an overlay is dynamically unloaded!
> 
> To resolve this, increase the of_node refcount when assigning (in
> function of_spmi_register_devices) and release the reference in
> spmi_device_remove().
> 
> Fixes: bc32bbd04011 ("spmi: Set fwnode for spmi devices")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260608100949.36309-1-angelogioacchino.delregno@collabora.com?part=2
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
