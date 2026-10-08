Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165B3DA7FF
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445296; cv=none; b=Uqu0UItRFrKlsR4vkqVVPY/cAxXAO8nkii4wbWSXR0lS19cdgVd4L+p2dLPQd+DsrB+UF28XfAH4BUYztOT2ZHavx+Wpi7Z2qwoC+bQCSZGvDuT3eyIkkSjwefxiX3pJRC/WA8Fal+OF1vl0al9xN/Gv0KBCRWXfeq4xoU/SRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445296; c=relaxed/simple;
	bh=p4eLj3IK1fG9x/qSMIU6H1LY2Et2owyfZqZcFS+5pn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpQBuxLOSCJAq1N6cG4HfZABtvU9AjILXnayWPqwA8r1w0qMjK0jGICggtgJt2gr/BhpQ1ZSekukic2SDu4W5glMbO3gJmam0eZsVftOWyIXfaXvnkQ6Mz87lhBmAOiCWpxlVmgxpBQVZb8poCx9Q+VNNYfH6q4KLRr3T+dGds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVKj+J9T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVKj+J9T"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so56081315e9.0
        for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2026 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791445292; x=1792050092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRAYeLKeAT80x2jiBfAEaezNXmhhh78xhPr6M0J8/2M=;
        b=hVKj+J9TILkyjZfmYLUF0m7f+C9fBIPV54Z6mgpHRSyOV4285p9WJEr5G2jmxay879
         xQL648Xpu2ec7zcVVJByx0JABiVgm62EJHyqH/w852Sj5/abCIkNWmHfhWY3uRTaTHh8
         gu2oHiNmwYlTCf4kDrEOErVv1PNJI3EuaDGTSGrRgM2lwtcaLEmyCUdoMjIHlW7rmh+k
         uqyYOtxuaZkP/QNBFrqSRdCTekma25BOl5l0Madw9YZRCwNQH1RSUZ5S9gJGntZE7ZWI
         CAqon4ZEUQD3nTUO+Zf5VnRTTExMYdTTLGAGmI6h8/T+kVDPsWe3PZDZzV20Wf6SE0Yv
         9q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445292; x=1792050092;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRAYeLKeAT80x2jiBfAEaezNXmhhh78xhPr6M0J8/2M=;
        b=zT/L9mIkTYNTKeoUSQx1X+/ahhGTX5xjWQE8T1dGbkHwtRRRc773zfX215lYU/uuUV
         zypzH/X9K1TIqG5UAHX3RxqwMtpatsJReQJXWFUwpJB2CgK41OQ/fj9rtGBC+ywN8fBG
         hbneGKiOKwVuYWEAZHSsx2VwX5yPyUO+vGmV5rWnWFWVhPITlWepv7/FmYm0cbdF3+xK
         d292bFVJhdLob/+S1qSNUB+TWt5YD24hJoCA5DBoyi6jrzec7q/4Ld8EVLkCjW6tnUVO
         YKtIJJyZRgAfr96w30u8q/vCPxMtYmY3lXFYGkNLObDGtoyYkTdmM4iMWL4J/pikmm0k
         3Jsw==
X-Forwarded-Encrypted: i=1; AKwUvBzlTVIihEaKmTztUB7ZpEdCQcVHQqyMogTk/5pk6bzQu0VZVe5HQq97hK3DTHQPdaeF6H0Fk3rj3ZE=@vger.kernel.org
X-Gm-Message-State: AFuF++kD5QRAgq6LsKgBaHpYo1krdx8zQITpuHPz8J505mgogmSPb/NC
	KSdBwbF7tUi2D/R2diqHdoY9OU6W8u5/qDuX443PVH0XixAVABrkwly0
X-Gm-Gg: AYBFou04LsUAT4aL3POejUK3IC/peXRmGV8NbpTlpYESuaPM5f6O2g4YtKMDW7I6Agr
	T3OhF4un0Gk7L3HQdnP1dtmRF4iCX3+KejCFns8DIa8/DHlt3tXUDcxEi7LLvlViTaOPGAWK4js
	WFTenuo95za19Sc/nIsKhKx1FQYM4qHtY8B9vKiHVMSnOWJ6d/7IY5gcKonKZZ9YOmFWBf2V+AE
	O0x/OucuwSMpsdVq1KE0ajqMPoRQlct6eLTU5v887vU7XHEaXhmxQWPv7pv2gsFFLbiwLogTRIx
	xpCDtE72vf+Va5Qcyfqh0AjHHlWINlzmKDR2sB8Ifm7Q5Z0nQ+vThi74CezkI60So8rluBewRoh
	MizwD+x3/lGZqLeMDSTOtgshJDgXMeawdIHnahON/l1Tgzzj+tn+sVJtpuSAaORWt5N4AWZAumW
	C+wZKQg0Wm9TXPcnHLgB6RYMcedIlPmTeq/Hi96aMlsbuLqTDLQQmianVSLoK/9aGhtVwOrkccx
	A4tfOhdjPTMDJC+KK7+ibYDbvmeduPonLhzo9ArODwtukVtE8Oq1CppBkjrfwiPNKrKSnpQibRZ
	tMYWY2M+OPwrAkVvH/xJtwxdRwPLajITD1YfkzCPhIesYq6aPayut6ULbiA+BwfrDahgfodEqBO
	+svQ02gaAWRrwPjUyjw9ZJXPi9AWdKvBYS2hoo9LB/BJUmQqeuCMc4UMBYJ7vWA4O1cGQMZGB4L
	6GKGKkFyS3oalQ+pg=
X-Received: by 2002:a05:600c:154c:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-4a18043c080mr88363195e9.23.1791445292117;
        Thu, 08 Oct 2026 00:41:32 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a185d914fdsm68758875e9.7.2026.10.08.00.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:41:31 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:41:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Alexis Bouzigues via B4 Relay
 <devnull+BouziguesAlexis.JohnDeere.com@kernel.org>
Cc: BouziguesAlexis@JohnDeere.com, Jonathan Cameron <jic23@kernel.org>,
 Lucas Stankus <lucas.p.stankus@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Lothar Rubusch <l.rubusch@gmail.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl313: add missing buffer selections in
 Kconfig
Message-ID: <20261008094119.00003007@gmail.com>
In-Reply-To: <20261006-fix-adxl313-buffer-deps-review-v1-1-386006c407be@JohnDeere.com>
References: <20261006-fix-adxl313-buffer-deps-review-v1-1-386006c407be@JohnDeere.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Oct 2026 19:08:58 -0500
Alexis Bouzigues via B4 Relay <devnull+BouziguesAlexis.JohnDeere.com@kernel.org> wrote:

> From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> 
> The FIFO support added to the ADXL313 core uses
> devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but its Kconfig
> entry does not select the required buffer support. Enabling either
> frontend without IIO_BUFFER or IIO_KFIFO_BUF causes undefined references
> to devm_iio_kfifo_buffer_setup_ext() and iio_push_to_buffers().
> 
> Select IIO_BUFFER and IIO_KFIFO_BUF from the shared ADXL313 core symbol
> so both the I2C and SPI frontends have the required dependencies.
> 
> Fixes: ff8093fa6ba4 ("iio: accel: adxl313: add buffered FIFO watermark with interrupt handling")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> ---

Tested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

If you're doing the same change for multiple drivers, please send it
as a series, it will make reviewing easier.

-- 
Kind regards,
Joshua Crofts
