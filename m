Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9C30D3EE
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621359; cv=pass; b=GOo96RkVsABFzIC98Ft7lsUeI5RlgUUXo52ZJZ90MDcfg3XY4IJoTYMB8y1vS2KIPMGxwGJh9cSgCTfE2xk58GRJRYjtmGxUc3lS4CtrmpLHJ72rkl0rxBop73u3B1WIb5japCLzXDpjEGZTCjj4FHKrzzllyznODLIjWQcqGNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621359; c=relaxed/simple;
	bh=+Ah0iXSrbj/vIWOgcYS601AF8sHPjPNavmOfnknsgk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuyMbOJVkEUrCaxusU8cqAKD3LUS6AOKDnW+892572WgvlDMKbn/XGJDwKNvdBin+uMeCaVqLrrxjBIe20jHDnfKN97V0Owoho/jijzSgW4FsiYmrWceXCMOUXcHQvpyYfqmPzNq/dz7mP4iRLLaDjrBoTCGW3/PF9x6rAnP40A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlPELZ6s; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlPELZ6s"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33c2520ad38so950385eec.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 01:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791621357; cv=none;
        d=google.com; s=arc-20260327;
        b=njGGzl/nQJAo9rL0FZgXGYi0TIKVnm2SDuFc/9vGiwGLsxasUVdOuToLHCqF8RXUre
         qWC3t+7HGlVInwcUeLr7XOC1rzKg5WGJ+swzm49wMUdSHZrWxsxLbhExJQJOc9Y1YyG2
         +njdVKA8ywWDM8k8ZZ1n9WrH6ehd7vUIlyUZtWpO+uDAvC/8ZMP9wXWjplYeBdsmb+PY
         yCInCCKMUJh4isRtFU0y+MqE71v8uHC3YYDh9M0zrei78Mujt/CfbEdDFlGwP1b+VUHo
         k2+VLX2R+QVLMnSODKsiCJTyv3x7/nW/Wq13ymWdhkdRy96QKjJZuisPrBvHF6uVyaIj
         HkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MjeVPOBrZxZk8zOp/qAcB3ja6M2cpy7hSuGh4PvxsM8=;
        fh=6UpoeWfhQaIzbMVbdSCVa44J6qwa+tdjvOPsGHJlEA4=;
        b=ICD7UaBgXa5sefx65INmq5hT31AkUxRNt3U8BWFA5rbbt7nvwnA4pzKnMUdd81N6nu
         R4aDqnRs54VArXZkF7YQ4ostFZzW1GSO1wOVAlg2o4M+nz2COKdcWrDCsTLvEn8Z1q0Y
         GGJtLP07MIxQoyMjWcfZ6rvZMTmxmOWZsz8n030Y/ijglmUzcBi91shzi128TUeOus4C
         i76erP+8CB0LZsQS+/7YMztyNy2j++ZIJUhn0kWmrFREFMdIwT08I9RlXozZfJmXCKuO
         924i1yaEm0Zx1jT1NmOJoO6ipZybENbAKgN6lr/voLhh+P8qXVYayreXGD9RzbCokBM2
         Konw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791621357; x=1792226157; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MjeVPOBrZxZk8zOp/qAcB3ja6M2cpy7hSuGh4PvxsM8=;
        b=TlPELZ6spcRhrnsiajkHguyuT87k9gYOAxxhFxBbeUh4LCU9Ljuwi4xeNM+PP15qS/
         PBy9vjx1tR/LojKenoL3Eqi1+3r/FhOal13WvNjWwMUBO4DQR2lDmZiS9Qo3qJ2e/4P6
         Lu9YP3pqSb4q7U+ifLBQV8i4yKC8KWHGZVv4fOBUUHWo8oLQusE8UogmMHMcG6z5dSYx
         vrrLfzpp8funNiW9EofTkdcTMnwBD6nZfMOm3tD1xgbKKGhFaSb8hb1SmP3IO5uUjPSX
         0lyxAOmuqjs3OlflNb+fODP8icALqqBNBJDy2UaFLpa2GgZM1C/JnFLIQSQFvE6Cs6MJ
         H2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621357; x=1792226157;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MjeVPOBrZxZk8zOp/qAcB3ja6M2cpy7hSuGh4PvxsM8=;
        b=kyS8zcEr7e3KOtuLtswFhijAMOF77ATbySzCzbJeli10QPoMvlhlsbHaVo3gUJpU97
         i0D4mSOiw1odE055VlMpjfxXQAGmDSKdXru1Zy3inBMrOwtAS5RIDLJVLtyrtNcG8jOU
         6FRwX20DKR+taEpIQ58tsSM1OTc1O6EmxUpZXkuytMfm6PYr1USfUXL8JhKSspFGiPLC
         N1ZOp0TEtbmo7Kk5meModCDZ5F7MjSsn32TX4J/lg2OkGvLe6mI31M09c+CQCPj1NMzu
         pa6KF8F8PMOzXY1aEGtcmHHAqOe90YEhdKFrVLZfrpD32jb9O5e3ZO2g+1FVCRQfYe2g
         3VeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHTJXwyUn3r7an10nqgpJ2cxARMigSKSdYIOaGBCVeJqK9kFLOAAfKaYuF3pk2Ni6Vz0M9qbL6Bf4=@vger.kernel.org
X-Gm-Message-State: AFq9FYItg0amLsKhbYa5gwTUqav+9pIPgG89jHc8SXhvecZwYxyYoqEV
	kOYxtHiuq/4YLVJCbozDxya9xMzVDsok4juyACmsKCnuNSxTh/fFSRfCmVpYb8hu94qgfzN9CCn
	Sgr89O17y91vdb6Yo8kxQyOgOySqMRpI=
X-Gm-Gg: AYBFou0aONGdht6MBV6HrffbS5bsboe/OiNnHsV4KAyxnYYlv77P4IYJYLj2DzTrIHh
	r05nOU1NkqXuOI0X+p7La8CF0KuxWPhIe1KOpsa1P6l0W9KuMPB3K3y+Z4zBHfSK+zjb6OnYvxU
	MPoVdGieCBpddmwMGMTUBAkP5O+7CtW51oln9unDWLszoYWWIoA5m1Gnc1uhFOEAAIWFd2iAeJz
	VfHb5Xx+LnKmNXD7pLlYflz4MmdRzK4fXbehcEQOyiG49B4pWwdsUbBlOSugNIJyU31EeTz5kMT
	3aEMhi+BdbkVBfgwntDZtxnbPNSHCAOthnQQSAJC1fQR3/GYh/bgkY9PXQ==
X-Received: by 2002:a05:701b:4349:b0:15c:20b8:796e with SMTP id
 a92af1059eb24-16a5f112b00mr5539162c88.22.1791621356878; Sat, 10 Oct 2026
 01:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919235145.48273-1-marcus.yu.56@gmail.com>
 <20260919235145.48273-3-marcus.yu.56@gmail.com> <arVqTWVw-eIZEcrR@ashevche-desk.local>
In-Reply-To: <arVqTWVw-eIZEcrR@ashevche-desk.local>
From: Chang Yu <marcus.yu.56@gmail.com>
Date: Sat, 10 Oct 2026 16:35:41 +0800
X-Gm-Features: AclHuK_Pdn5Y5rSwaHJD0Cqyy5Aqi9sXQlyXeocnYHJYtBTpz7Q3w3982yGkDko
Message-ID: <CAJSHAZWqWjtfmZu8yL=7e1T46CQ9YmY+LRdVmqFetqPOhsF6rA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: light: add AS7343 multi-spectral sensor driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Hao <i.shihao.999@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 09:22:05PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 19, 2026 at 04:51:45PM -0700, Chang Yu wrote:
> > Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> >
> > The AS7343 is a 14-channel spectral sensor featuring 11 visible
> > channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> > flicker detection channel.
> >
> > The driver exposes 12 spectral channels (11 visible light and 1
> > near-infrared) via sysfs. Runtime PM is implemented to stop
> > measurements when the device is suspended or torn down. Power is
> > never cut (PON=1 always) to preserve register values.
> >
> > Future patches will add configurable gain and integration time,
> > interrupt support, buffered reads, VIS channel, and flicker
> > detection.
>
> ...
>
> > +#include <linux/build_bug.h>
>
> This is unusual to meet...
>
> ...
>
> > +static inline u8 as7343_atime_steps(unsigned int step)
> > +{
> > +   BUILD_BUG_ON(step < 1 || step > 256);
>
> How is this any useful? The step == 1 gives the result 0, the step 256,
> 255 respectively. This covers the whole range of the returned variable
> (u8).
>
> > +   return step - 1;
> > +}
> > +
> > +static inline u16 as7343_astep_x2780ns(unsigned int n)
> > +{
> > +   BUILD_BUG_ON(n < 1 || n > 65535);
> > +   return n - 1;
> > +}
>
> Ditto.
>
> ...
>
> TL;DR: I do not see anything meaningful from these BUILD_BUG_ON():s.
> It's not a problem if the result gives just wrapped-up value. Or is it?
>
For now just letting them wrap back up is fine. The values are hard coded
so it's unlikely to happen anyways. But since these are going to be
configurable by the user in the future, I'll make these into runtime checks
as per Jonathan's advice so that we have a way to tell the user that they
are doing something wrong.
