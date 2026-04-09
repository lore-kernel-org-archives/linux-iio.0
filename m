Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48D336EC6
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764714; cv=pass; b=cPM7iEH0IoDcKn47R/DAQ22X3XpeFY6ffH5CU4NGN7p8qeIkZQT7PktLdsm9a7S+YcKZ6qVEnXXb9An+GSriML3Hx9T+BiB6sN3RJN7d0ARgKXIXNeEXHGy4N6k8uMaLjBq0zRIAswnpPPqL35oGh+vbz8qVuQKnY7Awefma1Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764714; c=relaxed/simple;
	bh=mMEfegMUrZlzMQIanpKaU9/P116N7bUNeCI61KMB8lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu7RmF9fnFm97MZVP8jtO8+BHsFsZsEvZRcBpEXxixW2jgFyYTjhK5ZVWdFq+b84JkbtxY0n4rjKoORG7/lPMmN5m4GS3Z0k1GcgrQYALtcP0RF/b/NCrmys2JoARE1Iz230Eg4ze/Lb1teH6CgAGnraXiautmtN/s81Qa8u4OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVHF8D14; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVHF8D14"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso13766065e9.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 12:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775764712; cv=none;
        d=google.com; s=arc-20240605;
        b=eT1lszRn+Mb69T9E81XMc05NgJsqk1Uw7nAuJx6TV1SHNiKj64K3+hS5/7Nw8reVGU
         tgzU6K13ocz73O7vy7ONsDD0sgBxA85o7eii0N4FhVmEHbR43K/1P4iJyxlGkCpqyZ9s
         IaA1zZDvQu4GW5NiDemQb/NeJQ3EZHrWQQwqv39OLkTvtDFR3+p1gZ1hhb5LKHdGPlqs
         1dZ7sD3O4A6Gnihzvl/5G9zWR8eCLri9ZZRH+tu6a1NQLY3Eek9Zg95OIfUavg+WN/eV
         5Cc+Uni8rN0RyHCoAT1zG4T/MjADjy8Y/mN0FBYXCQOQ/49aCz1XuG9UVztuQER9y0IM
         E8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5ZfNNSumJcUJcRXJ7KHcamfeklPULshzDqG5rSail8c=;
        fh=qVbdAT+Tz8Mh1YkZ25BA+ZUkSSQlpCsz1AJzeNahCV0=;
        b=gLLT3yiREO8XosN1QQFXIoTMQVnLRwETcI8KmxutAW9UuNDm7nN5DLY8vBp4GA93PY
         JChvrfre2TuUv2A3SGWwaPX8rVMeGVQkZBfOjwUEkb0GgWWHcPQTz9MiL2y6rzdH9CqD
         NO6nVUVx1ErMNbj22ka2BrBT/3nPUildXPGNk8jp2oIljPjsb+WsGNbpR8om3jl+M993
         qjWWLeG5WgVMzUSfl46mImxXtJB9PIAUYr6yKC7sEf84LB1egXikV0xdyIzrs31bvOvz
         xd9tvYDCCd5VnWm/vrPKsxNVMIzpoq2hDqsyvV9sc3p8cwAzUWIhmpY9z6SDESVI3iVO
         YeDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764712; x=1776369512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZfNNSumJcUJcRXJ7KHcamfeklPULshzDqG5rSail8c=;
        b=rVHF8D14Z0nHQjh5+7upj4L4VzV2ywrfeUyDYDCi5EsJCHm3NELezb06dJROTLcSkG
         4Tkw96sJ1YXMrXrYK4P9/q02PhtNMqqA/DefJRpyQXQ9+bT68UIZOBuozPPLm8Ymuktr
         H4pBkNIlJ5bYLwFzf68l2DxZLbOCDyuUAlcZ+rm2MOBpiMMNmlCdCyZBy0y5/8IvM3gE
         zJNbg+dZoqdS9xYqTlllvNwiOCN+63O5DQacpRWMFNlItFRvWMd/vJdHmLN6nPf7Np/y
         Asg92kP3FA562qqL10vWnEJ1goLaZRXV796BsZfq1NWDV2DmkHTTl/MkCukqO1hR+Kfq
         RZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764712; x=1776369512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZfNNSumJcUJcRXJ7KHcamfeklPULshzDqG5rSail8c=;
        b=YCj634V0NpQcGqoPPxbRoLdqg/y29Fbn7BTH+ewzJ1Iqq4irp/1chkMwFnOd4QSa4T
         A+6hk3d0xz7nXWzKwI5mZEdtRxFQAdE1vzzIdk9gMUZWGjGLa2AaYOrn/eKkz8n0AGU6
         dZazz6aKrkV3N0ahUn9TghreATtTuamErlrSzGW7JBzYUuSAxHHV1QUbXoA0YUzpb5dQ
         GP7FbUwK6KFFXz56yio2ul6xEJueZinB54oEIHoXcyk43MNbcqCSioBr63CshKabLG5i
         TPAIzzvrAPlsMR1ePauzLJbVblw4xrPabL6y4rA1nsuBFUWQZQva4FdNTUiZC+af/Z6h
         TPdA==
X-Forwarded-Encrypted: i=1; AJvYcCUo8DxT3klYd4tImFXYveOk1E4znFrInw2o0iy9nTZ7KPLfmpKD8RzL1PzYBoAvsaY5yDJL1pRiOJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQf0EhUsStGjX0H/WA5WaoMwT7McUflehLqA+st7ggEK3Bdxbm
	S4LWVKQOgqvEHsFyq1DcEGE0yEjzSNEM5EO6pkkH4U2S7xvRhbxBYZvsd/d9Bt05ZB8f4u3AQ+D
	cHTMcjlVFKkjHlvjMx7rWWRETiH3AGMg=
X-Gm-Gg: AeBDieuJPdpnjWs+NZP5JAQnQXTv9SdCCoY/+gV3workHj79EG2wFogsqFkiauZXiwK
	OPVeRYMo1BVeAr0/zxMNtH6gXpz2OmgSYmFxe6Nkohl4T1TDawkMnFV9WcZi/QXVkixSlg56XCU
	bbfg7xAsQNG625xR7Aw1BPAWXv+fJt4R9kCiqsrqdIGbv8ubGMm8ZImNrYXvXTTtFb11y9i6/jV
	0wTPLNde3TrHQhYjgPaVMfz1/nwPr/q9aY/rm5gBQb8eZVlPeugiJ5vg3BBBJYekeFYGdbWN1yc
	uvmjOGq0TTlbc2+v2euUA+HO9i7JHoPIq9ZnmHOt9PBqOrY6KHf383eOMFPk2qPU7E2fUgjDF0V
	Y3lfiAQIIvQxaRMhBQ15GYVXeHtwYZlIhm/U=
X-Received: by 2002:a05:600c:4451:b0:487:1fbf:e0a1 with SMTP id
 5b1f17b1804b1-488d68057e8mr2321355e9.4.1775764711692; Thu, 09 Apr 2026
 12:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409131823.1289-1-joshua.crofts1@gmail.com> <20260409182755.499a419c@pumpkin>
In-Reply-To: <20260409182755.499a419c@pumpkin>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 9 Apr 2026 21:58:20 +0200
X-Gm-Features: AQROBzDZ48Zj14TBxP7h6GTA7eaCDP02hump18XQXQ6s2JgG21j5v_0OT1ufOPU
Message-ID: <CALoEA-yVCyyiA1gUCj4Z0JcLscpSSssPCPXnUPOciWJOHj3VUg@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: ad983x: replace do_div() with div64_ul().
To: David Laight <david.laight.linux@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	greghk@linuxfoundation.org, dlechner@baylibre.com, nono.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Apr 2026 at 19:27, David Laight <david.laight.linux@gmail.com> wrote:
> Except here you have clock frequencies.
> Either they fit in 32bits or they don't.
> So the value shouldn't be 'unsigned long', but either u32 or u64.

The clk struct in linux/clk.h explicitly uses an unsigned long to represent
the clock value, which is used in this driver. Using an unsigned long
ensures platform independent usage without type mismatching.

> You need to check the domain of the values, coccinelle is just looking
> at the types.
> Even with mclk being 'unsigned long' the code is fine provided the
> frequency is below 4.2GHz.

I agree that we're not dealing with potential truncation problems, however
changing to div64_ul aligns the types with the clk API and scrubs a perfectly
valid cocci error.

-- 
Kind regards

CJD
