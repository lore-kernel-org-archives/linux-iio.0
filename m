Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E346EC8E
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934804; cv=none; b=GmzUvsPoNggs1PO4YYl5Hc8+nDXYH9GV09vn3vw8mHw6gAnC1GwEKVQjXjWn7RtkAINtolF2XxEJ/LYzvAfn4dst1R442etL9+6CpBQEC4gNwvvA3MgBPDqGLBjJKaM1MB9hHFTTpJNC6hn339FhQv/EM1rg2OJ7ZHvqRBmsz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934804; c=relaxed/simple;
	bh=T/wMbx9Z/1zJbIR2AmMs2iko9zhuwQ9+fe+zLoO8T0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qL7r1SVjig+9iMW/zTgVeXrD8nPxL70g+1T87uNt5PC0pEHvWvsfp4dPqTG/F14hW8kK/kylyPR5uQV/nJnhPEL2cOqNA+hsu8eEm6hneC+QKNMrHoOH7U6YX2+e6UmBS7cGeRK9WK05NaVpWd4lEDRHHQMDZJXdeNgcv7NM9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=E4k1AKzu; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="E4k1AKzu"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so583945a34.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785934800; x=1786539600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wM6yk6r0NLzOg7GU81l004OjiLwZ1wPFuT48mYtM3/8=;
        b=E4k1AKzub8/TLQwFZjPJLCOyDAQN1H7G7L/VC6nr/O8AZB8wEbuixQiyHHVjQY+BWh
         5K+ywkzfPI2jF8nx1QrzrRXlB/ktZ9jY7zzRkFUmGCnTPhwydZE2JPDMD1xmn1AJGn3K
         3gNpKsmxBdPh4RZZkgJCoScU70IzHNHGHwgq7hdtmt+v/016vEvvoHXyZN0zAbbeB6Zi
         kqD+ZqptNQk0+MrVwFUL3oMPZ2m2jHf9yE3RCXNiM4oWdJyFygzsxtPB7hH6x9IpL4my
         G42AAes2N4izuQZ5aVONGxdBsmgtnrSWbC7MvrzHUrUC78z80CLKd8s3oEjZw4YVNt59
         +iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934800; x=1786539600;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wM6yk6r0NLzOg7GU81l004OjiLwZ1wPFuT48mYtM3/8=;
        b=EEwGc16lpk9Nh7kP8F++91ystacQ12Ct21IoMxYN/du7lo7NOxiaNs9Nj1b/ORVMg5
         zP/JWjs1Dr53Pl01bUOGO3E5U7M+xX3dDOgIBSdT24wwu0/5+Hp3MbODnd3Uo6e12yhR
         xNkokd0AU6v82I84DWoHMDkWQ/7/99QEih4tDdN8/FR4PE9HmIpcAvK8rp1a9h2MbMuq
         A3zX997tkcruXFWcm891u11vjPIfWo0IJJtpkj10DnHo/3RA/uBMRuUyBc+dndGiwGg3
         rcHu5mEDtE27M1QD7KEK4OjjLKPEZP0u8600R5vFhPur1fuREeiJBU0nPmLiFQ/IXNEH
         zHTw==
X-Forwarded-Encrypted: i=1; AHgh+Root+vt8L6Ss3HXB0r1P6gaWkc7JTtiX7m0j6A/ixq0VzWmAHikgZYlVdkJXJDoiIlD+9XK+ilQ3Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbjTbO/CF3lA3fYZ58beFtdTmBUQR+dBfq43DQ8uaq+vfcS7VB
	ezfrhw4lus9SA2lA0AAaRD1tskXPbyWRrxK9q5IDZANYlEWMGrSLJfSemlUu4cJHWU4jz82EcYH
	YNkll5/Q=
X-Gm-Gg: AR+sD11fCLSNPT+5t8kzEqlCAev7JlzdJ5HX3Mn6uOUW6aKN3B5fUou1MHjOvjGrEUr
	kW0yIbAynV3GuS1X/48wyeKvX92CaKCAKZZvHlJia/cqTCsjDZUFbMdEZjYtDnlUzMYF8GQ+yeK
	utRs7/2+S/muPRCoWJkqMpRDBmGn2mQg/MrxFsG2hVEyqr8DpOuVHZZgpjcTkvx96RjNHYVQLqE
	e/1jld1XLmqiqbsKDlfWV7WqW9b2U4R9WqmZld73IukwY03EG6TTloYKI4bZEdfEbYjgSc2cMY3
	ghxYYvncP0Z7pXhKXSULv+fq0YbsoFicHSqDaMWRGHUswaGT01Bog6691PpAb5csaWO9JpQ+M0b
	uBp4PJEbSxi+I/2f0BVjk4OtgU/e5P1wzfjeykJ19iNohbd/EBS3Zw0Pmfs2S1ChbCkZdE8JvQo
	R5eWgvE1Cd8C3qKt5LlRjYgkSF/73gaRWrNedUO5bKEmo1VXqW57fZa1hz+qvjiJP74vbES/EoF
	j8IdfPsTQSgI/N0gRiOdbT7QCegYhKLbTpUJw4m
X-Received: by 2002:a05:6830:83b9:b0:7e9:e0f3:b914 with SMTP id 46e09a7af769-7f1e5e8f1f3mr4274433a34.13.1785934800450;
        Wed, 05 Aug 2026 06:00:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ebef:9550:d591:36ac? ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df59d551sm2746912a34.20.2026.08.05.05.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 05:59:59 -0700 (PDT)
Message-ID: <1ed98f0e-04dd-4cbc-ab08-96d076e77da0@baylibre.com>
Date: Wed, 5 Aug 2026 07:59:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
To: Linmao Li <lilinmao@kylinos.cn>, Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Maxwell Doose <maxwell@maxwelld.cc>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260805110255.504576-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 6:02 AM, Linmao Li wrote:
> slf3s_suspend() stops continuous measurement before disabling VDD. If
> regulator_disable() fails while the supply remains enabled, the system
> sleep transition is aborted. Since the PM core does not call the
> corresponding resume callback for a device whose suspend callback failed,
> the sensor remains idle after the system returns to the running state and
> subsequent reads fail.
> 
Was this observed to happen on real hardware or was this just deduced
through code analysis?

