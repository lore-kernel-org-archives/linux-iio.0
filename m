Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D137B417
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171601; cv=none; b=r7JnNi8HZkPvMOwE16u8yUDqa1UjopuLMOu9FvIQpIiN8tCxjFOn2nJq64Q0Tguk4N5fIQM2q++96JM9D7m0e7ma8V4Xiv2mqmtOIKpFW4Pd/VWPwbMJz44WmkOiTAmHKSvyx0i3btgv+/8LCmgNiJwHez6jx9BpvXz4wWyC0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171601; c=relaxed/simple;
	bh=+aofVVRqP5Rpe1qFn+k98ADHJAI9Bk1ziYslSUHAcxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bB/rT6e0Jt5CJO7lwd0DRyTqJuzHn1ULxyaGXqnGs13kn6Nhb0jned/41H+qWBAR442KolMVM5njP7EhPR+PhZLbJZrUo+NYcQiB9khQcx97i++AU/6bAez658Qtpx8cr9Oiv/DBPC7CO7EmA1YQOEuaWje7DhAXLTHk3AJUAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8+q3Tj5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8+q3Tj5"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a877510541so3809477e87.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171597; x=1779776397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvw/ZXy41jHIKAGbo0sC2whoO0qxxqIRkdRfPrw1odg=;
        b=P8+q3Tj50Li7F+3YgCP/Ohktha5QXc1iOAzLiJkl47OOIDCZEi2o83d0PEBblbklPe
         l0ik0f+cgjRdu3TfruA3qSXfs1gUcF8+ZgepBaJSeNTMGdqTlDj9JtInUsfwST6psQ8W
         +BkJNIoidy/GcNbZDsuETOQMS+seuiB8eWiPy7evqTbUO8H830qd3ac7ph4d6WfMJBI0
         dwn4t53579vvkKZ8GuOADlx/E3dRwLSu6/98uLf50ZS2IvVFY3xHzt7HMFt8KJUwVjIu
         0ho7tqnbh6cXsr9j3b57awPsLsptfwg40lYyd6v8n7oIGWvbRD7f8+OXsLjZqdM4H+lu
         ovJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171597; x=1779776397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvw/ZXy41jHIKAGbo0sC2whoO0qxxqIRkdRfPrw1odg=;
        b=S2DvsnSMcGKWhxhZ/Z4kGh2UesEpE8v6FSyFJ1b0yrIschL6lnkr6UudMAGULOZ8Mi
         KQE8byEqclqtvrUQ0CE0OpKtvkkdQh4sIVFp9mdbIROesOo0rndCphOMCACIGPeRgxgQ
         Pif9y/JN6y0jflKZmxcp2jqbeGKcL+08qfUZ2Q/wtVRq3am/X4Y0R2lLzBKHYZGViWws
         id3tJUwIja/b2Uv14W17VdZiGdH1G90jA1i9JAAoE2nJzNsQTBryj98uiwQR1qTAjn09
         u2X6THwgNGApE0Y81vyg/R0Nzwre9Jusbi/1VzsXv0xaA/MM4UOThTOUDTH/4K/bi6X5
         F9jA==
X-Forwarded-Encrypted: i=1; AFNElJ9J9u1kGjkpasJo0+4zYFRCAXFnjtbCUbQ+ohBq9Hfferl/D51ElrT8tLdU58s6zk/8CGRPTrgccu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WHxO1oeJsivgZPl95A4EIvC/Ki4WbkZFb96e5eTw9M3xinUQ
	H+7vYnzDa78hgtQljE2aV4Rg2+NgPtV5O2+xImBfGQgbr/PasI3TyeDx
X-Gm-Gg: Acq92OEZDKc4uH3n/FSBZrNuAYCLNY5XU/2DXIErXDAIh74WO78NmMbyZ3nI7vHWKw6
	C9vMK09GM2yagMjF8efdEuR1vfiY5B+0hYlSQ1mtWeIAt6+vIwEBCo2X/HygQbTVTAI9tJ/YqFt
	guL2UmklFkZmaEqW0/xwEint59L+0RTrZUajoFqYmbDVfPo5PZXvyNseJOwdqNYEywycCGOjomQ
	xcabyEun1P4QFXn9WDjOZtr4jpFgS0oJO0uRXKhJz4olU5GmwYTpbBa8Y/+RQQrAFEqcMRCr9WN
	YdpLyH22oogo9GXFCHGpI5nhbOqcKbFyJFeBIG8yW4qMcFcqxOwXkCJ5iUuKxjpsRdcObGCHv1D
	PQj2u78HXxK0sdr/QtzD4UKwkKNeREbfpJcIO6kbUzl9OoKyUm6/FhfHbPQeqd2w537jdbszb/x
	DKQa8QaMBKuQE1J50z0z/tyFhvxXYuNjD4X92kAZQaN6HLq5PydkIcz//CqCroxVCCd6z/x8LN7
	Xg/g5cn
X-Received: by 2002:a05:6512:2248:b0:5a8:7f30:609f with SMTP id 2adb3069b0e04-5aa0e73d4afmr5833121e87.10.1779171596672;
        Mon, 18 May 2026 23:19:56 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11a5d5sm3835660e87.28.2026.05.18.23.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 23:19:56 -0700 (PDT)
Message-ID: <01292abd-0f16-4ec4-9f48-36267973eb7a@gmail.com>
Date: Tue, 19 May 2026 09:19:55 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: pressure: rohm-bm1390: harden trigger handler
 against transient errors
To: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260518181110.1467-1-sozdayvek@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260518181110.1467-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/05/2026 21:11, Stepan Ionichev wrote:
> bm1390_trigger_handler() returns from three error paths without calling
> iio_trigger_notify_done(). The success path at the end does, so on a
> transient regmap or read failure the trigger's use_count is never
> decremented and iio_trigger_poll_chained() drops subsequent dispatches
> until the trigger is reattached.
> 
> This is not a fix for a reported bug, only hardening against hardware
> or bus glitches; if a glitch is persistent the device is wedged and
> needs an unbind anyway, which is left to the user.
> 
> Split the function so the inner helper returns bool with the data-read
> outcome, and the outer IRQ handler calls iio_trigger_notify_done()
> once and reports the result via IRQ_RETVAL().
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
