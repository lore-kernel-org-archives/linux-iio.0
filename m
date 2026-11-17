Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912777;
	b=kG6jcSEgUucnVTbVnQ3rYdshlMf7tvwqpVDTYgqAWMIneJ1EKb/PZHSp9XKntf00tWvy
	 3POmieAwR02J4+g9kYVAsnE0ftMnEyUq7MgClNsvPjnZKM7UVamWMedwIgbBlonpVxRgE
	 SaCZd0nXSOVW4jG9boJznH+f4kMIN0D+SPJ8ohcWeJtIPR0AYiAqyVTCDIf3+rJ21iZ+X
	 23mVi2Qm2oGDHJJhEw3CskBZu1Jos98RSIgrON8k6H7DudZseAfh7pXGwrZafoqS4jBCS
	 UiViOhwzwAit9fWxjoFL0tpgj/gqrvSA7DLnVb1DW+YxOFlTGJpwx4If7vCE6tyk7Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912777;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=U//Xc7wQnBNeFqSmWxuVmyQ7HhIYW6oU1E2DERMBTRc=;
	b=ZnCAsiapVppc6O8W6QgRuQyNr2N2hgz+FciUHH4kW0PoGMH5plCZb9kpRufAMxuPF2Nk
	 d4KKi9t/ZeyPEIP5FLIK6cgg12bBRcms/QocqxTN69CSkhuq9QF/uKvCWqWPD9xT5hSeQ
	 41EVej2m3lbOVTqSZ7oMdrkFD6EEI7EUqeXhElEBRP8S4TtnDJSxK3F0BPXAEKD7fb3lA
	 d1XwwaFP17aY0fqi/t5BnMkal4QK4i6n6/L8mlquGnLlXOZyf7I9CrO3P2OmGio8+aGXA
	 EH5W2YeRsioQpm1lIb88p27uudPlRzgKtOV191bfKrmGqqcpXTpBHvIl/zd3+OPlKhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AaMpjxlC;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96885606A329;
	Tue, 17 Nov 2026 10:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96885606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AaMpjxlC
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 09B4D1A15A6;
	Tue, 17 Nov 2026 10:52:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D0E685FC81;
	Tue, 17 Nov 2026 10:52:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5144511BC025C;
	Tue, 17 Nov 2026 11:52:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794912770; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=U//Xc7wQnBNeFqSmWxuVmyQ7HhIYW6oU1E2DERMBTRc=;
	b=AaMpjxlCrG0Nxm6JW6+aUy1lNJcIazaoHWqew5HkLnRb78Nb8+PrNvxKLZZ/OFc8HGTEZe
	KebpDhZo7zp4hThzzhNkyb8RMfsO8sopd95p/8Vo2XASOIUYj6qb1LvvlP3TWPy0H6LDv4
	4YVGXM6/MVWe0dLqYCTy1Hee1zRw5y7bYGnBwG1aw3Qk1aT6z5zDtwBuG5y3MqhqmYCUem
	PLfm6PrbBqhjTNqFwholRhSvJw4RkVlv8l4cl8r6qmpkjToPWHLfGHzVm7G7FDnPJ2CIJn
	iySpgFGVQBtnPURZieb8JNuEtFsrXJwpRzrnRXnqmf/pfcI+I9J3tjxbwUld8A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,  David Lechner <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,  Andy Shevchenko
 <andy@kernel.org>,
  linux-kernel@vger.kernel.org,  Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH] iio: adc: max1027: complete the EOC wait when using an
 external trigger
In-Reply-To: <20261115204551.2783884-1-jic23@kernel.org> (Jonathan Cameron's
	message of "Sun, 15 Nov 2026 20:45:51 +0000")
References: <20261115204551.2783884-1-jic23@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Nov 2026 11:52:46 +0100
Message-ID: <874idfn30h.fsf@bootlin.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonathan,

On 15/11/2026 at 20:45:51 GMT, Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> When an external trigger is in use, max1027_trigger_handler() starts the
> conversion and then waits in max1027_wait_eoc() for the end of conversion
> interrupt to complete(&st->complete). However max1027_handler() only
> completes it when the buffer is disabled. With the buffer enabled it
> instead polls the current trigger, which is the external trigger
> that is still being handled, so the poll does nothing,
> the wait times out and every sample fails with -ETIMEDOUT.
>
> Complete the wait when the buffer is enabled but the device's own
> trigger is not in use, as the comment above the check already
> describes.
>
> Fixes: 075d3280b4a1 ("iio: adc: max1027: Allow all kind of triggers to be=
 used")
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> ---
>
> The comment clearly states that we should just complete for
> triggers other than the one provided by this device, but the
> code doesn't do this. Ideal would be if someone has the part and
> can test this.

I no longer have an easy way to run that code, but looking at it 5 years
later, I agree with your description of the problem as well as your
solution.

> LLM spotted the issue whilst doing some other cleanup and
> prepared the patch.
>
> I think the reason this got past testing was that the code was
> fixed to actually return an error on timeout whereas a bug
> previously meant it always dropped through and carried on.

Ah, right, intersting, I guess you talk about
2021ef060900 ("iio: adc: max1027: fix error code in max1027_wait_eoc()")

> ---
>  drivers/iio/adc/max1027.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index d475cc91108d..65a0e85faca9 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -478,7 +478,7 @@ static irqreturn_t max1027_handler(int irq, void *pri=
vate)
>  	 * with another device. The core will then call the relevant handler to
>  	 * perform the data processing step.
>  	 */
> -	if (!iio_buffer_enabled(indio_dev))
> +	if (!iio_buffer_enabled(indio_dev) || !iio_trigger_using_own(indio_dev))
>  		complete(&st->complete);
>  	else
>  		iio_trigger_poll(st->trig);

In case you want to make it closer to what other drivers do, you may
invert the condition to simplify the reading:

	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
  		iio_trigger_poll(st->trig);
  	else
  		complete(&st->complete);

Regardless of that change,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
