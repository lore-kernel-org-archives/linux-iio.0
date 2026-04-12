Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74C49620;
	Sun, 12 Apr 2026 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775989813; cv=none; b=PLud2wfbFyADwUo3vFVpuZGLwHZBuVGvnTteM17qyrJ9w6lVhom0yZX/Hn5xDHm4GhxvHwmyIFk5jB0EYol9Vo7zNaQASFVcGRNQqebjaWvmC0ozcmTNIwA1JHW+HgNHPrdaiAhkpfstNcr9Y2hy27QZk6e367UFJnbJwXVTD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775989813; c=relaxed/simple;
	bh=xlkj3BdMlWR7r2iP8WIMGIN6gcVSGDhf5M5tebHhkhQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDGGdRlYNuBxVmC50cd29YHb6XxPbPMbB1oT+g1bcAKlD8g15ulNIHjs2UlXQ5kOiolwPcvFLUZd9/CZDkqTzJqxuAyWCFIiPGGPxKgUvOYDAny35Mbm/bBtNgJ9gnSpRvEpm2fCvWIm+OTjD+Id0fQp1VW89ApTixUMBwV/rpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=XOhHabCB; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="XOhHabCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775989809; x=1776249009;
	bh=Bu7RlL9Na4uFU4JD9ofeL4msgJlQRY/8HxYeBh739pg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XOhHabCBzKBzQW8hxd266ssa5zYRlBlYyDdb8TFVuYVKMfXg6aY7ZlCw/qVAKnIg6
	 5w/t5ZtUq/DeifF5YLIm9UqqyoUuSuJ97SktV88O4Ru7ivPpKDxygQP6pzgZ4wY6I4
	 5Kvw6oBW0RfdpH9AHQNuQbakXkvqPv0hTNx7/2fNGz10NrvIT1VSC9oYwMx7RjSJbi
	 pb3ApyYBRTvh+1OHQ86hXh4Fv7ub/LAwRC15rOe8cEPKHNkwxGT8g65IzlMEKcSsIT
	 A2tY8JuU2VawmRYxkEaOejya7xJgjA8A8Gh6lq4WHwaBg7yB/ZKZOQeAzGa81XjqBs
	 qcXHhEShCICng==
Date: Sun, 12 Apr 2026 10:30:03 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Hardik Phalet <hardik.phalet@pm.me>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add QST Corporation
Message-ID: <DHR3U8UOR5RG.2HLEZCXJBLQGU@pm.me>
In-Reply-To: <20260410-watchful-magnificent-caracara-0cae3d@quoll>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <20260409210639.3197576-2-hardik.phalet@pm.me> <20260410-watchful-magnificent-caracara-0cae3d@quoll>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 7a6fd0ac58324b31298681ff024cdc7acbf34011
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 10, 2026 at 1:22 PM IST, Krzysztof Kozlowski wrote:
> On Thu, Apr 09, 2026 at 09:07:20PM +0000, Hardik Phalet wrote:
>> +  "^qst,.*":
>
> Website tells me qstcorp.com, so prefix is qstcorp. Unless it is
> different company, but then just explain that in commit msg (e.g.
> provide link to website).
No qstcorp.com is what I am referring to. I will change it in the next
commit.

>
> Best regards,
> Krzysztof

Regards,
Hardik

