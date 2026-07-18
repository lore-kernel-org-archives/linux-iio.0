Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F351D86FF
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335501; cv=none; b=P+4iaZ9A1NLPfs1LiGjRW/7ovE8rGFqF72OW9duT8xhh75HMxpqxFmJZlLITTSQD098kgZ8AjPgVPkqNLDijSeO5vkFjFp93C6UAGfP9ZmulYplm2uquSNIaBrondn+Sk+F7urQmlxMBai9dbq/TTLdEASW0iiBTFYKlZOiF6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335501; c=relaxed/simple;
	bh=3NBFm3m6zjH9qz3Oq4HdZYo7fDvWg0k2tACnV2jow/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRxJ/IEKbguUTDk8qY8k56OqjPlI4Y177gPddAZPLxoBFuUu7KSyZhivGa9BnI6gijhu7UIcWlvc6R5ujhIVJbbUW4WmGDWYDJnc3jRfUsEL3Vg/e8Xqc/EyuRme8E2fRLxbvOwE622o7r67CMHCvwcd8SDDg2aTgSNWH5RtUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ffNBcacQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TFLF6g+9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffNBcacQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TFLF6g+9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66I0goY1321104
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l6i+TpyQ6fwm9znPT8SUwvybU3D+kAHhR84u4vyUBKg=; b=ffNBcacQtcK5M3Fv
	SKfG5PfgU8U6jHmaswaxWVxLBSLTBdDH2AiwRbzygwi15ns3Nf+G93mnUBWD4RtA
	vjj57zoy1xt1QjgvM/MKfpiWGYgs3su5uJwlQUCm/6vLGIIwKzNzlwRQ2WSrRW2h
	uJ0lGNftULwWtVBhxS1lF/JqfYcRDKE4xodBa30p97G+tD3bRn50sSUjDRzmF13k
	BNFOdx8Q1tyk4xnggu5Zrki86pnWogRjFjN53gjgKpgjBpLKYVPyKgujF4TZn1BO
	Aez6E/WR1+VP9DvUk0pzd7IOnMxpSKxykhwefcfxfsmpuScb9vNasgKgETJ6Plmx
	PVFN6Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffy6f0067-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:44:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88ab059052so2521101a12.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784335499; x=1784940299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l6i+TpyQ6fwm9znPT8SUwvybU3D+kAHhR84u4vyUBKg=;
        b=TFLF6g+9LgpT1xD1Ebdk8NAD4E91rvKlKqRGj43uouGZtlvPddwneUxcKarHQzVTNN
         bnUQl4JNjgL+vA8kUVQPjZSUy+sVThpRvnKk2vhc4MVujXC2qpzKINrcJoIxE6DlfUD4
         5+ARTxjfpQJWiYWwySidWkCZu2alELXoXgPf70z3vU0C+F79Hvbkv6Kboeh6C9Me4n3q
         V6EV2afXenD4ex/qd9w3JjpUfhgc99bmoXHrCcpZeYjddYoiyD9ith7FWl5rqB7BDjs7
         pfO9e/cHpwAzpqPvFrCV+2BXb715LezshNwmgfZ4QQQgBK5Qm2UQzmlNt9F5pWr2LID1
         6RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784335499; x=1784940299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6i+TpyQ6fwm9znPT8SUwvybU3D+kAHhR84u4vyUBKg=;
        b=gfmOoUnd6f5UOnJ59raENtOLkGxHouX5elwg5gbcRUuAOSyhvcOWgs/KBJJ+nj5oYB
         w5IJtnZtUP505WOboFvoPsQbAEZo/newUEiz4cTJAp5HLxy0AmwmimIDfNmDVbEcGem9
         GiW3RrTv8izlYV2S7/EXHSAvCg5l/TllLhi+eIWDQsxATClJL6xV+wrDFfUFrltsceYT
         YvdxvU5UalZ6tWlPS3LqPyNVv97JwuGC8+Z68Cqu3v0i6VsAmg46WJ12SosnBY3m2AL3
         nSSWRj49JBP4FYzRAOV45z7RJ7hs7j2Afai4WgP3XKLClDQFI5azDY4DBk934oY1aW1t
         KbxQ==
X-Gm-Message-State: AOJu0Yx/Ls/fiPWm64K+JlSa6DeU6vwFYC8K2kBHvudpQVaU6PiTLMfA
	G2TkLsHG/cxQ4bWDN1rTetM3e7noepQkAjwCyWu1sWkZSrvUF9cdz01TO4Oy2sPwpj9eqgdO9GB
	9b68i/1Bi6ZMih/OeA0YSR+MUYrojDRrizfLa/rlO74BVY67QaEuDLP3mJsLUWP8=
X-Gm-Gg: AfdE7cmpYlYYJSZnVTNMMFlecBSwTeZsLRZ2wFggXtgnKja5zfCnQvgFpim51Ej+tAD
	xYoQZAn+Yp3OXDKd+t/x8pHOg2kq6EJn9P9ytCZGoNGD4YQl5/sud98AnScRupBmHr1K8JwV2Dc
	xLzG27dnX+oQwD/xFa34p4vrnyIjE/vDbMF1CV6bVOKT88fw327HUnzz14LVeiilX7+pR2kFouY
	XrIV85DWxVBgRzK/KZb+DtB5LIYnbykpaFRXtC4YkrdLjs5/0hqWBBsQv0+ppdsasbMsoAlWsdV
	vVPQLAHBuZp1Zdo2ycZlBcUCSWfpidIlLmlOjvPOlGilNDmMeLckhS8hO0YHv/++Rarp7D+A4yv
	NF3aRBwEppY2MV/d0
X-Received: by 2002:a05:6a21:6e97:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3c38d90d3f3mr10267776637.12.1784335498681;
        Fri, 17 Jul 2026 17:44:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e97:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3c38d90d3f3mr10267741637.12.1784335498220;
        Fri, 17 Jul 2026 17:44:58 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb51a2c2a13sm1504573a12.31.2026.07.17.17.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 17:44:57 -0700 (PDT)
Date: Sat, 18 Jul 2026 01:44:51 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jakub =?UTF-8?B?U3pjenVkxYJv?= <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com,
        duje@dujemihanovic.xyz, jishnu.prakash@oss.qualcomm.com,
        jorge.marques@analog.com, joshua.crofts1@gmail.com, krzk+dt@kernel.org,
        linusw@kernel.org, marcelo.schmitt@analog.com,
        mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
        robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v6 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <20260718014441.3f1236ea@jic23-huawei>
In-Reply-To: <20260714175645.00003812@oss.qualcomm.com>
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
	<20260711184414.1013686-2-jakubszczudlo40@gmail.com>
	<20260713022040.146555b6@jic23-huawei>
	<CA+gq5JjOV2J87Ycm6bjpa1o=+eKELt6FZBk_KSdEt1zLiQs4MQ@mail.gmail.com>
	<20260714175645.00003812@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -5KJXjcjKyo_ghSwus60FsCMWgzmu75n
X-Proofpoint-GUID: -5KJXjcjKyo_ghSwus60FsCMWgzmu75n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDAwMyBTYWx0ZWRfXwrvdTpUy7ndl
 SDlXW3Gw5CyBsUTmzWNEa32unVtJf+3HsS8XaxJME1tKfr1Tq7JDLYzcMnhNlkFxwndf1pB6NIB
 gYwz7ytG7f5A4KaMmYZ5TPv9NPg/msWAtqrJ+WoDZu+d7eOfjtpRmKFNxmugMeZ0zWJ8Hj0bMPq
 2uiK6pj3heWJbp4qRHiJxtqvmE7NBMmLkGCMGGfdjnVWWV4EjqJeJYxnBKsvzKHADlyCF2r8KHm
 BxSLMQ9bARqoewhXPDGz6TEdjWLdAREu+Drzr8KhnzPsSDgx6+fVtlFd6aN+6iSKq1jUIRO5w9t
 hZX4W7I0cqbtTrkbi9cVSO3kEE2Yur7QnDhjLQWcepVe9v++d8lqSJDnJels9niiRmpR3dPqiBA
 I8LIPa5aFtkNtdaUF6/e2/v0xK4EFZliH2TvsFzQtpl7VR1PnOiaKSwOpg3FXQEWlzcJVhB8X0A
 jWa//A72yCVN1oCxJjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDAwMyBTYWx0ZWRfX4XSQeySRPfUE
 U90T614Wcdh9HGDEyITBfvyw0j5jyta68fFKD+MgyKuvZ3rVMT/oU3Ra8mL1sYDw3PFA7rnGpr4
 tXkYwVW1Z5X4DRXE/rDG90BxgKRDpb0=
X-Authority-Analysis: v=2.4 cv=BIODalQG c=1 sm=1 tr=0 ts=6a5acc8b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=zkuuJgflLB6RSPNJdggA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180003

On Tue, 14 Jul 2026 17:56:45 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Mon, 13 Jul 2026 12:53:49 +0200
> Jakub Szczud=C5=82o <jakubszczudlo40@gmail.com> wrote:
>=20
> > > > +     ret =3D i2c_master_recv(data->client, (char *)&buffer, sizeof=
(buffer));   =20
> > >
> > > In theory this can return short (generally reflects a misbehaving dev=
ice).
> > >   =20
> > > > +     if (ret < 0) {
> > > > +             dev_err(&data->client->dev, "I2C read fail: %d\n", re=
t);
> > > > +             return true;
> > > > +     }   =20
> > >
> > >         if (ret < sizeof(buffer))
> > >                 return -EIO;
> > >   =20
> > I have checked the source code for i2c_master_recv and it should
> > return sizeof(buffer)
> > or errno code. Also David and Andy in v4 told me to delete such check. =
=20
>=20
> Fair point on it not being needed.  Gah, I get my i2c functions confused.
> Only the multi transfer ones can return partial success.

Turns out that we are both wrong... See Lars reply to my thread tidying
these up universally.  It can return 0 :(
Anyhow, it is very unlikely to do so and hopefully that thread will lead
to us making sure it never does!


Jonathan

