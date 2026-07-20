Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DF29B8D0
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514575; cv=none; b=hm25BMQ61pbspThlXlHU5j/fPH/O16HvJiSU4bf0d7Wx86/r5JBJiscPccGmjMsIYc2kgyMQYuDmFCPBlhC6ymK6zLBQ/0o0ZbC3SSd7+jsFQLKpU17RsTtt+uIh7fT1hzauUSvsot0v3hNnhoJWfT2W2Ll++39gMxdtGc61DVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514575; c=relaxed/simple;
	bh=hcW4+jnZG8b4vxEKZJlNUE9jP73WL0SqOk+06jOM2T0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPO7E7NM3RBJ6Lp+wUsVoo4dwVEpIA+5akn7LJoFQARjNh1OUNzruIpoc4dPjMhJSTAfybeDtKecpZtWM/3v6gcLRVKQf42+HPDga5RksFNBZyHokh3e0pJ1sz/nFHvomVfF93G1QKLxanE5hNj1ctMvH4hVIzPyDrgOGVyd+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SxJZ/BQk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JnoeF+Nf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SxJZ/BQk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JnoeF+Nf"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNt4CP1912744
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a/JRSD/ECxDv7bVvnhyNJbXBL0lH3mP+ghfy34Djwss=; b=SxJZ/BQkNyLzx1KH
	1dfg4V8p0q8EZ6RfAX5oN3uIT7OD1EhpaiEI2k8dZwVovbNFRJ3M3gDQ4urE2OS9
	90aQXMnTnWZDsf3BoVxvZQrAMEFafcJc1hANUCVz1jKOZlWUeYKWVC7Al0Oor7uO
	ISkCNYi8f8jnpi6kJ+6c20Qy1PaTZdw146jJHaORpydoyj08BFtGPcovBVOZup2S
	nfW3ZI61nDmi0UPQDMQE4Izb7uJdQ/TrmxQRXhl0cKcqos/8/0w52rjP65EIxeYK
	zea8EmRS14VHkoh9duhLxCgjxgDvWwjzr0oloyhvvkabYQHLgdDmiVuq6YOu5/K1
	Hs+K0g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aauyr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:29:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dff6253so26811805ad.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784514573; x=1785119373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a/JRSD/ECxDv7bVvnhyNJbXBL0lH3mP+ghfy34Djwss=;
        b=JnoeF+NfR5eSsnlbqg7YGazgx/3cq7BDg5CGbhnbnJIN18v/lKbTaWFBsOkKVkAV4H
         jm+l57lHb3fEJOK5M/9F3Vg/MKo05PMqmDnsMo9u+A4mD24v0M3vzvWdQRaOHRptHYS1
         w1mbpltnOfMbnwSS/KYFJCzv7kyQuAWZKSOsjvrrGfKwzHwPPJjy/yrKuFhH+/U8z+Ph
         w4wA6e6Un6g8YJyf/f/eRQh8ZNmbVNle5hBqJtjbnnUOKO/9DjyX8SLNQbHGjIUYcsa/
         3BNmXqavNamXnIJzSfb2BfV8BCAnxv5r7pFVfBth2pxCwyvAW/GEM1gA00b7w1C7jfTG
         Ytng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784514573; x=1785119373;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/JRSD/ECxDv7bVvnhyNJbXBL0lH3mP+ghfy34Djwss=;
        b=c+qMtke7xgp70sczET+Ow9icHMFPbAO6bYr4x66EYz0XPvuIbeZ3XbsuF0U9PrRhKx
         xZbIZ74j0r6pvgOK1mhMrA9sZ5C34rz9lBAGUJO3BSxFlZiEyI6uvjBr1POy7mQh7Ph3
         9kXiLJxQwf7Si/oULZ+LN/lpwlOLz7XD3qDfodkVjdANfOqd5wrYeVsWsQPUHsWk31hl
         sr4Opk5Qpwb6O9CVo0n73Uz1z563bgNXM5lioIJMXwy9665CuvNMDWo1Uq/kgfkvrtuB
         e0rES6oSD4WGoKyGZmo6IcXLOenEp5FvBX0FFxKkmcCrOIf0yYcdxN7zzad1VqCxBGkD
         MtIA==
X-Forwarded-Encrypted: i=1; AHgh+Rqt63FmIti/Id9gSeBFAsCqOMX84JPioz5TxEu8FnSZqsHD41QjJQB+T5BShmw8HEqFgeSf2w7+vdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSHb9EljmhoZOw3dt3u0cQAKinEdIj0jiAlBoVfrIKOM7lMDg
	w8991qocAygSC5GNp6DI3Zv9Yb5RT/l7u01+vl8HyPKg9fTpBU2vi7oaGytKTXEcYkk9OUpKkiZ
	jPUl93ylmVsJ5DSqhHbmarg5V3WZhLBzqcM2oCcWw3DNROf7gkySamO0+7fx94Mg=
X-Gm-Gg: AfdE7ckBJvaJWhteW/eHSA1hOfzzGRSSSUh/s5l2aJwO8WJUE5ZiLOuurkAUf4YHChL
	VR0JAxcu8j1iCpQfRGWpqT8w+/9AL2aVRmqYNIMXSTqWu63fEwjVNr5lQg71h5GWPqXf7jHFE0P
	VrQB41SRFK6ZmJbsEndSFwTnIzt7i0ihVcnH+vbHo6UW+sGhfzojadkxXn6l1RDp1c+5P/BqjXG
	I07Ne8I/Xm/cZHFDjAGR2s4vzBnk3DbP8wsg1VWrHYuISfbm7oeT+w8WHlDLElqqPiOgvtOscZ5
	ZidLXuXmFXKIVPPMPSm1m882DDp9fdy5Kb0LfhOKEFbdUicfeNMeIJ8OylrLWsAHQmRUt39bmw+
	ZHfUKLm7xEZBRgFoo
X-Received: by 2002:a17:902:ce0b:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2cf34878effmr128423635ad.7.1784514572738;
        Sun, 19 Jul 2026 19:29:32 -0700 (PDT)
X-Received: by 2002:a17:902:ce0b:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2cf34878effmr128423385ad.7.1784514572249;
        Sun, 19 Jul 2026 19:29:32 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b1348sm48260335ad.18.2026.07.19.19.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:29:31 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:29:27 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>,
        Maxwell Doose <maxwell@maxwelld.cc>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: Re: [PATCH v5 0/4] iio: flow: Sensirion SLF3S liquid flow sensor
Message-ID: <20260720032927.14fc4f9f@jic23-huawei>
In-Reply-To: <20260714085358.20842-1-wafgo01@gmail.com>
References: <20260714085358.20842-1-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bhtFFP5PbdhhlA_-QhcOkYnQahvxOeoi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyNCBTYWx0ZWRfX8dhzEdtl6Qqw
 hNAM7FgPRvnOdE/150q6XTYdApw1FXoObVAwCIqSKAgsrPwKGFBAt1ZX4VbrDtpFqP2BKhm6ls3
 BhKFwm92UyIPx2bz6PR2CKcqkSD81uo=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5d880d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=LsRdE4r2pVaNBGN-3VYA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: bhtFFP5PbdhhlA_-QhcOkYnQahvxOeoi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyNCBTYWx0ZWRfX6eixAJrynEIm
 3nhxP+nYMERX11C995C38Ocrh655Qg0LXyl9oXNkNLHkGhYjKEM0CTrpdzFKcEG6P33m+gg8LiH
 GJjLLkAGROPteMxG94ZZvvf57bJ1FRnZ43QOIQrKKk5YWDmRAzATHMHtE87pIR7RbI4yajZbYng
 ZesOGcVgEAiY9bxpbJKIPE7/44O0utqA+yFY0t7uetSs9DOs3X1nvrWXmX+t80gWbLukj1LPklB
 ZdbTXNnGCB+qmr13QhPt8rar+GWIcrznJo/Oo9wdkGMTLxd0v5gq/pWZVDhsOjT5G6fvAdhqKkN
 4EbgZt2uu21X0fM+bEuMRmuEJjCrOqAwK0Fo+cHbYLIMOBZlauO2jkc3JZrEmV/JyHm++bSqeuB
 jBfhjKShcGfnqGHkhPdZAdCiU0aq8cqSHR26jYTWWbxNW6u8v6cBa5SDsa2bMGe3gUg3xN2xQzC
 hE6UnRogHkhbdwLho3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200024

On Tue, 14 Jul 2026 10:53:54 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Hi all,
> 
> this series adds a driver for the Sensirion SLF3S family of I2C liquid
> flow sensors (SLF3S-0600F / -1300F / -4000B) and a new IIO_VOLUMEFLOW
> channel type.

Hi Wadim

Something seems to have gone wrong somewhere. I'm not seeing patch 4
and it didn't reach patchwork either.

Thanks,

Jonathan

> 
> The series is now based on iio.git testing, which already contains
> Rodrigo Alencar's IIO_VAL_DECIMAL64_* core formatting work, so the
> external dependency listed in v4 is gone.  Patch 3/4 adds the
> IIO_VAL_DECIMAL64_FEMTO format type on top of it.
> 
> The compatible/fallback layout of the dt-binding is intentionally
> unchanged from v4 while the discussion on the v4 thread about the
> preferred fallback scheme is still open:
> 
>   https://lore.kernel.org/linux-iio/20260621145117.70b2d50e@jic23-huawei/
> 
> Changes since v4
> ----------------
>   * rebased onto iio.git testing; trivial conflict with the new
>     IIO_COVERAGE entries in the channel-type lists resolved (1/4)
>   * driver: include err.h for PTR_ERR() and math.h for struct
>     s32_fract, per Andy
>   * driver: fold the per-variant scale_num/scale_den pair into a
>     struct s32_fract, per Andy
>   * driver: add enum slf3s_variant_id and use it for the variant
>     table and the I2C/OF match tables instead of bare indices, per
>     Andy
>   * driver: slf3s_send_cmd(): drop the "at_least 2" parameter
>     annotation, decouple the ret assignment from its declaration and
>     check errors first, per Andy
>   * driver: use sizeof() instead of ARRAY_SIZE() for the measurement
>     byte buffer, per Andy
>   * driver: parenthesise the (FEMTO / MILLI) factor so it folds into
>     a single constant multiplication, per Andy
>   * driver: derive the temperature scale from MILLIDEGREE_PER_DEGREE
>     instead of a bare 1000, per Andy
>   * driver: checked the struct slf3s_data layout (re Andy's pahole
>     question): the non-pointer members total 260 bytes, so one 4-byte
>     hole remains for any member order; left as is
>   * driver: drop the inline comment on the mutex that duplicated the
>     kernel-doc, per Jonathan
>   * driver: fix the duplicated argument in the DT/sensor variant
>     mismatch dev_info(), per Jonathan
>   * driver: reformat the i2c_device_id/of_device_id tables to one
>     member per line, per Jonathan
>   * MAINTAINERS: updated Maxwells address in the R: entry to
>     maxwell@maxwelld.cc, as he requested on the v4 thread
> 
> The signaling-flags word (air-in-line / high-flow / smoothing status) in
> each measurement frame is intentionally not read; exposing it can be a
> later follow-up.
> 
> Thanks,
> Wadim
> 
> Wadim Mueller (4):
>   iio: types: add IIO_VOLUMEFLOW channel type
>   dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
>   iio: core: add IIO_VAL_DECIMAL64_FEMTO format type
>   iio: flow: add Sensirion SLF3S liquid flow sensor driver
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  11 +
>  Documentation/ABI/testing/sysfs-bus-iio-flow  |  21 +
>  .../bindings/iio/flow/sensirion,slf3s.yaml    |  58 ++
>  MAINTAINERS                                   |   8 +
>  drivers/iio/Kconfig                           |   1 +
>  drivers/iio/Makefile                          |   1 +
>  drivers/iio/flow/Kconfig                      |  22 +
>  drivers/iio/flow/Makefile                     |   7 +
>  drivers/iio/flow/slf3s.c                      | 541 ++++++++++++++++++
>  drivers/iio/industrialio-core.c               |   3 +
>  include/linux/iio/types.h                     |   1 +
>  include/uapi/linux/iio/types.h                |   1 +
>  tools/iio/iio_event_monitor.c                 |   2 +
>  13 files changed, 677 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-flow
>  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
>  create mode 100644 drivers/iio/flow/Kconfig
>  create mode 100644 drivers/iio/flow/Makefile
>  create mode 100644 drivers/iio/flow/slf3s.c
> 
> 
> base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996

