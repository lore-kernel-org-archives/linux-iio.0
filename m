Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE03288B1
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782582297; cv=none; b=K/tjISTtiFJskJm8Q92lUCdVMg3ueVe3l3ttaLbBN7dPZqua0m3kNZiBUaiSkfy7ohI/aknYRyqXT2MDE3uMxC7J3PDB5PMYzxlTHtEg0Upqu88c73iOvwy3z1uVs8gE/HlWNvcNj+LRHvxxALMI2IwKgHxCt+o+yPrLuXhiW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782582297; c=relaxed/simple;
	bh=A41M8uP44OawDz8zOzJX18CA8vhnP5nbbTzgUDs30ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8oogidGmugLH/HLb3G/uoeeO2LBkMJaJFMIxnlXC4JryQbnTjz5a5aBVzWS+cslGt0QUtbKSX6GeQYW6CiFyl7A9AG9naTqPTrHlfkfZIxkg9pc3h8/tTxmxlj4yTmHgZc2h9cUSvlmIJBWR++BcX9mImhxLRnGGBm1IoaRUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWDJYUIo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWDJYUIo"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4720f3bf164so161695f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782582294; x=1783187094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHEbbYYxlRHrBBYrZuyNBdVcf7muRXdd/OP7dB1/HX0=;
        b=WWDJYUIo5hBmskhUcCs43C55yNt0DzNDCOI0EUvr7XuYA76snHxsnd4aGBvo0hANB2
         Ok3duChcKTGpD4cNQLdYHju5XssxvZ2cdW6b8qE4xaBd9EVtQkoZVl7pvIKPOSM2PPmg
         ueYPi7LVjLcZe71I2rQqsdN67/9hLE3orXFJB7gHwOD2XWCxnd1BIxyX40insuuZXUTQ
         qkZzD48v9ZbQPcMWvFiD3M3/ZrEYbk8cXf/Sk1jpGL0QnGrAP2vbrmUO/JhstBxqK5K/
         S4lsfnv2ZMcUVCy7B75RPsuQvUyeh7XfI9u9UxlwE0tErh0q2APTpd2j4XQLhLUDT/oN
         aOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782582294; x=1783187094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHEbbYYxlRHrBBYrZuyNBdVcf7muRXdd/OP7dB1/HX0=;
        b=iWjE3spmTHftUzgwagf8oAUJZuDLWfWiVkK8aYWqG1i4LoVs93t60Npx3YZjuPgP1n
         lt1UBRc7gZbOo1b3VAUlWmPraw6SJrPQgih17G4ysbhD3anyoAhl+ZppDqhrxpIx2umu
         zZBRvm5FT4vlIr/KN2HpeGcpysF9AqQ5XrfxLKA/su1GcAPrre7wF44UK/SA/PfIPH99
         M0EkO5FpIaMYZ76FljEwNlcmH6Mdr8q68jFhELD669ZqNNS83i/myZ52W6HjBu8dq9C0
         JCTelnD/RADkeeVF2K67IJaFebpbAFF2UIPlkCzpuTtmo30ixFKJDIN9QDpvHG/qzWzR
         G1ow==
X-Forwarded-Encrypted: i=1; AHgh+RpkQZC/N7T2DvwJbJfKEok+itFEtcK/kf/oQmVtApJ4hPxPtbEt7RGcJupCc0dyggbwCp9OYhZyoQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZ4i/YcPVOPO9Q/QdGqhFtX81SAm+6h6dswjd7DpjZHPfhoD1
	pqz1rTQFL/K4LrueFeX1qJVF+RwvjpgFgRfoXKKG4m30V/RvTRcLffhr
X-Gm-Gg: AfdE7cnUldyF4dATmo60I8gzOhlBwmeFTsY/6MhOznoTeMCAKXNpMxNncQckzkoFuG3
	rcHtyGLHRmoE/jixm15MlvI3Z+BviV44Zy0uKDWM2xMS5Les3S4JBO9p/JLxkVN/VZKz1hPezzP
	bLQRDLDjN/AMvTLQvKBKfwo7OPJIXhqIXTpDGyrBymA/UcjeYm+bMJ63qRFa22G9vnm/fdJs9Oj
	0voRJgIdZuSURrwzmurZq2S9gJ9IzwyiQN1672HnFJdhqrex7fhIdx+WfrNh0yeH0iA/6a0NZQw
	U0wd3bTmRlrzCoVndHWMKd7q9pKGeUH8NYW3SIIxY1onedtAi4vu/dvn8DrvnKKnoN7swnORdru
	07v/7opQn3aQyx0UYJCIRfw2rA28iTTGSgwKZjYwVviBVt+VnCF54CbMY3OTONAmrRTmVT81Lon
	0VdIHrvfsb5suNGLNiu+o/x3cJ6xBYZtRQV3eWX5LyipU90fP/t07Vx6NlowSDBLErGIvrvBblh
	/NzlErMxQTemoUbnKlVUmA3sxVnfHOaSgY/MaPT6XVR+JV4pViPbubdqP2Yjvd5qzhjKOUyzWxu
	UueFlA==
X-Received: by 2002:a05:6000:18a9:b0:461:a15a:4160 with SMTP id ffacd0b85a97d-46da8c5fcb6mr18379220f8f.13.1782582294076;
        Sat, 27 Jun 2026 10:44:54 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e95f3d71fsm19042615f8f.12.2026.06.27.10.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:44:53 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:44:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, andriy.shevchenko@intel.com, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: dac: m62332: Use guard(mutex) for locking
Message-ID: <20260627194452.124793fd@systembl0wer>
In-Reply-To: <20260627132530.96680-4-erick.henrique.rodrigues@usp.br>
References: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
	<20260627132530.96680-4-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 10:25:30 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
> simplify locking and make cleanup automatic when the lock goes out
> of scope. Also simplify the i2c_master_send() error handling by
> using sequential early returns instead of a combined condition.
> 
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
> ---
>  drivers/iio/dac/m62332.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index ee8fd3a71315..10ff6727b76c 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -47,33 +47,26 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
>  	outbuf[0] = channel;
>  	outbuf[1] = val;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);

You're missing #include <linux/cleanup.h>.

-- 
Kind regards

CJD
