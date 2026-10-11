Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E633688F
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791739882; cv=none; b=TCxTTYDR5eVWfrOIsBYqAm94hWPD/UAok8s4QHrv94Sp3cWhFZxCz/ql0cAu8szzbBnk11a6J5pg061bUbbQZfiWh3pGJzqUTPzwSgoH5SLgW7SAAthvc1vktpigDLwP/u6WruNiObuRjl155qytdt7JPPsZz2s4XTrxBp6LrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791739882; c=relaxed/simple;
	bh=+g9pGrxc01MSce9vSil0qZ0bTteAzBL7Y1moTJt2cc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+bp9q5h6gqUxixaXIcppAje7clpVn58hlHaP9VNuYlsupw7gDZqYLOWHKerMLVmcn31nylceWqGG4ucNHLZ0qc2dWN2agVb+06B26LGOvc0xTlWyqFukxQ6dl034wMy/qGxDJYd0TFU+mzmEWZqYPOXMagiKJnoUMFKlX54VuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsBLYmTB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsBLYmTB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso9591345e9.2
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791739879; x=1792344679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QwOqW4FJeBRI49+8YlqiPoP98tplXvwUsQ8ubTdMnr4=;
        b=GsBLYmTBqBk5yyuEgux1K7s6P5/eWc2lkaeIrD4oUShnTuCyQ5P2+ReAgONx17oWbi
         lVvJnreJ6qf/8KJ1x78HocBWeqbkVBCkHNBZUJsW7xrrqXSxZsto4jkN6oAAOGbdr3KO
         QP1sKebQU3ns/mfBj6xOnM78h0nU3yx1nOZqg/GqDW23EL0O2XUTFf3tm2oHeMdt46ne
         d2MxK4paXuUen8RTz3lucvSJYBFA5S0Pg/5G2GdaxnwhdwiNOl4Eec88g90QBlt0ZxSe
         uXF0aTJpfhwhk4DxEgn5ZfJN3ijuKm4l15tXcS6W3zytQHL3Z5MDPfzk1Wijh6v0LfOv
         RsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791739879; x=1792344679;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwOqW4FJeBRI49+8YlqiPoP98tplXvwUsQ8ubTdMnr4=;
        b=B+avqNdZGvIjsRcJcYYKEGJTtQbaf3MHzZmjV4rEwHZCa7P/GwlYHrZYhiF+drFBMy
         ojHpeunMKAiRAtVAQlsbUpiEfsHeVGdJ2wycckEeJLY4gw/IUrX5cZ7m695PDMkYIZDS
         7w5IuGISDUxD2A7qGPLK3vNZ1sze3xaQjm5oNJLIZ7silrtpuQH9Q6E8Rrhz7I2Yhk8P
         EcfYzd7i7LRNIZ3QUQ1W8VftzQCqTrUPv7meFWX1dFUKYPBInaO+gA/1p56WFZ5pydfc
         ioG1z8JFU0xepHkPh0Yyo13yv+PsFqg09lkAA58kKsmkyHhK6ojvNsJkZL3YDwf2634P
         VHrw==
X-Forwarded-Encrypted: i=1; AKwUvBzs2K0rY0LCgxKX4W0YkTsKE9vmONfQrGZDZmnD+ff3+UiVJhRGkPtbWDD81S6eQrX/hhfoSVQEKX4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYN1nJ1DOOFXwsRNVQzj0+2fujT+rEhs8JfphIkJRzXVk4bgVA
	6qu12ZAILq6VRE89ukqyKAQ+tb+j9MUBo+Eof5hNrFhaEjqO90G71KLM
X-Gm-Gg: AYBFou2JTTpQz+1csouCWQlPGuN09k5TNSoKkcuJa+lBxA2GM+DZGYMKm/vUIH7QZXP
	5P3Sex6d6R0zt2x4buxfqKMusxuO4/B4SA2nuvOwD92door9L9y1of8j2Wm2IOpQUug25qcmTV1
	cQoiDhPtqtxyuC4zls5i03l5jn8tY6MR0zz0lS5dw6Pi6LLWXAhzF7av8pmecZSmvh7GHWN0nNt
	M8++xAwy4llJO9wh2d+oPjfAXBI3/CXzbWvC939V9DVUUJ3/Gw4XMHF19/ePDPg9e7yEzIKukPp
	EVxPY7QaSbDGA38FG2rJce6RUErioli5gc7n6OnPV5SfO7a31egeRBHOjeqiu+tixzq2e5KL9Iu
	6Qi/xnjB/jrYi2HZoozoBoZbdqHhX1ljxW0Vu5fzLKmF8HQ/K/aGfU40oVe9kVHsHad+lYfORCu
	+PnVvpA+tk+0PQ9hBw7M+PcCQIW6XZ4mozPHdhvDiJQftb7Wvit8pV+pK016anze/H+pfPMjJBa
	9SjGLvScCdC2ePuZNFcEXu2Zr2+hJJn06aoWwRyQ2edeKxDi9+wdaqEBthAzIlZEWxKY3kjA1ok
	aP1NknKFQbR7OaDuGFUaxWnqRs+L+3+CFbofBoeP4TtPc/rqdfpv4jpS4xWI3uWI/Db3N9GM9Jd
	MPe7UsdVeTAEomBPpTdzzuYla/DU581o=
X-Received: by 2002:a05:600c:1c15:b0:4a0:2867:d8a9 with SMTP id 5b1f17b1804b1-4a18e4d67e2mr157072275e9.30.1791739878863;
        Sun, 11 Oct 2026 10:31:18 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abdaa5sm15576275f8f.35.2026.10.11.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 10:31:18 -0700 (PDT)
Date: Sun, 11 Oct 2026 19:31:16 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Zixin Wang <ywp1023456@foxmail.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron
 <jic23@kernel.org>, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] iio: light: cm32181: add support for the CM32183
Message-ID: <20261011193116.4e7a4336@systembl0wer>
In-Reply-To: <tencent_27A2DA110A464EC41673E7C2217844837C09@qq.com>
References: <tencent_27A2DA110A464EC41673E7C2217844837C09@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 17:02:57 +0000 (UTC)
Zixin Wang <ywp1023456@foxmail.com> wrote:

> Add the device ID for the CM32183. The device has the same register
> layout as the CM32181.
> 
> Signed-off-by: Zixin Wang <ywp1023456@foxmail.com>
> ---

Ah, you're too fast! Please wait at least 24 hours before submitting
a new version.

Also, could you add a Datasheet: tag with the CM32183 datasheet for
documentation into the tag block?

Thanks.

-- 
Kind regards,
Joshua Crofts
