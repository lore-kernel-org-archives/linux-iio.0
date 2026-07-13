Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF428375ADE
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956242; cv=none; b=DkBib3fdyUBvZa0z2T3YgQ5omxFtB4QicOY3IDkxJNvSSYTOgtJTxfmvFXmFfGO/ydtq5WCn4AxTG1InNCbo4N44rMF2sZ89GOVvPqkc3330LkQDK9Ek4GdbjcpvIX0zfvwTi0lxkq4sMhkgYGerlZbqH6veG5kCY1rzGBDG/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956242; c=relaxed/simple;
	bh=Nig0z9be/bACiHxkv/zcR0n3Fa0ArflEoEv6FUY0xWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMfasAmaLubBAwihr4WWSWQAkb4hxqa+LroyJirdXjLr2PwQfmgvQfy7xq5mMmxY1YfQwq8V9+ATQOZ/uTj+WNXWRs02LGeAGE/k4g9TigwZyRbG+sTQOA0iFUv1/mV2ayoVgX2GCwokAsnUeF1qwI/h2RGbF+ojFs1LL5DQgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L1/GfUJ+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bour28/A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L1/GfUJ+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bour28/A"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8Kt11860768
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hybZBC9zxwIZTXM83Re9UAcSKe/d52J9cAF6ZF3C0mg=; b=L1/GfUJ+vLRiJZbB
	hzsdl0qm/cfPmPDd6SALgDD2sIBDyV8vewwkIaStNdGqsdBN7znjt0HdABZHNijY
	HjMgervJmXDqsLj2pLJJUoqbI52Qtm+zXTFbY6fb6o7G6GMuM+SPYs3oMN2Ne9D5
	18yGrp41+/EW+2/bpykhdqlzNllXZ65WKdB3O4oHB9RgRjQooI7q96dl0Xdk4dcs
	tdAATaId9XJ4TidCkt11l3/6gqhUtV6eTAD7Q9i8FdQ37fLho/aHwi1Eg/uZeozi
	rjJ2k8ZpO1nslyq52aT/ZtpiWrFR71FKaVAGOOrL+dL7Xq4+DMOd0pjexKL7mJyi
	L2A6jw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj01xvk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:23:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c7f385887bso79992485ad.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783956239; x=1784561039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hybZBC9zxwIZTXM83Re9UAcSKe/d52J9cAF6ZF3C0mg=;
        b=Bour28/Aj53l+d4K3UAROguRfb/ETh1UszlmX9Hk80DrKuetjkbjFtCrWV0T5BAsli
         mGBsgGIY/bwLP9BgM7Gy6YNwGWTUfrrtA68JHahK/YXoD35sc7fQBO1TxvfnbhbB26YE
         7Ns11IgxsEK3xINCePUU9XjrhX5xIZIxfFwrGct24xHYJrBn162/z+5p9Ubw4FoUBgRF
         jS+hM9Qm6sPlFdbRmqi63v22Uc8OsbkLU143t6cEILH80tr6MsSbwOv7IpPpztPJKCQL
         zLlb8Wh62HECRXvm1Nc+oBoK084dI2MI0AdPkawKfXyNH8VmT+EWnzEOZyfIx1Ia9VGY
         Birg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783956239; x=1784561039;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hybZBC9zxwIZTXM83Re9UAcSKe/d52J9cAF6ZF3C0mg=;
        b=JR4B/THgXO52PF8TvWk/n5n9jb9xgWFxTlDaLYsonzGq5nnBK0SbahIEOQ9So2UYLv
         lXSCMtmzIpO/uBWCQxZyhRFn2I0L1zrQ6ZkDxu4qJ9MWwEikxH8GdKZFIbPFwIHi09rB
         moKOIYrFqPNRk8mSqoMm2rON9VwcRMzy08owQMu/TqEepYx7QLxYKqGzIL0T13zTu/Vz
         rhKVW1qPx+vLmlL22cTZppY1DatHQHpn/cKtpQWTmc+WqwVUUUwjVHoOx9kSKNiG7esk
         hlyNESZDfFB15YQZkNuQpn4VAZNFlXYAuzEc92AS9MIoedYBanSZetWLnvyCNqlmcCxj
         2Bfw==
X-Forwarded-Encrypted: i=1; AHgh+Ros4FBxnrWRJoyZrTPLbwJ1knAE8ykZDLI6rf33TDr57faGj5oRGxSerKsXbXSzAcg1pJGr9GzHoa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzujN5UeYdcSDbjre6HjHIq+QGRZKJeSwY3xkZh+vU7CmIVMBKF
	zVn5NezACQ20eaKNktjMWZrs+g8RBYDEn5iHbUP2Hw55x+1aAfd3yWE39bI995S8Mxb4hT8av+6
	+bp/kvAwHnp7CFWCdP5zwVISUtj8X0opkA8HE8cAcHu30X2M/xlUSXbDBwT+opvk=
X-Gm-Gg: AfdE7cmeICOfIfZlkpQBoOArOp8sBUZFTl1ZLLnet4UMujfDJFDY8qWJH8Z5L1Ip9qR
	jiNsI2dix4OAuZNBszbgrMjqJkmW0MKeM4sIVBnXI/dNEc8FMoWYsnbXfb8iUfpCdpvYlLQ54hJ
	eY4jhxBby3A4BYLmG/sfwMUXr21JqP2+yB6ZbwTyp9acGP1z0qsW/FBA/yMjy95syzZR8Jk8+u7
	InU0UcUkpFoyMMTycXtlrdNjuwb1fLEv4vk6bgqnJjiaJgCKpbVXAH/l2lIaNOmA4EzqDj4JZXg
	+s3u+jzD0oD/M77JJwmaFizDGZ8oB14pJ/AUD98k3HJHx6ujQTko/SSPsAD0slO+BwtDbz5mC1z
	AzKHNNCh21BANoPgHYauukgfXHUc1r479pGRh
X-Received: by 2002:a17:903:2f08:b0:2ce:e75f:b713 with SMTP id d9443c01a7336-2cee75fbe28mr3254845ad.23.1783956238478;
        Mon, 13 Jul 2026 08:23:58 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2ce:e75f:b713 with SMTP id d9443c01a7336-2cee75fbe28mr3254495ad.23.1783956237827;
        Mon, 13 Jul 2026 08:23:57 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm100605175ad.53.2026.07.13.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:23:57 -0700 (PDT)
Date: Mon, 13 Jul 2026 08:24:00 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
        Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
        Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] dt-bindings: iio: adc: add input-chopping
 property
Message-ID: <20260713082400.000024f1@oss.qualcomm.com>
In-Reply-To: <1700ed07-47b5-4831-87c5-a6115928baab@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
	<20260710-iio-adc-ti-ads122c14-v3-4-746d52cbf1d0@baylibre.com>
	<20260713023443.1a7a9acb@jic23-huawei>
	<1700ed07-47b5-4831-87c5-a6115928baab@baylibre.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2MCBTYWx0ZWRfXz5yNs2/nKfln
 sSLR3F30Je5vVcuTMAGuSEKNM7pjXd51sBFOHJwKKxUl7xzKlux5vGD+V6c7zuM51dXjn2Pjwnf
 xTrM6Q/OqrTVFb2GbMB8i7345cwtnbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2MCBTYWx0ZWRfXwV7+jjYE/J9d
 pXI8w6fTlH3Naf0Jur28kez/DmVdjvBwR8qa3RM7AtJArIkJk2481eF3LEpdPWhkrvMXvEgPmWp
 Jpl3ddh03stidfTG+IraG0LvLGQzoXwJRc+AwYMAmB2UyRqhfb0MYc6CNKluSZ8yZCzVTAdlsYC
 MVzVlpTaeFsBkV9tnx7tzAn5CbrN2LVpy3MEFDUVhM4VG631/m1qxaOQza9g7EMz21JWCWMSF+f
 KGGS9Nq/qATNN7C23+D3FWIY7YlAyTyWXmSCCuoar7qa9rXyz0kUS9iPtEcs4+eCaf9KidSNBQT
 mJ3V9SUP6ibW4O83D8H+Z8EojJHVBwElImzK4kVHsVTBx6kS5VXV+LMPo05JLp2eo20S008zp4C
 w890c81TZWmCmF0AMQD2dRp5Ks18ZvAmIu/Yt5QbyLNK/mz+0WwR94ptaAfTinoIJQ6eD+8LV3i
 aGUKitx0HY56Sd7mKow==
X-Proofpoint-ORIG-GUID: GVDOdeMEpn9pWJkXR45J5zFeM-sM41_f
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a55030f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=IpJZQVW2AAAA:8 a=ALuaPTNhsiHwyfqByDAA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: GVDOdeMEpn9pWJkXR45J5zFeM-sM41_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130160

On Mon, 13 Jul 2026 09:55:53 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/12/26 8:34 PM, Jonathan Cameron wrote:
> > On Fri, 10 Jul 2026 17:50:37 -0500
> > "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> >   
> >> Add a generic input-chopping property to adc.yaml. This is a feature
> >> seen frequently in ADCs that are designed to measure resistive loads,
> >> such as RTDs and strain gauges. Enabling this can reduce offset errors
> >> by swapping the positive and negative input channels on every other
> >> conversion. This can have side-effects in timing and filter response, so
> >> it is not always desirable to enable this feature in some applications.
> >> Therefore, it is best to make this a property that can be enabled or
> >> disabled in the device tree.
> >>
> >> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> >> ---
> >> v3 changes:
> >> * Renamed property to input-chopping to reflect more common terminology.
> >> * Removed "allowed" from the description.
> >> * Extended description to explain when it should not be used.
> >>
> >> v2 changes:
> >> * New patch.
> >> ---
> >>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> >> index 308857f11220..c408feebd46d 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> >> @@ -80,6 +80,14 @@ properties:
> >>        ADCs usually allow choosing between internal reference sources or a pair
> >>        of external pins.
> >>  
> >> +  input-chopping:
> >> +    type: boolean
> >> +    description:
> >> +      If set, the positive and negative input channels are swapped on every
> >> +      other conversion to reduce offset error. This generally comes at the
> >> +      expense of added settling time between conversions, so should be omitted
> >> +      on systems with high-frequency signals or high data rate requirements.  
> > 
> > I'm lazy so I didn't check back, but in my mental model of this, the DT is simply
> > saying that the analog circuitry is suitable for doing chopping.  Driver decision
> > on whether to do it.  Perhaps we can reword it for that?  
> 
> Heh, that was the "allowed" part that I removed.
> 
> I think this is really more of a design decision between the tradeoff
> of less noise vs. data rate. By setting this property, we are saying
> we should favor less noise. So I think it is more about the expected
> signal than the circuitry.
> 
> So not sure that I would add anything here.
Fair enough.  Given the driver can always ignore what is in DT I guess it
is fine as is.

Thanks,

Jonathan

> 
> 
> >> +
> >>    excitation-channels:
> >>      $ref: /schemas/types.yaml#/definitions/uint32-array
> >>      description:
> >>  
> >   
> 
> 

