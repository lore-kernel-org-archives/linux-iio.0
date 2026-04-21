Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C523B637C
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768757; cv=pass; b=EmZyFGRDNWZ1X8YijvOsB2JV1KKmYYFafSihBBQldD1WzRftVHFMoO8ES/UwcyrNZjhQuZBaTW4fd1tSPV7oANXVAiSFmYItm3vyslDmL+UJWUVW8NO4/bkblQqGyTKtdSPJLVmCir4ldMiCnwJ0UcBBPvpHtfO9qoE5ieGVfEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768757; c=relaxed/simple;
	bh=wcrsMyNfiqYkFajGcyAUZZuAL+O3voVRFM2GV2wHjZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6zPOGDh8OfeUy8wYwYoniJ2xQYo2JPTLRzeXPZnNycdOimm0ktmWD1VAk+EeEWB97AMC9dBCFxISVG5K0GuLpDcnQcwLWPtNzLZbrCEkAfHoxT2HaqkUtWMasbhQZiGefOXYSfnOft+d/9QhqXPHp5dAiwhZC0GwmNLxKfyk2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEtfsiV3; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEtfsiV3"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a41099fa86so3655392e87.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 03:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776768755; cv=none;
        d=google.com; s=arc-20240605;
        b=gdqs2BJ5NRNovKtKzgbYgx81jampVNuTozml5NgNlEZgIfF2OHfRX/e0Nzi9+nkdnQ
         GwphII02nXnngGpjjAzhImPBXrv6GBehgnvHbZ/kutsdPcRTXQX4DCd3g1lhUgvjXGIT
         LOK4sf/Tz4n7kw5DhWYASeznY2hascUfEK/LWInFB2ym/k3dOQsLGPqbKjRaqjxSecrO
         x+yEO+KDw6PXd6kl286XLBfqVSA4cKb0wD6azlj+a8ZdpNS1ytw4MUYwDjJusBzhaWSN
         9amj5MtboIJXMeDIlY6sNn8aIfommuPptVOGB9lKqB80R+rNteP9RT+sRyBTScz/0gZt
         Oe/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IfLKEYdlA0VffD7MyicLhAfvNe130WR/gS1D+mSIY4s=;
        fh=skBftYPvdBxRv7c+d4yXRazqwKzUxdL+sZf24MujipQ=;
        b=AI/9ZfpM0QjddsaAzmsNXYIL452Ja4QFdWvBiMMNUqXqQVbxJsqDv3SfBVSty/Uh8E
         mKpWQi7btGQU8HbDwyQYfisYIh2vv+8CysoBU9ugNctwcxSm1SPwHbvkxYY/c9SrfhlU
         jlD5k4CKO9wVy2ZZdi7STcSoTI6QwkTr0wYQec4ctrdPvg8e4Lqf29J8lKDNBu4Y4CJx
         TDVAU/N8a/BHtitql+XQjLOCywRX8lJR8XtqpfGO7i6+X7xq95A/T2eJejWU41kYZbHY
         hhJRe4uvoOvdF0jOtpoBD7cGs1DbZhdCp8AmlKq2yn0sLlmyz2As+8aZA/NOtZYMgT2+
         B/zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776768755; x=1777373555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfLKEYdlA0VffD7MyicLhAfvNe130WR/gS1D+mSIY4s=;
        b=lEtfsiV3JNO/zbbEOcB0+VqACpnFCpm7OS2bU2cf45/310cXWRIFDr8HjPRgqsFhkZ
         Gz0WYbLW/t6JkbeeqW7y+q4LKbBxSXIK6aJ+biNXZnBT75+f2QYSVt+JPyJnoIVWvpy7
         H4+jBi8g5N48u1T1b86fWB4NNU/pWwcCPwEnNDlEIFPetsGEuhq4AwayA3KEDotVngF9
         CLsGXaLbzTKktjbOujOS/2XOGfDTfk6MdiVeXRdH4XbHAfGN7WJgoWHJOal+vh4i6d4l
         2CH+U8POe5/uJtb3M20ojyrWHKVZzlZYvzZw+L6mTfIBNnD9ifv0Qd2OhkJkGzy9hkjZ
         z6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768755; x=1777373555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfLKEYdlA0VffD7MyicLhAfvNe130WR/gS1D+mSIY4s=;
        b=H6QZMxvfLGmCXYbTD7zxMDvTJAhrs+TYUg0R3ARitXrtWGNpLMY43zk5BNrRS1kkOg
         SdzXF3NDWSqfuBQqXgWIh4asLdhdSYliVe4htCU8FytXdO+LGFWVSKkMeXEUxBdPZrJD
         DEw1a5mHma36pTkZFbISw+y+AcA5jADbXBFVV3wzInSzLTcEaa8gits9KHuhlGcbb2/F
         Js01BMjSOtU0Xn7utLYpBUBubgej8/iVLB5sM9N/voia0UwlcJPv8B3wmFGsGEAZqNsi
         yShZiRaN+9Dxm9xzp9i7oXZ9eDeDZ9Xlw7EVJd1xEyo/ZctflN7vT/jmNGl7GXuNygHN
         57ew==
X-Forwarded-Encrypted: i=1; AFNElJ8YRqhw9yo++y6h98XmAIlyuYPDF6yQ1MNhI/VY7VfpvCXPCx30eYjjnxjhzKGvZaqoQzC5FfAhefw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbPJQzEpLTKru6aYNc792Kbz7ajySGcBUD4a9wKN2Ls074gECZ
	fWdbO511ubz+CUoroGCyWOC1x9hYW1YLiV7JT5968pzuXm+/meWX4qPuIFfclzF99NvE9xStwxt
	hAxT0SwxKiZSmCTaoLmfGHPVJAX0jHdo=
X-Gm-Gg: AeBDiesQaICOdUWlCOrPZrY8/gaxGLwvQ6l1/XNNIpBHts/Q+8CTRQ7AnL5kJsULRFZ
	PU6tUq3fPCLWd1w9ekF9sHCJrH7Pl1CR68thRpq7KNuOgPUexmNe0X3WQA8wvNoGhuG3IxLnnEh
	B7jEeLVDTOcs6nN4UklbGR4RBkdiQ7Vg15K61v2L+dl/2EP4SAiVmkRXlYXX1Xw2y7ZEr9ZT0oM
	RWaK/fH+dmZ4oET6trSFl6oWdHfCzGEt72qHrlsDGT6vLCDfmxuB/10ksW/dJx1C8g8cJMe/CdS
	l0mXkNcH8Uu+CaYnHJ5IysYm2+RLVxeeB1+d+9mNSTiqsMaS+/z2CM/eHUpS44cSDkfgG0dozw7
	uHrIKQqaUQYuprIXLtR2BUZgUXvblcp4bmY0f91LDf1VdZad2MNRo46XnmVanMJ1LXftA6zZw9O
	9leY8+Kcb3vkppTnek
X-Received: by 2002:a05:6512:32c8:b0:5a2:c406:a74a with SMTP id
 2adb3069b0e04-5a4172de4ccmr6554798e87.35.1776768754439; Tue, 21 Apr 2026
 03:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
 <20260421100722.1296-2-joshua.crofts1@gmail.com> <20260421113557.49d12cb9@jic23-huawei>
In-Reply-To: <20260421113557.49d12cb9@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 21 Apr 2026 12:52:22 +0200
X-Gm-Features: AQROBzCSzhGP7-6LjZoWZSmyp948vK6DFqLf7J5FlgW6HBtEcq_bDl8-SJnXT88
Message-ID: <CALoEA-z7eQYh=DyRRjEkwtQFx_0dcy+wMt2af=Waw22Hzs=kmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: magnetometer: ak8975: header cleanup
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 12:36, Jonathan Cameron <jic23@kernel.org> wrote:
> I just saw your reply to v1 thread.  General advice would be slow down a bit.
> Even if you have reviews, a new patch set should sit for at least a few days
> to gather multiple reviews before a revision.

Yeah, I might've sent a v2 a bit earlier, next time I'll let it sit
longer before
sending a new version.

> For this sort of change I'd expect two patches.
> 1. Sort headers as is, not changes.
> 2. Add and remove headers.
>
> Both are good to do, but if you do them together as you had in v1
> it is annoyingly hard to review.

Fair, I can see why that would be annoying. I'll split it into two patches
in the v3 version.

-- 
Kind regards

CJD
