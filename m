Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC032D0EE
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775903812; cv=none; b=t6Jg/fJHsUPg/qnpCwdhwUKdeFG3qh48b2HR9HMXPSyjtrAMIgdD8llApun41rjgqjwKwngqtE9OvjblYTzHan6VNol9rMD+7ds33o+3mJQrwyEA4KwF26VAq0zddMTzcsaGHf5NKHYqqa5cKEMNa/7HfbwatD0BPqh9ZInfPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775903812; c=relaxed/simple;
	bh=jrkvMc2KZ/Iv4DrE00kRYtfKjd873yyNocXxsrkPaD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA84r+2665HHwqRlhlmxnfGKW9S2Niqm1aXSjcFI1khe9/YaS0mYfjH3vmEJxx0E5uj9LhqVzAiXZjhhE/hH6pS4/YggMEh55RAolNgLJxD16fKWlUsYpiuBAMcTHKJXahze/syUrdCfR0DCY1FKEy1ZP3tCNoWfX0Umemyre8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTa2hxDV; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTa2hxDV"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1273349c56bso3876021c88.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775903811; x=1776508611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrhYXHyxwDX1H8cIsOzl7I0KsZOpptKIlYKIA44JX/A=;
        b=qTa2hxDVUMc499MmsqA57SIitNt25ZjCwfrAB6WR+nfSpFTbYvo4SbYMtdr98rAMzk
         bnRnQHgzRFlkdqlR81dLiC0gVcrBJNRy0Fv8wTvxCe7rWk0yntEIOJ+r4Vv7J2KHkR4d
         rbn7+CcTonl1tEn4QsyzPianBWm1yOgp0NILKkOuEaFQwvO2cjUl0G1IA8Aw5oyUdSzJ
         9JFORWVnisDK8ZmlnJjrgHPx0lBJedpTDPVPMgHAtYk0ZQ7a8YLmYxe4F5MiDJDy/McG
         8UoFeQAGV/vkcH1HFW81fSxbLBg/t7kEoLlMxevJPf9xhyL7ZuUaDepD3bHP0AE+ABgd
         jjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775903811; x=1776508611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrhYXHyxwDX1H8cIsOzl7I0KsZOpptKIlYKIA44JX/A=;
        b=SjL4dE8msF5gGD+DisI0bQtbo1wr3jKM2Y0zq/3oL5FjO2KCJbqOpPNbTC8hMx9pH0
         tRLIYSFo5++epWmNpJZpA4PBYMkisBgB6VlS0eeFrdX1drdoti8ZSBb/X3o7NMjPOpYX
         xyqGjhtcEUMYvOStW8TR6+meP/JRfvLUJyacVdq5MIc4pkrduPUEYXuzbdJexv/gZPA2
         vUbyVnQX+K0OcgAUWL/YAMt0dM6dm2N91zU/Iu3WeP4v4ikbSw5r8xoHAk7IwznNKMI6
         +8a/U5rGKP8k8+7EtyjPCfaYkqZ3KIurcThuSmLV46Wbv4PtOYMUTFIb8A7UiATRBBn7
         rDJA==
X-Forwarded-Encrypted: i=1; AJvYcCXW8++Y4AmURyoasNhjwe/6G33YoSrqENgLSTKi/ADQZhMPItRXPR+eNBPmL/uTfzmVfZrAartk+U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR02B1fT5VdcMXR3gj+dIHvCCZ7zkXD47iGDTlvzOja63agK8i
	S24aWfiUQBPvvIEqYtMAD4Mm1v71pGS2AkGBFC2FosL/19u7hkDm0RIh
X-Gm-Gg: AeBDieuteY0sA0t7ZLPlBgMLTI161JWZ1Clw9CKYP4VQzdd0v9zl+oeEL0Qs6XjHpyf
	XHCVsyXR6Vszzw4SUMYAi6ZqmKwOJdbuseT+1mhnOt0W4LW+kBgLzESGmuzaSo5Uu5/k26rumtP
	iZPqTY1psFDqrjxzD8IPUu5Ww57IHqRUnE+akNwsa2ahveq6rd+R9EtYzfU1CFwjyr4UNHzqenn
	nRV9IVk1n/QrZ4XU9fILs3dbzzLRNeWU1UEf6/9/n/Ioqcd5UXCqRXVVHFvzzA/XdE/X+rtNwvG
	LhKVDEc4tJ653Qxz8jxqIuLf7iEpwsbFKycmLmWyYs7edwzQqQHs4ezq21+nWhTZxaD2TQjCFrx
	8RJywrrczC/4/3VEKd4EBNpfE3xsmVzKiqgIAjHri9VSBXkka2hbnwM5DkC3l7/eE0hGGUsvzHp
	yWNHy5pGqmCV1TV5w=
X-Received: by 2002:a05:7022:61a5:b0:128:ceac:6db1 with SMTP id a92af1059eb24-12c34f0677bmr3459374c88.28.1775903810563;
        Sat, 11 Apr 2026 03:36:50 -0700 (PDT)
Received: from localhost ([45.86.211.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa571csm9829684eec.10.2026.04.11.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:36:49 -0700 (PDT)
Date: Sat, 11 Apr 2026 13:36:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix refcount leak in viio_trigger_alloc()
 error path
Message-ID: <adokO8-Pf_FjKYCI@stanley.mountain>
References: <20260411080435.2125626-1-lgs201920130244@gmail.com>
 <adoEfbDRO_ZsIUx6@stanley.mountain>
 <CANUHTR-CY2WdPqdheQHHsFqj=y88zs3iiVn=5rE6gh9mRmsong@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR-CY2WdPqdheQHHsFqj=y88zs3iiVn=5rE6gh9mRmsong@mail.gmail.com>

Ah, yes.  It *was* a real bug but it was fixed a few months ago
by commit 12b393486c70 ("iio: core: Clean up device correctly on
viio_trigger_alloc() failure").

It's unfortunate that that commit didn't have a Fixes tag.

regards,
dan carpenter

