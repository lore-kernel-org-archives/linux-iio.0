Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA93955C7;
	Sat,  1 Aug 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785597165; cv=none; b=pDw2YRa1zEIqEiWvCbHeQaUVB4OYjhKSTkR80CShtOmvTVpuGZHP0jgzpyjn/ntmR9ZHHNJmw+CnwOnkwbSQB0wwWuVG+FMKAsqXhd41tihEM5Xe9MCyK1N2SViV/dBZ3u8ygtfqrRGFLRAc7MXSSCpdYUWqD8LdjT6v8LvYaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785597165; c=relaxed/simple;
	bh=ghCIIZawIKlvI3gcRIPm8hOH3AByhGvPziveYuWEghY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W1aQHy0rlcsEUnZG96Vv04MRcRBJiPmB2e6w0WeMu+DdjgclGtsNEs7U2tSsONdM+jjC6HR+UBG6HweN2BL7tgdRnerfg3F0jq7rrIdIv/Oy8iA4K1ltyFTKKjqA70SLtFT2uOtnzqCcvRmYpSmuwKQNtOUIhwKUXrbhHtTuXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwqO+CHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwqO+CHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710321F00AC4;
	Sat,  1 Aug 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785597164;
	bh=3LOtk8BiHe80gN1O9VLee4uMtRfmQY4koPNnBTZALEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WwqO+CHLro3El+QH5/ls4R1+gzuS/CRTQDrWuyO6KUrWqaMjvK4Tbm2aK5qhe14YM
	 AAxA8v+PhYkEjSvNeO89UJL+dP9zWcuSp0e/Z9yc2dMAUtOpH/lrnjKN/l5jKQbAfA
	 YTgRO8RUiu24JdGSHoiRVRQ34fOa+iQRVUlM0fxvIkioHvIX0yv4CZQ7P1J3zzl5gb
	 1knmQV8rbrTlfJjjA4lEyQZ7yAf1EsSdfElcNnM2acF8SEX6fSBfu6HZ93Kq6R/Far
	 zJccMewodLJQgy7XtfGlODR+I0P9Q4W0aZeycwRlMSEfMVOXtFbc0Vn2cwbiEi7O9R
	 yMjFKSbeq3MVA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 linux-media@vger.kernel.org
In-Reply-To: <20260727092451.43570-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260727092451.43570-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Drop redundant lists from various Samsung
 entries
Message-Id: <178559716090.66839.4580869609570192881.b4-ty@b4>
Date: Sat, 01 Aug 2026 17:12:40 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 27 Jul 2026 11:24:49 +0200, Krzysztof Kozlowski wrote:
> Individual driver maintainer entries (not subsystem) do not need to
> repeat the generic subsystem mailing lists in "L:", because
> get_maintainers.pl will get them from the subsystem entry.  They only
> need to mention additional lists specific to Samsung stuff, like
> linux-samsung-soc@vger.kernel.org.
> 
> Drop generic lists from almost all of the Samsung entries where all the
> files are already covered by the subsystem entry.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: Drop redundant lists from various Samsung entries
      https://git.kernel.org/krzk/linux/c/f839968769b64bb81878a626d34097959ab79295

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

