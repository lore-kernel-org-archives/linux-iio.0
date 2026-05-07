Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6040DFCC
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778120232; cv=none; b=LAiwF8ht+vAfcSaQyVgn4bLZjKa+e3MQkUUd4He3e4k+sdPm6iVAqDsAnxNzmTl+wiRiYKxJzK2dOIOaO36hnQ967v7viG0Usk9Lff1DISVm6/Gq93/4Dg++wMX1La1hBaz7cuIIzMzn4Xu2mJM17i4sv0Pc/fxJKPCwuFLiJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778120232; c=relaxed/simple;
	bh=kHnjARW+TF9xfZP6oEbxt59KWoJQlz0Bd+tOaK3roWQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mvmLHgeYWni81F5vkb5lBMyS2F5hQq5DaObbOhQ0P5jj2YEq4xdFf9K7lVvg0WOVbFHWrVJNAdSEdkz7P0GL6gznjli/kdDrB+xSkHfMMuemCGbyH2MmCgRUHqGTb8WKCDDDRalLD7HJX4Xi1GE/r4Ik2jiyXGWIov5up/hhuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLl0lVYl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLl0lVYl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba4a1a0325so2444865ad.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778120231; x=1778725031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QfljaX0j/OnEAlVF44pPhl2QZFR+lhq0RxifLBR+ro0=;
        b=fLl0lVYlcFY6vvTbAA8rIAbpbIkSvcp8SHwbnXS9zd0IMPC7IxtzvC4LHjPslm26b2
         RORiqaVfLSM0luXE1XxK4VdOAg5OpBx1ptM2cMnIuoS2X8LBQYyPqfeiB9RZRMyQvb9m
         vxfm5qDSYivb5Xp/PHoH6wR84drqiEUw02LaYXNp62rzvLZ1xpQvbUOPCtJLSmfI7H3H
         3v1zWvSLb6t/IUsddTR5oUUK3WUaeHEK46OootmoACyrK1tbMzlAvvTvzWyr8SYCb26d
         OHpt4pEAQ52BqPjuIzYOx1ElJW9xcTU1X+ew+rQ5Rf72zRuwklAQJB9fLJvXbJKwHRh3
         qvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778120231; x=1778725031;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfljaX0j/OnEAlVF44pPhl2QZFR+lhq0RxifLBR+ro0=;
        b=lYgMnrY0xjUcbY8lOU42c4cRAz0FbzXe294+IDDd9vM4cdBPK7+hWHvs4lTe3H83ct
         OuFFwDM852NXCZvjF/OBJ9ZDqLhIYPB0g31PqeupnOiXWWNe3YaiGcmwz5I5edsQ2nU/
         grrhKuS6PXnThg92k1vOGM0NUvqFSHJ0jMqtt/ldpSWJiz3YLroVDbCSRzk8TZYxWO6s
         4fOQX2veilKEJZ/Rk8ZYs24MfeEdPKNZViOV3PEc6Id+miT7xbql3HVIKjeheoYZkBBV
         iSRUUsqYa5R58g1CxzLpyG94/11HkDjhzbfMnE0DX8Ic63N6fGWl8COf7YsR4jAOjPwg
         yurA==
X-Forwarded-Encrypted: i=1; AFNElJ/6RnE4kvvj0xt6MJPSHh3ZwkMKyueL2RD9JBKSlhGQCezNPqqJFOZw/J46TUr1Mhl8BpLx2xiGUhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGmB/aD6yg8JYlO2zVHgsQnW564W+9ELc3cK4IpFLjLsRFect
	SUCM+BA4gxX/UfWCLJT0LxgTh7O/bJwYksyZUradXQoj/JsBAQZLKM1m
X-Gm-Gg: AeBDietsr85Ku/TJilIVyuKKw6SQBHUj6HPAn0f6PIDHIQPyNvOLIKRkORLbCivodxJ
	ROraEXYPCH5l2hy3dlX8FSK8r/VoSkT30irNchR7lS5Ou1d2VZip4xhmGiGh6HzOJCPOrEW380Z
	8jL3LmrrxFng01/sEw1rkl5FkHCzG03lbxjtdGdZLCnWcGRrsfVdL0KNm4al++SOwoAc4iSie4J
	3MZU8zY3yfbGGUxrzG/bb392N5/qvtGL70tQd8PaDre8mHpVRzR4jO4I3yZ6dhSrcK7GL6jPpin
	DAFsMjbRfLsTLQRzkslSUDAlteT9LVaaus0M2vH13VEBpEdwRDas3VwCYvpGmNEtsZq5XaqQp1S
	JyyAJbEKIFw69z2RtoyPi7wCMOgpZ3ucqS6Dcr2DNHsqfuP1QYzJsoeLY2Zg7U6AKfr1UHEJTCJ
	JLGR+2DRpTgZ9+8cWU8g30TjnJ2pUydt7wIdcKJrc9AnZSMqxfJfUXyN0Syg==
X-Received: by 2002:a17:903:3850:b0:2ba:b738:bc2 with SMTP id d9443c01a7336-2bab7381ebdmr15578345ad.27.1778120230584;
        Wed, 06 May 2026 19:17:10 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac23:b594:789f:a6c4:c581:db80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaac3495sm6259255ad.13.2026.05.06.19.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 19:17:10 -0700 (PDT)
Date: Thu, 07 May 2026 07:47:05 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] iio: accel: mma8452: use local struct device
User-Agent: Thunderbird for Android
In-Reply-To: <CALoEA-y37XZMVSnzdUbmWKHOWxs5r=39DEVcs_G71vEQTZ=ntA@mail.gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com> <20260505174640.3998281-8-sanjayembedded@gmail.com> <CALoEA-y37XZMVSnzdUbmWKHOWxs5r=39DEVcs_G71vEQTZ=ntA@mail.gmail.com>
Message-ID: <CCC9ECD1-6847-4AE1-9176-57B1F8F84EF4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 6 May 2026 2:49:33=E2=80=AFpm IST, Joshua Crofts <joshua=2Ecrofts1@gmai=
l=2Ecom> wrote:
>On Tue, 5 May 2026 at 19:50, Sanjay Chitroda <sanjayembeddedse@gmail=2Eco=
m> wrote:
>> @@ -1552,7 +1552,7 @@ static int mma8452_probe(struct i2c_client *clien=
t)
>>         struct iio_dev *indio_dev;
>>         int ret;
>
>As mentioned, you added the local struct device in patch 5, making
>this really confusing (and potentially breaking if only a partial set
>of the patches would be picked up)=2E Please add it here=2E
Hi Joshua,

Thank you for the review=2E
I have prepared series as there is some dependency on earlier change with =
respect to current=2E If we pick random change it has high changes to fail=
=2E

FYI, compilation is validated on each change so if someone take few initia=
l patch then hopefully nothing would break=2E Additionally, if we plan to t=
ake random patches from series based on some review comment or requirement =
then I would resend new series specific to that patches to avoid any break=
=2E

>
