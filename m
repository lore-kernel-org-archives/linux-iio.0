Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3724E4A8
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776185521; cv=none; b=BqULnIawB0IUaHx4bgGBl2UX0qrJf/GRSnwryYWIQg9/1GY9/Nol+GWprYNJPsIDSME/PASVx4Nl09+aWSX0yjcYk3UpCv/M6vrngJRcc2ohK+/UJLx8ZIAwEeQa7oP+xa4RoKSo//8fR6MkpehDDSEx4nGkJC2HrWtT0Hh1Buw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776185521; c=relaxed/simple;
	bh=/ij2d71mc2Et6yN4ppdwQSyZAPq+qpiKVHLB0QB8pS8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UwZvaQalYCSNaVMRfi7jmFHf+d0OJ4izQtpi5Y0Ry8kbM3VSvIKizlMZrvmVFy7HDQtj9YIEh4o5ipmDANBjCwFV5XPCy7J2G8h8BHkeUmhdIv+BUQWPy8O/3lYFSeyLXGfCZkACZw749921YQ0JEwMnLd3NKbqs356u2XH8iQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N112tpRi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N112tpRi"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso1525553b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776185520; x=1776790320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ij2d71mc2Et6yN4ppdwQSyZAPq+qpiKVHLB0QB8pS8=;
        b=N112tpRinsAtHPh7+LHmNlDozi/2U0uU2vfdBJELU9lG264SKoDbFqZyaNo/6WEmj4
         uzz4N7BfJFDGsb76TByNsGSvnIvYvprw7Xqy8hd0vfYp+4h+TIp9pgvMfAv4+igsMw3k
         m2yuGHo2ERmUyuv5Vp8yYFVrUM0i/y/YKnHMtbmAcvuYqE4K0y29XCfTogZmVxaeJfKl
         yMxi75k5qM6sONXeqgT8TbJ+6KMwVQ32OwlYK44a1fK6K+sEut5cpz9BD50QYfFxsi01
         IlThJQK303U6ykvPQpMWn2WU7nAIjoMKrrHk8d6VIlal1i0l1vfiyzImt5pZ9o47Nzi8
         OaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776185520; x=1776790320;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ij2d71mc2Et6yN4ppdwQSyZAPq+qpiKVHLB0QB8pS8=;
        b=Jwy9/a0t/d/ZvwcT/tAzKV4tKA6yfIQ54ABN+zsUZfnjnkvIeDuOUHdXC1Otd/ftRe
         u4peOi7Q+4bmqceCMjof0Mnybw6/BpE9fKzA/eSURk63rnZ0lj9MP5gFBc6hu+rcSg+9
         NW+67O9XP3y/gvV3Ls40omBGF6PJCK+MwIlXlCxkfuemuNltPig2CHqErnngVgAOlVyS
         SoLc+OC5Mi5DOtXQpYdRKyKEnewHFiusUW3QStm3IGaB6JRbO0uZco9PSiX0C6Y/DCrn
         LkIAlafW3Kl83G9Pln15JCsh6Z+EJFOhV8DKp1EKLv90S/KbxPGtq1FR7QGmoPZsBajh
         AHbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/I3UDxtT/Ge3y4UtvwaIF2L+IHnj9aUnbOzdz0EzbyJQ1Lv90MGC525bagh4mKUoHPbGJwoT0Zyck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLj+Qv98zD2LYlJ46rMr6laECKMI5RExBU0qq2zwOMM7A14rW
	Jxvq69+KNUTLplj44eVJt7bvwxO7JAEcAQYOJ+6M9iSwkZ3NSUh9r3SR2qtnDw==
X-Gm-Gg: AeBDietmKEwN+Wapx6ZG3jc8ycyJytjLI5gXdhWjsYpYbHGP4gMj8QpboT/ha9hkwKX
	7GlbB3ms3XzAOdyht4gafUi7W2ihD0jtcFd2BVu+SS0Cst+s4+sy9803P6Mrg1N/TTp1DJ2pRSl
	s/AOZcG2YdL+PGaOFy3TRBX/A65TSEnwGPa//wxONeKR0WayAd2hYfFgLEcHAJzCxcxfxrylHZd
	8v9ytfZQDUP9wO0PqBbZ+3ZuXAHzq8J/ks0WWFOhnWRzUg1QAzaDxQLfNURdGja4RP+lJGwIMLS
	2OWe//Ks+DTPJJoW7nDMolMRPhfl/j2ZUytOYhhA9vpYbP2fWbAK/PcjGiiOzeOtAlM1Zug3/Lt
	kH4O5gz1WKyst68K/2SzzAZt3qCOd2/tST2M5SIlv251IHdUo4nFklLwx3sEsXnxrk90yhsjnGC
	KyRQjc2DylnIFMrZmATA2IydJn2RT2OaJIhyk8d9sHapfZ3jkrAPH8QDYALg==
X-Received: by 2002:a05:6a00:3c8a:b0:82f:5576:2853 with SMTP id d2e1a72fcca58-82f55762a9cmr3913259b3a.30.1776185519664;
        Tue, 14 Apr 2026 09:51:59 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac12:a4a1:b77e:33f7:8c2a:3842])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm14838251b3a.24.2026.04.14.09.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 09:51:59 -0700 (PDT)
Date: Tue, 14 Apr 2026 22:21:52 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/3=5D_iio=3A_adc=3A_ad7173=3A_cle?=
 =?US-ASCII?Q?anup_codestyle_check_and_spell_correct?=
User-Agent: Thunderbird for Android
In-Reply-To: <ad3zd34HnrzB0TMH@ashevche-desk.local>
References: <20260413134223.2331911-1-sanjayembedded@gmail.com> <20260413134223.2331911-4-sanjayembedded@gmail.com> <ad3zd34HnrzB0TMH@ashevche-desk.local>
Message-ID: <F9A182CC-62C0-445C-BAF0-9CDB7FFB3868@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 14 April 2026 1:27:43=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Mon, Apr 13, 2026 at 07:12:23PM +0530, Sanjay Chitroda wrote:
>
>> Reported by checkpatch:
>> FILE: drivers/iio/adc/ad7173=2Ec
>>=20
>> CHECK: Avoid CamelCase: <AD7173_TEMP_SENSIIVITY_uV_per_C>
>
>Fix checkpatch, please, to make it understand the Syst=C3=A8me Internatio=
nal d'unit=C3=A9s=2E
>

Hi Andy,=20
Thank you for the valuable input=2E

KTODO: update checkpatch to understand system international d'units=2E=20

e=2Eg=2E Standard unit list:
Prefixes: u, m, k, M, G
Units: V, A, Hz, Ohm, C, K, s, W, etc=2E
