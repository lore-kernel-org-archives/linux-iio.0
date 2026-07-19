Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9632FBA3D
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784419768; cv=none; b=rZMlcsRzQqDT6VJSk7cEZcZwBa/GYzukSsolqQuQlmTRTcKBvqjCiuZftR0eb34kvsw3VS/GuF7o/MqAc464aCnlHTCUtOJEFU2GnjwdR+A09BrPb5x6Mr4FrEniVthgiYQsoApm6bERj+BhHsi2HXyfuoiVYAo5kr7ELuT01Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784419768; c=relaxed/simple;
	bh=Fp1M2fJsMXzbVJa1xj290WI9PSfRcyhTd/zB16zI1wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GySU7t6zgswE3IzWfeesqZTwo/4/cv4UvCAwzF7ytlEFnoTdeX4/oT36eFTmyvgE/ZOJNQXINNYiKVIlHZfN9HF3hiabxVb5QMfuw0mMtltVjhjTjNwfqreJiGiQF3fr6U2jyFvNmWzA3lRPrasTy29wS7RqNlyqCx+lxKt1pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5Q3Eaeu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h6aV5FFy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5Q3Eaeu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h6aV5FFy"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN2Ivs2157715
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Ip7BNs+p7U2rvcrd2MAfZwgo2ckBeageifb/ZWfaLE=; b=T5Q3EaeuizOSIlUT
	nGEb/nxINB+pP40e/s9kvBijWokWKYHTUHUnwgxsA3Zp34NxMPMZS8oln2otGUt3
	+9+3MY5WmTXeDPT+vfxE8d41PDpU9DpJjdnJ8VChdPt8ACyYuDqG3XeJ+4sGUCoH
	c44NnP94lbWp53adUWQLdYAMyphx6A0ZnpLRwrJ7HYzfSiU5dPqnVWSBCVApbycK
	H/y5Q5j6Dr/rBC1GiAfypO+rT/bM/qL0YfOn7K4fDJ4jQvncithkUqU5h5Z+444O
	yVBzzc8Kjw7B1tZiyIQBZqBqVBXN1Af6Mc2qeAR1p2j1fax6D9iMxzez5KQSQRXB
	UIK6dg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d91s7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:09:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8485d853b08so7889380b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 17:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784419764; x=1785024564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Ip7BNs+p7U2rvcrd2MAfZwgo2ckBeageifb/ZWfaLE=;
        b=h6aV5FFy0IJqf88sbDeP5gVCyWbAHPzT+N7k0UUQ5vEC/ixuzVzTeEC5Ryk4c9IMv9
         xl20HGRCP+K8VqnW+p7lO+SD+Nv+mlzdj2DorBMauXWp1ejgrddZ+xfG2I6grKTDHl+b
         bN6Gau/SPX1rDdh1TaOJw/tfzemgPaAaZ7Q41aDOGncGqnnYMFCf0ngguwqAA0+18Rto
         09IBkfG4pggWYozpgw1IkGR70J7/x1YPsBE+4MMG7A2Rkbe0poW1lZJSOz7g+relmH27
         24lwqdk0G631xtb6CpEfLnb04dY0CUsQIu2VQiShqmBdWRVr+MkSNazNCarqfMGefaTq
         0hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784419764; x=1785024564;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Ip7BNs+p7U2rvcrd2MAfZwgo2ckBeageifb/ZWfaLE=;
        b=FF65cap3WT1pW0omvVgYR0KdgHrJ0EEippisOC7/N7uy3oeVOK9LnFA1oTGNxC1HOR
         XhQa39dyh4o//8S1JzMGaK5aI6p9asOTOUWkNf10nK/zdpi6OIQnFCcPrhptnJvOlIO2
         4xWuFqlwehpRWVHcEEXjJ4GazdMcOpMsVHc4jHJpeBaWb/0F0HUB9aKh3JcKnDAssM23
         iX4DhzMK34mYsCso+GgbvEWsah1LLldMTT5S8JzD5+vbSMtHgwGAUr48GrL8CjrdB2XJ
         FZijoQFdOyY97SK/uBHu29HedONr4gZM5LKi5KtDRmA57Gr8VVvZKiW6GBtpnXBicDhK
         q/Lg==
X-Forwarded-Encrypted: i=1; AHgh+RolumLiTef4vtv9cuWtcugtyqLEwRcAKQfjFOTBYZuOawwxRcHsEtWZCZLUHmyrMbBsBaSWmFveZZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVI7+qVcKCSmZQgRZUqO7nkiSyHxEqxNvrP6L0N44HXSfbPLVQ
	f/JKLZzZ+mvSlTDFIQRovphxE0LLHZ2dC8IBGDhtvZe++rXpYJxcqJbSHfiLZD1L5NBLEmq9h/h
	BQV+jbRxWz5TME79nTgPXD7uLbj8Pd84K0AjNipzI9SDOtHiIoK9Y9FqDvS6ytI0=
X-Gm-Gg: AfdE7cltf6Rl8u3hQ5hovfXFsmSJ6QNVreX0AgQMqob+ntThYRjejEYU2i/d8hJVh8U
	083ov3lACGa4KtvvGr4kafcO7vwjReqs+ydg2hJLmi65KInZDheIeisiE6aD783YgEWP49QSLWf
	ll/h3HB4vH1RlxUkVilk299QyWgFniABH/aHxYPJ0sxyEWaFUvkvmNFFCZQ8cJmnzSL95nLLcjE
	0dpGfdRafij4atyvCF+9ldSRq6yX83RTbGk6ZvSRtXhawhu3+tKNdon8CMCiM8DHF0OHKxHYGeY
	niT34l0u9WyD3qQSSFiGvyv6iEK2Jgnnl8rgbPC2gl0G/vZg1mL1DNOJ5T4PPbZ86Z3q8CY5YYK
	BVx0rb5gAozP4xYbp
X-Received: by 2002:a05:6a00:400f:b0:848:6ba2:4139 with SMTP id d2e1a72fcca58-84c29487c9amr8216364b3a.36.1784419763992;
        Sat, 18 Jul 2026 17:09:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:400f:b0:848:6ba2:4139 with SMTP id d2e1a72fcca58-84c29487c9amr8216349b3a.36.1784419763537;
        Sat, 18 Jul 2026 17:09:23 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc3466sm3491452b3a.15.2026.07.18.17.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 17:09:22 -0700 (PDT)
Date: Sun, 19 Jul 2026 01:09:16 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
        Michael Auchter
 <michael.auchter@ni.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match
 data
Message-ID: <20260719010916.54de1870@jic23-huawei>
In-Reply-To: <20260719005533.41520a27@jic23-huawei>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
	<20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
	<alkmAcDvSXr_COc_@ashevche-desk.local>
	<ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
	<alnknz55FbyyqqlL@ashevche-desk.local>
	<gy2dn5emz7sreavy6kioz27f3sx2ip6zhkgzs2uz4qzecpkrbe@zgsortof6aqn>
	<aloD5HdbntKu--xC@ashevche-desk.local>
	<20260719005533.41520a27@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5c15b4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=HvgeF_Dkktg8HcRXRxcA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: kbBxBzUK8sP6o8XQFxX8pax754o2xEEk
X-Proofpoint-ORIG-GUID: kbBxBzUK8sP6o8XQFxX8pax754o2xEEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDI1MyBTYWx0ZWRfX/5Aci1zlHzVp
 CATu5KckaHLQs12q3e6G+LoNDosYvT9nb5QyajiGwBUvqDvR9ipW8v5SkZhe5aVAi3OCbSQNjz7
 ymP0wGpZtNvsePT1551F7cX0g8ieg1HFQQvZNxbfNWmrHuYjSQkoJ4YV6WRwLCjmBidqwSds0HE
 1P4sCrwryit+ywpfZsSJaZYbBwBQPHbVRrEM+khdR9857UsJBjQZRj8iY58AskVvQ5CFNlnVSU+
 IZBM/nfdPX4ixbfibD+y1GB4Q7HKkrh4igLqwv4yqCXb9eUx+WUCqRHLFR/Zbwy54qS2YuQjjM8
 qTpNB6GflT/qsL5z6NvMjtjIQytzMqr5gJf+PW3Vi1zF+lW4XO5g9jr7z2eIgg74CgJn3RCKIQM
 Wy8+BWMNJSR1FYmYjZ7WSLDpY4LmMNEtD6Nk7jDpykuvz95YDWinZC4IzGlVn1gzjovOv0DrWpV
 H3WtiAGBMIiZSht7FtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDI1MyBTYWx0ZWRfX2sxq5CEbUJ09
 WSaF4VUbgmZDBBpDujqlElfAlHfIfwzcyw61n+rOoatG5HBCzq1z6JvSM+APZtxBPS4r+QunLnn
 khI5ooX+3d4Q+MsnGrTYRsSEAtykCIs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180253

On Sun, 19 Jul 2026 00:55:44 +0100
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Fri, 17 Jul 2026 13:28:52 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Fri, Jul 17, 2026 at 10:31:26AM +0100, Rodrigo Alencar wrote:  
> > > On 17/07/26 11:15, Andy Shevchenko wrote:    
> > > > On Fri, Jul 17, 2026 at 07:51:35AM +0100, Rodrigo Alencar wrote:    
> > > > > On 16/07/26 21:42, Andy Shevchenko wrote:    
> > > > > > On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:    
> > 
> > ...
> >   
> > > > > > >  	struct iio_dev *indio_dev;
> > > > > > >  	int ret, i;    
> > > > > > 
> > > > > > Move an assignment here as well.
> > > > > > 
> > > > > > 	chip_info = ...    
> > > > > 
> > > > > assignment? this is an input param validation    
> > > > 
> > > > Can we make sure we always get a correct one to begin with?
> > > > With that an assignment and check can be coupled together.
> > > > Also consider use -ENODATA as it's most likely comes from
> > > > driver_data.    
> > > 
> > > I suppose you are suggesting to move the check to the bus code with:
> > > 
> > > 	info = i2c_get_match_data(i2c);
> > > 	if (!info)
> > > 		return -ENODATA;
> > > 
> > > rather than here in the core/common code.    
> > 
> > Yes! This avoids layering violation and makes the API contract cleaner.  
> 
> I applied the following rather than going for a v9 for just this:
> Shout if I messed it up.
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 8abfaf8f0c46..591596a68004 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -98,8 +98,13 @@ static const struct ad5686_bus_ops ad5686_spi_ops = {
>  
>  static int ad5686_spi_probe(struct spi_device *spi)
>  {
> -       return ad5686_probe(&spi->dev, spi_get_device_match_data(spi),
> -                           spi->modalias, &ad5686_spi_ops);
> +       const struct ad5686_chip_info *chip_info;
Renamed these to info to match the later patch that has this code anyway.

> +
> +       chip_info = spi_get_device_match_data(spi);
> +       if (!chip_info)
> +               return -ENODEV;
> +
> +       return ad5686_probe(&spi->dev, chip_info, spi->modalias, &ad5686_spi_ops);
>  }
>  
>  static const struct spi_device_id ad5686_spi_id[] = {
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index d49946adbde3..a6c85d0c33c9 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -68,8 +68,13 @@ static const struct ad5686_bus_ops ad5686_i2c_ops = {
>  
>  static int ad5686_i2c_probe(struct i2c_client *i2c)
>  {
> -       return ad5686_probe(&i2c->dev, i2c_get_match_data(i2c),
> -                           i2c->name, &ad5686_i2c_ops);
> +       const struct ad5686_chip_info *chip_info;
> +
> +       chip_info = i2c_get_match_data(i2c);
> +       if (!chip_info)
> +               return -ENODEV;
> +
> +       return ad5686_probe(&i2c->dev, chip_info, i2c->name, &ad5686_i2c_ops);
>  }
> 
> 
> >   
> > > > > > > +	if (!chip_info)
> > > > > > > +		return -ENODEV;    
> >   
> 
> 

