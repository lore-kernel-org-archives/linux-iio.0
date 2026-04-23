Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277323D7C2
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776911436; cv=none; b=rhvlnEc3y32jCSj/F1CBaSPZBl8I9jdcPFmtbAh0W3UMCMX3mM5ORyar5zVC4aFrliRBcAyfis+zq5dWcMkVbj3biPhGGLA7c9AI6GQYtyODxlLFoPQwYIR/Sf3cyvakYhzdbZ3tfwZIEHmYcp2RVZjCb1EyfkhX32VVuoXglpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776911436; c=relaxed/simple;
	bh=Zs+BXQ5/hgHJh017J43cUebk4kTb4SZI9Rul+NNPZw8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=C8q0Xef+mvHGvYnaWoNzVXxj9R4LEMV4YFtd0VhdSnHuhUJ2C1Cq0hQOVlJNH9D3kdKcSWf9DVx6vgptIaG5U5DzQ118H7A/ih4TXz54xdcttjRrB+6QT14ZQ0R/FouEkbZlp8fsUXLXQdPYNlrGZk1+KBJcgSpO43NCT0QIhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II5M1nhz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II5M1nhz"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so51356355ad.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 19:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776911434; x=1777516234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+AJ1NbFhg4HBMp4LCD77//5RxTY1aVb1ulIOEO2Fv0=;
        b=II5M1nhzJKWWWsHA3m8bEjlnEgSudCeT048IISwYG5PHjo1/2ri5Jlui8Q7DiWBz1d
         WaN+DVrq78Z0tnONL5FXtS4BXti6DnjZtmQO/UGVCCFdqz9KK7z4cFCuV/iXhG5Fz1mA
         wiUaI4woIAX6nBclTIXsfUMCBsqIjKK0bU3RrD9Q/PAGQFmpImU77nUyzTmpO0KcJrox
         nWHlwT1dT9aMgyVrIfamY5Gv04/PuwOIW/wUfdGR3iW9E2ukJk0GjYj0FArorY4PcDCa
         uQ+1fvQIaSHK+w3AbLM4ENR/3/cnKQIugBUxHF6L/NcJX7Pr9XI7+ma01Vc5DWMtutja
         o+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776911434; x=1777516234;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+AJ1NbFhg4HBMp4LCD77//5RxTY1aVb1ulIOEO2Fv0=;
        b=b7Bv1io1a70mk57++YUgPrD8VfaF7imk5lOrr9AJIRgt04i/AlmQtYXvgXUDa6zj1/
         Des+HlTiZf6Swjve34CQTYJJyTxqHZOM76WNUu6UB9/9euGZQIoEGO+8ehoMgylbjGIP
         DhTMF9KeTpMoJLMK27OKAW4mTWd26HOdIoAAK5yxrzCvKNH1SpE/SGWSinw82y3wDYyG
         wkV0sTMqGVcMdPrpNVytS0DJiKNCfPdNNVd/CBbyoahD9zFQQBcmpnBRkQzlbrRUXr4S
         +1gQZf4pyWMhqwrGd/Lbq/8owAKf6wjzJdMl1nOGpVxo3LPuXmgFMJA1d+dly37YMfP1
         4xrw==
X-Forwarded-Encrypted: i=1; AFNElJ8feK6ZRj6PYVU38n+1tHTqxhr9RRi9pDjOeeqI6MVnLA2NBHItXOuMp0vW1+1REHYV/DDmmzBFVYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAs9QGDNrtmLrhWBPyF8GWRJv6a+QWJKPem3BRMxWop12ApxZo
	8xay2VNq4Uf9SyxUND0/SXMDNn9Fo3hT5of9xGKAPnVoU1kdFKs0l/Cq
X-Gm-Gg: AeBDiev9V4Zni/vlCy44wWunEN2zrNazIqW6Ke6l71vDzaZGTaj/dVvAr0yqyJ4q2Tm
	0p/x8Kp+1tQ7T9th/xh4Oa88zzh1+RcaHZ+sAIQeRPSuECiYl/2jXjnODqc9gPzJ81hjRnTOGP2
	jXeHyLcq6JXaIUaIwHL1TgEvLIQ+DVmT9DMYhSCCyx+uC9wwVyE66O8Ngn2wXt3WGqEXqSH3Ho+
	q7nt4yKnOvUuJJ+6qp4uq1QdBqoRmYPMuIO1un4qaThwWLvMuGyt4TB6R2GQAs2Ub+UbTAhdK1U
	ika3LpEUpvEA+5s7yLLS8Ae4FMb1yaNZsu8PBxyOgLiWTEAl92fupk4PZyQczsGubW9dcAZQWgu
	2VQMZrgSRMcqnWcsPv4I25GBK9cz73XAgBlF5yupi0HwsW+q5gq8RmmoB4VpLBUnb/JJqUQSQkh
	4Ep3VB/W70v0+jIih98Uo874kY2wWKfDJCtC/zas7rNYVw58aolFDWD9omtg==
X-Received: by 2002:a17:902:988d:b0:2b2:6cab:30fe with SMTP id d9443c01a7336-2b5f9fca466mr195164535ad.29.1776911434158;
        Wed, 22 Apr 2026 19:30:34 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac11:2511:e0be:6376:6b19:86dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab2112csm170839265ad.62.2026.04.22.19.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 19:30:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:00:28 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: accel: mma8452: sort headers alphabetically
User-Agent: Thunderbird for Android
In-Reply-To: <aekhwk14at43zT7f@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com> <20260422165643.2148195-3-sanjayembedded@gmail.com> <aekhwk14at43zT7f@ashevche-desk.local>
Message-ID: <371383C2-BA73-49CC-B2E3-17A1B11A2D6C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23 April 2026 1:00:10=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 22, 2026 at 10:26:39PM +0530, Sanjay Chitroda wrote:
>
>> Sort include headers alphabetically to improve readability=2E
>
>=2E=2E=2E
>
>> -#include <linux/module=2Eh>
>> +#include <linux/delay=2Eh>
>> +#include <linux/i2c=2Eh>
>>  #include <linux/mod_devicetable=2Eh>
>> +#include <linux/module=2Eh>
>> +#include <linux/pm_runtime=2Eh>
>>  #include <linux/property=2Eh>
>> -#include <linux/i2c=2Eh>
>> +#include <linux/types=2Eh>
>> +
>> +#include <linux/iio/buffer=2Eh>
>> +#include <linux/iio/events=2Eh>
>>  #include <linux/iio/iio=2Eh>
>>  #include <linux/iio/sysfs=2Eh>
>> -#include <linux/iio/buffer=2Eh>
>>  #include <linux/iio/trigger=2Eh>
>>  #include <linux/iio/trigger_consumer=2Eh>
>>  #include <linux/iio/triggered_buffer=2Eh>
>> -#include <linux/iio/events=2Eh>
>> -#include <linux/delay=2Eh>
>> -#include <linux/pm_runtime=2Eh>
>
>> +
>>  #include <linux/regulator/consumer=2Eh>
>> -#include <linux/types=2Eh>
>
>For this driver the regulator/consumer is a regular header and can be mov=
ed to
>be between property=2Eh and types=2Eh=2E
>

Andy, Thank you for your review=2E
Along with alphabetic sort, I have also grouped different header(s), at to=
p linux direct header, then iio headers and at last regulator headers for r=
eadability=2E

If you suggest, I would include this in commit description=2E

Thanks,
Sanjay Chitroda
