Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D523D7E3
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511597; cv=none; b=Wg7tgxS1sp9U/+hKeQpvEedRcnxqpua+DlWWD8oGv8tsoVxyvqQ61p7uuRczPQhFvNXgQZ/eKs3vJo+qY56+jxuRW09X96Z31ANwn874OnossVGAsiFSb8kG/pLdbSo1hlq+WFayOMSIhz//+XIs63+05hOJEUAVi8DbCplGlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511597; c=relaxed/simple;
	bh=kHtfumkrjgWV6lqa6yLCz3o3in3lRj0JfrLm7BDLacg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LozKpti2ai0zmHcj7zCj8SGYvKykAnJxzwQ43nt1U/5eUV5AzvUCmF5wRBiSGUoJc8lDuE8wdJ3uPJmv5EfUFZch4XTKPcucxFJHIzjDw6YyLuC469HGtu5A9p+Tpvs9N6jnFFLZ/s3PXLMcbX/W9VtbrQiga5VQRWzyGwRHU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gf1eMcpZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cdEkCaeQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gf1eMcpZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cdEkCaeQ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNt6wD850541
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kHtfumkrjgWV6lqa6yLCz3o3in3lRj0JfrLm7BDLacg=; b=Gf1eMcpZ+8HPLJAN
	fiCceCP8o7gZyVS2ficRMT61jE+1kif8cDyKp2T1NMhKtz2Y2q63BlRPiWUIy8Wx
	ClhT/nckFZRUezDlKJAJYLKBzNkwyV3y7FSgeEc2dtiHWtTF5vn73qZnyJCwY/Pc
	MDh+3AXYn3S9mFxazvO4DgAG4nDdcTJiGlgEKiXMAZyUvUb1ZQ2bQ4//YXiUNuEX
	TmycDo60JjR+RSmmEwmiG7Dw4UeuZ7yzMs2Tgz4hw5MHHHX2/USiF7cawmLTghao
	Cwo26aAoFMA1aC6bQxpS71lVfm1/V+/sD1/27YV3Du6UeWKH44ezy5aNwnhAxdJS
	ZKL3Ug==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc3wmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:39:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7f385887bso233994575ad.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784511593; x=1785116393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kHtfumkrjgWV6lqa6yLCz3o3in3lRj0JfrLm7BDLacg=;
        b=cdEkCaeQBLng/vkQ7qs5IeR/eRPKqacl36ul4QuiuUhsOX0FRkp65K2vhcuUnF9qMF
         Y6MZ9wAVc0VI7ekbv7Mg52xULU4oGPkR25LJlUtEoWybLWxP3Qnsbnb48iVIa304RWDG
         S0LMYWDcJq/Kg8X+BaWVF9EEC3ZgxxGoQEuujEuvFsRmAtBHFBcZoPnd55gZSNq4M8z2
         hdQFlxFLGggPtKlsTvIW/oOJKHSp8qdAcPvtKRADDp3I4JCPt+ZXr7AgXUJ+4OwmBDFZ
         xRc/xheYqBDYF4I0XeHTUi99umc+bOGfDeviUfKog0d4SyV1qaDNjOw8FRPej1If3uqw
         yW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784511593; x=1785116393;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHtfumkrjgWV6lqa6yLCz3o3in3lRj0JfrLm7BDLacg=;
        b=qvq0YZqDkVkmPo1RuQLoauYcaFKaQz6LeHLjAynK1sGt048g3hyhQl+Hp+Mcz/AUNE
         Y/C7Vk3j8lLFYihOCfrL6t+pG0BNs57pZomjBm/2g88rXFxhRAp75miGs/5OE5bweW0T
         ZFtos5DjH/1xSgayoPcUHV9jsfzMDoajjOn2vKW/Y4x8RIlO7jxbx4REHOs5ic6jz8VP
         RtC6IAjUgLnJ+xqT9qJcir0vmVl9ylPWF71gojHspjm86/lRe5iypRuIxCJo71e8/r1i
         L1BOJdZy/3BK+Eghff+Kv28XtDVDWULrYz29BdPz5Zeb2yE/fpYXYnx0gG3gYy8NNf84
         Kurw==
X-Forwarded-Encrypted: i=1; AHgh+RrwpRBOD3ICBc4jqql0H71DT4m18mSR51ApRkkYZeWO2NjmY95qhHXm8QFA4RWRrRGMSD+CUT2SbHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxS3xy3NtY8GKb3l54eZwtIL08FUoGhS8IdyLUUaxZu6u1lqzp
	zaizbQNVTrNCtUbsZv2gc6otvSWcreaMpzIInoxqwaAc4wDK8MQAdji03WmIWSRV3IWr3voT5gO
	zQwitF/AwVWbWIrp1br0DaIv/dJy3eFK6lvP+6FKgN51NwEqcs3y+eBighStghfY=
X-Gm-Gg: AfdE7cmWsPHKfIJLTA6tmHrsBI9Kpa7dwuT+FVvIREZzZwOMMRWXa8jBnoNX0ojmuXq
	UE2DkF2VEE121OwQ55mR3QyasAYypkdAxvp3v0TfGgiQX3Uu+0btc8CSXo04QH+xjBI4xSMtJn8
	ilv5/zaGWytmqet6Zf6H5USYEH+eM2QBQG/C/5Z9hU/xxbTj6dkhfANb+86U9vQXLMzBTHklKIQ
	MOOAYuvIgUUpQXzDz0jnN3nkG+fEVQVd2ZlGWobob3ontBda4l+BZ2DFzJYXtHmeCUM3tm1r6M3
	+xBjXFMeBmD+QAIS2lLU/PSpCG5VZVHex5gOgcsJRcK06mtBaAuc6cKVVEz4FO2nPLh5Q6Jbk+J
	ToFURO/ulsY1RrFEU
X-Received: by 2002:a17:902:d987:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2cf3489c64amr138490595ad.21.1784511593222;
        Sun, 19 Jul 2026 18:39:53 -0700 (PDT)
X-Received: by 2002:a17:902:d987:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2cf3489c64amr138490325ad.21.1784511592787;
        Sun, 19 Jul 2026 18:39:52 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34730e35sm47246165ad.64.2026.07.19.18.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:39:52 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:39:47 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Simon Glass <sjg@chromium.org>, Andy Shevchenko <andy@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Rob Herring <robh@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: rockchip-saradc: Add RV1106
 compatible
Message-ID: <20260720023947.0064a45c@jic23-huawei>
In-Reply-To: <5684233.Sb9uPGUboI@phil>
References: <20260714131631.v2.1.0b846080833e4b836793c43fc26d1c6d817cf9b4@changeid>
	<5684233.Sb9uPGUboI@phil>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAxNCBTYWx0ZWRfX0M1ZIj3eCW3v
 yh+M+clAdwHvu48drQavPbAljjuHsa8sSoLOu3aJwb+wDjrPluN+l10S9IzJaoI2K9j79LtTIn7
 rhfPawcf19zInZ9Toqrz/KXAwa6X9Z4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAxNCBTYWx0ZWRfX6+zL37HaRbzX
 Qw0bo5bKQEdIQ/lW7Z9G0fdWWD0k6gC3BJ6asq85p02K8pJJlTHQNhFO+RLFezNvQAyvshMY88w
 tM7jjQ+NOdQ3H7RQZ2zt2+HMX3mA5tdxuhIKgg4Yj9uuxZtSnqMe/9fnjIIEf9TgmrFpNhP20fg
 1dNTfOJOg/hZweMlfUmGbI7mLq/P9L13/XyNAygmrpmpLUx1ar17JEtjB60fU0Yz+uVdvU83Rws
 HWZHu+CoFCyVUMzP/LB8zsgFYQRPvoaUA5Sm0usDwJnxpyhSnFj2AE/yDafHiIUZKk/cmYZNYm3
 CvKpfUsnSZLX3y/5cIqeA9ZQKNg05ZwaYUjOkBIRUodbIfRC8hSvF6HiC02/P3r1ndBE9QVLbc8
 MmuQjGOUlUUcp4eb8C5f/GpUXmRHM3ujysG9c3hHyliXDJqdmwYQS7UHOTNz8jjW42slV0D4YoJ
 PpEb/FmB1JlWygfsNLA==
X-Proofpoint-ORIG-GUID: HHW_EHhmOf030QvgvzGzmxGywMUGBSdb
X-Proofpoint-GUID: HHW_EHhmOf030QvgvzGzmxGywMUGBSdb
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5d7c6a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=cm27Pg_UAAAA:8 a=-xwdloifxYJzbv6MhYQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200014

On Wed, 15 Jul 2026 21:21:17 +0200
Heiko Stuebner <heiko@sntech.de> wrote:

> Am Dienstag, 14. Juli 2026, 21:16:32 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Simon Glass:
> > Add the compatible for the SARADC of the Rockchip RV1106, which is
> > compatible with the RK3588 variant.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org> =20
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
>=20
Applied to the testing branch of iio.git. Thanks,

J
>=20
>=20

