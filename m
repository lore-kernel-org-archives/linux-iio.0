Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAB363081
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784503109; cv=none; b=CqQX/UNZ1HUBhCZvYES3mwdeSiOFAL/CB4zs1nR+ETMZ1kJ/pA+HWAGPYRdpWDlhla5hood8dzTE5BRunqnBiwjLIRb2+N5hNpwfPnsPqjTMAx1kBUtjyut/TkG/kK5R2F99zyEazrNlOBmD6D5JWY1I8NYNR7kinus0IaoCGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784503109; c=relaxed/simple;
	bh=jlZxa9vZboy0BksuXXTUMp6z/9XDE8IsRqB0EXK49kY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOc0uTs1A+yLQWj7stgwBJY8grv0pjPW0GkagllKxGripzFkxwujWKOStc8qKNLJGQ9E62/qFkT9VODjTcIZISprO8Jyjgw+IUiRk7FTek1cND0ooZnMvX/PaTSDtV2jmpMbNdhKRPyi7nwjnM0CXmJ3QBFsoeSvKfiCCHg3J9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KgolratY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P7tKP5RO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KgolratY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P7tKP5RO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKQqIx422141
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QgeRlMIF4PNYTV0QauQI/hB2VqHL/8Zkn/RtkXBaTMg=; b=KgolratYUAK77z96
	n5xkG1LD+sx9M/Zvq/tQ/vBSEdK7DouV3O5Qdx9p/TcYcbCL3XkOkjXhX2Zi5bdk
	sBtTC/EqpBPF52YXaGfGxV/fRFDWeZsVltexUcszFKATp1HGJ7Hrhgo/glXU+pwh
	eChgy41J/GwxawyCXyHUaMREE5TDx70XxPMwDrWH7g66qg3GxrCwi6gLOP6QLNrq
	D1A2KkqcdOhZ5np75TokYY1gM+p0x2qWP8agpIxwoR4PJoa9i0PzeEFXnyPGf2Od
	F7dSpujuPsiRUHL5s/WeOhpzpy5JwGfolXYx2o9TNb3Iq40OkSPwjGb4w+24bWCT
	m98Zkg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc3p9d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:18:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a651759a2so11576101b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784503106; x=1785107906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QgeRlMIF4PNYTV0QauQI/hB2VqHL/8Zkn/RtkXBaTMg=;
        b=P7tKP5ROBzVk0lcdHTo9OjK/yAF0IppABWuGLLw7uDvBctUqHVzfRcwaxiwFYq8zlU
         YMg6L4ER/5dDQ7O5ZYFGshOCvpO81/7D54O5RrjN66jBpUqTsfpx8Qk9GD/qqi5n8Deg
         B/yoYIxu8sfYPgyN3+7EHxbaSeFNQHBD/5DR15GNGNdL2AlOaaRogE/y8Ku21Kp87NHG
         h338hOjXKmT8qiC+dshqMG6dhjIh8LgB6p8sxoyP3jts72CgtjsP2JHsVqariLFS2WVK
         tJG9gEessXopenAFjcy01hbCxDue3Con2lvjHprxNpnN0OUTOaMnMu+ozzlUbORxNT9z
         AGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784503106; x=1785107906;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QgeRlMIF4PNYTV0QauQI/hB2VqHL/8Zkn/RtkXBaTMg=;
        b=WRNi9TQPFY/eC7d9a4hHunK4vq+Su+b8Eaagln9MLn7xGRhP9tiXzxFzIfmYk3byk7
         ZiFBpBy6G3FsArfNVThXuThM7YBhSX8Bbwr3RySDSFUnIfgm3IwMJQwSxY9G9v7DYuzG
         3AYyf+NEVMySydhNR0L0qL/OVhevC3YdIXe3O1xSs1ORNQiF+vo6M0OMREfUFraPQzND
         JLsqQ8Ke7t0pSMdUR1j39abeQhGbQ5wiUvGpAgmDXFnL4Qg5V1e1tgv2aPc3Tiflqe4v
         yJG+pLk2gHhz9bQLnPhBaAmhnDCTtcChOUnSEF9LquIsLr1899eRx1wmWFenKGX8peJa
         lyZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSjJJ0reyaI8lU01Ot4f1Rm7lkoIfNUvBipzZCu3aobU6d9IIf1KhePvLt7enTz5F9YL3VK7xugTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYZ4cL+8/hcg3VG9nV3uFu+TizEaMWRbz8/I4M3fcBuAI1NIge
	+GgTUeBJl7iEDJK1OOUs6mw0nWnNGptLWVRnBrq+6k8E/3pm9titp8Ep4x9MJRstqlukaRHCoMp
	Ru8B0tQzkDnRaDacg8tZTnBtfiXV4Rl9/y4ff2QI4WIx4adoQhvkieebHM+l0654=
X-Gm-Gg: AfdE7ckQJ0Hf3ClpiXPWKb4ZCSXaphkLOZoNDKWx1m0Iraol6+YIsSUUJRecR7aEXID
	Uc0YmksEhp6wWdEUIb5etWNlTUH4cQy+okWimSX9qMr0LecZeHjfyx8nB+EcOMfxu3T/iHC5nk+
	VWOg/Y070DwkJFZ5h2Ez2L7BApgiXII3QxHgoNZsM+mIOmjRLjqCOwliiPCj3Y3sICReSvdjGvB
	L/e6B8WOnNCw3B9Vdf3b2a5BU6IIWI/sa+lcb1Gg1md8PqIls+dVLxah+G4JzwVHJKZ+F3urFNs
	d/Ym+XsXP3C7v6tSjmyZ0KJ2Ybd8psRNW68dWvMn1d0+xX3ys55DqbXHr2whaYdBjxm6JPXPw6I
	Knjcr1RyNHDJ8/ScV
X-Received: by 2002:a05:6a00:228b:b0:848:4424:2b8e with SMTP id d2e1a72fcca58-84c29272e4amr12634555b3a.3.1784503106317;
        Sun, 19 Jul 2026 16:18:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:228b:b0:848:4424:2b8e with SMTP id d2e1a72fcca58-84c29272e4amr12634541b3a.3.1784503105842;
        Sun, 19 Jul 2026 16:18:25 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519ae8684sm3634095a12.17.2026.07.19.16.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 16:18:25 -0700 (PDT)
Date: Mon, 20 Jul 2026 00:18:20 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>,
        Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>,
        Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <20260720001808.63d576af@jic23-huawei>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-8-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
	<20260714-iio-adc-ti-ads122c14-v4-8-25f8e3084485@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI2MSBTYWx0ZWRfXwBzW+Zk+Xzon
 zYqfByQ9vE50icatKBtApAZILXND1Q3QKgtJQOb+9TG0kTuiULdHpovszezD2FCqG0XbC0PZ93l
 +wwQLobmTG6XvEnyauBiCrHvfUUjCqI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI2MSBTYWx0ZWRfX1R4OvjwnkS+N
 6oDsoRGnrBKZ96sgQmp9dztPKbrDJGFE7x6Xub/nwYdIPEpPWDOyRGb7zYqzuC4fGrYruq7iMqo
 PBQ5DQKY9oiOgleUt2HE+ZHPkBbKoczaCz9kod49xFFOl7RCYGyBccUqHEgKZFIMS4UPDbxfnnb
 awkr1kccmajpMEKArBi97xJFXal/11eC0L7LIyCRT6uZQi9W1rOll2Q5YYn4NxW2L7Pxpc72lY8
 vJoIBk1oX2q/v2o0Mo4ws5avWlbt0IhK8FhA/o7XZwlzBSyel8Kub0MSOnnClNkr3+o/ORKoSVS
 ECO+zB74ERHCVCGE0NGX9Zjg2KZiJvA0ejQh5lDsz7xV+yBf2JBXI6s6sMhyuy4x3F7LP9Jh6UX
 VTZDi0+sgmz9fZuzPs7snFv95Qx7EQJ4YIxDH6wim1BCBWIgZdAiCer9wQmck1oaOEfCHQwSqYQ
 b5ewEu5gQVZeaYsC2og==
X-Proofpoint-ORIG-GUID: Tp3lc04pp69k9l7Rrt4IdYXfw6b0_hrk
X-Proofpoint-GUID: Tp3lc04pp69k9l7Rrt4IdYXfw6b0_hrk
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5d5b43 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=c92rfblmAAAA:8 a=IpJZQVW2AAAA:8 a=KzLlk2TKFSg7Zc6CKOQA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=IoOABgeZipijB_acs4fv:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190261

On Tue, 14 Jul 2026 18:21:30 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for parsing devicetree properties for measurement channels
> and doing direct reads on these.
> 
> There are quite a lot of conditions that have to be met for each
> measurement to be made, so quite a bit of state and algorithms are
> required to handle it.
> 
> Channels are created dynamically since the number of possibilities is
> unreasonably large.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

Huh. Sashiko had a field day on this one.  Other than the earlier
mentioned 'maybe' case of the i2c_smbus stuff returning short, I'm not
seeing any of the ones I looked at being true. I particular enjoyed the
hold statement that something didn't fit in a 3 bit field.  True, but
the field is 4 bits and there it does fit.

https://sashiko.dev/#/patchset/20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485%40baylibre.com

To me this all looks good.

Thanks

Jonathan

