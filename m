Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7C2475E3
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784414727; cv=none; b=cm5P1AJFVnEYPPvLSrQWBQfPTT5uVI259L4GhYsKj63Br05aVCynx4+rVwLVbd0fXbwhQ0SSXQVuEZ/Jzu5s4fCYMhnKynfoG5zTMplbRNPjGDBR2XWoxevCOLYw1KZfOygsNSEfsrKGy+4H03fRDx4woAyI25YF0ODtqGPQS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784414727; c=relaxed/simple;
	bh=zFJz1TFoY7str3S0bdvPAXXa1XyZo8BVY0uJKI25kXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBX8pFCaM/v0xt3m/HqPr1ckySg2jCNuJ5diw1na4DT09a777i/8z8pGHT29zMG/eS1d1vxsl63msWsm5wvLI3KorBFQ9t6an+CQYnZGOMjAbi+p9fO4v441hGMZh3B+wFiRaItpF9uVmCVAEFLlL5YfMNI4jOKLZflaHtJ5/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QXlEQ3rv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y6CmFech; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QXlEQ3rv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y6CmFech"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJpVqY1352247
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6R7VFVtjJrSn13IAfhDQXBcntPDsXnb7m6UQzlLcsZ0=; b=QXlEQ3rvfq1FvJqW
	4jvcSSvJWst9Tdd9fSeC4Fuses/YFcFLn+aneaxVBLvDbKrLWK5JmMuQrxq8Nu0V
	S95/UfGqnelepL0AD8T8CutSxrZPQzu/WLU0yHurTm3eEfKWvqhdrts5sqOyAwzB
	9Ue/zzG2EwXBGtF9MSBwjWjxkHOSz4VsZFVwgfs6wVGiKs56X5885KlzNj3s9msG
	VQchWs/9GGtyRLwh9PKNGqNu27vbG+dixPsCBjZcM/wpP3L62RvHsPwjWEl9L7Zl
	IDOHdNFsPbmDPDfLlkXBRL109ZuHom2PtRxycbVXdXv7vjv+X5JR/v9Lt3u4S56M
	4+5hTg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7smsb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:45:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381250979d5so6236020a91.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784414725; x=1785019525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6R7VFVtjJrSn13IAfhDQXBcntPDsXnb7m6UQzlLcsZ0=;
        b=Y6CmFechPFgW4x6NoHZqgd0dDRGnTlMR2yeiukVaPW+R1yuaiaKS6cZSJEYLxekpfP
         DUl6ZIOqvVNDvLPIeCUmGc3kSRgVH52jS9MwMMmXS352suZoB1sDLlxgQ6dbMc1aALC4
         EosPciGeqrCGDJiKPrJ1AzR5t24/SwIP8QW6yH59Nprc9vKIQKpz2/DbPli9wj/kyVJ0
         J6P/wRMmZ4eJJLkk1vdpyMpddE6jzZoHp38EDgkvz/KORuELlInYVMSvZf73iHum+fVr
         2tQtHAQyXuQBVOtu1mQOInZS9FZFFy9R8akZtkKhFLqOEjtfqZl4F7kGlN+N3HM3KanP
         pJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784414725; x=1785019525;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6R7VFVtjJrSn13IAfhDQXBcntPDsXnb7m6UQzlLcsZ0=;
        b=ForMFy/8Fndr/bkGbNTeCCmQ8WgJejV+I9GUKEicbc38xa3NbwmbW3mP586tR1Iiyw
         baB2oNL6i/b+tavbTmUoz3V+wH/4mHnGVQtsruiTnGah/MmqoOWnydW4KsY0MOb4f2oh
         3imMnYNEKt7q8LqoPrZibClpuqYmlRsmdG5d6zuaIZbNGFupt6t0kwFENiJatax3posb
         eOexpa8IqcUbldl7/krGK72Ndi/Y5FNNl1hVYtx5TI680GqkuD3h+4tWd8TESGePlxxn
         jJ3fb5u1fRvnEKuy5m/LW5GtXqdDAjStiVqJbq0cRKCdYhb/l5/MX+eyATA+uz1ijpHY
         Wjaw==
X-Forwarded-Encrypted: i=1; AHgh+RreZgiFLS/ipkcwDPUMTiUIYYrFudrW3thAiTq7Kx0vB/NAMWxdHJhI3D1aSRnYc7dZe84Fr565MsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymiuz1gw+iFcW8+sT/vkddfaU3p9qmNgA+c++n6S6uiSRIO9/p
	szxmCPO4oiH0/gGoF93+OIl7YpzjR4+UmrQika1fkE6+xNDA9NshAsg2uXQ7pwvkke3w3iIQeqc
	jp2T3jraEPxBomSS6gBxIz84Tt1/UOZCrDxDJsHUvdXrmDWZzXOCnaSB3zDzUA9g=
X-Gm-Gg: AfdE7cm/O4Q9I8ZdDmhgZYWmv8BDHg0wEbzjAtTAIrb9qboncAimkqEENQUvLlZApk5
	3rg1ADSHpwT55dvyBpBXQpVBU6979IHyovyS1rDfAmeqtc4ayeNgEwfXaFBOzlY75rsEyBxUw7I
	U3hXoGvsme2UT+tliaLTfSXWxWYoScgGtXdKIC5cBYbJXoL+716hBt1gVzMvVtV1CJmF+j/h45i
	+7oPgaAnqcPjFOGq3TzFXlM1f0cGz7pQ7hFAtiZEMAfsdCoaaSON+Cr7/uwRJ966Szyd82jDstM
	dhBFKTbz56d2CxjHsFu5H52J464dNfl1OGTJNhytcLzhyLULIfsk8ZdzSM4nT4SdXCdtmqbF/r6
	Cczsk5z/xk3x8T9eZ
X-Received: by 2002:a17:90b:3f85:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-38e4b3dc094mr8450579a91.1.1784414724960;
        Sat, 18 Jul 2026 15:45:24 -0700 (PDT)
X-Received: by 2002:a17:90b:3f85:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-38e4b3dc094mr8450557a91.1.1784414724449;
        Sat, 18 Jul 2026 15:45:24 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4aff383dsm3399462a91.8.2026.07.18.15.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 15:45:23 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:45:19 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: =?UTF-8?B?UGF3ZcWCIFdpxZtuaWV3c2tp?= <pawel.wis.me@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ak@it-klinger.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] dt-bindings: iio: proximity: Add Cytron HC-SR04
Message-ID: <20260718234506.6aecbc9b@jic23-huawei>
In-Reply-To: <bb79ea1b842e062dd47bd1fb31fdd15a9ef76c29.1784221074.git.pawel.wis.me@gmail.com>
References: <cover.1784221074.git.pawel.wis.me@gmail.com>
	<bb79ea1b842e062dd47bd1fb31fdd15a9ef76c29.1784221074.git.pawel.wis.me@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIzOCBTYWx0ZWRfX3vAJhtwoKsHZ
 y67QagVtwHtydY6vI2up0IFMKCqMw9+n2oOsq7WriB+txFheh49dq7oskEET/zelG3Vn9z5Qz4Q
 ctfugiRwB4MfbU4T0+qaKLgjmemPy+u9S97URF+VxDqt4S6TD4+iVTiGOzgowpBJ6Kgy1nzYZP5
 JSIz+au9RbgYRAB+smj3Z4kL8VTqwAxkeQJZHj5Ui4v9fgvRCLxmgtKI1MrL4nqUz41lUQeaYLV
 pItWV6Ep8QydTlP3dL/+WXg3pGVgY5wwxWSlSTcK7WiQfiOXYv+vDc8dl8bkYtFdVqVqOwPAkzC
 f23XDtNoqli30uYvyFe5NBifid9Cq01CDYQWLWByN2rpYUyie9MSxxjEr5Pl2MyikJ4CVkZhXF9
 YT5VYnrI6AZ7WIkNilUAJBlR1NWAEVF7OqZ09sbaG/vE4zo3wVFNHCrJMyp6RJDeFEXjcSxo+9L
 D7Ae8tWtdU+5Nw3Vhwg==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5c0205 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=OyMgvzc1AAAA:8 a=jYvFoifOAAAA:8 a=pGLkceISAAAA:8
 a=JtMDQYCtEKDs4ho9HbIA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=BRz8ttEm2lkauKK-z13Y:22 a=Kz13i9gsNeNICKTRhWM7:22
X-Proofpoint-ORIG-GUID: y2nPrtSJfqDUK_lCyz7K-3xncAbeJo6T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIzOCBTYWx0ZWRfXym1ZhQAwHxBL
 qYXzR3u0cwJ17GCkEaGU09U5ffc9bZ1K/TiBekNrbdgQgRJtyLsHHiU3Ra/cTI+lOknRSuyKvjE
 jve0C7LJ/I1CqyiHbLAveHI7iB6w7Us=
X-Proofpoint-GUID: y2nPrtSJfqDUK_lCyz7K-3xncAbeJo6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180238

On Thu, 16 Jul 2026 19:35:55 +0200
Pawe=C5=82 Wi=C5=9Bniewski <pawel.wis.me@gmail.com> wrote:

> The Cytron HC-SR04 starts a ranging cycle with an active-high trigger
> pulse of at least 10 us and reports the acoustic round-trip time as
> the width of an active-high echo pulse.
>=20
> Add the cytron,hc-sr04 compatible and a reference to the product
> manual. Update the trigger GPIO description to account for the pulse
> durations used by the supported devices.
>=20
> The interface matches the two-GPIO protocol implemented by the
> existing SRF04 driver.

Is it suited to using a fallback compatible to one of those already
supported parts?  This should say where things are different.

>=20
> Assisted-by: ChatGPT:GPT-5.6 Thinking
> Signed-off-by: Pawe=C5=82 Wi=C5=9Bniewski <pawel.wis.me@gmail.com>
> ---
>  .../devicetree/bindings/iio/proximity/devantech-srf04.yaml   | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-sr=
f04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.=
yaml
> index ce795279839e..f4237ae612ab 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/proximity/devantech-srf04.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Devantech SRF04 and Maxbotix mb1000 ultrasonic range finder
> +title: Devantech SRF04 and Maxbotix mb1000 and Cytron HC-SR04 ultrasonic=
 range finder
If we were going to keep the list going it would need to be:
title: Devantech SRF04, Maxbotix mb1000 and Cytron HC-SR04 ultrasonic range=
 finder

However, previous experience suggests that sooner or later it is better to =
just
jump to Devantech SRF04 and similar.

> =20
>  maintainers:
>    - Andreas Klinger <ak@it-klinger.de>
> @@ -21,9 +21,12 @@ description: |
> =20
>    https://www.maxbotix.com/documents/LV-MaxSonar-EZ_Datasheet.pdf
> =20
> +  https://botland.com.pl/index.php?controller=3Dattachment&id_attachment=
=3D476
> +
>  properties:
>    compatible:
>      enum:
> +      - cytron,hc-sr04
>        - devantech,srf04
>        - maxbotix,mb1000
>        - maxbotix,mb1010

