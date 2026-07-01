Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3023EAAD;
	Wed,  1 Jul 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938891; cv=none; b=j8HbB1bVvqc6+Xm3RL9v4NwfOMtQAqnhzq7vEr+HzTRm+E8DUxfk7abiAdv066WTBEe2S1YdtUTY/B3Sq2KFiFV3ZtLUpPFRKBr5jnN0+wZhQssjTkOw6RMN+O95pXgx0XurEfrSKyp6rWPNGCiLC/vyE7DlDq9i4jTAfstXSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938891; c=relaxed/simple;
	bh=fFFASaWIVPTO/G0jYmGXDjKnC/NNmLabRV1MDrHhkaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0gitONDbLV2DqStSEoCgU+RzCfdgglZt0zUgAt2c95sNhODgSTlgdOpdwhphGKoZ4vBOk8nb94my27iAp6oqGWASUDKVcgRnbF9YcDRCEk5s3CNz0DZ09GxGcKeMKRtbCVj3YkXSbiMPNjWnw6IlX3AboijRI4Z8Dt+Cxjg+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu5NXJW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu5NXJW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934E31F000E9;
	Wed,  1 Jul 2026 20:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938890;
	bh=dXe1F0qlkv4rwzIlVkfpLvhn2XwRfGCv0VMVJzEV2Nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bu5NXJW5Lj3HsqVWcTkrrA1I0288TQ1yiVDA/CEOQwyJYZ4JP3EwJM+wCBwxXVSMb
	 dns+vYSJ5v1dVfy1DNEYp5G56LYRGD9wMYqKbfAL9KlCEWsOyb+dQcJhJUABwIvVik
	 m7+senSlAhdV0FqiCXe+zPDaQelypK+jDmvRZPJBATYGPwQl78wNYNxdkBvfhrY+p7
	 /Gq8CbTAO1sCgXmMU1cyeQ2ghuxofS7V31QXnNPT/OkO41I36wobtZizqLcAeINXDr
	 DxilHWEoNVeF9hG2xAD+Qn/pxzR46aD4FbIV1nunkDvStgobF1wtyN6XergkQCYWgg
	 kishH10Q4sHbQ==
Date: Wed, 1 Jul 2026 21:48:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 2/2] iio: imu: inv_icm42600: add buffer hwfifo
 watermark attributes
Message-ID: <20260701214805.1a810910@jic23-huawei>
In-Reply-To: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-2-8b4c8bfa96d7@tdk.com>
References: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-0-8b4c8bfa96d7@tdk.com>
	<20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-2-8b4c8bfa96d7@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 14:24:53 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add hwfifo_watermark/min/max/enabled buffer attributes.
> Hardware FIFO is always enabled and used.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied.
