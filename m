Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA73E9C32
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270009; cv=none; b=kAzUado/WP2FLcPivo6+oJTHZDbi1wI4RxS85vBs16/CrcWQOkAfJemd7etdVMoKZM5nOvs89KMEvxdSRvW1xTR+iy5/NooDGP4YiDPAPp4/0esCZ6Kj/Q0oWo02RG5StqPVMNdY+MdCZq4R+y1vIsGrALNN6VgUrgW/pJfraDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270009; c=relaxed/simple;
	bh=yQ4GLYiZlXIERfb2uNDrs5hd4Co+jRQWqQhbxSg3fD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvzt50xrlGmEu7IOYqPUAu5tcvpKmirdGXj3rEFO5QxMiTOBf4Ox0fT1gGKLuHas5/fnWY7AwbLZxezSqkZ/Jkph5vbYK8Y04A75+r5xhPVXaM0GjGJhhn2IK9ynuPM/S2It8k3061I65/adOnFOqO9l4GMc06JZ65EXz1fx3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyweUNcu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyweUNcu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-460166910e6so541808f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270007; x=1781874807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWZhl2ivaLNFWdM8nq4/32ijqldiB4HiW95gGitIZc8=;
        b=UyweUNcu35ldyt2zJvK2mZkadh7q0mFw51czalvbxaBorx87AuIHf/9WTAlAA8OrVP
         ZOD7kWAzPi3VKWmm3y0pF0fQODcbv2GNZlh+11VDZ3tKyB9wwLT6tOStnvxbmrZz1LJ7
         huM1AxnV9D0PBOr4ANOyRY9A2Ix534JAlcsOQBxYKDcHJXRf16VnUWJgbCOQGigjLLLz
         z/POfROZPChXnProv1cePY0yjkPrncirpvFPEe8e80trz6U38antEET2xFZYx71Kxspw
         tXgSziItZ6VdXUPmeB4bszjbgNcAPJHYEMs9LIqHrvp0gULk+pQrvologjv6zHS/1Mxs
         otsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270007; x=1781874807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWZhl2ivaLNFWdM8nq4/32ijqldiB4HiW95gGitIZc8=;
        b=SkQriZ6VKacEy4Vm87Ge4tqAFLTz38CbHgbvYs1S1p5nQUbnR3Ck+wra/A6ieqUSc7
         xnWd1CH9iWnupfKGUx3ItuRYcySxRqry93nLyUaIYPMaqv3I1A0Nt5m/5mb2wpxaAnyZ
         kc576G6q0mvL5l0OrJgVqEHYYJJ9RcjX+YVj+n9XHTcL6EUEZjDB0raMKzyw3K1Bw75U
         SIrtQm4S/67hFhHXY4NbHrgS0Ac6ZwZZW/PjbEMxwkcBTX6Ew1/Q93ZxxjzsfyFqcwTs
         d173n8uz1S+QdV9+4Ju4qXhhHHgRI476NhnyEp5u9aN+jm9GEovz1c4jM2ukEw9iUmTa
         OO8g==
X-Forwarded-Encrypted: i=1; AFNElJ/UWwrdSckQOJrqArxPwjULrSp7fQqn2MpZ5d9y2mOZUrDKWSxU6y2YJjBn2GgbpSV7d/sMzgQSvw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyYQxxh03e9a8209454SkyBhQOZFYb1Ga9S1nh2b4NjRrLe4n
	legZ3P0kC8Q3drPWe6qMj6V1c5bLiOzVZV+UsqseSDosVgP5qkHSRQTA
X-Gm-Gg: Acq92OEa/KKnAOLYGeMo7h7U1Pojm2FkYPnyENVaCQU+YUfoI7NWgUdH0L6dw4YClqr
	O+/dECVtTuUShtjvhApPQikiMO0aq2ByIYg5OWagiW286BvErqtH069Ho+k5JZiQk322tNd7r/q
	o/mBOJNcZkf2uAKypO4hFMu20bP/IMxSjviLJCKXeeSMAvDyZ1U2TxDTP78RUCieOOU2uHuxBEh
	CZKSnLUUFXb0FWIbxyOxwqUdU2tA60dGsY9fylOjRglP4WVfo7oSsBUyWe0FcS2V1cIA+QVRYq2
	fVLJpPHTkJyGlOY2m6V1+aunHHb6AIEHdq4cQp6kUw9gXWVhq7bcu1Gr1bvLnGuv0YRkIa2wYvc
	ijghbYu9t8GkWDxs2pA1UQfl4e/2t8OkBXrWp+tpJfpgbcGO/INQa1pwS6FfhfxYdKziO111Amp
	hkyvbR8sQCL9yH0H/3dMbPk7d+uopWYZPzom/+BwngSjT6mN9sXt8YUnmektBJeXc7qEUJPprzt
	GA26pBmce/bZ7m1J/3bI/7C7JDRj6toR+8y7uyZ0qBoG7Ol4xs+W7vKJxsMOLkEobAbS6f9wBzv
	TpAZXC4lMh/KJJ1fd+/iQpIOKepZGKmTolQo6itZegKDMjFCpN4veuvB4zKGtmPq1g==
X-Received: by 2002:a5d:5d03:0:b0:460:1684:ba11 with SMTP id ffacd0b85a97d-4606da69cc5mr4514544f8f.15.1781270006792;
        Fri, 12 Jun 2026 06:13:26 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm6038265f8f.1.2026.06.12.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:13:26 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:13:24 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Siratul Islam <email@sirat.me>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: add QST QMC5883L
 Sensor
Message-ID: <20260612151324.0000704d@gmail.com>
In-Reply-To: <20260612124557.13750-3-email@sirat.me>
References: <20260612124557.13750-1-email@sirat.me>
	<20260612124557.13750-3-email@sirat.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 18:45:26 +0600
Siratul Islam <email@sirat.me> wrote:

> +QST QMC5883L 3-Axis Magnetic Sensor
> +M:	Siratul Islam <email@sirat.me>
> +L:	linux-iio@vger.kernel.org

There's no point in having the IIO list in your MAINTAINERS
entry, get_maintainer.pl would return it automatically based
on the driver file's path.

-- 
Kind regards

CJD
