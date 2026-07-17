Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0E3264EA
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784332372; cv=none; b=K79MFsHB/YJJ85768KJb4lpxyBqSo7F6rWxUks3JRVXUFvS43k5T6cBM2SC8c+rPJZmVd8c5oZ2w9Dkc3ynIyChU92UNaz/jhGyRrPxVN+3TMaTip2sCpBUsCYY5ZYUfhqYF++dkXq9wrErx+H9kmgHMC4qhNxCIMeCo58NRZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784332372; c=relaxed/simple;
	bh=ZW9ofNaaEumpSf2q3QMhLy/+OoegC2Wk3bdQdpknPRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZycofKUt2k1A41lIglCkq+8u8/CG5ascIkVWO+DpiFeCd6uGFG/hjfXVmvEDzON9fKmEePcVOg/zfmKXbJ4btGxYmSkYjYnnSjYMi21U4DCjEN7nBFi8cW6f8tD1ii++nUMJ6Jotmk71dYva2on5b6Qs85jbZcxTeCwCGPAFyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I1ChI2lo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WEigj5s1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1ChI2lo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WEigj5s1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNERSp3178765
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kk12mBLAFELG+8Y8fFDe+d7lOJBRnJtueIom81VofhA=; b=I1ChI2loDJLY0fD2
	L4l75db5a6Aw0GgHMCLUo05/blGAEK9Jzmwj5LvswSj9Xf5v9cKwqoPpai3ZiRWV
	0QakLPOovVf8b909wWZd4HmzhY1d5N2DYM4w6kG9pbv1qB1A4MoOQK8E5RGxvNTP
	jXk9Yz807kTwWA83vPhUAtbe3YjLBugBJR3LXlURAeTlqhmzZQZhyB6vMX/WJ5mS
	H4tLULxiPC32OhtVos6edOlE2XymJwpCZML2wBqZ4+fGRc8W3MVqG0evA5JVgK/5
	3Ldddm07ti6U2Von2nR3PluKJV99BeBMYcmrVw7V74u3bOlfbDZHV9e2FG3oIMC5
	URgYSA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug1sd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:52:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so11614428a91.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784332368; x=1784937168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kk12mBLAFELG+8Y8fFDe+d7lOJBRnJtueIom81VofhA=;
        b=WEigj5s16qvbNeydOT/WbZ+FMKnu1usDcgGcnEAXm6JShSU5tl5h05+sIvU0h87eHM
         MXtTJt3AL+fixgJUOfiqlJW8JrIEik+r9RqdHMqekgUbP9GayGSQ1wvjGksm9lzi0GEE
         IcXVy9KbtbLjGrvf71a5Kqw1zl6PH10ZI/GMtGycI6Ydk4vPmTmoJzI+7CTssYwSMNc2
         wBAyNkJbAXfeMGoWGoAZbI2k0JBXsN6lsslNUC1isGVreh57qNHiQduZqKOTbJ0OLxZj
         9qtd6ziUYJSHNBQXViuDe+fUhGXulMgRRimlrfCFMT+ctIROhyDAAa8D6vmt9UrysiQB
         QKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784332368; x=1784937168;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kk12mBLAFELG+8Y8fFDe+d7lOJBRnJtueIom81VofhA=;
        b=C/PkU4326BcTNLwRW7YbNSnDYZ8ZSQ3nEfJdKa7ur6c1EAh+m2UYbsojVU+qd7oYoi
         6S401LM+OgHhOITB7ul0WLljt9K3dOq8UzH49UZ36x4TuyL2blFULl7XpIEhSvKmyytY
         5stmAconEakCipZsfL0eiEnnH7j4HtkRZ1Xrbq1I/hP2Z1+hzU33ioG2oPL8a8XxuEVA
         wVMWT2gIiVJboPsbJevZSI+mW6EYP2OVK6LVWwiATlB1cWtIPwJZQGCxIla4MxoBCONz
         GgNg1YZ+n0/brHI9sNXGSB3exzAlfgMGJNVrjcuRS8Xe5eWZ3sdTNrLLwHrwPtKWKfYz
         tpMg==
X-Gm-Message-State: AOJu0Yx4smc/7ICvjA54MTME38c/A5q2iee9rL4pkq7g5ReqkJTOS+Cn
	Pu4XA7/JB+/CGOJ5H9AYHTjvnuAZG7p9KpGoHx9MaLpHE1vdIBMNJr95hXp0rp5GQdWg82FINd8
	zsRna0O7qKo2ijoqW1Wjtgv9rKUZoteuu30X4Gz/6JLmpzpBEbA91ccYlG9pIb9c=
X-Gm-Gg: AfdE7cm/IKDVk0zYqDJu1jvD/K0L5ddmXl34N5gjGir+b7kfGqD5O1Hhl9/O3HxV3Zp
	kHiH3WOtCQcpms1sKm8OK1Eo35hKhLiOJLenCInM+qzBcKSh/hE1MbTMb7/KMKEZkDV3jxvB9D9
	Ceput1gkQhT+8B+FNVbH5A0OamRxbfSPMbngkMcAoAfc9OCksC/IcDG6rVKlOF1MCiGWE4TWWoP
	das9IM4Ho6CO8PB/l9A+0hUN2SjH7kJpaxb3nVvyWg/gZMKi1TkbkWbOkgVpWOKe4QJITOzWyHC
	BLdP4w+YKrpB5pBAj9M0FmRs9QNuSGDh7IvSD8Wm5tWGXC0jASXVWRmfiQbCcyVgJL64gbQuGMy
	iJex2WEXyEB5uuzlu
X-Received: by 2002:a17:902:d2d2:b0:2cc:fd6c:c5c9 with SMTP id d9443c01a7336-2cf348961ecmr54352755ad.4.1784332368575;
        Fri, 17 Jul 2026 16:52:48 -0700 (PDT)
X-Received: by 2002:a17:902:d2d2:b0:2cc:fd6c:c5c9 with SMTP id d9443c01a7336-2cf348961ecmr54352565ad.4.1784332368141;
        Fri, 17 Jul 2026 16:52:48 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee37sm18828825ad.14.2026.07.17.16.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:52:47 -0700 (PDT)
Date: Sat, 18 Jul 2026 00:52:42 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <nuno.sa@analog.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: add maxim,max40080
Message-ID: <20260718005229.5793795a@jic23-huawei>
In-Reply-To: <20260717123852.1140893-2-stefan.popa@analog.com>
References: <20260717123852.1140893-1-stefan.popa@analog.com>
	<20260717123852.1140893-2-stefan.popa@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0NSBTYWx0ZWRfX+ZLGD+mof0Rl
 Gn9gbpCoHRmnZt3bV6cHEYZajTNzqO/4nVdC7CgGqSO6TNmGJk70nbKlEHXeK5Eveu5Uu0S+fZ7
 BeHY34A1CAF22Y33a4ogBhwR4ygaJqQkav5UAdMyL7iF5kCeU07eb6eujpMghOTz9egjF4U4wWL
 3qBtZV/j0nNOfRyGf61TPz0xIfeiDI7YhrKXaj72ljm8Ge831wycDRwFlVhpDyhxwRrNEQL9YP1
 QbqKCCZeroB42dGar1rOXVaHUJsI7KXvWqp1tt4m8OpLgMfr4iXNhxGuVD6VhanFmlQTANnG9Vi
 oNCq9pg8omYrNeJFii1O5pzw9SEPtovA8JsKLgvDqah8prUVgsbaHCagjKZvvqUhKLsaBYuNkrh
 I3Zgj3vDN7PbsYRHAser9yBrLfWnetGzuYq+mWfh82wCNDFlfxszHJm6M5uGdCcJaXRETr256IP
 xw/zhcqsmY6pc1WHxRw==
X-Proofpoint-GUID: q3WnvzUbcGPL1c4BlocmMjqs0wZIghtq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0NSBTYWx0ZWRfX9Ou2GUyi6LxC
 jar9CxFk7ehtVPpSfam6bt/D0GMQ132EK8m8dHFxzidz/m+KzXniaAlsy5xeYdnK4KkDnL6OoPG
 H1rAL41daZm0tTo2ofpBVIIX7Off960=
X-Proofpoint-ORIG-GUID: q3WnvzUbcGPL1c4BlocmMjqs0wZIghtq
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5ac051 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gAnH3GRIAAAA:8 a=Eq6eYOmURhmhu4GIWB0A:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170245

On Fri, 17 Jul 2026 15:38:48 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Add device tree bindings for the Maxim MAX40080 bidirectional
> current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Hi Stefan,


> ---
>  .../bindings/iio/adc/maxim,max40080.yaml      | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> new file mode 100644
> index 0000000000000..3b367071b5d3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml

...

> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value of the current-sense shunt resistor connected between the IN+ and
> +      IN- inputs. Used to scale the reported current.

How useful is the device if we don't know what value this takes?  For a current
sense amplifier I'd kind of expect the shunt resistance to be required.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@20 {
> +            compatible = "maxim,max40080";
> +            reg = <0x20>;
> +            vdd-supply = <&vdd_3v3>;
> +            #io-channel-cells = <1>;
> +            shunt-resistor-micro-ohms = <100000>;
> +        };
> +    };

