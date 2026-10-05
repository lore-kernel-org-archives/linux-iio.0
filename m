Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8769481241
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205012; cv=none; b=F2faxGURWzbDV/2BrysDVNA3okedo6r3VnemL7m6Kf2N3pbTvgA6GUG4+iNZKhWV6xOQ9AkfUcPFJGY67zXaff5Yl7p4v+TAZoNpJwXGvYbsogGpwHgJqeE3yZkWhQ04a5fO7ZzZErxEthFLrvLJlUM3Migf2UEkxQ7BvLRd+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205012; c=relaxed/simple;
	bh=bb9p4HBvcxNOQ/oImkac1xFQmfwMQ5ihcG9F8QvpDQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoIh4guMZba8W+O33MWV5kES1t/6pCAm0Wh/B6Eqd2EGmn3H84+AUHC7bpwh15nAMobK339b9Mz8UeNqh7bvvyKZaKJVsN/RN9LEzrXuxbL2ngXtLCSw19h+pR869VDtd5HfyuQ/M0cHSqNHZxTocoMsAgWe89zbNUilWoYODCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBwdLXRh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBwdLXRh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a0280d4f56so10612115e9.2
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791205009; x=1791809809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W/Ouz9WloeKvUHxr+IWiDIKxmL82mM4htq+/IQDKXxk=;
        b=UBwdLXRhUAFVbQSEuwOv0k4O9rZ8VsKqu6qzzo6O0sG9YHAuMtoojO3NaBxV9maYeO
         up2qGmJOsJph8ybAB/AkxismevsWyb3g1nRiw9zp4aiiIOGbPH5ASIBfi5WGYBq85K8W
         PQDv9tqdn2WDsyGL1SbXAVsyREaWeMXqTHUyj+oi4GutlZknfdsqU8cs4Lq1vh5lUWdU
         l0Sd+ebfCZIWXwWSxs4mfgOomOmgqRJnFIdn3Hh+7PcqQfoR+Zrd9W1SFVvFxs27zz6Z
         JOs2B5mzaScVmR9PG/A6s/aahvx2fgX81wJwlWIPHujS2rgSiLez4HSR18wQ9pmKue08
         cBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791205009; x=1791809809;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/Ouz9WloeKvUHxr+IWiDIKxmL82mM4htq+/IQDKXxk=;
        b=ziFzUD5kDe+2baTMk7e2dv9buBVtuz0Zbexn3qNA6UbkH1eS8qQi74ULKud2W24Lo8
         4iyk0d6103Dna4N+jGRRdD4Ll1yPswh9MXuolT8C+PdVsioFGZXYWKr/tm/ys50OW6ac
         YSPTNKpHeUZVVtyRt4m/3cJpzIkVhjhi2EDgOT8CgtUWd/fN0MMboxhk+qVrrkJjlVrr
         5y0Vq7Xoxwhrumpbz3UfTUy1UUxL8HuLiQd9qU55z8rEv4KXHTsv2qsZfx7dUjqJjZTP
         m0yZ7DZ8Hv6/hSJt9z/Uf8fgCkZdTq7vj8y6BTVSYZAbSsoxM73CQZLiSAXnL4Zmwb5s
         PgTg==
X-Forwarded-Encrypted: i=1; AKwUvBzERhMGyq+ph60yELy6Bqt2FqI5DdbJ402UzxBnd6DflaT8JK1PowzOOgTcIympzgBushH1fAgjnGI=@vger.kernel.org
X-Gm-Message-State: AFuF++my4Jz+bLQ2KCcLz1hCh4FiDu812icVLo9aNhLLs3WbXxWgGqwZ
	W8y+kxuQlPCIP4EjZivXjBHvQ6AjoPg5asp6PiQpVQ+lfOVr2WlHTvrz
X-Gm-Gg: AYBFou1J9E7Q0gDgY3DRBYhXjD8ayCttjJmpj2JsaUWxp+5Va9ufO/++hOGFBD5qR1C
	cvLr2um/T0X+JZefIIUxX1PeRcQJ3HnV5LzfnXS3GVjpaLc2JGxfgqqoSBfE5g/I4tnik93Mc6I
	FYCipzOR6ZjeAY6ZvwG48+cGSNcXmtuhFEL/5XsOc2sINmm/aNdq/5RhylYQGFJgOobDDLX1YWt
	xbckoZxMfRfvhpgGuVxtTHYkEncUyFfSMuNo3HgsrSZw+phhW3zciqUgVu7S1bfQBwXdW4T4fLm
	4SVnjVvdR80tWPhjwvSze3RGQHKKwmv5im9EKmgfTZbcwEem9+rJ2o8xTvof1XkCVQ17sjVout5
	kWgxodGIdm1dGNeT8OTNxwpbE16q1WXlIh9yu8Lld+xSus/rN4Acr8eAR9NkZeE+lxYImfktv1l
	8fXAgCExb0KpsctzddKovg9B+sD0MC0JxSZWnqfZmjIu7OiTgko+kXwICfZu3HvJ0niA1F2FM/K
	2WTbECRJftwLOEV5VP3GlUXLqrdZMwxxWLYB8tFpQ+ZAdoA2z41IOJnX7ynAO36Oul1V1PrVJz5
	nIus9Viau82p57236af59dKbkPZflKipE8k2V5g4+u0eiKqOVHGbo7jHbjsUbUYMRfri278jyFM
	1hpBh7KZj/RBAlpy3mLARytXPSjSKHsrMxunG2ee/Ik5GE9zKwmSS6FOemGJwysVVRLXnKa4mK3
	j0OFpX
X-Received: by 2002:a05:600c:474e:b0:4a0:1bf4:edbd with SMTP id 5b1f17b1804b1-4a027573d30mr166221905e9.5.1791205008939;
        Mon, 05 Oct 2026 05:56:48 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622704c1sm2895736f8f.10.2026.10.05.05.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:56:48 -0700 (PDT)
Date: Mon, 5 Oct 2026 14:56:45 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 09/15] iio: adc: xilinx-xadc: Drop unused header
 files
Message-ID: <20261005145645.0000170f@gmail.com>
In-Reply-To: <20261005094205.1045874-10-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-10-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:11:59 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Remove header files that are no longer required after the
> recent code cleanups.

A bit of a misleading commit message since you're also adding new
includes as well.

-- 
Kind regards,
Joshua Crofts
