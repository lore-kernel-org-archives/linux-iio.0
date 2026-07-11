Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0B242D7B
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809974; cv=none; b=f0GqWNiva6lqY9ro3OG8WqFMSBWORe3FX3iw62yXgm8o4ghyK1DmJGWbswhlQhne5i44cBG+9jz4XP2xYgxGvCKPR/4DSS5CEmIw8pzl213eY4QXeziVekehzZvvjnoPM6m8CuBZp1xwUKn7rK+n0WLjrPnEm6ZX6RxLa1SVYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809974; c=relaxed/simple;
	bh=JYkNJMYJm9V95OUQaZleNIWO2yB9VyUf6m85m8oIEjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onqPk7Czy0mwFh6rZMpVAc/Rz23+1BcRdbdAmAHnq8EJyLEyVOTydf2+TDMmEGm6AftmkiZNoEXkx7JQIadEQU3fl8QxffhDP1hZykrmfENy8+dOS8vk6Urx7sE0Lb18gc+n5eyUvZlIm/m+l6Bp4Bpi+CVvL2IWFKouQw0NWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgJAYp54; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BS+UJZvM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgJAYp54";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BS+UJZvM"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BKx93D722283
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 22:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JYkNJMYJm9V95OUQaZleNIWO2yB9VyUf6m85m8oIEjM=; b=hgJAYp54wD7xltet
	p2B22jokqrzdwocSLZKmhbFIhlCDYbcyX9ZU9YqlahBvmZOwKnNupxCqedoZbNwP
	EDW+orwMKwV4d0YiUI1MmFwbXvgpQgJb1x1UWiWUKP03dio5X9RGQeJNaNN9SOGI
	aRqtzp1GK41G7zM2MSYxcYrav/Bv3P2MWDnFSkyuM7StHDLcNDZeqtnw9UXxBK37
	m2+G7RoYRHsIU2g6hcAFZz6wKZZcayWg0Y/s73Cc1Y/eS6QtcdDQjiopKjL5w6B/
	OvrA7ONybwWxjznWo5EJ8lv0P+oe4j0ccDo4r7qGkFEbsL8io1tbbR5iPphQ5PoB
	SAsoIw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe8v9q4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 22:46:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccd1958e8fso25901935ad.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 15:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783809972; x=1784414772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JYkNJMYJm9V95OUQaZleNIWO2yB9VyUf6m85m8oIEjM=;
        b=BS+UJZvMCRzMCj5Jneyd5JszWQifkqXFzmrZpe5Dkn3Rxya16jIvd+ZwhHg1+/B+FE
         2ZH7p/5WTGpsp2oICNe07N9daMsGnsAAFsz5M9oLzD23ogTP89dykZ7RHlXqlIoLDSEE
         7dxMDk3grUGAFiBtbHBry+mZnIgWgAkqXSj5/clXjXO1N3y+YlJ3sKRBHrwG2zE0RoIW
         QbNmEU3p7j7nhqWtHDjVFPupRisEi1zNHPYKK/4sdNpzWDnj067UCito4vwkVmFisBFu
         70Zc73rA/UX66/SjTqb175AiHG4hXFvngN6ewe4RuNRXS0IGzeerwN34qHsvdi954x0D
         WjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783809972; x=1784414772;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYkNJMYJm9V95OUQaZleNIWO2yB9VyUf6m85m8oIEjM=;
        b=TDL6rGdP3ud5rkAbfTnKiNR/Q3Am8UPeqm1WE8ocUbX1qidM2wweT7ZC7Pf/3j4pDG
         98TMdH4YR3z/Kthxpu+C/MG8e0cWcpX/m11UFEnf+Vvzxj+/ewjSAFT7jtRlnvEe9b8s
         VU45FwoTIYspfizfWK5m9ltdGb/WFhQpW+5V/DM7ndjNB1jAADtal+lCm9RYbwzcH8P6
         Z/4vh06KIrUawBiHCVWrJVeQNsGL625tv253hyM2Djy1695kg3cjmM0aRbeU7tTmskXb
         huMk+/g2K2azcWLwvWRryr/8o72zS+bntICjuqsYKapyPZvjgD++B9WyaVVaF08uXQ6H
         ZvLA==
X-Forwarded-Encrypted: i=1; AHgh+RopyeNacCtQHNP0OtturX8d0+yWzBUChiFTzxirNMww21O0LX8dyyKq9bbcO3n6ZFatH9iz24aiDzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWp5VezX41WX5nyv8VXY1i3UU+zNRI8ds8ylYpNQcsMTqb6CfP
	Q3w6fVe6gajWcX7a0lk2uM7jnLJqgN/uY2g0yowgxA8n/9bKT04TuSp4IY5tJYGJMw8p7n4Af9L
	ALPjkeQtr9Bu7PrYzsl6NVRWjJnN+QJr+QY4lK5uEnYLSrErToD9Kkc8BEaxVVFhfd43b4XE=
X-Gm-Gg: AfdE7clwBcTalIptxXopTbUYhoQreM1u5KK+5p+WxOhKejnaIC+sfhqU3N4M9WW+pZd
	AYH/cYcJKNolUfiUmYAzk+Dkj94ME1+EzEZfEww03959NuNqbVWHIssfWFliEIoHf+bTiJ7SFcO
	rJAr0Rm3+UcjxteXvMlD5JJEN28Ixhw7QE0r6gidTspiDncERRIOx1GeyMNJsSnmPOvnKgAmqNn
	cuGUldrKx8/1JKsGulHFmgdlRxak9rlpfvRweQ2gm65w2/7KqITJ8KyxO8Ob/SqZ9yssrb/2lUn
	o+Cc6SCUdLwhYCtMlNeTjV8WKhLD1/WMZczzfePmhZeADd4xqZtEx76qm9oTNQHtNS5OfjGG5vU
	I9XP2aWnSk17xHb80bmvE+K+Ktw4=
X-Received: by 2002:a17:903:468f:b0:2ca:eea:eb5c with SMTP id d9443c01a7336-2ce9e9ad7c6mr45041615ad.18.1783809972038;
        Sat, 11 Jul 2026 15:46:12 -0700 (PDT)
X-Received: by 2002:a17:903:468f:b0:2ca:eea:eb5c with SMTP id d9443c01a7336-2ce9e9ad7c6mr45041535ad.18.1783809971591;
        Sat, 11 Jul 2026 15:46:11 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8f26sm79358595ad.27.2026.07.11.15.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 15:46:11 -0700 (PDT)
Date: Sat, 11 Jul 2026 23:46:07 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap002: Disable regulators on resume
 failure
Message-ID: <20260711234607.2eca985f@jic23-huawei>
In-Reply-To: <CAD++jL=WW1tVFOd=0UE0JxJPgwYTye-oGgTjAw3RuWxYWmykSg@mail.gmail.com>
References: <20260704083412.43145-1-acharyalaxman8848@gmail.com>
	<CAD++jL=WW1tVFOd=0UE0JxJPgwYTye-oGgTjAw3RuWxYWmykSg@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: UWy5yQZRZbJ4Gt8A00XChQz1tIVb38sD
X-Proofpoint-GUID: UWy5yQZRZbJ4Gt8A00XChQz1tIVb38sD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDIzMiBTYWx0ZWRfXyX3DWBa48efz
 0LQ2MBCQE02hFkAwHUKhhrlqkH39LXUDHt5oWEiLrJQ8Rk3jXodtjIfGgKKgca2/cliVIOfBqOK
 CiiMTRUWeJyr1eiTA8tv/NKlsadf4GE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDIzMiBTYWx0ZWRfX4jaQZ4o71wJU
 0w9udzPPoSm/lrH6/K25uujJT4J02h/dnKdlaGEAR6aRv7zpgXZEHk9Syo74mU50obALtcEzUGG
 ZT97j4GDFwqPNT3AQmTWxansGRwxByDeyjpiHrXR0Ho5ppzIz++Y9flF7CaOb7+ofOszM6eLmbk
 UnxzaTsXq1Pwx+6qDn7YAg5DQ/msbSJMcNtrH0nY3jo58RJILzvP4CwWac59rM4CMHaRV48F6cD
 +E89EF9LU/xbNo05bmBhh5ItZ8wsHqTLocp04CDltakvKG6L39/1mho5IwzhIychmZv9xYXSgAQ
 mCjEkAhmDiQhNcPin06Ax7pl+1P8SyE7q4fbyfxP/h7Qlhfs/N1kAx7Ao8hQuHDldMREsRJGoor
 C+b6R/BSPkDG0Hbc3wUz6ZBatuaB0LA3NdLfnqQaEbka7AM1fiUkcdLkK+YVLZxVnLjBOHz+L/T
 nJAJdGwGP39dOzJrEJA==
X-Authority-Analysis: v=2.4 cv=WONPmHsR c=1 sm=1 tr=0 ts=6a52c7b4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=4M_2WnJjjLYkfDCoBUQA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110232

On Fri, 10 Jul 2026 19:40:50 +0200
Linus Walleij <linusw@kernel.org> wrote:

> On Sat, Jul 4, 2026 at 10:34=E2=80=AFAM Laxman Acharya Padhya
> <acharyalaxman8848@gmail.com> wrote:
>=20
> > If enabling VIO fails after VDD has been enabled, runtime resume
> > returns without disabling VDD. Likewise, if device reinitialization
> > fails, both supplies remain enabled. The runtime PM core keeps the
> > device suspended when its resume callback fails, so the supplies must
> > be restored to the suspended state.
> >
> > Disable the supplies enabled by the callback before returning an error.
> >
> > Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
> > Assisted-by: Codex:gpt-5
> > Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com> =20
>=20
> Looks right.
> Reviewed-by: Linus Walleij <linusw@kernel.org>
Applied, and marked for stable.

Jonathan

>=20
> Yours,
> Linus Walleij

