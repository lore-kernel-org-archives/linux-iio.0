Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9498248B
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784420118; cv=none; b=Qy7V4d3VnHqLOSFua9gYrHZo+RfObdvpTL16Vk0+YWb1Mijt0Mh79XzVQjZf2ZUa3NBgtGsk4Ii1eSRUNK1htp5sQhRYzXU8Ls8J0ikP0Mdm8hKXPkmJSqFeTBxgKA7tBySdCtcIicbokZLM9WROM8sKlvKUGWvW/4mT/4eTnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784420118; c=relaxed/simple;
	bh=u1fp1alkBNst/d1DzrEnNRW68x049gphSMGWlVawCIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyP1qlZgsnfNkqVuI9PD7Q60l4c8TEY95L6sblvxBsmgqHPCEpl94wcuPO8NoryImRlz7M08HpAUVf63VY5uU/T7Z28jFAxGSxg9AUlY7jIlVLUjevMhydMhaV4hWvAo2vkMtcMUNfgEX6/HMn6hh1CVWos0ziQhAa+QXParJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RUCLgyIR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M3egmu6u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RUCLgyIR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M3egmu6u"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN520M2055572
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jVtBejOk/fS9XQZvzarHu+foBgQblzV41Qics6xtFZ4=; b=RUCLgyIRYVts9/2s
	6+y7DuyqiVzp5l33JMD9gJqSwGPG7bHiCuiHZjgRPIPWzkOTf6ajAA4RJvvihwxl
	3V91JAmPf+SRgPdoZJYk43iIHaVuBgzrB1TTK8MDCv6igWSxhIurQjK6tLiibFBY
	zKEGYPVVN5wtSIBl89y4jf/vXkSkqzsJcQyomvkI5rvADW+/eJ2UosjX5C5qjvsW
	WmZR/+A9euUPR/oCJRPG54xCRZ/j/yx0zrQSlEq2UuthZsdBZbU1xeMEuKlSbFGG
	7+5LJCsI2V5nJwELHJcMpbskCC1yZQx3+SrGHyLrwtMzqiFLs943HQCwu0bR06M0
	QdJgTw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af1shd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:15:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848544a8496so6656555b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784420114; x=1785024914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jVtBejOk/fS9XQZvzarHu+foBgQblzV41Qics6xtFZ4=;
        b=M3egmu6uR/v4t7VVo0x6s3uFM2hUuzGlDyu24kqAAJgo0eSGFxXrDSChjIq46P8O04
         hBZIxq4zWc299PtJvfUVvzBIrYUckCuOZrEVAPCPXYc7h7iq5+GevmpcG6toUMPEzyyr
         1Mvp/46Q+sVhaT/+a/FOeMgnisjFpn+e6iLgAiEfLpbBpS/G6+4eQDBuokvy3FemSavF
         2DoB55JmwCkcJfQ5ncUQGW+/qIrgbd9UuncPy6REZVOOH9alqXCFRMhIiaNEdiG1aC1A
         7W9ADVeHKTZNY5y4CyvW/GC7ys50lYkw6IUv0OJrGEvjl1zxSrAZi+TLbxeF2g2v7eJu
         trIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784420114; x=1785024914;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVtBejOk/fS9XQZvzarHu+foBgQblzV41Qics6xtFZ4=;
        b=AloDwwVUPFbQIWXoLvWI/jWHcZDa3XXIPJqugCViSdKVatuvzO357dhCd1W8rQtO4Z
         A9Ieq+kC2+KPQD/Lp6los5jdZD7zffEI6RIU+HfxXdTfHgSNQXbIQ9klgEIqQEl0k45p
         qcr9fs3FqNeFNEMcysPollwqITGuk0OIE3xLFFt7IYvAGaPUyQ4SdFzWBHC9ZEPk7/YO
         HaAbbESPYwgRmenbLv/dSRZsUu7QrhQgxCW1Xx5sgQz6kO928RppAbSASrOibus1Y9yQ
         5mavCmzGBiY+MR+hNKDdv063iPq+TJYm0d7tdsvE0R8A0XVjN3ej+5YEVJDstb8bqKFM
         ro5g==
X-Forwarded-Encrypted: i=1; AHgh+RpJQGxhgK5GvLBxrgbciaDmYq6ddGEnjSu2ejEM9aUv/QwihIPt+G96fwHOpvEWu4Lpl2BWI+plUsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIHIUn1bTTQCbJZ5IROI4CZsJGsKJ6HH0xfjsgNSCNpQGTxFp
	mX5RiW6cZljIrZKPAu1ZIzG8+ZFKp4QHYc71HYHgJknqEBiodVZcQBN9vxsZiXuBLfDa2KzHh8i
	uxAQtr0PdQwE1aTNZNcGLa6q42YLXPRGgurYGL1051xMYtL6uMkAyAKz1BJuizigWY6a8xQM=
X-Gm-Gg: AfdE7claj8hhs5+/qpPWsoklesKyCMrrCeCvJtlDsK480/z+Sek43qwBC9C8Mkxd49N
	fAQVID4c8OUKvG16w9VLSTIzkwdS4JZwIKtaYhjV7ZrQVgCm52CQEYg4qRotzfPB30MJMHmHkpw
	C7JfHMKZ6ePSgKmNQa/q0nQ1888lOEKjRY4ucQrJv3vS7mX0u3vgq8wyiXxxrv6wVU3lRJ5+MPF
	M5KYDFhWKkcncA65FbsDZEw2T5LhrrW4iq4yQY66kMIzh4HkVt7o4tYyIJM48O8l5GuRB0SKcDn
	40HX29zR0i864YmrZQx+H/A7bRvdR6iz+5L2Mu30ZlpJg14ZVugdq1n0Oo7WHWD08n7YpJo+2R4
	5KEldU/0taInH7W7e
X-Received: by 2002:a05:6a00:9283:b0:848:2f74:1d5f with SMTP id d2e1a72fcca58-84c29568665mr7946956b3a.69.1784420114217;
        Sat, 18 Jul 2026 17:15:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:9283:b0:848:2f74:1d5f with SMTP id d2e1a72fcca58-84c29568665mr7946915b3a.69.1784420113746;
        Sat, 18 Jul 2026 17:15:13 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad89d0csm3466351b3a.6.2026.07.18.17.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 17:15:13 -0700 (PDT)
Date: Sun, 19 Jul 2026 01:15:07 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org,
        Maxwell Doose <m32285159@gmail.com>,
        Joshua Crofts
 <joshua.crofts1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v8 0/8] New features for the AD5686 IIO driver
Message-ID: <20260719011454.10239afd@jic23-huawei>
In-Reply-To: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAwMCBTYWx0ZWRfXzweF97E5a34Z
 RSJvW0E5sE79Un1OtJv02wTEYaiKbEUOyObDcnK5sJfET7iuHiUD7wJI1neAs2q+9t2rabMMu7x
 kXe4PLEP6CcNh75mwHdtGz8i7m6C1Ok=
X-Proofpoint-GUID: yLweYn9s2dZbXC8NXjw1YdB5EXlZDqvM
X-Proofpoint-ORIG-GUID: yLweYn9s2dZbXC8NXjw1YdB5EXlZDqvM
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5c1713 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=evLihkQWVGAqolPEgxMA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAwMCBTYWx0ZWRfX0tN1OiIpEy3D
 k12ewwdvcpYGtgXgZUoMX7pkqGPTVVlXiFGsO6f1f1l52tBJZRB4emIktRBVtJ/UiPXHwyHPj1H
 9zctaq5uFKxH3P/Rgu1B8ixlaifQ+raEPZW1WRbypBwOxCtVujxJGThHNSbWpTARHeZ2zY4TGVZ
 RgjpRPm3LFItvlfoyVjAsjBHwCVnZdi0BZRhI+N/vna7mKj1gwZzfLk6o90xmm3w2iMQbZ7NMyT
 56fHa+sr00Cmqx7CSWPRZzrIq5N49xbUIEafdAKFoj4vl8ns1R3Ymjq7NPOXbE5JVhANqs66wjz
 fypQjcixYYLB6rjYIWhAAnq1ebNtJ1w4QokjOqSx8Y4wF5Pgqe1H7K0BLGbwQ559cVMLR0sTBRv
 U150bYJdGumHThNlF+EtkpSbiRwIt6sK0+mWp4wudTIaPBqAH1bDIFKr/mmHHo2barHHd8kNNES
 GQ7+VctJ99RlKOornKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190000

On Thu, 16 Jul 2026 13:14:16 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This is the second series of three on updating the AD5686 driver.
> 
> Initially, a big patch series was sent:
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> Then, the first patch series added fixes and cleanups:
> https://lore.kernel.org/linux-iio/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/
> 
> This one is introducing new features:
> - Consume optional reset and correct power supplies;
> - LDAC GPIO handling (active-low, held low when unused);
> - SPI bus sync() implementation for batching multiple transfers;
> - Triggered buffer support, leveraging LDAC and sync() to flush
>   all channel writes atomically;
> - Gain control support through the scale property.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied 2-8 but with tweaks as called out.  Pushed out as testing, please
check I didn't mess it up.

For 1, hopefully I'll get some time this week to put out a set adding
the defensive check in the i2c layer.  That API is just too weird
today for my liking.

Jonathan

> ---
> Changes in v8:
> - Add nul-check for chip_info match data.
> - Update comments/commit text and other minor changes.
> - Link to v7: https://lore.kernel.org/r/20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com
> 
> Changes in v7:
> - Fix return value check of i2c_transfer().
> - Amend refactoring of command/data macros.
> - Link to v6: https://lore.kernel.org/r/20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com
> 
> Changes in v6:
> - Refactor command/data macros in favor of FIELD_PREP()
> - Link to v5: https://lore.kernel.org/r/20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com
> 
> Changes in v5:
> - Create auxiliary handler for the triggered buffer.
> - Do not allow modification of double_scale in case gain_gpio is not set.
> - Link to v4: https://lore.kernel.org/r/20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com
> 
> Changes in v4:
> - Replace anyof+const for enum in dt-bindings. 
> - Address some sashiko's comments.
> - Use guard(mutex)() in trigger handler and other misc changes.
> - Link to v3: https://lore.kernel.org/r/20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com
> 
> Changes in v3:
> - Add range-double property.
> - Acquire reset control after power-up delay.
> - Include cleanup.h and use guard(mutex)() in read_raw().
> - Link to v2: https://lore.kernel.org/r/20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com
> 
> Changes in v2:
> - Get reset control deasserted.
> - Update entire spi_transfer struct rather than individual fields.
> - Replace udelay() for fsleep() in probe().
> - Minor changes addressing further feedback.
> - Link to v1: https://lore.kernel.org/r/20260602-ad5686-new-features-v1-0-691e01883d27@analog.com
> 
> ---
> Rodrigo Alencar (8):
>       iio: dac: ad5696: properly check i2c_transfer() return value
>       iio: dac: ad5686: missing NULL check on match data
>       iio: dac: ad5686: refactor command/data macros
>       iio: dac: ad5686: introduce sync operation
>       iio: dac: ad5686: implement new sync() op for the spi bus
>       iio: dac: ad5686: read_raw/write_raw: use guard(mutex)()
>       iio: dac: ad5686: add triggered buffer support
>       iio: dac: ad5686: add gain control support
> 
>  drivers/iio/dac/Kconfig      |   2 +
>  drivers/iio/dac/ad5686-spi.c | 142 +++++++++++++++++++++-------
>  drivers/iio/dac/ad5686.c     | 217 +++++++++++++++++++++++++++++++++++++++----
>  drivers/iio/dac/ad5686.h     |  52 ++++++++---
>  drivers/iio/dac/ad5696-i2c.c |  18 ++--
>  5 files changed, 355 insertions(+), 76 deletions(-)
> ---
> base-commit: 4c0ecdbdc0d87570f74e656e21d56bae1ab6a8f1
> change-id: 20260602-ad5686-new-features-e116c04bddb9
> 
> Best regards,

