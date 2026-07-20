Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE0E299927
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784515004; cv=none; b=Uk/YUr9HeeManvFVtCbUtgmDbltOjyo+56bsxuMFdeyFdQo6AT7+mY4XUSZy9MrbwYFfANwW46+OjrLanCjsN4PpUUfhjiBzSq6UAIynQce8qAr309Lw+J2FuLMQtBCqxDuqDb1VL0wyZn5wge6PJaxT4yj8UUVJCUTb+MfB5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784515004; c=relaxed/simple;
	bh=Bek1vFuC4E5g4lwTqTTdOV/SROtBQggmloff8l1n2f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNhmOsJQgDk5Uj9wkkT9v5lAz6H0YdSsqWoyUfG6o1y0OwKk4S60V+wnJjTnSBLWLj3oiEMSpVIljeHPTtyOuveQFJOCCGs9FTtPExms7czJVS97tA8Dz3mtLCybY0FO7JjMR1Cwi9zchjvzefchxP3mvAEK/jykqtyUSrkdRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ie2I19GM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dj3HZq1l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ie2I19GM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dj3HZq1l"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsPOM565048
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vv9KnVt3MLG7Ob7Vop7I3+twElUEhg4uMBFP2i5c+Ps=; b=Ie2I19GMpNlB0t3F
	xQtU1GCKoQKP25vaNBJJsFjWq49y3lGiOYe+vc1X2gcHiEDMQ76KfHj2pWpUnKx/
	WGdMk3TmQ265Suzd+ggOY+IBxjhUnmYfigAUek6VStOT3eDqtCVvbyKCs4by2UBs
	WjLEtjcW4VmHfAbA3GwltpXZFNPNbhtZIEyVOCH8pd+KCuFbZ/LaM34FvDJU2bhM
	hh0G6uwdF5c7QcVJt4maWNq3vr3FIOWhCNy5rWWy71WD7xAf+uks2/pepDtfRfbD
	wSBLudCV9ke65QTPHZ0wd7jh/EcbGyspE1KthZStWwuw0+owiFXCO3ThfJCGELI9
	6r5ILA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7uyav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:36:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84870e7f498so10193859b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784515001; x=1785119801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vv9KnVt3MLG7Ob7Vop7I3+twElUEhg4uMBFP2i5c+Ps=;
        b=dj3HZq1lRvCo2d4l77OL9ENxAJD2jUw1XyEuw4uJKCdbXI0EDVPC+zNUUWmF6+YU2w
         TbCc1TbPGaDNbtvyszaoE5PR10/zDF8GVTU5cD/vCXNdxn3Xil3oKY1/0rhTrb+uyY4R
         kWjSvTyMTD8Th0eNIRwIuzNf9ximyEwQVvm9KHmYKxhkTXeObXiVF5U7/uVlFzEmA64f
         7jBlT3dEmIn23fgN01R3RsXOgz+ou52Xb6gb/6KWzN0PSJmB+tve7fxs7khMXOmzkPvp
         HLvJX2YIKq9ohR6Nmbxfe9d8dXRrdnYsw71L+l2ikTEFqo/EIbESzhPcGf7z2qThCVQl
         vJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784515001; x=1785119801;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vv9KnVt3MLG7Ob7Vop7I3+twElUEhg4uMBFP2i5c+Ps=;
        b=Ip4l7QGgLRmg6WePyn8JMvva4VvRkYyPzlMc2LdMRcbhFcgyEqm70ARg5uMb3rqHqA
         S+K5PvCV8OxjTo8HtxuMJikHFy42cM4WbEfcdyjF+rX7zd4JMf0gRTsQpoH9IsJZ0E4E
         eNtXDsvd58Xk0KdO1D1VYdYln/7eNzKsSSJu614d7zx793+SMdRW/ReEO4EZI4awAw/A
         PqW1zJHXznddFSyDSeuWaxVLsT4fZfkfXcmgyefCVbxcrZAiMWU9mGFhvoQtPPiaiDnf
         TvM/9rUqnaeuZvz/WgtYjJCaMnZO+9PKeQaWp7uCi+DHQ1Xj4GmCYykTUbf6Ia0lURPi
         BwDg==
X-Forwarded-Encrypted: i=1; AHgh+Rre/+ZRBeU/hVqXtpFnSX2PJgWLW+hFRJQxHTr3j4xMp1BW3aSOqIWjK86HugAwMaCqUu/40CGyrnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJG3Rh8vBqGMkm7GgMtMa/4OBWBje+8w9gouwfvDeb5bosZ2F
	ykX1pDJ3oQgw4VYQp0bt3/QuQLjrpCgI+QGS66nwYafWsKuHEAhMa6OUjlrsyMSvvGsp7LIXEuO
	v5qxM+3S7eOX1z3GyjEATM/h5ARby9tLRwXwVrovwKq3b+wf4WEby/tLEjmI2ysQ=
X-Gm-Gg: AfdE7cncUIZcjiFZKaGe4mGBxxIxPKlNiuXTve1z/NkATUEBJKIxAY/SbcnOJ80CVKA
	eYy0L5QNmXX1yE9TnDOENfMborRehl6umBgSeQYntRaRyuotB4EDPby0SuGJynFswegmoi2vpuz
	sDPRFfuuvmlZ0l2T7kyjRqMacCQVL7myc+c5BvcI/wzsRpOp1slBEbEPP/PdCRqatappUOClYAF
	obY6M29HWS3wxBM5YtgwhdLd1p2Ky0aJ2ePRtoKcfXw2qmVJqGpsbRGourhqNOmDpmR2N+JdmnH
	vEGUsUagaY8aKGHOEhspxnaZp9rrNmKdkG04+5DCmG7t3POW9V4CrGp+OqRnFyAxBOH6GjdZU7f
	Og3o8aFSXcsG4l0l7
X-Received: by 2002:a05:6a00:2d96:b0:848:827b:70f8 with SMTP id d2e1a72fcca58-84c29568573mr11495044b3a.67.1784515001606;
        Sun, 19 Jul 2026 19:36:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d96:b0:848:827b:70f8 with SMTP id d2e1a72fcca58-84c29568573mr11495024b3a.67.1784515001165;
        Sun, 19 Jul 2026 19:36:41 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3f6sm4744331b3a.44.2026.07.19.19.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:36:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:36:35 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linkai Gong <gonglinkai@kylinos.cn>, nuno.sa@analog.com,
        olivier.moysan@foss.st.com, dlechner@baylibre.com, andy@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix typos in kernel-doc for
 iio_backend_interface_data_align()
Message-ID: <20260720033635.057d8df5@jic23-huawei>
In-Reply-To: <alX8brPnXIueYPOP@ashevche-desk.local>
References: <20260714085019.3109889-1-gonglinkai@kylinos.cn>
	<alX8brPnXIueYPOP@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyNiBTYWx0ZWRfX/cdaj/dhHcQn
 5S0XLmq2wjniwR9GC+w92kSUB8ZKqwhbnZ2VujKvXymcgUFgZzCr471eWmW7m9a1xPbC3BDWVmE
 AJQM+l+PawQu5lFPAL5H9rMvfRivNoW/quUfIfNOftckEgii47choW46gpGw73Mu7akCEaQXnZR
 FcS8UpGbkF4cDuUn4JWZYjpf7a4Z3x/ja8oECmyPSh7yphO24OdYuCSRFf4d0sHPE2hd1hcefv4
 /AgrcnvHnSkrCzrskYsb28EzLWU0V07FoXiH6YVTmPsBdsi86eP9aywGTha3lwUSVHZ15IYIYOG
 BT+vxCBsQgOKf0gb0H/y4+azZt3sOy02LMbcbs7G/UzXclEZSns8D5qZZaxrMtw3sxvWBWHsJj8
 wKZzv/KJfE5rTyg3DOoJyNDXQWDdruEA1gjZAcHWos9s/7idlcegulCanpRiF7dmhLzj67jnakp
 WDYPuhEEaB+ZBsYGlaw==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5d89ba cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QyXUC8HyAAAA:8 a=rTwKCDYDlI0d0RxuAlcA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 224nAIxJ3Jdk1Zbv6_4aemEq4s4kI27g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyNiBTYWx0ZWRfX96PBgDUVoTFO
 BTgv709VESuhvQYFqVpI5mBRyfW5PWZolMfFmxITC5srOCYzhzuE2DCCx13lnYfio2vHGzEtdvZ
 wZY86DctzsL8qC32pZXZrIhXZtMXC6o=
X-Proofpoint-GUID: 224nAIxJ3Jdk1Zbv6_4aemEq4s4kI27g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200026

On Tue, 14 Jul 2026 12:07:58 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 14, 2026 at 04:50:19PM +0800, Linkai Gong wrote:
> > Fix two spelling mistakes in the kernel-doc comment:
> > "initates"->"initiates" and "proccess"->"process".  
> 
> Is it the only a single spelling mistake in the whole IIO core?
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

This one isn't there any more, though fix was only a few weeks
back.

> 

