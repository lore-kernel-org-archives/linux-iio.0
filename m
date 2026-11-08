Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168102;
	b=W47SaeX3Xb6oFxT73GxNb8YJpZgFUM4wFN722jX5fEmRpWd1vRAN99DqJpQkCg0gHEQn
	 +tzBvSmZfuXx0kkPrMwcnNXIveiuX6zhV7N35iNcyex27EHLDVbTWTtXh9S2ngjrmFS8m
	 94umg8mzfAJxG3RNcyWT4DJGDTvO/xnYYp3ZcoeKIqYezROWsSEJvtDW1+jDcDXHAHY28
	 wFIRSX1aOnTvVpAPzdmDBY87eNKIHACJlTbucxvPJOM9u9lstttRVDMrCa8wXir6UgZwL
	 nw3xzNsoPfCZi6XVrfpAplxz5ErqmQhYGEKnRWodff8mDbAcMduvm7VOQbMmiWkTu7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168102;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CE49tEgK6Xw8h5/EIRwkIZrWWlTCb8XlM0i9Lsa99ws=;
	b=5ntBh5CeF8lGkL4SNBnH0o5Gg81pXf0xJGUKCQ60J5OmJIiRimvTnilHb5ssGhRLYRkM
	 l3Y6FH992aDoIGXK/bqZQWzd9hYXD6Zl76BjAgwr9d8G+6KCvBJmUFtuXoY/OYpxMBCMb
	 9HFLpMrSsJUXeMjXP//M86MXx1KJni4QWrm2sJ20zD66+WqkW1pEfdvGYoPC8IFniRS1O
	 +/EKwjwUwJukDExK4KC0xiCzPdsVdnsdLjwV/wfP+MyOtff2HNQWZRn2V5rKFimlInAKB
	 R5q6vlPEJ53/ON5wOTTRK8hFLq03PVBXnBSmpm9sk6kkC98U/7lq8UfQMW0WjHC3yzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmZwFuOD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057C606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmZwFuOD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEDA1F0089F;
	Sun,  8 Nov 2026 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168101;
	bh=CE49tEgK6Xw8h5/EIRwkIZrWWlTCb8XlM0i9Lsa99ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bmZwFuOD8DtW0qO9Zu3/AYh7u5CR2YwTeZXnkYmYBxvHjzNdTwr6AuW4JmBHx1WGw
	 +i2zNJ93quusZfE3yu1BTJpi0JA+7ihfmj8jH+jx0ClYo7DU0S6mrtqLIF509by1dv
	 eSH1cB3xe7gLmgi6tqXWXKtquBbKeC2uxt4IU+xBrDs4wp9ghQiFpPB+3dx3k6LVsZ
	 nSLgCsKRxYQB4NQBcRU4Mic92+e6rwpPKLa7al4dyW76UfeGqqTiyllE8ZZezbpsj8
	 PLo22KTB8TqoJ2n/1w579+xEhLp64OBh5TkfFhy2IvzvbjjMM1mXKBp7dq5ZvZT2ch
	 1fN+KQqXNvOkQ==
Date: Sun, 8 Nov 2026 20:01:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Shen Jianping
 <Jianping.Shen@de.bosch.com>
Subject: Re: [PATCH 22/39] iio: imu: smi240: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108200136.056581e2@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-22-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-22-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:40 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Move the buffer onto the stack, local to smi240_trigger_handler(), and
> declare it via IIO_DECLARE_BUFFER_WITH_TS().
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
> Cc: Shen Jianping <Jianping.Shen@de.bosch.com>
Applied.

