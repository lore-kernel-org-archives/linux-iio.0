Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794013206;
	b=3Es5GFKbacWcQ04MZd3k9LPs3a8EJw3AaGHLS4yzG2y8POokiiky/2r95z8FFvxV5C1A
	 Kanrgw5fnPlj9fhzTeR7By5FZ2PI1XaLx3mAeCA/t4NJWtvDhiQem1gGu6NtIi5559xoi
	 FH7sUbYIEfaeMdUS1Vnbfm5BAkL0A5vKHI5oyBJxp2Qh8VRG5HKqin4HcTN8psaKy6TRs
	 6VRAoFBYPDWYKaj/0Io0Sc2zzY+UZ62anH0MM0RuqtBtDHWh2AHL8ug5jpSpQjoplUTBj
	 yt/8eCwQGVZ+AHLdG+8kg0r3GmlwWJ3I1E3S7fYwj5QNVtYVvipC/JfeOBe5iDzdk6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794013206;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f5siVNgFbxLBQ1QMnUvIOA6GSr9qzcA82CUcS7hu/DQ=;
	b=wJdpBNNB+4PrfzXrY8UPTRIYvCjBFp3LSGucL/lI14I442G0yMF/g1KHiDm/rl2jlUGD
	 LAZqW375+hjdQ8cnmNnezp8sZAnfDKsvOwrnQmCf0l6N7CdojLnR1245aPb7DfeCsWXOY
	 nG4vgL9nwOfqCo21SBmeSGLOJGq62IUzw2pv2xMxv9KWSFxwNgqqEvssIxutUURhni4Jo
	 g1tgnBSNB9QdvUk6p8H2yltjd8mfuNSHW7xrVgC7IOlBZbFjb4K0y49gWtad0WwrjeCiz
	 q8eTfKmO92IKIQs6+b7a6nk92i06WycXBMFrCtlpxOqTiZwR52/fN4bYU55TTE3ovDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P+Wf/7xZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87154606A326;
	Sat,  7 Nov 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+Wf/7xZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8311F008A2;
	Sat,  7 Nov 2026 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794013206;
	bh=f5siVNgFbxLBQ1QMnUvIOA6GSr9qzcA82CUcS7hu/DQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P+Wf/7xZtzjUn9Y3NP6BsZnSb87fAX68Z1jxc9Gc5/vQgc8oscEHlbx0cNhRqBliL
	 GGEmnVIZhhZU2/Resp5s0VBve/5kPspsu64w7R1YcFKR87Jqho++cdiE3X4nkqVCig
	 o3VAZdJjeE6UQbaWKfEbxkfc1Ad4fGrYOmYBJGRBiPuaaR609DyXRL8y57DPz3LPLC
	 3e7unQ9wEA0PVOBXzxB/6ZNE+1QQFBKom5Zw3sN/NufhdPq11Cf7ShJWiB5tPhEk0M
	 rpx2/WBSiWiAcgUchlwX9LRpPDuslKInhjThthrXxj1Sw/ZoGMp7OdYTZyq8WZVNcg
	 7PPtaoPiLvgeg==
Date: Sat, 7 Nov 2026 00:59:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91_adc: fix NULL pointer deref in trigger
 removal
Message-ID: <20261107005958.706c6bd8@jic23-hlaptop>
In-Reply-To: <20261106200809.53799-1-abdelnasserhussein11@gmail.com>
References: <20261106200809.53799-1-abdelnasserhussein11@gmail.com>
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

On Fri,  6 Nov 2026 22:08:09 +0200
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> If 'atmel,adc-use-external-triggers' is not set in the device tree,
> at91_adc_trigger_init() leaves the external trigger slots in st->trig
> as NULL. at91_adc_trigger_remove(), also used by the probe error path,
> then calls iio_trigger_unregister() and iio_trigger_free() on them
> unconditionally, causing a NULL pointer dereference.
> 
> Skip NULL triggers when unregistering and freeing.
Good catch.

There doesn't seem to be anything stopping us just moving the
registration and tear down handling of these over to devm managed
calls.  That way we'd not need to clean them up explicitly at all.

That would mean calling devm_input_allocate_device() for the input
path and devm_iio_triggered_buffer_setup(), devm_iio_trigger_alloc()
devm_iio_trigger_register() and devm_iio_device_register() for iio instead
of the non devm cases.  The error handling and remove path would
go away + the NULL dereference would be solved because no cleanup
would be registered for the the case where the trigger was never
there.  I'd consider carefully if the various helpers make sense
after this change.  I suspect you'd be better off with these
calls inline in at91_adc_probe()  for the IIO ones at least
as less done in those than the input related one.

Whilst it will be more lines of code changed, it would both fix
the bug and improve the code.  So that would definitely be my
preferred solution.

Thanks,

Jonathan


> 
> Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/iio/adc/at91_adc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 0ac74ad92fca..c7fc06214c05 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -660,6 +660,8 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
>  
>  error_trigger:
>  	for (i--; i >= 0; i--) {
> +		if (!st->trig[i])
> +			continue;
>  		iio_trigger_unregister(st->trig[i]);
>  		iio_trigger_free(st->trig[i]);
>  	}
> @@ -673,6 +675,8 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
>  	int i;
>  
>  	for (i = 0; i < st->caps->trigger_number; i++) {
> +		if (!st->trig[i])
> +			continue;
>  		iio_trigger_unregister(st->trig[i]);
>  		iio_trigger_free(st->trig[i]);
>  	}

