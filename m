Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025793CB576
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331730; cv=none; b=AQ20T0QIoOWHRFSTElWiqIYIjuwhfxuQ1TF6LRmC3S9UlVE1eP1ligfZCoS0helkLk5TfOVMjbX3clUQNd1fcE2zkvWM2Pyc/jvi7brw5BMFdKXCQqST8vHfEnWBV66Km8Ey2GSd0W28B/LTQ8r2GN7wkaaABX/WH1MWoNHbhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331730; c=relaxed/simple;
	bh=Dh4PhUdgx0Srvx2iN+3TiJNnWorjoHEMHaISL8VgawU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJnrCm1lgthzuJ45U4LyXhpyQKYjybPQ1k2Syq4VOSn15viMxSgfZYzZxsfZv83JMaKWNN8PRRCMpS8g8gYdus9rcuG3pkcLeeF2p4sNMCYqia8V2w+NxmZGrdF8yGZjU1WJk+ms/TWXqSAz3WDbEVWum8cJVSr5Q54wCBp6XB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HhMwSkvK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XD6oPHbB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhMwSkvK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XD6oPHbB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNELif2872635
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hNk7g4pY92o6e2+1OUe9g8KgB5YklUhVrGTC39c/648=; b=HhMwSkvK0wJ+kYKZ
	ZvhNg2up1E1emTlNlkvgFvtp4uUKCLa6SI0z5ynLqjYV+l/DBDhINLHrLKg96Y0+
	4bqjt7a2/L64rpJOd285XPafACVrRt/ZakT1R+UPG2NOQ6yCmEN/STt4osZ95qDC
	McCUYfCxmKeWcbH/SyhdaurHZB+xK+mlwjW13ps4iKWa9l1VSzuKW7l6OUr3lRxl
	cqtjp9p72Ep4sxM4NAsabwJrg6VexcHjZ9tfGsslIKKZTu3fjCMiihvx/u3/uIa+
	QQqcGR2Wlc84f9S6Lg6k05NlmXl+p4f/+0OZpmfJIXPfwizrpVClL6hmKA2Vz/b1
	KrcXBA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffj78tyfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:42:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2caf4173b1cso95205815ad.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784331724; x=1784936524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hNk7g4pY92o6e2+1OUe9g8KgB5YklUhVrGTC39c/648=;
        b=XD6oPHbBuODPXzKeRDLC/iOgB2F8OQio5qVFwjAQB7I2CB9JnDINPM1hx2ww1Q0cL1
         9mpJm5/OKI/ReJuo8gS93RWDa6jN9cKPh9Yk9iusZCOFcF8udSGX3HRoLq1W0rpAlMTW
         g+bp9WSvVtPRCoaL50BJzBx1aI6mIr1zaD987i2QZjHmNgKGypG34JV54z7fuuVM+PUV
         arIA4POR0GETUCndJfF84kbrGja0SYkMvMu6SbQAWHcSz6PsfDJz4s1oGuvnpRwqkPJA
         8lhtOp65Y2MT7veGn/Y8bnvXWzIFVe0dB33J11tnwoaHqKWIjRjHvUay5ES73K/+FQ4k
         PnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331724; x=1784936524;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNk7g4pY92o6e2+1OUe9g8KgB5YklUhVrGTC39c/648=;
        b=PhaTRTOJrn8I//5eLZ4WUxljyCIQnNjyae77E9tR5OB+xQ3f3r1EcuO+CS884kpCqA
         q+TF86iLbavZGbBfDNXXYTTQu/OpK2QDDesB7c1TpUNdEch1rWIG6B3Czd22qAn572rq
         pHBhFpAPszo7v9hnUZQNqWhdKMwGopmKzUSxvvZTa/t2XMqpKof5mUqylzK+CFWg6gtO
         4V4LrNGfuNiRA0t8PYr2DmGKnOj0H2QWMGYSCqwIQySVGeSK1bknkPv2m7kBC6QFbuW3
         mZzsziBTDVHoTdqgf+Ns2TFenE+VR8nirHU6EQAq3vMjo22Z7rGI3CtAHyhU+N+Ry2Aw
         OzZg==
X-Forwarded-Encrypted: i=1; AHgh+RrUc58QwUChoU51nZw44POsCUt5TYCt3F71vE1QoQIIMXLYqApIZbKCYt/G46pt6h8r6IR8+1+3weg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbQ22B1sArMUMSEdVuhBU+5x3G477BLqetF/W9BpUOr1GoI3B
	kecoA3h97L1/7fbpSx/lDg00pMtMgtIAfXpuc/UrvWPZzcmbtIkTUcv7l0q+iMng9A7KyvSggo0
	Ms3B9EITnxBXZDZDOF37UtzxF7poxa2gltLzwJ3CEfuH9Fe0ACylzmrfCiM5W65Q=
X-Gm-Gg: AfdE7ckCGVHxtz0nI+HUbPIGOODtPxpX3wzhUb7PzWmY93drZMK/rveRjeRdSermi6P
	YW3K86NbR3o1G15b3iBsyUD/KGGOkCyrv8ViPkM+slIABuRLSrC9XeipD2JAWItKC21Wn16TL8J
	PBSnsuvMMGV8NQuDFCNgNcwsD/g6ld38W0onJcE4oy7F2QwUwOu0f9Pma61cwgWdMZ1fy4fPx5C
	5pcZboeTmIz4QE12C9i+QcBG/nnlg42SwGtqMcdJqrlN+9zEQ57+tGOYrdu2+4H/FylivBntyax
	cecDm7lS/MJWt17VIRUfra7ykEJr6PQk5EAFb8NeAs7/TD+68msmaYDWqIXcmXLs62U+l6xn5my
	dd2xdqFV+6JJT6uG4
X-Received: by 2002:a17:902:ccc9:b0:2ca:2073:3119 with SMTP id d9443c01a7336-2cf34994dccmr53378815ad.32.1784331723864;
        Fri, 17 Jul 2026 16:42:03 -0700 (PDT)
X-Received: by 2002:a17:902:ccc9:b0:2ca:2073:3119 with SMTP id d9443c01a7336-2cf34994dccmr53378495ad.32.1784331723381;
        Fri, 17 Jul 2026 16:42:03 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347554a2sm19070135ad.73.2026.07.17.16.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:42:03 -0700 (PDT)
Date: Sat, 18 Jul 2026 00:41:57 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Siratul Islam <siratul.islam@linux.dev>,
        Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
        Ciprian
 Hegbeli <ciprian.hegbeli@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260718004145.079c5262@jic23-huawei>
In-Reply-To: <gnkthebcxlpbwvbo774hap4mphqro4gxho4zemj6p3ixa2qp7g@ncb5o7tw5wf3>
References: <20260715063652.368501-1-stefan.popa@analog.com>
	<20260715063652.368501-3-stefan.popa@analog.com>
	<gnkthebcxlpbwvbo774hap4mphqro4gxho4zemj6p3ixa2qp7g@ncb5o7tw5wf3>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MyBTYWx0ZWRfX8tHUxctdabrE
 2RwstETGTIWQjkGuuBicSX49nofW/DMjIckrU9jZQKXBGLgWCOLOn2Rz9Qdm5n94dnJqFSlseHm
 1qjBJBW60d6uxaDwpuVb+20PDS4pfua26E0rgpEX6xSRRZT3tBoTqowHAtYRs/74gvgwymOdaRi
 5aLUrcm5eMbfoldRaES9hVAUU8jUCqGcrRCrcEV6CKjke/INQTpRro/ib97X/vBWmIbxcYKxlv6
 0MjuRYz1FfMBHxzVbmTb9MN2xwqo6n24hYm9wORmXQrh128OL6UCDjjCpam1nEx8oVPzzcbBkzR
 C5J1fRulN6UQixDstk+2C+6OAieNXEiFwPabV5likd+54kcWFN35t7OYDpMylpgAU3BTU5eOYyt
 eOH8Jd7DZQVBuUQzTukFI+bkmW5Sy9SDSYlK0fImv2iCU9eD+BpmaSHlds3qnUi8fztw2gsuZ5k
 jVHj/ofhMhD7xHKLkuQ==
X-Proofpoint-ORIG-GUID: y9gB9eILb0ru--BcuRGRvdhSzAFC-Vcr
X-Authority-Analysis: v=2.4 cv=U9Ciy+ru c=1 sm=1 tr=0 ts=6a5abdcc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=4aaiC0Uwtqp2U5VG_rAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: y9gB9eILb0ru--BcuRGRvdhSzAFC-Vcr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MyBTYWx0ZWRfXzfv90rwV1OI/
 w1JOGgr0gG4tyTk8vVVE9rdDhOuQtCfLryRl98V/kB3EwU+j8LSbyH74+gbexxEXcUvXZ6sehYX
 RzbsgAyjSdv8TcV+FFILLeKIHLcnN78=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170243

On Wed, 15 Jul 2026 16:23:11 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Stefan,
>=20
> Some comments from me
>=20
> On Wed, Jul 15, 2026 at 09:36:17AM +0300, Stefan Popa wrote:
> > The MAX40080 is a bidirectional current-sense amplifier with an
> > integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> > voltage across an external shunt resistor and the input bus voltage,
> > storing the results in an internal FIFO.
> >=20
> > No existing IIO driver covers this device or a register-compatible part.
> > The closest relatives target different silicon with incompatible regist=
er
> > maps and feature sets: max9611 is a unidirectional high-side sensor wit=
h a
> > die-temperature channel and MUX-selected gain and no FIFO/PEC, while
> > max34408 is an 8-bit multi-channel current monitor. The MAX40080 has a
> > device-specific register map with bidirectional 13-bit current, a 64-en=
try
> > FIFO, PEC, a single-measurement mode triggered by an SMBus Quick Comman=
d,
> > and two selectable input ranges, so it warrants its own driver.
> >=20
> > Add a direct-mode IIO driver exposing the current and voltage channels
> > with raw and scale attributes, a configurable oversampling (digital
> > averaging) ratio, and PEC-protected register access. The two selectable
> > current-sense ranges are exposed through scale/scale_available; the
> > current scale is derived from the shunt-resistor-micro-ohms device-tree
> > property.
> >=20
> > Link: https://www.analog.com/media/en/technical-documentation/data-shee=
ts/MAX40080.pdf
> >=20
> > Co-developed-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>

A couple of follow ups even though v4 is on list. =20

That should indicate clearly why you should slow down and let people
get to earlier versions.

Jonathan

> > diff --git a/drivers/iio/adc/max40080.c b/drivers/iio/adc/max40080.c
> > new file mode 100644
> > index 0000000000000..a0c1144cfda7c
> > --- /dev/null
> > +++ b/drivers/iio/adc/max40080.c
> > @@ -0,0 +1,630 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * MAX40080 Digital Current-Sense Amplifier driver
> > + *
> > + * Copyright 2026 Analog Devices, Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/math64.h>
> > +#include <linux/module.h> =20
>=20
> Typically I would say you're missing mod_devicetable.h but now we have:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
include/linux/device-id
>=20
> You might need to base your series on linux-next though.

I merged rc2 into the IIO togreg (and so testing as well) branches to resol=
ve
merge conflicts with that series.  Upshot is just don't bother
including mod_devicetable.h in any new code.  Also don't worry
about including any of the linux/device-id headers unless you don't
get them via i2c.h, spi.h etc

>=20
> > +#include <linux/mutex.h>
> > +#include <linux/pm.h>
> > +#include <linux/property.h>
> > +#include <linux/time.h>
> > +static int max40080_read_iv_once(struct max40080_state *st, u32 *iv)
> > +{
> > +	u8 buf[4];
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_i2c_block_data(st->client, MAX40080_REG_IV,
> > +					    sizeof(buf), buf); =20
>=20
> It's not clear to me that i2c will use safe buffer all the time (from a
> quick look). So I would say to make this DMA safe the usual way we do in
> IIO.

I2c always bounces unless you use specific dmasafe functions to indicate
that your particular buffer is DMA safe.

>=20
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret !=3D sizeof(buf))
> > +		return -EIO;
> > +
> > +	*iv =3D get_unaligned_le32(buf);
> > +
> > +	return 0;
> > +}
> > + =20
