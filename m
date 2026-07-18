Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7972618
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784413200; cv=none; b=XRtacGb35Mv7s18+W/6Cofq4+NvQY6UBV6jQxS5WHoh4/jeAnHgpM/so4WgRDaqRSyhKMXsCGth5CNLFl+nsnptpqmYQzM4uJm5s+imJoZ/V3Ekf503W3kyo0GQ31pRCKYf4mX/YgzStzQAMP4rudVvmQ57j9SOqhyIOVv98brw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784413200; c=relaxed/simple;
	bh=uBQ8XlnqOMtNKgZqtoqvdpfI4CIFQ2BHelfCbW+fGw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxFCMxJyEk7GKO3gddwkpOgYuefggCqvBO+BMM+sJU69Ri0aerAvWVtWwcLf9pCmjGn+5R4WhW2RDG9eBIpQWi3ZnUDc8NXaI4cAhsR+NT6gDqR5r04pE9dH7mWA04ZX9olwsCH1hsD4LvymdhwyFHj13aacQoij4ZVcOL/xr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IHKXe/yR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DbgUTvSX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IHKXe/yR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbgUTvSX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJphNb1603083
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OSIoHX29BzBjnIxq4ol7lBXbSbHoZ60LqztgJWDtdzA=; b=IHKXe/yRaHMq1eKf
	iUOY+J0bLWQGmFRD4VkHY1ft2Y2SMgFE7ONLhZOq0WJMCvWPcCHEuFXxqkjARsTs
	8sqP9K52dEGalJvRHOo/+q8KBcaDZezZMzY6P2A+gd6jMQEV4g2L4w5apQ/NpLrt
	1LUWoSYJlrTZXgUHebAyo85ueTRmN3G+zSOYN9Ak8zl+XJKOQB2BbTJy1e9eOMpW
	oqhd3BUN2Y7JFZ6N48T50lz29sJj1VJtmtpeVgOwJSOo0gXRD7cyg5tUKDUAXGRo
	B7VDSurJIbiAP9SDwBT6LZQj6zuruXAmO7KfPd5qUgjQcPcSPWLSTFvVXk+L+lDN
	Ulydog==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc1pfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:19:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so5005181a12.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784413196; x=1785017996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OSIoHX29BzBjnIxq4ol7lBXbSbHoZ60LqztgJWDtdzA=;
        b=DbgUTvSXMGrUqBw4szZ64Gj33aUwlMsxfMdbcQHKHwdgsv/ugyew0nWOv0geRN9zG0
         kNth8PTc4udeH70DE7M2aNCV4URAsRZa7KIx40vEe/4y4iwuwaGy941TiEVbU3g01wjL
         vpGCssscxWYK3n7toF0NRd68+hPOJUi/ev+soBBJd51NJpS6dv31NU2UuCszL2vhn7e1
         kWBiihM0Sy5YFtwo/z5pC+dYGa46WxnSGfLz9f9yxhuJv4r6njum++CYinLfFHau5qbp
         KH3hzrlWYDidOO7RHnmee3Ux25CcbjhBGB43E1cTAYXV/8ZOM/NN1SLbMYKZmv6FQ5Lg
         g7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784413196; x=1785017996;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OSIoHX29BzBjnIxq4ol7lBXbSbHoZ60LqztgJWDtdzA=;
        b=kqlO/3jXLz6UcnLbb6XyY02uEyDrf539htX8A60SX92iQBlRA8KrazEohdg5jf4RBh
         DKdswWd3FJrNkzv2R0g1FxPklLDhZCkbe1FivPBWK3jc8/2mdhQP4hAZfDAOXGLyg5BM
         xsbER5mZRrnMgfa25dXP/+rYGkMYOHaZyAvvS+YOpMy3JKi9bmHOfJt+9DTzfkZYSLKJ
         pH8JNBNSq7BKBqdEZPoG4rCK2iTTtOZ8denjXGxZR9uhL8D9kJbP598W+Mi/OknJw1gV
         MnXjgY6uSzmKi/6kCXQkPGlr7FRSXgHHZrYy313RyLBiJpwV6LAZHS0ZfwZ8531QDIzO
         wfew==
X-Gm-Message-State: AOJu0YzP7cumlj8HmyxxH49sqYU1GLHDDmKVBPwDODwCE8ss6lJ05nvq
	2AT3ygihiFW8Swsu5GhFtbUUGzg3ZGMwAhnlRvyAsMJ6ECIjr/w14ALwxZdjlvY19sv/KzQ0cna
	cpwbTGlhfgpsgfqSUlEhUnTtEkXUAuzODRqZkAymI/NhgP1Nxa5d4q09D7T0RjrA=
X-Gm-Gg: AfdE7clxlGzmSgsqo2ATMGcv+UIRcFQQtTR2/CvUA+8M4BtQ6/7uhg92Is43o5Sg0YB
	Z57ImfRpM/PogGPjdzdUOQRHLK39KJ5rn/S7oF1oTpsFU/sD8xinxTx9HqJpUu+qIvvBZRhBbd2
	w4WBDuiqe34cIU4x7tyS/3YCc8GGFRjLiWqbKhFV1i7m3mZXuUJojFBSPIYAy8cq4CTIjw8igNq
	k3al8Isrv80CYTaZC/aD5NmTs/0kMEqUqusTx0Nf8HBUYPdYQSGZFr4+CyKwdmS7xISjvcPYOwr
	rdRcZjRQfvft6kQhIZ6Z6ZXzbg81DdKvkmgFRq5QnOEa8VL1ZrdzkyAdzjpi1gLjuk6Lj6utCFd
	D42JDpJLjC4H4bU5w
X-Received: by 2002:a17:90b:58ee:b0:37f:9ce0:af32 with SMTP id 98e67ed59e1d1-38e4b595a3dmr8487154a91.29.1784413196367;
        Sat, 18 Jul 2026 15:19:56 -0700 (PDT)
X-Received: by 2002:a17:90b:58ee:b0:37f:9ce0:af32 with SMTP id 98e67ed59e1d1-38e4b595a3dmr8487134a91.29.1784413195919;
        Sat, 18 Jul 2026 15:19:55 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39de785dsm5062346a91.4.2026.07.18.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 15:19:54 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:19:49 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andriy.shevchenko@intel.com,
        u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com,
        nuno.sa@analog.com, Michael.Hennerich@analog.com,
        dlechner@baylibre.com, linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] dt-bindings: iio: health: add adi,max86150
Message-ID: <20260718231938.54f41543@jic23-huawei>
In-Reply-To: <20260717201138.1078019-2-shofiqtest@gmail.com>
References: <20260717201138.1078019-1-shofiqtest@gmail.com>
	<20260717201138.1078019-2-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIzNCBTYWx0ZWRfX+nYgtOTEQy08
 hGhvgl7Yyz1H0PCs6oQ5JgkIXJop+nwXezH6jtuLYW6KOaiCFCRVP0VvACGQER8lP2hB6grKcml
 bwEviOk9sDerfQR5BWHoY6HjCpZL45s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIzNCBTYWx0ZWRfX1pDsLFU/6JRE
 5yJoRw2uHkPJLBAv4wOBrJjxloSXQYZMZu93qMCvcC8Fhk5lSr/LiioiIKy5IUfixLzSkO29tIT
 psNQJ+R4hMokyHC7/hojOzPnntVIuOAI61MZvlP++rToQ+BSLwEhlPFWgPkKn6z0/Wi2DwDE1Gr
 seF63gZZaexdI5E8Lqfb/+Y9INhBBp7ONo8tg5fJEnXAXgXqX7IgrExfsyywtZvS5ofGYc3goob
 lABTsoJ4sL5lwczpuDs/DvAKLqaSj/hiPna6nbWM+aKA6GgJfuHyMBEm9Gi4QltLpH8tJtn9ZCC
 14bzqGyOnn1G4jtDILtSoaPlVkiDpx8rmPLJAY4CTX5P85ITEdeRziVIp6NofBr3Sa7sATqRaXJ
 Y0+DyYTtsdMAbh354slsEA8tFACX4ydA9rXb/T3M8no5JaaXqeYiAj5MeTtoGvh0P6SZEmroGop
 Z1Xm/VM1hTx75tgRMAw==
X-Proofpoint-ORIG-GUID: aaifngOcFRHA1L5LWqToJOC8dVT4Ignq
X-Proofpoint-GUID: aaifngOcFRHA1L5LWqToJOC8dVT4Ignq
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5bfc0d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=KgpIswxficZqQvW3BnAA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180234

On Fri, 17 Jul 2026 23:11:36 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Add the Device Tree binding schema for the Analog Devices MAX86150
> integrated biosensor, which combines two photoplethysmography (PPG)
> channels (Red LED and IR LED) and one electrocardiogram (ECG) channel
> in a single I2C device. Samples are buffered in a 32-entry hardware
> FIFO with a configurable almost-full interrupt.
> 
> The device requires four independent supply rails per the datasheet
> power tree: digital core (vdd), analog core (avdd), ECG reference
> (vref), and LED anode (leds).
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
A few small things inline from a fresh look.

Thanks,

Jonathan

> ---
>  .../bindings/iio/health/adi,max86150.yaml     | 78 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> new file mode 100644
> index 0000000000000..da2ff9b0ada2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/health/adi,max86150.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX86150 ECG and PPG Biosensor
> +
> +maintainers:
> +  - Md Shofiqul Islam <shofiqtest@gmail.com>
> +
> +description: |
> +  The MAX86150 is an integrated biosensor SoC that combines:
> +    - Two PPG (photoplethysmography) channels: Red LED and IR LED,
> +      for heart rate and blood-oxygen saturation (SpO2) measurement.
> +    - One ECG (electrocardiogram) channel for biopotential recording.
> +
> +  The device communicates over I2C at up to 400 kHz and raises an
> +  active-low interrupt when the 32-entry hardware FIFO reaches its
> +  configurable almost-full threshold.

For this the 32-entry fifo bit is good but maybe move ti to the interrupt
description. The rest of this paragraph is a repeat of detail below where
it is more useful. Hence I would drop it.

> +
> +  Datasheet:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
> +
> +properties:
> +  compatible:
> +    const: adi,max86150
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |

Formatting not needed so drop the |

> +      Active-low interrupt line.  Asserted when the FIFO almost-full
> +      threshold is reached or when a new PPG sample is ready.
