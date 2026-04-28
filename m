Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C2B672;
	Tue, 28 Apr 2026 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395958; cv=none; b=KIDCq727TYCT2arvBssqhJuDpQe6oMjX/AudKOxKia+nWSq3bWku4K3oAbpJ9OtoJWiM7lvzROSSyyNLGJGbgTxfRfXgbHCGtxP83dwx+b7Kym+PwjJZIe15gmC/PkHB7RwsvH9Rbo5i35bisj5Sm7ioxZmV5Ajn6E4zOgV+z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395958; c=relaxed/simple;
	bh=03kc1X5djN18NtUt3ZkSRWjk4rDjoE8IX/g6F/yzhNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdvI0M3PTQsuYLOeNiC9q2AMeb9zcubdYYRabh/iN/Fu2KwLx36sX1CZQ0uqV+1hgYqzaZhHZXsWpBP2Cduz9lXAEMifPMd5n/1cVP+X9DzfpN6lgG2b/x/Nngl2zj3uLa6HYqQDuafpl5nNvS3hkvDry2v43SMp1WszJjWW7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBm9z0e1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBm9z0e1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AA6C2BCAF;
	Tue, 28 Apr 2026 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395958;
	bh=03kc1X5djN18NtUt3ZkSRWjk4rDjoE8IX/g6F/yzhNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IBm9z0e1byXGF/I29fTlHe6oH1fe9a0tQ6J9jfc41wrvSvbma+0mu25dt2z/M0ar3
	 12F7INIbcYf6SPJjSdH+TDDUj7N1UvuIkzo5W0z7yCU21DDiYZU54arKAXeT8yMO1t
	 spEoQbEs5LAiB51pKte/ZrZGkQwGduQ3Y3s5XD1RPoTtQ1ngY+5fAxOLC+IzHuSUop
	 jO/tLxCedihbsdUFwYg5kw7RewkZ0JG1Qh1nHBIz7AfHESJqQxkBMShsgD5cOx2WWa
	 82ZmOmZDUSVJ39BmW6VqKVTBoREOqVexjgaymNffwHnY0yVZHDZzMGldMA2MqXyr/5
	 kVWfwIFB4E10g==
Date: Tue, 28 Apr 2026 18:05:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Rosen Penev <rosenp@gmail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: meson-saradc: fix calibration buffer leak
 on error
Message-ID: <20260428180547.6efaa859@jic23-huawei>
In-Reply-To: <20260427-meson_saradc-v2-1-8981c56fd05e@gmail.com>
References: <20260427-meson_saradc-v2-1-8981c56fd05e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 19:26:31 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> meson_sar_adc_temp_sensor_init() allocates a buffer with
> nvmem_cell_read(), but the old code leaked it if
> syscon_regmap_lookup_by_phandle() failed.
> 
> Fix this by adding missing kfree(buf).
> 
> Fixes: d6f2eac64403 ("iio: adc: meson: no devm for nvmem_cell_get")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Applied. Thanks

J
