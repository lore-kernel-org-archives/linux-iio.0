Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216576;
	b=X/wD5GSoQvGC6lJwrDdQpORPEYZeiVoN0BKLIdj1DuBAMbzj2w6VvD2MqabsSuDydH9w
	 A1hCjhx6RyCj1RK8wgeVEH7k/2EDAXqCfqUGqyudf/nmHO5cwVAY9jX1HVO4ZGs9baVfk
	 f6pu5tv8bA6mywMBnyh2Ed349CLqMccxR/G0JwQCK2w+moyQQCmFdYcTca/365n9mxgDJ
	 xk+2iGJ2mveCt16FTxnBnl7pRkKGMcsB7qbPahVk1NggYBeysa7cMK2bwycMYUv3/tl9F
	 /kRbNv0gnjnsZZ7CNsH/YetpzxJcv2pYUW9eH7WzXtyllDkSuEZT2qd6ARxpVu0nFkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216576;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ho2IhSaUqh3dPlHHU0H/LrPR7pgN8UNv5QNfyaCJbQE=;
	b=xj5+r2Gago1rnDz9u8mr67JyLW1IFt+02vYsiBkK5j01KSAv14pHqX0idtO5kDLSXie8
	 LYSXMY2ZMhmILgw8QgnpliucwNLSKX88Z95GLH7Nxb6ILCPDCp1g/PPJO6eRVPRYpSxIr
	 HaR0Z1F1dL5ndEw718GsWFkwGwpi5Ne4jJ1TE38i0aOl0djZzK55JD5aVGCJafZrZJ4VW
	 3AOXfpVy5nH1kSYpQtoPKgQYK5ooSMlvtRYGZdUPX94hJWC+XHdKCawksSKZ02ietbj0v
	 KZtEqGu0EnFXyY74PZ9gwjeegE/0kED1bsddIPmtMgM/TS77PQLafpfJdSVv5tKgzwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrztFWH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 57795606A33B;
	Mon,  9 Nov 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrztFWH5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1AAC11F0089F;
	Mon,  9 Nov 2026 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216576;
	bh=Ho2IhSaUqh3dPlHHU0H/LrPR7pgN8UNv5QNfyaCJbQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LrztFWH5bTzwac9JA/ZuA9c8Q5nT1No/4zyH/YQdlNvgvKfh4sgVBwrWtYWhVSOW0
	 xP2iOKhRndjlkysG5+3O/WiJPMf4+y+UU8+GbYwWRmMHKvin9TnwEfz9qEaseZEXg+
	 BBuicYlERK/FJydFbOqsCG3iXmjZ5l56jem2EDkECxcJltVMtvq5zuvVURNzeKs1Nv
	 ntzc+Cms0pxTSoySEeoqRxZ0GmR/R6VmYZY99hFM+rj1lCAgC412aQ1oqAiPo4K8N1
	 MOxMaHURsznwXUcrTSzRUQrh9zYORWG2H06FJ9csCBOZAy1qxAzbGnEY4Goq0F2QKS
	 TWJCljEqtP4SQ==
Date: Mon, 9 Nov 2026 10:29:32 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
	Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads112c14: add gpio support
Message-ID: <bmfjg3jeenesctngjuu4pwvbx5aqozfvkshly33jk6m5rmovry@7ipljwjtpsud>
References: <20261106-iio-adc-ti-ads112c14-gpio-v3-0-7578ae66ee19@baylibre.com>
 <20261106-iio-adc-ti-ads112c14-gpio-v3-2-7578ae66ee19@baylibre.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-iio-adc-ti-ads112c14-gpio-v3-2-7578ae66ee19@baylibre.com>

On Fri, Nov 06, 2026 at 04:00:07PM -0600, David Lechner (TI) wrote:
> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
> the gpio-controller property is present.
> 
> Pins that are already used for something else according to the
> devicetree are excluded from the valid GPIO mask. This includes analog
> inputs and excitation current outputs used by channels, REFP/REFN when
> an external reference is used, the /FAULT and /DRDY interrupts and the
> external clock input.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
