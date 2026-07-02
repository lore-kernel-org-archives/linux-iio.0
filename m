Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E44DC542
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001929; cv=none; b=dXiMeeD5mbDUqcLeJ7R39efG5Q1V8EGHmaoR2EOFDHoPziKHHZgQdIVWHNj6nU45FYAbfq/z4r6tq9Fs/25W0UwGuU5/40Uf6782VTihsne4lRgpaEdz00f+uFFaFZIC3Yv5u0hoHDq1zo6SPBvig915VlabjIXXYEwMclZ6rtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001929; c=relaxed/simple;
	bh=FzlQ4dU8Y7So5+PoKuqx2vCx/5MPgXqpsLfNBx+XtJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toN41MHuiP696FDPT97Wl2zlQM/yZorABpts1//m0larCrOpPhhrZsMA3Vclw6LmDk1GnwjJWlQUaw0wl3Bg/4s0PqPuOlsBH2BKZaD1QBVmz4kPw2D1Escu68iqS+wKgMlTnf0RlYBFhD+rxjq9LM3slMiDGFlq6BuYlsgX4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SefeOP/8; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SefeOP/8"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4472500e25fso830197fac.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783001923; x=1783606723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3aJl8QhQEFbQbyrb9zx0aFaFWiPGxodfC82XFdOcZ0=;
        b=SefeOP/8wupF+nUFeWKGg9bdzKJHS14dotjJBUP95kU68lu/bstckB3fZElv823DDO
         bfk7ZgVMZ9Utd2C3DHb6vmt9U3MassvQwQdVz5V+G/VybSCuA+OBHfxbSaCTjEpIj20J
         uAxWi4q2wXC1yjf+JNEP2CiigBAbGX0O6nZag8IWkOdYFpRqVLUJX1sRmA7qaFpYlxIW
         Nh2ZbHlm3KeyOhy9T9bthrD4Fm2sojoROpWKq7rx0YYPH0+Nw4MTgQxd07TMN96rw2db
         849dWaf6hWSay7c+3JtjMVpNdGSLyg0kawt1OH01clcw1KYG6cSoozdh9VoyDlx5gCRj
         glHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783001923; x=1783606723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3aJl8QhQEFbQbyrb9zx0aFaFWiPGxodfC82XFdOcZ0=;
        b=Wy4J/oUZitS5OEehik0VsNyAgx2vqQaahrnyWaPHcW2q0a3yzQhigg7xOB7oPI3SCZ
         MMw9YelDVNGQS3h5/4HDdUAaxe09eXxxV4KOGK2bVTj5E4ck4EvY4NoXZhQU2ID7AnM+
         VPK2ipNNp8K/8jbfJb+JvU8TtTt1Zu+TDP1JXcScrMosad9kgvCD82jFcLlUbvoIz+QK
         Kilm8VLmltp989r4/TuejzSIyW0lsuZ3XWWcXnt+Ztiur4r1J/fmBSfQA5zlOqD7prA9
         Mxv9Tc4PvapBactnPEAhLbvsdZCrxQO2b8vhgspRtg/jkH9fgkFnVIxgUCQCzRoIZnc3
         p9Mg==
X-Forwarded-Encrypted: i=1; AHgh+RoLkucqZpcirgH9hf//myDi7QLmTBcdUJcyWQDO2vmKlk3ogJdAXXj0X7R7p5a4G96LpiYCgRU6NCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq79C15C1fg0t1nZh/fN4ZLCEWWzk7FCt9JWoD+10m2dXCI+yo
	0JXSpg+TPEbKPQvLkB7mEnZS17WH+j/8lZIsFtp3EVsSjmDIe3SjE/QQFAYetqnJzag=
X-Gm-Gg: AfdE7clyyFrFVUVRnDz94v239YX9jPMh0MExi8ncdEfdkadeb3FhTkMIfBJFZmq5Iql
	Av2Zb9E0axLPnAfoWdk50Mz/W3fiQws+JjBbfsB1Cs/962JpH72iIDY61ZBxKIGTS8ROeNoMRub
	mSqLafD1g8s30GHdYU8iR9rnGhbd2JWOAlF8Ag9CcDeV5H8/Cm6/sc+rceE3xMpNNu78khwXzwV
	Okem0vRH0lVEdFW5UxV9spB3r7Xv+w0JsIubb22SwdcO2EQ/HBvxXBO6a7m0XzWy2jkEx/W8htg
	HQoqxVMNJ6OzhY62a+wTeG9h71KuCtGyWUNf9T8t/p4RuuLxBq2tqm+BtUcKphtKvQifU/AAO+d
	TypC3bY1fY72AWQ3cu2dlcFD5/5d02DXBwa2mp3pXnmYR8F1914kg5Wl9m7TYiy2w6P4rUZly8E
	s9bfp+jrF7ubwZyfh8FLNCiIMdQaeUCBYjyGVUaWsooVsUZo44yOBx3h+w6XpFhWKibA+LSLzLQ
	Q==
X-Received: by 2002:a05:6870:8899:b0:44a:e965:b9dd with SMTP id 586e51a60fabf-44cabcb3840mr3681787fac.42.1783001923076;
        Thu, 02 Jul 2026 07:18:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6a9f:626e:95c4:2a80? ([2600:8803:e7e4:500:6a9f:626e:95c4:2a80])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec92bbbsm3013174fac.10.2026.07.02.07.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 07:18:42 -0700 (PDT)
Message-ID: <544fbdef-268d-49cc-ae9e-b18907d9382b@baylibre.com>
Date: Thu, 2 Jul 2026 09:18:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-8-ceb9b0b561cb@baylibre.com>
 <20260701212019.12757df3@jic23-huawei> <akYs-QgyjN-nmjq-@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <akYs-QgyjN-nmjq-@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 4:18 AM, Andy Shevchenko wrote:
> On Wed, Jul 01, 2026 at 09:20:19PM +0100, Jonathan Cameron wrote:
>> On Thu, 25 Jun 2026 16:55:10 -0500
>> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
> ...
> 
>>> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
>>> +		struct ads112c14_measurement *measurement = &data->measurements[i];
>>> +		struct iio_chan_spec *spec = &channels[i];
> 
>>> +		if (!fwnode_device_is_available(child))
>>> +			continue;
> 
> Also drop this dup check.
> 

How is this duplicate? device_for_each_named_child_node_scoped()
doesn't check this.
