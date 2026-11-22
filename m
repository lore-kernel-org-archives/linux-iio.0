Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307022;
	b=4UBVdlxM6EACw6ZGkQyBZoxLqGItVjWhDtfaIZ+0hjlom61M3s5JZkm0ryRu+FlxyRP8
	 QW6T6o7tGQOjOTivDWSb6CzxV6++9zodLHy63JjMfBSc6r4b8qtZ/4IFM8tXxDX/0SUYP
	 /65XrZffRs7bvOO4mMB9lVHEs0sUKhZ/yAVpHbqQU/1NVCb6kwR5o/OEDLaCFNQPGGVPO
	 rPYymR6FTHYU2Uk/ORQKvz+O7pPVQyng8gR+BlzixzkTt51yu+95u4pRnn5rEjNTClFDa
	 JUvueLlhmxSZJO3FvGEqyDuOtvZR0P0VV3CIm7eFTHu7se2gyANpRURlD2Rhn81FvTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307022;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AyDS5VRgSOms4J8bbyqtZFW1oePW7qKyGAxVG2slVEk=;
	b=EO18YICN/n1m0UfMBNrEU9Oo1DvqYypp2QmttBcEZ+iCtoFLyi9X9ITAKITpb6smcOve
	 PY952fYCAHP7JO+0xqlhLlj7Ua+4cgH/KwM384jXtY8VZnVe2l6EuebmHUbnBDZK4zxjz
	 gszafnP1iUDfeAdFwuC3QA/4HIQMzcKmH85VRvo0Zuk2JdnLVkIIurlAHr+RjjyR5aGwy
	 KSo9qVNUs/EWIaU0gMugn3f321sruqFLQ08F1FGcl8mNr+p1uPRUCQyda88Sfus6Ij2Jo
	 9EO257eZ22SoHZgdgV0qth05YbiBIvGODaU4TLFqSYaku8d4mpAYxm1qPItt96eFDww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTHAnEuW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109DA606A320;
	Sun, 22 Nov 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTHAnEuW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A241F000C4;
	Sun, 22 Nov 2026 00:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795307021;
	bh=AyDS5VRgSOms4J8bbyqtZFW1oePW7qKyGAxVG2slVEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cTHAnEuWPHd2J77ndevmd13NWYxF1vg7Yjc3RXM1QFh1cNrSqub3F4HMbCQlfa3/k
	 m0FWxdp7/ZzL+47bQvd214KGwnTX0Ww38fGaKnW6yJZAj9G9tNrNyKvYyxLiI1jAmt
	 QCL44DnuLRVxLurWhKxgFbPFomv8G+++cQscTaGD6oAkkWf421Erc/RfPgnRj/UXnX
	 baTLXZs7lEpouyTP7IE6BG5TEvK5Y/QrGtAHyqaL7wXUmzznX9G3qtb7nndTnugLYh
	 o3s6SlkSssIkGFlTCDrrpzDwMA2IUo13Yz4W4DSCpQEIXoGZNqYv8rW5e6A2RwC3Is
	 9x8yPMvdNG4mw==
Date: Sun, 22 Nov 2026 00:23:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
 antoniu.miclaus@analog.com, gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: at91_adc: convert to device-managed
 resources
Message-ID: <20261122002337.5fcb85ce@jic23-hlaptop>
In-Reply-To: <20261117140510.391907-4-abdelnasserhussein11@gmail.com>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
	<20261117140510.391907-4-abdelnasserhussein11@gmail.com>
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

On Tue, 17 Nov 2026 16:05:10 +0200
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Convert the driver to device-managed APIs so that all resources are
> freed automatically on probe failure and on driver detach:
> 
>   - allocate and register the IIO triggers directly in at91_adc_probe()
>     with devm_iio_trigger_alloc() and devm_iio_trigger_register(),
>     dropping at91_adc_allocate_trigger(), at91_adc_trigger_init() and
>     at91_adc_trigger_remove() along with their manual rollback paths
>   - set up the triggered buffer with devm_iio_triggered_buffer_setup()
>     directly in at91_adc_probe(), dropping at91_adc_buffer_init() and
>     at91_adc_buffer_remove()
>   - allocate the touchscreen input device with
>     devm_input_allocate_device(), dropping at91_ts_unregister() and the
>     manual input_free_device() error path in at91_ts_register()
>   - register the IIO device with devm_iio_device_register()
> 
> at91_adc_probe() no longer needs any error unwinding labels and
> at91_adc_remove() is removed together with the platform driver's
> .remove callback.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>

Looks good in general. Even better with the stuff Andy spotted that
would be nice to do whilst you are here!

Thanks,

Jonathan
