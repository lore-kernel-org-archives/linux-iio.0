Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794696326;
	b=EDuPaEYtDY1YbXU0C3oSzYUuzAIuGJHXHd/6Mryciw4WrWXeLmKvOi31ZHonEapDCeS5
	 MuerFfRo9R6iY6MHhaTBlOAGWNC084tz1athmIFuOn+fS+9h50HZKVu8Sqw9rc/o3y3mg
	 fawLo303ni++H/fQsfdlIdr1nq5//pdZfP/hG9RCS+dihpXNWEyrjkfeKDwFtfH08mxUc
	 5VSqrD0cq5m7YUeyYcZ7E1aMnC8bFy7RTmQ+TYHlw0dKda2JLS1A0XPuNimj43curoqg9
	 IdNt7B3d5xq3xq8LXGBKZt7Tgc+tD6WF5jnhL3sabwnvZ2PHkcU7vW/+xagigFHlHKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794696326;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=47qMCJcVyD03I6vccj2xfGDt0pC4IdckcHW0oqCCzbA=;
	b=XhRRC7LTOe9PnM/TGPjN+5NeGNao4+9aSadBweCXc67KusQSlpRD+GPNaj7KXuACWHY5
	 IlJ/Spf6oav1kn/VfmAsbucLMBF4RvBLw538wl+iiWByd8NsmvxrJOsPRtjSoc+FDpxQe
	 xl5L7ZgDpE6uJJDjmMD17JWcdGx1zwo87uDwUmI9t5z6Cc8hFNxQEfzkYvN6knYA7UpTf
	 dDJ7cDQx1cUqCJteUHPdmOeiX9uAlvJti0w8D4MXzV/XD+PdcsXgobK3Rv3V0bGsX499x
	 cvt3XOj1miBdYSObnB4Ox4hF38AzSHeZVtMR+vlTl4acs6GWeFk0ES5CMmsYxhT1GMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQiZ0qlQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15211606A327;
	Sat, 14 Nov 2026 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQiZ0qlQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB381F000C4;
	Sat, 14 Nov 2026 22:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794696325;
	bh=47qMCJcVyD03I6vccj2xfGDt0pC4IdckcHW0oqCCzbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DQiZ0qlQHW1JtJ7xBMlk6zCa9A5lBnAp9vqiD6MMj2h2ol9cPG3g2ntdaZmFfftKe
	 UmkFKxSCp6zmE529AC3al+Jq0jwrF8IxcMydgKHS7Ib2PFqPLW3Z4etIf0i8GoTDTz
	 eJONb+UBBoZthVinoe+bIivaKAw0P0N2tY6jIRKN1sovythI3hvFq9nJVHb5slb2pq
	 ckEwLADK9+scAXesjfFXYInQ5cfCogJ9qBl2brz+8PwIZQV4bSUYWHgOBfFlDWl2g3
	 VUPiSl9c6QRu7wh8Vu+zjbuOjdO64ZEcpyaCwGb489M/dwyrq1ohobpoTmvss6Is7U
	 HgY4QTIJpK5dQ==
Date: Sat, 14 Nov 2026 22:45:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] iio: adc: ti-ads112c14: add gpio support
Message-ID: <20261114224519.169919b3@jic23-hlaptop>
In-Reply-To: <20261106-iio-adc-ti-ads112c14-gpio-v3-0-7578ae66ee19@baylibre.com>
References: <20261106-iio-adc-ti-ads112c14-gpio-v3-0-7578ae66ee19@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Nov 2026 16:00:05 -0600
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add GPIO controller support to the TI ADS112C14 driver. The first patch
> is a small cleanup to make the GPIO register field macros usable with a
> GPIO offset. The second patch adds the GPIO support.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan
