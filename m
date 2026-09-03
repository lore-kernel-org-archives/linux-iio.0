Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72E4A1DFC
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437336; cv=none; b=bHlOEQM1XqcnHravgJwi1CfFaKEVKEbxCrohRG7wxmwqdfKi/7Nm/qw6sjNP0UIKEwL/6U5RWbIpYUfXKBt1Zht1XI2+D1EJKY2YwKjQhBafXf7RhpTs6f3M9f2Oc1ka77UAjGAcYTtQcZCDNAPOj8hItCBaQpwOwvz405+VzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437336; c=relaxed/simple;
	bh=BRKIuIMQwGJz+W0+V2Cv4f46rDoN+QkQp0uwFbNfBIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzbSqyNKmu3CAOw3CKi70Bcd2M/bwe+Pn6SmrWN8BKvOs3R+yLWnyZ3WqiDoWU6M/bztyDuTpDU0ENj7uLMEdVWphBkPyvZ8rzL4bB7uw9POLNOpZkpXmP/EuGWbFfwwsUzRJd6dciVR6SWu2v+2G8BSbyg/4Vrjj9vTYbdqK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNTleZLj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNTleZLj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so26200735e9.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2026 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788437332; x=1789042132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRKIuIMQwGJz+W0+V2Cv4f46rDoN+QkQp0uwFbNfBIs=;
        b=LNTleZLjtLgIkdeZGbBPeA9ZsjsvEyJPAhQhNw2PZd7ulApEWLz537mrDf9ZD5zD1W
         IKRBieQ9ZE3yGWPobxeG6n5BXCN5/89i/ov0Hy5ANlwABc6aLPvxpegb5+l79KI6X6Jo
         l+vN6k2xe86K3nisCWYEpHTA7W2K9seBjLKwpUhDxHnaCXI8KzgJRYAqrxjPPrFF4pK7
         oJV3tXY7t5rvjU5gIw4KkjJdJXJ2Jp0YSmz9uJ06ODrtEjzDrZu+sZSay4S6Upq0eK7c
         xB7EzuW9XtK2N2yhAq5gu0jbPGqKb/czT2e3Z6vn0F1ejmGraUuNngCFotffaXXogYwJ
         uJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437332; x=1789042132;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRKIuIMQwGJz+W0+V2Cv4f46rDoN+QkQp0uwFbNfBIs=;
        b=IqYBdugrXSnHDHyz9cdITbGW7qpN5rzXz52I0wjf8W8Imiu6wD39FTKyLK8Y35ZYjp
         XiK17v797ZOP8F2Vcw8ofNT3dJ5eRp8/R2ef+bsfFHUPh5cBVzJocGlJn1//IKLCo7mf
         KdUMkBj5cOn2O69XXHN12F04smL/2sYu5DIawgIqZjRolg+FwZoKq6PlqHcGJJ64IXS7
         P/80j2oX0LdQX13pL8dWVB5QEchEbswyUHRcH/aQTgWzIGDysAEB+xXcmwiaXh30xraK
         KN/ZVwCSGdvZeD9JVzsFEZ92kYNpX3M4ymQFA94osVCQdQa1cLrr+3LKwmcRY6DjbLgv
         JugA==
X-Forwarded-Encrypted: i=1; AKwUvBwMBPTwts37I5Rs9wKrWHYes0CGNaw/ckNFwOXCmlM2its0zW+JrEKsdXmSV2NAFAX5AngPbaILKgM=@vger.kernel.org
X-Gm-Message-State: AFuF++n38FS9YXHmQf6702tKoK9xQd0rqHGlJOXtxXvz0QclMxbKw0sG
	JFJEAmyxJeaVZaR9U5YBruhEu9Kj7Js2Ek7QBbPX8stVz1UAtCsj9DsK
X-Gm-Gg: AYBFou0TdHixcGPUJsDZyIEH4iIpUHvqowEpNfeerplLnPs/J4TvAAOVnAfrDop9U6L
	t6Ec+RWB8fBftgTKRysDnvl+wuNkzlJEMp48ytCuHAArQscpiXChxbhrVU4EvvHfb/6sDlMbKCx
	hyCXzXhcV48lxTMbKhTeMX+gKGftXgl+EMLl6WkWJtygz58jTvrLNbrqTAv4i5iNru8xoOdB1vK
	BCR9KlpGWCxhgipfUi9knSJgWlmDYM5nZ+QeyLJ0XG7fqFalcfzg+Jf47f1qaX/QKACkciggIV6
	iN8++J6urtHQ8fl2K21nhn7M25E3RNP+g5//HV1CIKx4SrgGk/7DdoU23xtgj5zwtoVAyPS6AB9
	eeTP2EGDPkXIT5F8sl94V9Wq4AADMe3IPtWZBQ8g81j4/dNiboxOp4VQykXHp8d7ZsT20PHsPAL
	cHr0ymQYr9nMHYkhmWCpE8C6/lzxPWKr2y0+fP7DlmesV0LTIA8bqtZz8WPVny3I+sBUn6TAPGI
	tZa1lUGdxOJuwVqcpLDj72peEHYlfJ5jvq5rFrEE1l0sd7b+v1ao9YSODi4eFFL7A==
X-Received: by 2002:a05:600c:630e:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49ce55ecea8mr213777445e9.3.1788437331849;
        Thu, 03 Sep 2026 05:08:51 -0700 (PDT)
Received: from [172.24.138.145] (ipservice-092-208-247-184.092.208.pools.vodafone-ip.de. [92.208.247.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf0c1728bsm52458095e9.15.2026.09.03.05.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 05:08:51 -0700 (PDT)
Message-ID: <98851819-2079-4505-b8fa-1b6943ef71e2@gmail.com>
Date: Thu, 3 Sep 2026 14:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/20] gpio: regmap: Use regmap_test_bits() for single
 bit reads
To: Bartosz Golaszewski <brgl@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Michael Walle <mwalle@kernel.org>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-17-e33ca6f841a2@analog.com>
 <CAMRc=MfV+ziruvdyFU-RTbD09E_Jhpxgaab9T6bG=tuPg-jhLA@mail.gmail.com>
Content-Language: en-US
From: Janani Sunil <jananisunil.dev@gmail.com>
In-Reply-To: <CAMRc=MfV+ziruvdyFU-RTbD09E_Jhpxgaab9T6bG=tuPg-jhLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/2/26 15:48, Bartosz Golaszewski wrote:
> On Fri, 28 Aug 2026 17:30:40 +0200, Janani Sunil <janani.sunil@analog.com> said:
>> Use regmap_test_bits() when reading a single GPIO value from a normal
>> register and when reading the direction bit.
>>
>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>> Reviewed-by: Michael Walle <mwalle@kernel.org>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> ---
> Janani: the GPIO patches don't apply on top of current gpio/for-next. Can you
> rebase and resend just the GPIO bits separately?
>
> Thanks,
> Bartosz

Hi Bartosz,

Done. I split out the three GPIO patches, rebased them onto the current gpio/for-next branch and resent them separately as v6.

https://lore.kernel.org/r/20260903-ad7768-gpio-v6-0-4254ef6c9b38@analog.com

I will drop these patches from the next version of the main AD7768 IIO series.

Best Regards,
Jan

