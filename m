Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2429B200
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576901; cv=none; b=ciK2s3akQ2egFyn1XiINBPxgJjkJsZCjNPCLZDOtIHUzhzlrHgMIoq8A8CNLATgKTqWJlCHKWec5Z63nww/oyBU38hN4m/kiJI3NPWiROAJf7wiNGwjJ8D/w6Q086okVRC4eUFsWF1tvUvBiI9pWq5h4Ytr6HFu0LZbjspcS7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576901; c=relaxed/simple;
	bh=Id/9QrNMu8Ly9mOLs/23rfazEvvQ4Gj7sfkpsrP5n4E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ij5FVjTxW/hCxBWry/wx3RKz1S+Kl60nM04Rd/5sngIJpQ4LcYX0KwekqW/CQWJQqWC7YNG8Suui77qNOjAFoxCQN86lhblrxO/Vgb/HoGezDT7+Wpfxu5qXnKACS8qRJmxjbNSXx5VYuPodpWH3fUgZArQXdklrh2F1cfl1Vq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwzLRFyv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwzLRFyv"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35e576110adso993762a91.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576900; x=1778181700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kTutwlsLC+vJ/RVb3tmIFV1fWy4ibAZn5i0AUmzY/Yo=;
        b=iwzLRFyvwlWJOhg4Utuz/vVuLDxcpLVAkiAu0a+hu7WmAD3QRWGERW/Jb8RRo+zqMu
         QhXuPSGxwj36igGz8zKbiKF598BVMhsyuhDCE1z+OB34136bDNcG+gw+ruchpDfhE+eb
         7K4MSjX4kH5hDc7pKF2at3PA5xLNglQFSuQD9ifmDqZmEmwZ40OVZuZ5QXpCvSTWPjAu
         vL0cutrFLXvOzCIPc77q6jOvxnnATgbi/zPHKFNezVO6wgeYdZExFBue9lIV5EOuf3cN
         AOyoono+pkOVDR+AZgvwmII6MaiyTmOcuna9Gz8ara4VUdP22JGn6ZhSEa2rp1X/HWjD
         dC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576900; x=1778181700;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTutwlsLC+vJ/RVb3tmIFV1fWy4ibAZn5i0AUmzY/Yo=;
        b=rjF50ZFiTx/JbfXmHHOLjS04VTZp69j4VcA3A1U7iWzrE6yRkIgmHZlHUmDoTN4/iz
         Ru3Hi3phoOBsgl3YhT9X92Dxl99DZCch9/nf0/3/TcAaEdsXDDmhfekCKutCIO7oHXoP
         Sxf+mDC1OSuVfe8Wd/IVffO0RjQ0Sba6zT/e/V3LchUv9ihdiiLpRRJmAryAaQx/IiQ/
         ygej86aUIvXrU0j9jdUdGfoUShkgpfKvGUNlfP5iqCUGsfAInBuPc1Qtm4O2koVdblzP
         Rqd81vCAypQqKc2zhgLGs3sLklePkGR1l7YfWnWv56L67Rw07O3JlrZPy/SNOfmxd6pu
         x/PQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PQUuQVKQ1VGzUwgEkoF5HBHKgI6BWEqZ2WfsUFk4VSE8T8R9ffqi+dVqNZFsJBWPfiYHwo2yePjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdT37sgjQnu+YyrIMDh55oDUtbMr37LAIp7E0q6QLCFYFjPPui
	yrOX33uGtNaBN+T+H+qpzzdX1fIeKuRE0bpxvoEWJsaKMGwB0sMZ0vxE
X-Gm-Gg: AeBDiesAQGwc4Glj2MbmNxPspEx7nmXuDjpmVzWcockSS25Q+NI86hemKLVTm6YU6Ol
	nUxDH16bk6BeT75zsQzhIIIxUryxScNtEAYalvKrN4ttHSGW9y218HqRgKGzlXwSaEmXOuJXhn8
	4JZybZbeEp1/eqP9CyKYtGDqfSLfVo6U43PB41pbcRNrjpzXhPkkcOfijTaC5/gDQAqDw89Dyrm
	mo9w9+3PQ6p7JAVujeL3QhXZcqUl4djp3CBXUcg0V+QMeekNpw6CqjrMfryg0KowECyO1ToMQAQ
	4IdaF8SsVeyQ7n2cED9uJKSpHHfhWc0cGNQ9Xrp6X67t3HHh0dq3NlD3zsBRFKrUCJt+Zfxyxwv
	ajjE0ZuNWQXaD43JRoqCaezH8Vj4bhzMpIzYBQlXSqYv/Z6nT1pd+N/MgCDV+P9GvVwhCwrEIy3
	WcD9+zNmJ2iRE3y4T9UI4wpaP4/CsrQUUaXIs/JSL1QyXr
X-Received: by 2002:a17:90b:4c04:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-364c461d8ffmr3191808a91.5.1777576899778;
        Thu, 30 Apr 2026 12:21:39 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:53d0:4e4d::e3d:bc05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364d9e9c03dsm1643018a91.0.2026.04.30.12.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 12:21:39 -0700 (PDT)
Date: Fri, 01 May 2026 00:51:24 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/4=5D_iio=3A_humidity=3A_drop_h?=
 =?US-ASCII?Q?id=5Fsensor=5Fremove=5Ftrigger=28=29_using_devm_API?=
User-Agent: Thunderbird for Android
In-Reply-To: <afJdJIQS1vwOcaGT@ashevche-desk.local>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com> <20260429175918.2541914-5-sanjayembedded@gmail.com> <afJdJIQS1vwOcaGT@ashevche-desk.local>
Message-ID: <12C22ED3-20F9-401C-ACC9-D666393B292A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 30 April 2026 1:03:56=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 29, 2026 at 11:29:18PM +0530, Sanjay Chitroda wrote:
>
>> Use devm_hid_sensor_setup_trigger() to automatically release resource
>> during fail, unbind or removal of driver using devres framework=2E
>>=20
>> This simplify the setup, remove goto, avoid manual resource cleanup in
>> teardown path=2E
>
>=2E=2E=2E
>
>> -	ret =3D hid_sensor_setup_trigger(indio_dev, name,
>> -				&humid_st->common_attributes);
>> +	ret =3D devm_hid_sensor_setup_trigger(&indio_dev->dev, indio_dev, nam=
e,
>> +					    &humid_st->common_attributes);
>
>I believe the first parameter is utterly wrong here=2E
>Or other way around, same issue but in the previous patch=2E
>
Thank you Andy for the review comment=2E

It looks in same humidity probe of hid sensor with devm API two device poi=
nter are used &pdev->dev and &indio_dev->dev; ideally all devm should have =
same parent device for devres resource framework and over here preferable a=
nd consistent device should be &pdev->dev;

I would first update existing devm_* API to have consistent device and on =
top of that will use same device in devm conversation=2E

While for gyro change device is consistent as &pdev->dev across all devm A=
PI=2E

Thanks,
Sanjay Chitroda=20


>>  	if (ret)
>>  		return ret;
>
