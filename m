Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793559578;
	b=sv2AD30mzI81Zzmt+msChhM8dkSmIIfCvL6/UvPh7z5h6GtG7EVMDaiq2Zuwn7f0k9iH
	 5dUGFYMFq+YuaLo9xIV2P2A4LuPwAYeHt8HIv7IsBUUZ2GMkEJrdHj6wdGIl+98AkcNaD
	 RcocXx4XILUAVB71mmOTV8fq8BbkMSk3Go3YI4pQPIxa2P/awI1up5pz7Iv0ZKUS8hazt
	 tLGBlcDfEWYARTIG1ewWlgoKcEP/Yb1LaiUo6qQjKeeRZZqqpCOWdsizzeqmViO1nkuMj
	 8YCu0ifC74GDoyetehfBqL6oN6ibX+WCqgVxULLX5wo1bsmUKnwTTgoZI4pvV3fxjgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559578;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8kTeAGzekm/MJUppeDHNBzSirJscu8UDoZqPjNsLkRE=;
	b=YnTO3tVbGuCzozVtomYRukF+V87dfLh042P1PVdyMAyhAbrZehYY/6jRNOHlpT8Wf82j
	 K0JR+3m+S9n5KpN7ed5mHtczQunkCZbTwH5Z+pvDeUX08ULTDZ9KhxotU1zBz3hU1UnKT
	 2d/Elb3GPkIyCJGR2jfewTz3PsOGf6QXCAQcpBCn8X8iSmgIufnCOeSeWpCc1+YC8IoX2
	 r02b0/FcoVTSZMxwZvw+LThq2LUHRLUNqAsGPmUEgWJa1LSC/NnKlXo7mkqlAsGKg7CbI
	 h8M9IN19y0+8fSZeN0+nnoREhKj4BR6VLdrwhXA2KdioMIa7oZixPkrs6tCSxlXEq1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SAmfCABj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SeKfTpZm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3528606A327
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 18:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3528606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SAmfCABj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SeKfTpZm
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HSxdM1104587
	for <linux-iio@vger.kernel.org>; Sun, 1 Nov 2026 18:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8kTeAGzekm/MJUppeDHNBzSirJscu8UDoZqPjNsLkRE=; b=SAmfCABjNQFoKphV
	DZwIecNBfi8PYDTr3vAhvoLFxDFDTtK47A4iihTcrhvOU6RUlIb75niU40uP4kKL
	SewEiMx8hh738FzyxDQwMVK9APwWL+sF9oIzi7Ahnq5qZy7Da4roq7XvouEn/Ai2
	EWxVEfOoeWZP8uWUIrNvMGtcjSVS6P4tuwO4wMSLY5bnS8rhg7E6Ylgx98IK1nvm
	zK639rkoUhB3I2K1F4r+PDX18499zzInxgGH+/RQxNzvIrF6TvwaKF+Mw958ltcp
	SXYwROjk2AFhTvuj3kQcM/Z55LwVA8e/80B6HFJMdSWa2M76OgnQuTU+8QUdIUXO
	Dnt4lQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfv3kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 18:59:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb6391e89so469444485a.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 10:59:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793559575; cv=none;
        d=google.com; s=arc-20260327;
        b=r8Q8VPa/CcSEswVPJFs/rOpG21pMfDGUw6lIgzSBDKVyNTiXHQBEbMi9fsBbRl52jF
         wE/cJwcTABzela5PnZra4Z6LAsd2Y1nM+jqtYJHMHdPeOYVbs6w9mimji1GZNaebeg6N
         V9hpdAJw9zuNEdulJS470NEmiKLLgOakDDkerG60f+942B/Dp9TF0J8FuhjnesaKXDT/
         4+PGvX1rOEiV5/u+o2DZmGpkkxfFmQ7neasYHXGtDRE6/nKiJkSmIMX+UuBZWRXVDjaj
         J5v6G7L6Vrljuej3cdyhIqyCQSTN4isJNijyNmqhr35c6AUOF3HSgzRZwCYbVeuCyx+h
         q7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8kTeAGzekm/MJUppeDHNBzSirJscu8UDoZqPjNsLkRE=;
        fh=aT8Gl4tQgejmQdhqaQtg/b1F2DQMbMtPjY/gE28NcCo=;
        b=gr1PEBR9r87j+Da2y3mBizUmo5dtXpPRNwfHkRxZZvYoRlxxlwz02C4Y8NG6orVymx
         mdMtJvYrKolVttsXuy6wFSEfRnxD0GUR5R8jyEzGuXi2UFQBk9uDVFy3h0EcRwMZ1ZWs
         Orbvi7c977ci77UsXcsh9hBtT9BaJWZQ9t29kwwsXRymG5/kVr5Mfc5otT+UaUhIzYvs
         qnPPSPYlgWLg/Qm+4dDuR8DCZZmuUTjtXV+IcQ4aDhikkRr9aGLt6Arcs+Vqo2G5sDO/
         rgowr7IFSOV4eeVAFtzrMAVxeH1hd/Dk0gVBW2iOfX2szI61opBP983ng1zi1zE/Y0f3
         /IFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793559575; x=1794164375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8kTeAGzekm/MJUppeDHNBzSirJscu8UDoZqPjNsLkRE=;
        b=SeKfTpZmnD1EUY9d45HnJXozHdeS3MHwgJVNqo0+mfMtphR9H3dS5xC7G2yToLfrkk
         q6S49GXAvxmifL8AwYe5OM0yrnqErhZ5azVeVK3oMiUk2Vcoy5/HqpysLxbgGa4+Zb/r
         T4Fh52To1zPG0koVdcoIn9CUmSdut5wg9f6DTGio2g1SnUWvsYZSi/nC4F5or1IIXp8b
         GTh4Wqd4ZlakqqvuuagHqBqp7nHQux0g9i84Wc88cpwFYRqX4mW4ET0jzbotN/EYDJ5w
         YYsOOoqhVhU55myn30IRmnAZBZx6SoiRIw/eb80lNNk+1Cup3D6YPYOtKhFQGYZbndcH
         e+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559575; x=1794164375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kTeAGzekm/MJUppeDHNBzSirJscu8UDoZqPjNsLkRE=;
        b=KfFdS3hj92lnw7F29j8nWTqxNTPzeAMIgIje6rdQjRez0ypZtqyWb6eE77oQ1tw34m
         7G1YSSj9vEbQE73OiXLByg87GSoIICKTVmk74i4LW5JVkSxCGXukxU03gjVPgnH5KeQC
         jwCg88y+EqhU4D2Ggz2bN+FLl+KANVMkg37ir9PSz3xT5vyOv722UwgiGlGVFlnbkSYg
         U0rLL5KQ7pcJJ/GzZ53HngQ7OtZ+z2l07BbxF6G3G2rwdK3340RREOsjbmtedDE/av7N
         tJD4fALdV3y/7F/FAeZL2UmoSeOh3G3ErwHs2C8cx3CMFPy7+69xLQFm1XYtuyVQvmlj
         6qaA==
X-Forwarded-Encrypted: i=1; AKwUvBzXcmEF/KyAkTU69qFmAp9rBH9W0/TQMmE/d9AOEFdJO6dcKlY2PMGvCQLg0IPXdfkX1PnRFmBfZmY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWr7o8hXnJWEFV8b9dRZWzu+WZ24/lHrgzfivkXaNcz6n9jFv3
	HlviQ8Dc5zqgtLDgB2NABWEL15yf6QftTANApiDp21bM5i3QumzxeLHnVWwMQofEom8uzn/MtS3
	U/DoQ47br6YbWV+xYPODvuaQwuI6Rw9WPBneo093YoVyRXzFCjWFfnie5plZZJaeX7I8tZ9tISB
	QuRzihx2vz2U+XOsqJa7QKPy/Il0pVZutthftYZg==
X-Gm-Gg: AYBFou1DgWIcqteqPYkBbFNh6f1gV21mfpnqrUalHW9F3zLI5TwI/0Ka8F0jjlXLjeg
	9ROBWQZ37CcP1ct4mLhSQlK9z//jsM9jmvv3Z+KYsEheWOAb5lUZH7Pv4ZEClTxLCjUbQSEEn+F
	NnMD3+5vosP3pR81RVEwcudqc0i4W005304+bX3bmOkO+voC3rBYZEi3GVYFdKf5AsLco5inMGX
	XowhaCYd81eMmyo5MpQ7h+G3ZsrLi9hhzuAUSMiww97gVV0rTaNUMJVpBV296rkxLiflRTWTjLp
	DmBu29CTVSPBgVP16Y5qSBDISp4s
X-Received: by 2002:a05:620a:808d:b0:93e:e531:b78d with SMTP id af79cd13be357-944214cb80amr1355910485a.7.1793559574779;
        Sun, 01 Nov 2026 10:59:34 -0800 (PST)
X-Received: by 2002:a05:620a:808d:b0:93e:e531:b78d with SMTP id
 af79cd13be357-944214cb80amr1355909085a.7.1793559574364; Sun, 01 Nov 2026
 10:59:34 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101030902.1387122-1-shengchao.guo@oss.qualcomm.com> <20261101173256.5ad42925@jic23-hlaptop>
In-Reply-To: <20261101173256.5ad42925@jic23-hlaptop>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 19:59:23 +0100
X-Gm-Features: AclHuK_y-XxcZzWJ7IkifUD6NDu71IxST9CH5U17suAkwJv0PiDsP7l0eUD4YmM
Message-ID: <CAFEp6-27XLrb56XpnnSLxkRXzQzugvXPzsDt_OshR5EmhC8Kzw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Reuse IIO device ID for
 ADC_TM aux device
To: Jonathan Cameron <jic23@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX6DAu4jwd1LNa
 /1jxcbFJ7h61jSypJ5FW7gZezAAhXZ0H8mAjvuytCBGQ/P5w2E1VayOM+T4x7u66bPQqruaG8n/
 iKbnkYcIz27nakgjKnhWPNYV0ecLekY=
X-Proofpoint-GUID: 306eT0lwmciKF7dp_LI5d1rZwn9itY-2
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae78c17 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=hw_--xrD18hxE5MXGX4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 306eT0lwmciKF7dp_LI5d1rZwn9itY-2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX0EUhJ5lq4kvU
 UmdRs4KTxoq/3bUt137i36sF60S2TB6JpAGZtBFWbHoKKDVJxrIweXZlYQUhabP9pxav1LYSXBX
 K3xhye86cs9FXp2Cs+FElyYUR0wpkGh5xmVoY92AM+QpzxxH84Z5jN2tWyFdBWHoWipUnST6EFw
 NPm1WUe6fQX5Xa53Ke8iFJflW2PLA3cVhtVVKVE1T+vRKcsEbk+i4Zns7dpARNX4xxgnIp/xxNC
 qut05LRCwRFyDZRnRhNc0zTPYrM+cDbGUCfYRZrjGLDHBLDEP51gOTVYsbIZ/bqyVOrFBZgB898
 AEFInUoO9O5nYQ/5YyPUSrbaItJn6eQC+b4ns+zLrOCUXzD2x6wQANy1Y3IoqtV6BrFSDWNvbtv
 gOqjxMR213PmUqOiqxS00Y3hbWgvRMEf7y619h+QLa3Z/1hnsf1B0uea6VNsFTjMPtnAW9ESFKb
 e/VfxYP/yDxVOfT0eyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010075

Hi Jonathan,

On Sun, Nov 1, 2026 at 6:33=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun,  1 Nov 2026 11:09:02 +0800
> Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:
>
> > From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >
> > adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
> > every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
> > to register the same device name. With ADC_TM channels on more than
> > one PMIC, the second instance to probe fails:
> >
> >   sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_=
spmi_adc5_gen3.adc5_tm_gen3.0'
> >   ...
> >   auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device=
 failed!: -17
> >   qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Fail=
ed to add auxiliary TM device
> >
> > The ADC probe then fails as a whole, so that PMIC loses both its IIO
> > channels and its thermal zones. This shows up on Nord, which has
> > thermistor channels on two PMAU0102 PMICs.
> >
> > Each ADC instance already has a unique IIO device ID. Use it as the
> > auxiliary device id instead of allocating one from a separate driver-wi=
de
> > IDA, which removes the custom ID allocation and release handling. The
> > ADC_TM driver matches on the device name only, so the instance number
> > does not affect binding.
> >
> > Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
>
> Applied.  Given the slightly odd nature of this series, Loic can you conf=
irm
> you are fine with having the authorship + Sign off.   Given alternative
> would have been Shawn having that and Shawn sent this, the attribution
> seems fine to me - but best to check!

Yes I'm fine with this, thanks for the squash Shawn!

Regards,
Loic

>
> Thanks,
>
> Jonathan
>
> > ---
> > This is the squashed version as requsted by Jonathan at:
> > https://lore.kernel.org/all/20261101020047.66034613@jic23-hlaptop/
> >
> >  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qc=
om-spmi-adc5-gen3.c
> > index c68c6c5f6aca..a23eb5c9096d 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > @@ -610,7 +610,7 @@ static void adc5_gen3_delete_aux(void *data)
> >
> >  static void adc5_gen3_aux_device_release(struct device *dev) {}
> >
> > -static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> > +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
> >  {
> >       struct tm5_aux_dev_wrapper *aux_device;
> >       int i, ret, i_tm =3D 0;
> > @@ -620,6 +620,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_=
chip *adc)
> >               return -ENOMEM;
> >
> >       aux_device->aux_dev.name =3D "adc5_tm_gen3";
> > +     aux_device->aux_dev.id =3D id;
> >       aux_device->aux_dev.dev.parent =3D adc->dev;
> >       aux_device->aux_dev.dev.release =3D adc5_gen3_aux_device_release;
> >
> > @@ -799,7 +800,7 @@ static int adc5_gen3_probe(struct platform_device *=
pdev)
> >               return ret;
> >
> >       if (adc->n_tm_channels > 0) {
> > -             ret =3D adc5_gen3_add_aux_tm_device(adc);
> > +             ret =3D adc5_gen3_add_aux_tm_device(adc, iio_device_id(in=
dio_dev));
> >               if (ret)
> >                       dev_err_probe(dev, ret,
> >                                     "Failed to add auxiliary TM device\=
n");
>
