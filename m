Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A434D4EA
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009569; cv=none; b=jH2R7Fs3rkV+t+McwXSb0xAHoQyFG8CfakrAhwaR5g9AkUtBoElcMJU6h8Aleu6saUFQ9+SHaaJuBZL+Wx1/ydjdr9rTAOIKr/U/xes0u8nTrmiZSrGp0WTIE0EnCnMSE2WVXzh0tWhOdpqwHkddnfk2sjQDbg9rW9b8FUdaCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009569; c=relaxed/simple;
	bh=0oFHG/9YNr6cXFesy7rAK4h0uUsngPTJ8X5jVnsIw9M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:Cc:
	 In-Reply-To:References; b=Rzv4tu2Lmqpd6u+gS18SKIT/NV+Qd1nNZSAlBioI1gM9vXQP+iCeXaknKV1f4H1Snoc3gb8/fYM97QpGFLFP3YymB2FqKUTNVsyTc05bEwWNtOr0YFfASLArPwrWkUTbZEYlRjaAi/5gmlD6Zh12svW6c2J7H/fHCFmy9GpSbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTP93Jqt; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTP93Jqt"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so1754914e87.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779009566; x=1779614366; darn=vger.kernel.org;
        h=references:in-reply-to:cc:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e5hb4GkBKUt6rdX+SQqx6eHCLZLizik7KNt6EvEvW9I=;
        b=VTP93Jqtr8rYPbpofWccJi1jXQ4hWec0pFsKkicqs3L1wkxUG7nqfeolHUjwrycUjq
         cOv9YMC/N8mnOoJkrSqBN7SHWrVz15F4jIhqdGCXGJCUeUp2kjHB6p0OnGdPXC6ThCp2
         KxRXcZTbb55psc3UUPBi35T/7ITFA/GO4iti8X3DhTldvzr5Y3UrlJDfRljGF9JWFr+c
         MzfrQdoOFp14bflPiaEM0JzRXQgvs3PrRHR3MEIg1yJ5as3SQehFWB9/SQXA5pEBfDNI
         zOiHs8Sr07Vo0Q4IofRJySQeYMjq5NWqndVDIMEecAa81R7S/cfO19oQeka1SwbO8JMa
         R9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779009566; x=1779614366;
        h=references:in-reply-to:cc:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5hb4GkBKUt6rdX+SQqx6eHCLZLizik7KNt6EvEvW9I=;
        b=HqKFclzdHVazmbopOxmaJFgZiTXo8xcDRzlodRdqM0oj1Iqiml4TUgZw+MMjcS/V6L
         USsmq0mfg0cptYW9/0B7ipAeSJ7uwa7ivf6I8V3/Mdtzl6miFUT34f9i3rXdgblMOkKD
         aN56JXarKw/aJQN7xIodvOqzcG2nlNo/80b9HB7M46krWzGWhyd4XMfFd37SPZzxtRvS
         hgmoeD8eJPjoa5WiMkIH489M2kc+2AQap4628kqHmyggkFMUrZ4qeCKHXdzf3bCuNOgE
         DWwdio5/UqbLxRbKEb5eMIrBH2Hql0JYnaZdbGgGAerv2cvjitFet/GhWcPDI7F8mERC
         9WVg==
X-Gm-Message-State: AOJu0YxL7LPmcwyrtXgFFIDA8mZ4lXzn18CNQ1srmV2/wGGhQLVh62p8
	/4hxiXE2g6qSqAXJX5Vighmq71feYmdLqIarl7al724IPJgQFy87CaxOquIV9kPm
X-Gm-Gg: Acq92OGKlXSKkAuuNytztfMi1j5JCno6hhABrTqllrSYFI/KJMf2Ev8zXPJsdDHAqgZ
	Rq9UnEbcCGITG/ttCu+Cx85tJua9Zqjs7NJBWX8hX2e8cDqrbbtZ7Z4o4M+FRcQPxm3VoHxErOy
	3dwIhVFMC4J3M8ECtg0YWtHobnYcN3XFVrjPkdxF9KoQEtAeh31pbSXh1rKLCnc9fySYnbnN18g
	UMNvHCHcKlyCW2UnuxyYezhX2GhreuEWNytoDTULU0XWfdRlPggcH5pCd+Ig4VDqVngeiKHjDWb
	wwGNSfeHasqM4JnKIVEZYbbmzI+q4rOPrAbW374Qg8AQ617NGRSk02WIKZ9DnB4mEcMbwpWzSuN
	qku2KJRnkT4AcIotU+L3X4vZYKVb0oF0FcyK16MmuKywOIBWv6yx/tNocmUUG/58g1mYM3Bent8
	W/aDe4st7TbrX/EV6Xy6nVb2I1RsIvyVhihgKF+gpgLWpIPTGNsDGzncbECM9Hxx8HQ4MMFnSJt
	8lB
X-Received: by 2002:a05:6512:159a:b0:5a4:505:f63c with SMTP id 2adb3069b0e04-5a8ffc52773mr5720181e87.11.1779009565737;
        Sun, 17 May 2026 02:19:25 -0700 (PDT)
Received: from Shofiq.localdomain (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c7214sm4185211fa.14.2026.05.17.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 02:19:25 -0700 (PDT)
Message-ID: <6a09881d.8a1109d5.2659dd.6b1c@mx.google.com>
Date: Sun, 17 May 2026 02:19:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1525967955329319804=="
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: stepan.ionichev@gmail.com
Subject: Re: [PATCH v2] iio: accel: adxl372: Add timestamp to FIFO data
Cc: linux-iio@vger.kernel.org
In-Reply-To: <20260516211935.36773-1-shofiqtest@gmail.com>
References: <20260516211935.36773-1-shofiqtest@gmail.com>

--===============1525967955329319804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Stepan,

Thank you for the careful analysis. You are correct -- iio_push_to_buffers_with_ts()
writes the s64 timestamp into the source buffer at offset ALIGN(data_sz - 8, 8),
which in the FIFO drain loop means the write lands in data that has not been
consumed by the next iteration yet. This is indeed a data corruption bug.

v3 switches to iio_push_to_buffers_with_ts_unaligned() which copies the sample
into an internal bounce buffer before adding the timestamp, leaving fifo_buf[]
untouched across iterations. The size argument stays as
st->fifo_set_size * sizeof(__be16) -- the actual per-sample data size -- which
_unaligned() clamps internally to min(scan_bytes, data_sz).

The fix and the explanation of why _unaligned() is needed are in the commit
message of v3:
  [PATCH v3] iio: accel: adxl372: Add timestamp to FIFO data
  Message-ID: <20260517091735.135610-1-shofiqtest@gmail.com>

Thanks again for catching this.

Md Shofiqul Islam

--===============1525967955329319804==--
