Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E0175A68
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509807; cv=none; b=Xc/X7oLr77jSkvJBTm3xKho6PL9bmVCRjaonjvx8MiCtgHvclX71o10MwBjkrvxxDPGRoXf/v1Ey6Pkmnrpy0aiLFWvPAWV6JALmnRAnMxiPp6BDDiD4LXkTrxAm+kWZrWLc9y6OWx7i5MKygj5oQJNBlHOCoF7huwjkEZ09b0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509807; c=relaxed/simple;
	bh=hDiOy+/M4OfbO5Y+OUa4JeHIlcDyUf3B6CeACEejA1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8i3AGBvIQAOo3+Knbw/acwSiDMBxLvmpHzDIWYJ/hFvRyHespQ0dDD73PBzRtePnyBM1yMPOjLooXaeDry2hUhYhovphwTyuJrBTPGi+6uy4Z8sGncDVL1iMnphDqKTR8dqIn/uQcjToOcbFxR1sdEisV2Y5c74LycQ/X0wT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AxmZcS5X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gogdtSP2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AxmZcS5X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gogdtSP2"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsSXB408365
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OVqOUuBVtydQxQUla2vfU1Oku0cw1BoRtkOvkgKRR7s=; b=AxmZcS5Xwpz//RCl
	BcSCobVgIdL5tCaLK5EJ6MXNjnGU0FBlmbWodP9Ej/8g98kCYdmMOsQAyPD86w7e
	1KGKN7K2nUhG5XjgwOfRWjtdmt0ZgOY7nyDdEU7TdXPkP8jDn0rmgk0VeWB1wyud
	2MO2MF/m7NlhntB3Tu+VzLXyQie9Yzv99/o8F+VBP4hSEXSDZkm6On31J/FSnpio
	LkfkNbO8Rz5ZXNRwysQpLQXfGeDc6VMCMimUAdU7LZ0xHo7yoJf4UFEXdql3+YQO
	fHpzUqMlpP5KCvLB1SBbx1OHGObum4Fz1aZ93QGXJfrxWxSQ0tawjA3/7ADs4Ro2
	JF8zdg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhktqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:10:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cacf17c7e0so91716285ad.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784509805; x=1785114605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OVqOUuBVtydQxQUla2vfU1Oku0cw1BoRtkOvkgKRR7s=;
        b=gogdtSP2Y+jeO1lzRNi3hsN2Bz194kJ4HMrJ08oV9Ff8S+bdkMaR0+/TYHer60pEm1
         6Vc1kkFv9Ob7rlVzmGgcqzwQbiqxjwrAfuAfkEKETIa5AU6BmjHyvmcZQHRHKmk0AEKd
         g1oPQMnF7798L03W2lG9AiH3ZqQDoHjG2rpV4WATubx0nGxXBx1+Aj46Tk+pwkcY6kJg
         YS0tb7u474K2bZ4JRIds5vSLQe7FWjlpoOMB3u8/LbaIHfDCosF6egg4FjkvXO+Pz7Iz
         VmX+u02BUKAoSdoHzA4HWAVhGWQj+9IHwrSe/iccm/TkSfCUo8qOCGHBRbhIK6VGNivZ
         NGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784509805; x=1785114605;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OVqOUuBVtydQxQUla2vfU1Oku0cw1BoRtkOvkgKRR7s=;
        b=FLRowkyETBv46fO0nKu7K2WHQfHARW3ONPf3UQE4q5LtX7BFdHBq0Y2NBiaZCZu8Vi
         z9HUYzEDAzHjreXcb5gmwrhp2KFffKSlxV7MqAyZySMUhFcUJKXXJDSjDJwOrDYk2paF
         XG9i0iETLo2QO+SIPNM5lwan6fNgCjreRuMX4vt/JTXcMFovLhuC12qZG74GqR2cLRPF
         AeLUOksnG8eEujs4/Yv9wxcs7BmRLI+QbCXjfgW3wOzmOk2KiqvlXYkiLy9sY/UwOYgd
         Inj2zjwJtc3YM1cmgsL/NSDnOqbkabDX7Wkkt4mMWYHb0xqOrUBG38kFXCXeNgxR4Kew
         EF8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqGKTJVlTLAaK+wmwJ6VFqqNDgnthLsvYKDk/4/c9bpWXgQnlU2yYlZxIhKNMp15QAyS0GEIT4/bXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxM4STyFaN8IInIyBb+Nd0FYww6/93L9qP39lxAonDXl6u11a
	kv612w0swQUx2Qn0zMHY1HnWWCdlPBtHlZQL9Kz5xtVzbGKzaw8XwvlGxdH3AIgwt5GVDUu3ctT
	r8FSXp+yRq85Z4lj5vvYJD20SP+h0+N5xFskrPHSJCrgj+NMX+jr0YJIUrZcagFI=
X-Gm-Gg: AfdE7ckmzNPvw27B3206aGJSjU8SeSykz5MiPZ10mht5jqYW5IR9laLGevKzpZZjhdc
	dHQqtl8gi3tz66Ohsfgz62O5yf0Dd7Pn2JX7ojVQt+oHcZhaPr8pPaJZV2ZhSEIK3OVDC8p8a6H
	zg2RGZ/TlKwU/Rx+zmGG7+aGUbEx0FcWqmN44DOuD/Wo/TrTkHQF1xn8m7NBu5Dd4kVSQgxI5TS
	4mNCxQxq1rP3WHjtzhuuQSvJEJrpYdrfTWg+mUp2becy3NS77iVxzwus+QxFZ4jJoPnSblLTf/d
	OL/WbgL+VFBSSXViwBqJsnKAStPMm/ezmFkqnHBM4eEuYWi0t2NG6Te20mjid4kOTVOIX9eDpIW
	hKH69RVaHFCX02xZZ
X-Received: by 2002:a17:902:d2cc:b0:2c9:97a7:f548 with SMTP id d9443c01a7336-2cf34a49278mr136309625ad.46.1784509804846;
        Sun, 19 Jul 2026 18:10:04 -0700 (PDT)
X-Received: by 2002:a17:902:d2cc:b0:2c9:97a7:f548 with SMTP id d9443c01a7336-2cf34a49278mr136309295ad.46.1784509804384;
        Sun, 19 Jul 2026 18:10:04 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347166e6sm46987155ad.59.2026.07.19.18.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:10:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:09:59 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Siratul Islam <siratul.islam@linux.dev>,
        Luca Weiss
 <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add QST QMC6308
Message-ID: <20260720020959.3d5e38cf@jic23-huawei>
In-Reply-To: <20260714202842.340293-2-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
	<20260714202842.340293-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5d756d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gEfo2CItAAAA:8 a=s-49AVHpAAAA:8 a=GYSh3LzNAAAA:8 a=XZePDpeZXBMwPD_SGuQA:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=tmfrqOOcxroFHF4kknLN:22 a=lWcdFasyL5yHfcDTNXXo:22
X-Proofpoint-GUID: _LGR032fYXm4UWEI-KwrQjdPhRXMMT6d
X-Proofpoint-ORIG-GUID: _LGR032fYXm4UWEI-KwrQjdPhRXMMT6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwOCBTYWx0ZWRfX3BSl1fwU4Jab
 y2ywG8Hy/1CdNXmnT0F4ybj8AmZBpK/dzJV1ap8di/LAarFZb5XlwwWlG4e+Ov7ZGAg8dFCl3ej
 zXp+2iJauVpAXsl2i+8L+PPkNfr5VxBSHlzn92E4o8eVxfvfj9gyVxOA04STmdapaiQIjT7873p
 97AlmllnmR6nZ5F+Lgv+EnU/Zonzd1Ocl1kKQd4OKT0Hecst/lgqGDHjkRDa7gQ9ti/CxcdYu//
 yRUjTg4aMsajZthqzLcDRtg/ppFy+fs2TYBBvHc6X161Ia7FkLo9smY+EPMXt0OxYlfaOYcnbzc
 8JLJFtKTsoxSGteLAtCsj0dKxEQMEesGA8NfszNv8xUSi8t6TWoL1EDTlVzXXcOhmpMYpQM8WwX
 ltEHP7E4dbZJ2s84bNa99/fooLilJTRs9bkt2FRDKjvyU7kRJyWmC+NzyWwOXx1/y3Aqc3GZODe
 bPZQybBK4J7Y8h8ZERQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAwOCBTYWx0ZWRfXze1qQ/xzpyDi
 ct/84jo9+cNh3PWIz8zfpQFOiorSE0sH4ODRhhb2VlIvmht0VwlVo7IZhzCfdp8vbe9XlYqcje5
 ZadhDG0h9iqtZO1BrKzFAKTyvrqx95M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200008

On Tue, 14 Jul 2026 22:28:41 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> Add device tree bindings for the QST QMC6308, a 3-axis AMR
> magnetometer. It is an I2C device in a 4-pin WLCSP package with a
> single supply and no interrupt pin, at I2C address 0x2c.
Hi Jorijn,

As below.  Don't think we care about the package (and manufacturers
often decided to release in more packages if large customers ask for
them). I'm not sure what AMR means, so please spell that out.

A few really minor things below.

> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

> ---
>  .../iio/magnetometer/qstcorp,qmc6308.yaml     | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
> new file mode 100644
> index 000000000000..ced839d2aac3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/qstcorp,qmc6308.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QST QMC6308 3-Axis Magnetic Sensor
> +
> +maintainers:
> +  - Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> +
> +description: |
> +  QST QMC6308 3-Axis Magnetic Sensor on I2C bus. The sensor comes in a
> +  4-pin WLCSP package with a single supply and no interrupt pin.

Not sure we care about the package, but the rest is a good description.

> +  https://qstcorp.com/upload/pdf/202202/13-52-15%20QMC6308%20Datasheet%20Rev.%20F(1).pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qstcorp,qmc6308

Unless you plan to soon add other devices, can use the more compact.
    compatible:
      const: qstcorp,qmc6308



