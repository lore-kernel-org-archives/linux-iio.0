Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619417BB21
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784495693; cv=none; b=nnehzJQ0H3PwG9Gt7/bZt60nDktzoeH1xATlR7WJFynHBeoF7MzDpUfPc7K/gynKDALYtk/Oi95kYUmMOM17jnO2nQWeQbooOZyuEInEtuWSO5hHfVc8SoffArONcdrRJzQHAE47UNKoFVjZmSO8B/4LWXldJ52FDAZ3UNku2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784495693; c=relaxed/simple;
	bh=U9HvmCvpRC0PdwshPiDg79v4iyuivDBJ/X8yCQTdP7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4giP/f7vaHIYTtMaxaxQWKNmPU0v+/URY6qa9V5tZXzn1PPEkAyoQRtfXBGWhPohwLlUkLXqwHOm4hulzx4GMLroP+tCbTJU/JI0VG05uHopCT5VfoxzZ00OCRUpcw4zsSoxwKgQm757D2j9MJenBvPykkhbFbyb8R1WIeBjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qjv0Wcr9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+t/qPuM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qjv0Wcr9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+t/qPuM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKQpVf1488164
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XZzuuSEDGCp+fKgbeKtpBXb0/PZytFwOg+5d3PdkXUY=; b=Qjv0Wcr9e/ofF0/G
	5/mXsAOTZmv5MlHp/tWlEgPtErd/wIxyaOC8+pIkToOQ0ebrbpqmpDLORbR/ZGCx
	QMTt7NUps9DF/K7hPajZIRIfPTAo0EHwhviU4IsJXhqQgA7WngmwlSKoIxM2UlK4
	grqyGc/gPhfNgEOtQIoOsN0a1GkGj5pxGesUxczj+vB5B/AQzG02OPjpKDMwg+d3
	c0W9UMvVlNzXDKesFpqV8b26kx1wPPIq/GHtUQjJiH2dQlFPbWYhayFl6XshjViA
	PNZRAwrwHQqJ6FB080c/Xzc7D+Q3yFbIlnXVSONLrPt6Xl/S2Eifi9cfVOy7yAo7
	o5plbA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aauf7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:14:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85798977dcso11133954a12.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784495691; x=1785100491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XZzuuSEDGCp+fKgbeKtpBXb0/PZytFwOg+5d3PdkXUY=;
        b=f+t/qPuMFNCHuXvOE+7Jt940nfKpJvLvoYQ5fL7arNZbPwZ5dg4bHvDftu/rQyoZHJ
         adypZkLMYj4XvaW4ffSRP7IWwS3SJ0gq9B0GBOrCug3FnzpLPzCJfUdPfWGeiAchVev/
         m82rEkKAjuZbOeSjusL6PHYvkpBDmW6cKNyD+o2Zdu7Bgk/AheaAQf8d8YhxQXfygieV
         ZXB5K2wIDYk09aVzGU7sGBVfXDWmNbfPv2NEtxBlDByNNILoel/IBSoZI9fyhJUT8m7a
         /coGNddDnGamGA0PjWo5xCpYDZyvgCg/8+n+no/+qdJrkUDUortSprd3mFg/+SaO9CAj
         IDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784495691; x=1785100491;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZzuuSEDGCp+fKgbeKtpBXb0/PZytFwOg+5d3PdkXUY=;
        b=kRMov4WIBnRCimuH900Uqsyl7sAt7bQf7ECjfX+96IJeoAsYP7D+vD2/aGCORxcoQ1
         xdwsMfQerLcNCYSqfY8WHe84WtybUA4m89xH4j+kz/SFpAPpDRShBivR37eE49C2Wxb7
         20k0lY4vbQWNcOy6QWt8freOg1LEieAI77kPqn+1CrgLg+jidePXqlhjqDO/A7o0pNG5
         u6l7wuOGt8db/vId0URm0x2wJNdjEjAKdYM0W4ZCJfzjTeT1R/1tDPxh3gQXF8FEqzfu
         0WFpYJidYpYS+9zNlRBBljnElBvi1efI0Fk1uIc5W9NCTpSyAMoKkLIrXIAWQc2HmIQ9
         bGPA==
X-Forwarded-Encrypted: i=1; AHgh+RphqgtvyD3z8y4KjXB8qWubLFsBsB3ug2i0Tk/k14cNtICqIMTPHkX59M8CSwoKHsPMMHBFTdz75bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3ue71PyJN/0X9tMUsjJXR53R7EB6d7bVMhmFJBW1faBgG+by
	fRnZUsxLkCmzsPK6hB0UDrb152qLh8QS5eluSjI8SyeizPlJjEvPKbRUXa+Yw7YEny1rFZxD3yu
	ZYLo6TPc1yYfzB7JWjhum+1udvPQCQHOi1wM2j0Dxx07adSEDjOwaYhGZ/vriiv0=
X-Gm-Gg: AfdE7ckiDGk7u8ZhUkLB8FyJlw8lwxTQ6qVyYfQ2toPEFevF2oOu34uqjKEBRxuJAbz
	3NdZoGfgA007F6Q3YlVdKjax3XV53bIfIMQmSuAW+KLqatnKQ1O5QAYEtk7zyHDvl+dZz9xrf2i
	k+Y8JsvNC7dAQMSQOcoaPQN5yVJNooYiCOhFiTh2gqcgPHkrg8Cm/a/FjP7rFMLBPtG7ndvtqfl
	sO7X07bvxo5Ranij9u8OeFCVuJR48XSCIpv2FSXcuovFrit/g02Ikd/juiRsYl2njRyeJ6+aYBS
	G28tS+T7NbKmHCqFG4XZhvCX2tkCxEe7he7yI9BPpYc3+683Lil8VMSRgQY3uZ/IMEpVZtpldfw
	FfNXz2n3f8pvihXQ8
X-Received: by 2002:a05:6a21:7a45:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3c3ad66b702mr14057732637.21.1784495690672;
        Sun, 19 Jul 2026 14:14:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a45:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3c3ad66b702mr14057709637.21.1784495690247;
        Sun, 19 Jul 2026 14:14:50 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb51a2c1b0dsm3440525a12.30.2026.07.19.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 14:14:49 -0700 (PDT)
Date: Sun, 19 Jul 2026 22:14:46 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rupert Zoone <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Kai-Heng Feng
 <kai.heng.feng@canonical.com>,
        David Lechner <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH] iio: pressure: dps310: fix NULL pointer dereference on
 ACPI probe
Message-ID: <20260719221343.2a797351@jic23-huawei>
In-Reply-To: <CABpb+S4sg=HtYRAKOBcx+rH+1LnNbxqvfsxRuW=_kShGc4d6Og@mail.gmail.com>
References: <20260719000752.75936-1-zoone.rupert@gmail.com>
	<alyTjkq2bCuTE3OO@ashevche-desk.local>
	<CABpb+S4sg=HtYRAKOBcx+rH+1LnNbxqvfsxRuW=_kShGc4d6Og@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: GiUA6SBbXyHCnG7bvFVAAEo0imnr958d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDIzNyBTYWx0ZWRfXxgO6IDNqhyf2
 G4ijUbgN2VKhQyYGfqFbaMIQYkJIEcTicwsESNCDqeUkF3luH6FIdThAwpEEZc2assX7e6EUVwb
 dCXaFVAGSO3lFD9zBti/49VZYTRKyT8=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5d3e4b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=Qx8pq7cJZwYMmCun04IA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: GiUA6SBbXyHCnG7bvFVAAEo0imnr958d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDIzNyBTYWx0ZWRfXzJf0GsoJuqLo
 mzMwYE5VnOkY+LlXUz/EJW0d9BtxYZmMhYK9Zem65+hlGky4DWcRxDyN5dNPEo3ACQw/y0XE3mm
 YO50hQbCvwMkno6LKP7nFQVuknETpMFa9UW/eN0bmrrAbuL7ofNXBAkmHQPmuXF2msuEdPvHSJd
 H9rf73zxHQjcBTuaigbp57T+d8UkK4quPikeKGDiUwjPQHyb025oWABI1JJqCpxqdrKCymT3Igk
 drcsGUOz3qQ+tYUpWnRcy1PPUqJ3CNwHgyZNCa26V7AvkM45DtCAZbiMWRbiaj+hcdrSrMKdAC2
 AERfuGTJEvC3no6ojijpqnrLTeRH+1JI7aDeRP3njXchfnXcbZWuE6hUS2Q15hxBBcEP7WnyIYw
 Df6aWmzoMM+eCLXUptH4MHhwifKb02U+zQ4cwrdjKu7oPANi3xErUS/UtWIVkm9RvRDVto8mPOu
 Qi3Z3xYckQKryWFBXfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190237

On Sun, 19 Jul 2026 15:16:02 +0300
Rupert Zoone <zoone.rupert@gmail.com> wrote:

>   On Sun, Jul 19, 2026 at 12:06 PM +0300, Andy Shevchenko wrote:
>   > As a quick fix this patch is okay, the proper one is to go with chip_=
info
>   > structure in the driver_data. where the name will be defined. =20

For this particular driver I'd not do that as it only supports one device.
Can leave bringing a chip_info structure in until someone sends support for
a second one.

>=20
>   Thanks for the review. I'd like to keep this one as the minimal fix so =
it
>   backports cleanly (it's Cc: stable). The chip_info/driver_data rework i=
s a
>   good idea, but I'll do it as follow-up on top rather than fold it into =
the
>   stable fix.
>=20
>   > On top of that mutex_init() should be devm_mutex_init(), which is a f=
ix,
>   > and some cleanups:
>   > - unused i2c_set_clientdata(); may be dropped
>   > - C99 initialisers in ACPI ID table
>   > - IWYU principle for the header inclusions
>   > - some unneeded GENMASK()s due to use of sign_extend32()
>   > - perhaps converting to use get_unaligned_xx() where it makes sense
>   > - use time multipliers in _read_poll_timeout()
>   > - use fsleep() and time multipliers instead of usleep_range()
>   > - get rid of min_t(); perhaps replace with clamp() or min()
>   > - use SI multipliers from units.h =20
>=20
>   Agreed on all of these, including the devm_mutex_init() change. I'll se=
nd
>   them as a separate cleanup series once this fix and the triggered-buffer
>   patch are in, so each change stays easy to review on its own.
Excellent.  I've applied this one to the fixes-togreg branch of iio.git

Thanks,

Jonathan

>=20
>   Thanks,
>   Rupesh
>=20
> On Sun, Jul 19, 2026 at 12:06=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Sun, Jul 19, 2026 at 03:07:52AM +0300, Rupesh Majhi wrote: =20
> > > When the device is enumerated through its ACPI HID (IFX3100),
> > > i2c_client_get_device_id() returns NULL: the ACPI-derived client name
> > > does not match the driver's i2c_device_id table. dps310_probe() then
> > > dereferences that NULL pointer in "iio->name =3D id->name" and crashe=
s the
> > > kernel during probe.
> > >
> > > The IIO device name is always "dps310", so set it directly and drop t=
he
> > > now-unused device-id lookup. =20
> >
> > ...
> >
> > As a quick fix this patch is okay, the proper one is to go with chip_in=
fo
> > structure in the driver_data. where the name will be defined.
> >
> > On top of that mutex_init() should be devm_mutex_init(), which is a fix,
> > and some cleanups:
> > - unused i2c_set_clientdata(); may be dropped
> > - C99 initialisers in ACPI ID table
> > - IWYU principle for the header inclusions
> > - some unneeded GENMASK()s due to use of sign_extend32()
> > - perhaps converting to use get_unaligned_xx() where it makes sense
> > - use time multipliers in _read_poll_timeout()
> > - use fsleep() and time multipliers instead of usleep_range()
> > - get rid of min_t(); perhaps replace with clamp() or min()
> > - use SI multipliers from units.h
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20

