Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1C189F43
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077017; cv=none; b=fl7eQjwT5H8nB8up+38zLMCaToSW8DR41d+eHePfxq2gi26P61MAl29BaNOGk39+dZuy553AiUc2UsGgrUyQk+U1TZN2/g6n4FJ/NH5yAa7A0Jvj5WSjz5xtcBDnIE6ElWAU9PxFAfLmw2e27GEeortmMuWGNdX4xH6leRJ9t4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077017; c=relaxed/simple;
	bh=mrFYyVQ0KBWMb4CPv5kKuc6l3WHZmVhCNBe1hGaVu2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLwnjM0oswGvnEqKIegDPnPWwahENxYhGkrugzRXbb8VbAxdsA3L1K0dEHREgRt3W/TgzoTOUyh7gKBnCa66gUHfyuOF9DgjkY0QGbaujATtX13pEvQdUr80RD5xx8Cs3BaHBW1BSgr8pfsBUDe7EFOOgC4nC+3uIw8YmXjggMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hx2Qu0NQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eOpGNdJL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hx2Qu0NQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eOpGNdJL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F0I66a2098575
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DuGYd+nbcS+7wxsqHNc6Na2GrKd6Tt0ThlI3iCDj1V0=; b=hx2Qu0NQQIdIes2z
	5EePa+h7cEDwcR87mO5c2BnhohGJI3uMDUrdtOtXAky378zItWoM7f1+CcxMzrTx
	3ruWDX0cfuTDG4TDgPkteGpJ3aTzxzDtc8zRYSxe35oypRBO1phT5bT/ehBushc/
	9J/vQE6l7M/FHxN6UR61hIqS3vT3IlhLRR250iOqQd0gqBhogfHCiIiV3tSTpimw
	scomkXcGUkv87YfF+Oel3dn2pb6RBUWIyszFmJNM/hSCnrJy36GTs20KA4Wh/4Ao
	L0XsvXTqwGm51xh5bBhryQMD4o7MGXIrXB5RN9q7e4w8UMFYiDux49D2oODOloMo
	IzU6/g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9ksbyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:56:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2caa9a3cf7aso1789195ad.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 17:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784077010; x=1784681810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DuGYd+nbcS+7wxsqHNc6Na2GrKd6Tt0ThlI3iCDj1V0=;
        b=eOpGNdJLV46Ozw6ROK3biIrclfZ4cTOe1qy1dIuWVcbR0weuHZlRiEgaQ+0Hxz0L/M
         AVPv2vcejujVNOW+h97M+629ZAfbXDYxq1DdaxRXVHrvBC0MHfg6K0Hgo3GfpS3pN9Mf
         FXUKPVdIwrOR5Y8IOxqixHurCBEiTklf28q8rCEcrYPdwzFUf7gURvUikuFUi8UFIKIV
         L5vYgVafSWaDeBHpSro1BW+F0ScjFZPnI51H9Z59w8DoSpEFxQTJ/4cbpKMTvssZy1/J
         qHZDBSEGs6OGMcF9++I01K/nCsLiw7p9t0AAggcAzseaf0yspxZ/zce3RWKymKptDx4n
         Gmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784077010; x=1784681810;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DuGYd+nbcS+7wxsqHNc6Na2GrKd6Tt0ThlI3iCDj1V0=;
        b=k4Ak2/pxZdoT1vo+FYct3ftFJ0itcRvRIra8KCE+oUE9CB/9LOUk64xBOUyUN+JlxH
         pPlzIHFpkarMTCueQ6/XQuEcUi1lvFZR0oZ9gUQgYaBhAo1eguSFUOgMEXe0HhRy31RP
         ywUTVL7MiUX/lTTx2Z96Y7sizZRHJJRur6QgZPZbyxipccogGqRA+oTTAM+zSRojmpZF
         4Yx9hioEikyy7/GdtIqgiMLGz1jPcfYYV0ETQ1ZlHg6txvcYQrYovlFJz9vDSmXijSSy
         rcldTn9RPSkGwsvhPYrXRIpVjDLRjFzsylzCF6hV+bj6buZmjCSsB1JgHsDrdj0IGnxg
         qMKg==
X-Forwarded-Encrypted: i=1; AHgh+RqWD2++pFGj4zDlQkKlSKzcjY6uJMOBC1hsft5L5UO5PTBz0/DVh3YxBLF3MQr9Zbj0SbLcgtnKNIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS18l9tA0dHlRQ/fMt3o6mdxPB2Brrg8jf28F2VLn5BTDB4BS/
	joXL2InSeig7Jz+o7Oz0U8l2O33Z9dFDm9SGDoNuAGxj5k5/PNab8nvHhQdJvQQ21VgAPwnuhhr
	Pzhmo91WX/yQ43e1kAnh1WOUIfdhztBNRRWI/aYWi4EpYiuhPGjJEePmmhzEZg60=
X-Gm-Gg: AfdE7cmRilbU2gS7A3i7UTe7lsLKZI7ZKEL85VoRyHkGdPX4PPneQfEezNMRdLCREuT
	MPUz1cbsyCCYZGXLVe2IqRQoFgs8UEfEtaEJFxDl2M1Z2zg3AK7qfNEVovZvZ5aCl945wPgKzzB
	ks4VvFjLpGCPpgMMyTJNz6r/pWloR6xFSvumjq2adLmX7iA8jnN0D8hQJGh4CXGjP4MM+nE2rbh
	4z234+4fgqdicqPcbtFAEyWcCd3QwTxGgJ43r00qrWhtIzxRHvJ/5q6x7qUIRT6vCieW8CHKPXP
	+bALyV8abVn3liOr2oQIwSz2NZyhlCB2uFraPgh/oKVELeA9utppib2rQBCdiZVnU73KGsBJRup
	jrb4W5TBQgAneCndpqLEIqO5Vt0+swmae0dLt
X-Received: by 2002:a05:6a20:d489:b0:3bd:1cfc:1b9b with SMTP id adf61e73a8af0-3c0f08f8997mr25125524637.10.1784077010208;
        Tue, 14 Jul 2026 17:56:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:d489:b0:3bd:1cfc:1b9b with SMTP id adf61e73a8af0-3c0f08f8997mr25125498637.10.1784077009752;
        Tue, 14 Jul 2026 17:56:49 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm77197449eec.9.2026.07.14.17.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:56:49 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:56:45 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jakub =?UTF-8?Q?Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dlechner@baylibre.com,
        duje@dujemihanovic.xyz, jishnu.prakash@oss.qualcomm.com,
        jorge.marques@analog.com, joshua.crofts1@gmail.com, krzk+dt@kernel.org,
        linusw@kernel.org, marcelo.schmitt@analog.com,
        mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
        robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v6 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <20260714175645.00003812@oss.qualcomm.com>
In-Reply-To: <CA+gq5JjOV2J87Ycm6bjpa1o=+eKELt6FZBk_KSdEt1zLiQs4MQ@mail.gmail.com>
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
	<20260711184414.1013686-2-jakubszczudlo40@gmail.com>
	<20260713022040.146555b6@jic23-huawei>
	<CA+gq5JjOV2J87Ycm6bjpa1o=+eKELt6FZBk_KSdEt1zLiQs4MQ@mail.gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a56dad3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=WLc210Dr34ffwojkXyYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: t15gWhU7agw1z9rAe4BX0l9ThvhfSKSn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAwNSBTYWx0ZWRfX6px24sXraDQ1
 5fP8ZCtWT6By51WISDy5okBwfQFf3BLqmfIjRMAu2vQaHRwdM0dxOD0Hs/gUMGb0H8+/C0isYmB
 7mLHMm/JprELNYsLj7LujG6P4TXualU=
X-Proofpoint-GUID: t15gWhU7agw1z9rAe4BX0l9ThvhfSKSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAwNSBTYWx0ZWRfXxplCrbyU72ej
 wuZVegpjmpQcfFGQIpgqyvicjZGyxHyBeg3pvwtL2gi8MPljdOeus6pjdIl1/WnZxnEzxu+dccz
 jD1OBnXwl6vOEN4b3amg9WbjPod5AoXmfs93p6OT3foUJuDgbr79pAN/W7dYRbUkqn7bZiwNtZF
 ecqFZN5iT0RQuafA6I2c6eqdpA+xQGyrDc1OYEBos2TRfnZnBnhzfZtwJ16zvoob+Vr0PGp10Ug
 DgYQiUikT0Sl8LqIlUtH5sc+DH4vNu1ArsBdtL6QV4NrCEJ0hud9r+ZS6SBaDNWdRpMhv1CbD2w
 LxNfsv2l1J21ap9QQj+sgPEDx9bU2xr19Ovs0g5DAyq7c5QTtLpoESru5sEsSotsLAGADCNWQsv
 /JsX6WruNSO1XxcMilb65ClaEp9k2XXcXSe48Tc/5JaWgPyRCRMoCd2Pijy7mmiE4cBeCffbrNV
 vVpz4yjMVK1Z6A1Y1ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150005

On Mon, 13 Jul 2026 12:53:49 +0200
Jakub Szczud=C5=82o <jakubszczudlo40@gmail.com> wrote:

> > > +     ret =3D i2c_master_recv(data->client, (char *)&buffer, sizeof(b=
uffer)); =20
> >
> > In theory this can return short (generally reflects a misbehaving devic=
e).
> > =20
> > > +     if (ret < 0) {
> > > +             dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> > > +             return true;
> > > +     } =20
> >
> >         if (ret < sizeof(buffer))
> >                 return -EIO;
> > =20
> I have checked the source code for i2c_master_recv and it should
> return sizeof(buffer)
> or errno code. Also David and Andy in v4 told me to delete such check.

Fair point on it not being needed.  Gah, I get my i2c functions confused.
Only the multi transfer ones can return partial success.

> > > +
> > > +     return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> > > +}
> > > +
> > > +static int ads1100_poll_data_ready(struct ads1100_data *data)
> > > +{
> > > +     int data_rate_Hz =3D ads1100_data_rate[FIELD_GET(ADS1100_DR_MAS=
K, data->config)];
> > > +     /* To be sure we wait 5 times more than data rate */
> > > +     unsigned long wait_time_us =3D DIV_ROUND_CLOSEST(USEC_PER_SEC, =
5 * data_rate_Hz);
> > > +     bool data_ready;
> > > +     u8 buffer[3];
> > > +     int ret;
> > > +
> > > +     /* To be sure that polled value will have value after config ch=
ange */
> > > +     ret =3D i2c_master_recv(data->client, (char *)&buffer, sizeof(b=
uffer));
> > > +     if (ret < 0) {
> > > +             dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> > > +             return ret;
> > > +     } =20
> >         if (ret < sizeof(buffer))
> >                 reutrn -EIO; =20
> > > +
> > > +     return readx_poll_timeout(ads1100_new_data_not_ready, data,
> > > +                              data_ready, data_ready !=3D 0, =20
> >
> > Kind of related to David's question: sashiko doesn't like this.
> > https://sashiko.dev/#/patchset/20260711184414.1013686-1-jakubszczudlo40=
%40gmail.com
> > I think I agree with it.  Generally need to check for errors in the pol=
ling
> > routing as well and return those if seen (in data_ready I think at the =
end?)
> > =20
> > > +                              wait_time_us, ADS1100_MAX_DRDY_TIMEOUT=
_US);
> > > +} =20
> > =20
> sure I will update the function to return int instead of bool and
> check for errors
>=20
>=20

