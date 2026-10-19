Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16064CF48E
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390082; cv=none; b=r9BKH/iUBo7vQTeoY4qXzxpylDAOP+pR+4wmdEBjQpYyOuA2zyI2gPE8t33UHv4+MQQhQvZMaQsoyjKyeaDEMg8iOFGBKpZnAQ9oanXV3CzUf/wSLVTW8iVV9lOpPtakK8byWmTfYwtAG1xC0R6sF2U5p2DxYvp+wsCZ2Cl8naw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390082; c=relaxed/simple;
	bh=duA7B0Xz1GSz7k56DoehqNOkhx4so86WkE0Xspjnnx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9PmAYndqL5ddLtKs/MfwuoWUkFTGp0kUrnHOo9krhpzS7chjMREudQORq8iL22VFCXq7wj25Iji+Rq24yK+ZfZaucU5c/rfa9xDDWetJ1x/djoke8QC8ZQAdyngTkvAAZ5D5jU2bHuny61Zu4Udunn9FV27fqwoauLOVxUEmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DC3DwmzN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OmYg2ddB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DC3DwmzN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OmYg2ddB"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4j1931405872
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 06:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gt7a3hg1P+/V3uWV0MxezY3U
	P7FV/WGedH1bLBk7Y2M=; b=DC3DwmzNbA4G1Daciwzpr4rrE67iqcwqudt/kbRw
	du76hEYeuQZ9HIl0Ha5vbD+dPuyZqLc/dwEJy1nARjS+S/0K+CzR+pGObr5D9NLy
	OuaF7TwjcWr1Hz02tBLYqdFe28UTQBYpR7mlSkUfTj89X+qdixGUBwLuJLUoSLrF
	ZUbwzDQkFxX9zK9KIdyStf6/5E0QDBw8mxKJysZ1rN4hx7LADWy06FD7+119PgP7
	/DkLgSBP9yNxiWziofFxFxi4ZKXb/bWjAUpJI0PzO55u6nFfJ35hJfLuYXTOLJsb
	Io0AfX9lNgpEnyl0lKHehs+cqpT3JAH7VGYKQrbCxY2+bA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr8cnb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 06:07:59 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-18b5ee75447so1135971c88.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 23:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792390079; x=1792994879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gt7a3hg1P+/V3uWV0MxezY3UP7FV/WGedH1bLBk7Y2M=;
        b=OmYg2ddBXymg1c2qjZqPNE3PNoh++UTJgp3VoOyTU2d5+WvUuHRTZUCLrgU1kxX688
         Xw9jZqOzB/LYwOQUK5x/GDZFcdyeMeUvh+qFUUV4MGwXIAwSWZo8S7ODVfdKBnCH4dLx
         iN/6FAL324dstkHx7qM5jNDHu5YmYtwSB16HkG5PMDZH6I0sO66iQTXLddmjgoNhgBlb
         McG1i8rtQ7K5Uli8u2Nhma5QAUFzEyXF7XHUA9L9R53kMx68YHmxTIVBBywtirynRqEY
         nqBmnyp/r7ARoZqLQEHfJ62HMEpgb5oGrAyLyqhgkcxUwFXwWYhui2H1nEsiFmjfvYaM
         mpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792390079; x=1792994879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gt7a3hg1P+/V3uWV0MxezY3UP7FV/WGedH1bLBk7Y2M=;
        b=IAXOiFtfpU6QccL9r/XgKRrgjtU9z5zAj3DphsHTbQcEMeCWp+kV1431lehvxJXQ/3
         oNubaYkJwDJfLmGoP+l0c/Vkak1UHf9UMDBs2+37yDYouvE2rBu2mrmIQvfbR8sQy7iT
         J1ycB/rQc6TpGrFQTWaBt9ll7pe/r9UjNoxQP4GSrJgF11uAGlzr3rol6eFN5Oy9APM/
         EhvFI1zQwvmGBUvydrGfHKAmQjN40KmUYsVfTc9k+uDeHLImKIqU2X3Jna87scKaorcY
         UViBDok1n8W2e6nz6fT8wjw4zQuDNbykzw1Tm4GCB5v+STZZjh4e8mAllggqLY2UdWSG
         z6lg==
X-Forwarded-Encrypted: i=1; AKwUvBxDKL54SHpxNcdttqrjMzeQPZoNa78leCHrXGnyx3CtBJcvHGYUKT8XlPsSlsSHvAEtgf3fdkfos1k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwgkLn44D7nu6LYZBn1U+cJ/xVfndVoSSpNkh4M4pWMseNY5Pk
	GvaqC6slAgieqxpjxiZfCNcSlf3ONweds/3BZlq++Y2c1m70Q3o+3XICOcOO39HRnzTWLWRdUBh
	lwgKPgbZudzjAOqBN/CUPxrXFCaE2eje+6mI3HU86Nl8Q7bTYraoSAO3xr6u+G+YO+A5B0jKhmw
	==
X-Gm-Gg: AYBFou1PCqzbEMwzYcTCbm/zIfcDAuOkz0EUBaoKg03PLdg8HFACUNGJGPOA6RTe6wv
	Wuvxphyz/6GWkffJxQ0S6xeMmiQRKRZ9nQv3PW0Xpd4YBPlZrd1GdpTDcET82vRL4//grYmakZP
	FRHGmrgCUdwl358rU4hZFoRm1bjftpwwHQ9N1PFuJdBU/wfJOw01eLJJ01rVpYel8PUu+4ab1jg
	AuniQ2hB1Uh78n5ATUB8Ur5WdQzLiwUPY4EpK6Q2WTrXnKWKRUOg2YtppRnfdwCQsJk8Z4WTH+A
	LzbSJ5rKLaXYz4/c7UpUWexGQKBv5iLw9K5NijIwBzvd7Ti1qYmaR0eL0zBpcwhR4ZQnfRXnLDc
	2v9zfnwSGJYThEC36ihpXbLbE3ftosL3R9LJfcauyIA==
X-Received: by 2002:a05:701b:458d:b0:144:f089:b189 with SMTP id a92af1059eb24-18513f76427mr9319133c88.36.1792390078714;
        Sun, 18 Oct 2026 23:07:58 -0700 (PDT)
X-Received: by 2002:a05:701b:458d:b0:144:f089:b189 with SMTP id a92af1059eb24-18513f76427mr9319106c88.36.1792390078055;
        Sun, 18 Oct 2026 23:07:58 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm29051923c88.4.2026.10.18.23.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:07:57 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:07:51 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Dan Carpenter <error27@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM
 aux device IDs
Message-ID: <atWzt_cOCgEzFAyk@QCOM-aGQu4IUr3Y>
References: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
 <20261018192151.1115a40a@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018192151.1115a40a@jic23-hlaptop>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfXxLhdJs88wMBi
 gpKp9UcHjHZA91Nqnp2Lf/M8vuTmr0wPzOagV4sVy2SwAKGjKhZfCbWzNI1QNYykpoqZzaeS2C4
 oqjjGGblHIKa8PNXFCD6zaQLDOVSku1K/AHvPSld3Yx/HACX02tjLBdzp3KZxs4XPHXwAr0iwIT
 ggSmo5wyV7yhdpD/NSa1pppuBh7cRJk1Ly3AZiVytbB/Nr8ErD1r2jmoOBWwYIzZFxtoCki6+xI
 viSOhEJzjNH32BNcTAJr1cYE0oUoSMm/dhI6aRjh4KkLc3BenIsrbipgIu/W0cpmFyYZPV9oUk0
 r5V6f6sir10i+1xqpzkc59qdDxLnsYH5ISVgXlp6LF6kc8YWxshJJi7MaI8M0yiYMz1YgukpxJK
 OnUTsNQyxjvXNZgu5xfVhvWvckYvBkqXnlmkYMCwwnyx/KGHdGY6cFDrSSlapozZl7SrwnnViZ5
 eyBdgZNJxXyu1mpq7OA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX9pxXr53sWVKC
 z8dEZ8rI7N6x1mYiePzzq1HS/m2PVx6AuSVnsVfWEoj+2MR/YJlJUa0bdbIA0N7D23XzlaMSsM+
 HTrRQ44DBMdBjk9UUilEkUa/DOt0Hvg=
X-Proofpoint-GUID: OYKyu0Q4OuXhDXeO1DNB-78IUv__0Jm1
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5b3bf cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tvFe3K95HD5XBKzLawEA:9 a=CjuIK1q_8ugA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: OYKyu0Q4OuXhDXeO1DNB-78IUv__0Jm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190024

On Sun, Oct 18, 2026 at 07:21:51PM +0100, Jonathan Cameron wrote:
> On Thu,  8 Oct 2026 11:11:54 +0800
> Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:
> 
> > adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
> > every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
> > to register the same device name. With ADC_TM channels on more than
> > one PMIC, the second instance to probe fails:
> > 
> >   sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_spmi_adc5_gen3.adc5_tm_gen3.0'
> >   ...
> >   auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device failed!: -17
> >   qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Failed to add auxiliary TM device
> > 
> > The ADC probe then fails as a whole, so that PMIC loses both its IIO
> > channels and its thermal zones. This shows up on Nord, which has
> > thermistor channels on two PMAU0102 PMICs.
> 
> Fixes tag?  Just replying to this thread is fine rather than sending
> a v2 just for that.

Replied to the patch with a hope that b4 will be able to pick up
the Fixes tag.

Thanks,
Shawn
