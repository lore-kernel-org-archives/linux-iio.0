Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E946DFE7
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792459; cv=none; b=IEXQ6/sG5EsPUL6kO0iA5Ac0JBWo8Kwi8lJqp7Q6t6neL7R3ASKxhWY6izemhXa7NidBbFE/0qx0ngiAf5LLEG96v/tk4yXceDGXydVSCcOvtbbU29+j9vl44cXy1sCCVGoKjv0EbctuYf/WGcb2WnRBpPs+GntJMa466U/DeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792459; c=relaxed/simple;
	bh=E+MeBfcTyMEV9OSx8wYUhiX3tACuQ1SoFRNY0klEmXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVZHwwrK7p2XqRvxT/WKZASt4LEHbTu6d+k11ur78NbeGOMBD6IhXMEnQ4hefz9XZvQY4KZmjB3hrixVnR5sEUIj8GrQJufKS7iv8VIPpYwZv4yf4zXosV9SLCWoTMX1OzGGQK7TDWZnaPMWXiv2O0IamiZkU8PGMSVL0pA8N+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lySrdM3H; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lySrdM3H"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d0726ccc2so13893035e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788792456; x=1789397256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5yFrcnbH5MykHypbL5/SQUfD+utrrwUHZtQrV81eIR8=;
        b=lySrdM3HMYnaM60f6QQIrtGJiZTJfUfnHNY85vVypqubQ7Nfj4dUyQxxkn7USHPeBb
         EnqMBxfRxGtduofJbFK1O/ePy7r9wxVpbKOZsjnSdyjYzXe3JIr2IOeR1zMkQa2tzVyE
         qDCy3PrTM+H7nCk7a57sj4ZmukL3dk4UdDzhKtrRyDiGKbxjHsby/mTkQ8QqVTvCj7XD
         H7dRs5SiVwkKjQtfh4stFlJeoTx1Cg6Y0IS4zWseJM3onH81QLME2D25x7Aw4qVcuHds
         Ptb1V9xN/qILugyRbM8N+133z97aAbTv54kjHOluwbKGvT7SRPsvmm7rNmUZMq1qgMTj
         p1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792456; x=1789397256;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yFrcnbH5MykHypbL5/SQUfD+utrrwUHZtQrV81eIR8=;
        b=NoMTTwOp832dSowWILYcfjIys3dqEJFU1L0ogPGfzBfvtBRwwrlXYAP+xNpQQ4rKj8
         BoQcAZCoYJs0JUbxgxRC31DGdWlZF4TEFqckUeHAA5KLdUXbruy5Pv3MpBAECRQ1RScz
         XXTVdbdZDfuJRrSwM23bSWo9U5MARmpFLs0hRnXUg96Z2M5R8CxuITTkpD+JhnZaG93N
         cBbEZpoSDTo7WOAlv31BmAfJahLkbdzXuZXPhFd3P2cHDX3wHrnNVp5bGhaao4ITkxmq
         xPPWIzril6UoB8kPSmSLOoGcPpQzSXv3Xm+uOu1uyxw8kmtNKKQbPV7mwJmizk/7rXob
         +3Mw==
X-Forwarded-Encrypted: i=1; AKwUvBxTSwRIOVqrqmy4LGEfLMqJhtqLj0FrSnsMgjWE2xha+2g+c7r/XyAQFWrjcB9HU9QB4CerZ9TnshY=@vger.kernel.org
X-Gm-Message-State: AFuF++ncVEOene+YKtX/Jyj+EPCXNyBoG0M5EsCxEHVn6gnwypB9euUm
	eS8mlVVV3NiuohodAC896oS0ir7RJcsd5b+aB16sdTWjUIgviUBPRvCc
X-Gm-Gg: AYBFou262AI7KGXUwauGXAnyfh1owFdqKem9mDPyGRRJcGxuJMmVLfXSZOt2MjPses6
	BT/25P1yP0S7yGvEQY//cLBNuhk6aaaXLTEWy4RoSGlNDOOpg+kOixuS+80q5GvbRhKid1rNw8v
	XaEHjqNGUBJkPYLtRS9yzqPa9BBvsr2TCtcolhKDP6O7HKnoxpIEls4IZ8Vh5iFnBcXN37ZQaMG
	nGeW5vgQZvwsi/hi0gauHHn5Tf7n0isLw5B2KoYRNGEsWHJEntj6CzaEkjQ6Pyl14C1wE4TAAop
	kc+StaNPSMmVQ71amksw8Wg4/SgxPCRamLiRUAvoiaEXhf4Z5U/1kT9kux56UpSQIuXKgsMnZx4
	VESqn/sU0p41RRCuUfYE1FMkpCXjvp0CSuEa6G0VYth/Rfw4Y+si1DpNSfpqV00oHZH3lCm3Yc7
	MCj9RJQgTm9elpnVPaVygNb5xmh0ytphuRuOMNgnHBsy7c/QuEK/tyAGzbuOwWFZuhBh4YEnCC6
	ANviPSvlH2Ksg8nYc5F70laHd2x/4R192Qy4bEnfqgANfN/aC/enf/mmbrzSnoSvYTuqzBfgSfp
	Q2E4vetOUGLDmhGBMDE/riQppRfib+20KZWKpBsFojOpxItIxKiaikrpw2mziaug6Fl8cApvn9A
	WjJTMccJ24w05B0M2fFv6Furyy6GmRUs8AiDh2ruq8Ze1/RHnjXQes77xuWlagB7Mu9F32w==
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr413588155e9.4.1788792455654;
        Mon, 07 Sep 2026 07:47:35 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm28494015f8f.32.2026.09.07.07.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:47:35 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:47:33 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tmp006: Fix endianness byte swap in
 trigger handler
Message-ID: <20260907164733.000066f9@gmail.com>
In-Reply-To: <20260907082216.52821-1-salah.triki@gmail.com>
References: <20260907082216.52821-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 09:22:15 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> In tmp006_trigger_handler(), i2c_smbus_read_word_data() is used to read
> the VOBJECT and TAMBIENT registers. However, the TMP006 stores register
> values in Big Endian byte order, while i2c_smbus_read_word_data() assumes
> Little Endian.
> 
> This causes byte-swapped values to be pushed to the IIO buffer on Little
> Endian architectures, leading to corrupted sensor readings when using
> triggered buffers.
> 
> Fix this by switching to i2c_smbus_read_word_swapped() inside the trigger
> handler.
> 
> Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
> Assisted-by: LLM
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/temperature/tmp006.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index d9f6449ec0d8..f3b3de0bf221 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -256,12 +256,12 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
>  	} scan = { };
>  	s32 ret;
>  
> -	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
> +	ret = i2c_smbus_read_word_swapped(data->client, TMP006_VOBJECT);

Sashiko has something to say:

Does this code introduce a regression where sensor readings are corrupted for
userspace clients reading from the triggered IIO buffer on Little Endian
architectures?

Before this patch, i2c_smbus_read_word_data() returned a byte-swapped word.
When this was assigned to the s16 array in tmp006_trigger_handler() on a Little
Endian CPU, the memory layout became [msb, lsb]. This implicitly matched the
IIO_BE (Big Endian) endianness declared in the tmp006_channels array, so it
worked correctly.

By switching to i2c_smbus_read_word_swapped(), the value is now in native CPU
endianness [lsb, msb]. However, the channel specification in tmp006_channels
still specifies IIO_BE:
drivers/iio/temperature/tmp006.c:tmp006_channels[] {
    ...
        .scan_type = {
            .endianness = IIO_BE,
        },
    ...
}

Because the ABI still advertises the data as Big Endian, userspace will parse
the little-endian data as big-endian.

Should the channel specification be updated from IIO_BE to IIO_CPU, or should
scan.channels be declared as __be16 and populated using cpu_to_be16() to
preserve the existing Big Endian ABI?

-- 
Kind regards,
Joshua Crofts
