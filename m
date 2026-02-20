Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2D275B18
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771555128; cv=none; b=kVVV3MzctjCypOcA/i3jC2BP0CMTPDBfAeT+GurafeYv23fvUCCrJODi94xZg0NxA5UyamZzyA40MXsXPAusnV5+GtpRr+/iUIFEAoveiRns7aKqC/mz0j2rA9MPUlUtZzuNWisq+knqOVKU0W2PvanhwAIu19fGGHLkO1XyZp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771555128; c=relaxed/simple;
	bh=/Kpq7WtqU5Qo+ElKEvMo8vcHjWvE/xVzDh5NRFw9C4w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eg1K+gO7TaHJab5wafO0wjsY7RPzSPGdjwytiGM8mOETE8EJviRhnCSi7HuwGKVn/r4YhZwfvwjrpQkxN/BbjetGr/zFpGM9cjar/FI7Kg1Fb6PWVHPUSsr6kUnBOCSkFE6Guy6SsbFW/FIso8yKo2h+MmjP9iQ0IUvP5X9mBCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmT4unB8; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmT4unB8"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad019bb5eso1485275d50.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 18:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771555126; x=1772159926; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUf8Tvxn6DWfqyQL0ZrRVzTHnfhZo5ZNQwPMKAB66U8=;
        b=RmT4unB8jgEpckrmPQnDm5iFE0NH80VYrEyR5yFTZA6qYZbZDL8iMssixHPrDuCNMJ
         tUsNZBZBerBuS477wMd0XdiTRbl0v1C6fKIvDGRWclZC9lZkUIStji+lTDvSpNzFKxMg
         TwMK6YvTy/tiCGKMYKGi6sCit5ufTIQC5VOaesZXpxY/CHKQtVlAcB5uB0Ay77TwO3hA
         0Io73xH5K2XfEd+U5+qsnsRcojeuhNzqsGGhBnWLaOV+zo4nJGDKhv+lfCy5IFE6v6ED
         OvO4p4NKzQuiYalt7hb2wym972X5563/3I7OZXCVMxBpWoDs4r8iD97Larp4Ri5jiPyh
         E/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771555126; x=1772159926;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUf8Tvxn6DWfqyQL0ZrRVzTHnfhZo5ZNQwPMKAB66U8=;
        b=N25u6k1MC+ReLbU0a5dYhvdqS/r7d6EUTWhDNheKkPvxFrf7/i1yzWZAn8a83WxL6w
         AqfwU/fa+oa1dCU3GU4l03Isncx4J5oJXgyqHaEuVeE/7BAI0uHaWvgJwdpQnTIJdEKq
         kuwsT6cEJAYV6dm3+/YDBVHu6ABduXa8YHTUQKmllI9287LZz8iHdDwXlCkmdMLzrGiR
         HkyYfqe6ys2tHwyj2odrzR/uwd4hAs92D8gCsFM9jOjyR1N1f6I0QFyfl+q+BMRtaqpl
         6ecAzgcfXCJc4RkLLjmn16RyIwowQMtiFQWZC24DZmFYAHauo/kM4Khb4O/6NFuEGGJ9
         WOwA==
X-Forwarded-Encrypted: i=1; AJvYcCXEmPr7XAU1BP3+swuqlGAYo0UVrr/gYySDg4hzDNbEqGFT1Kh0kD1oFH5Rhmysw8KcGPO9Lafjrww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqhM6legxrhC5fErNbfUtR24EEipeMKUjaSRlnaBwSDHE89uI
	mBuGo5ExATJ1fsJVlv3NfgycH4lVRaZFX5Dr2QdKt+gH477fJUP6BnR6
X-Gm-Gg: AZuq6aIUOAq7lenVeKwKHlmZcCFqVykzSQ5l/6qN1nxs+240cLs2NlgHB5rRTgTtbcX
	rl2DcYEJXfdngiHVOwksea6lDmJlHYDLspoepin48UcemA8C+W7U7Lo8C2Gl+ocz/7B/UUwFpH6
	W6C3LwtvfEFYToq6HMy7xhYIwhmmv4HRK/VZQB1II8dEcyGsL8+tsbqFBZqT8PwYZt/ABYvJC7q
	6liDkHAAq4zXNMr04I0i0PmIdrqtRDUvBB+NCDZ0+r0tGuHDPJmkYdkyCTpiwLUEgGDLU+9MxM8
	qbcU8e0GFxVFdJvWKWCdVMIuYrNwjZ0H81B81vbfQbUUTiGcrSblSrAWo1QYUwstGnNj/FfnwA1
	4tapF8wjqSnKf0p7YnjGU0oT30dy4ZwftluFMW/qrm/3LF2CloFPQZ3F+nUyziNvJZIEvkq2IDa
	SIVcWfcNPsYjJmXUuJXTlBKYT0Cf1MAw7EXXXZnchOX5JMUtuueTV99VUZO1yfnwwzVGnDxO71l
	UPVjjnka3sEIpuvOXoInI1do3P/rs5JMiGcHQJsg0lMi8qVxe0=
X-Received: by 2002:a53:ac85:0:b0:64a:dbfa:cd09 with SMTP id 956f58d0204a3-64c70e1a755mr163503d50.81.1771555125705;
        Thu, 19 Feb 2026 18:38:45 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6f7e1sm7910725d50.2.2026.02.19.18.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 18:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Feb 2026 20:38:28 -0600
Message-Id: <DGJFVHM5C384.3J15UGDT3VGCX@gmail.com>
Cc: <jic23@kernel.org>, <andy@kernel.org>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] iio: light: gp2ap020a00f: simplify locking with
 guard()
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Ethan Tidmore"
 <ethantidmore06@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
 <20260218043728.609659-2-ethantidmore06@gmail.com>
 <aZVlU9SL9e1x8Vwu@smile.fi.intel.com>
In-Reply-To: <aZVlU9SL9e1x8Vwu@smile.fi.intel.com>

On Wed Feb 18, 2026 at 1:08 AM CST, Andy Shevchenko wrote:
> On Tue, Feb 17, 2026 at 10:37:20PM -0600, Ethan Tidmore wrote:
>> Use the guard() cleanup handler to manage the device lock.
>> This simplifies the code by removing the need for manual unlocking
>> and goto error handling paths.
>

...

>
> What I meant in the my cover letter is that you need to take some pieces =
from
> my patches and incorporate them here, so this becomes
>
> 	return 0;
>

Understood, so with the first patch how should I credit you? With the
patches I'm splitting up that you gave, I know to just put my SOB. Just
unsure about the first.

Thanks,

ET
