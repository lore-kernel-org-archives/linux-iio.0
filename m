Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A40BA21
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669117; cv=none; b=HxHuNu9ChM+SLzuLV9kLhHo2uGcuDSu/QOhEFdcDFOLOh6r04cQ9iNmZbgHv0jJOg6KRN74N2ZVk+inKa8k/5sZOktozNWe8FKSu9103yKxfvJCRTh5JeTejHbyBfr9WZz+sb5O769gfI5kgaHNgMyNrPxovtI8h0lr+roAMChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669117; c=relaxed/simple;
	bh=7/GisGeAb0QSGDWThezPsL6NT32IDJfl0jkfyfEFnmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTBDdXd8VfBq4q+DEo0Kw3m/VzscBi3WaGk4iLXY5ve6Yga06SpSmQ0NEWUm1TwAg/qNpDwJ23zljbwW7VBcgBh4mllE/BG8yJJ5j16kxfzzhucZzuFOmoW7i3Q9j8OG0ey67Hr807UIc7kCpN2NxGyrICasIjqL3wEfIWd4xZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smq0+ts+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smq0+ts+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so47405865e9.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669113; x=1774273913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGSmU9dcqf1LyB14ADER64gtrG8X3mhhv3QkYvPKxRE=;
        b=Smq0+ts+PQU+UAoDD80Sxv2YPOmBYBgM3+IE5onrIdqPbhhmm5UCVb3XnYvcNfZkDn
         dsqegAvNeDkM9SvkbhZwAdswvYIRF1ZYBMc3cJA5u4gKvDQ8J7ubGYPslA9IWmxQ4oVT
         CW2JvdbQPbl82f0ioR9Mb/l2UVCf7GClVN3WoBZHrmzXqwdkZmgXKjmQAQy6iUznO2wY
         vDwuNmVOlWZ1h+Qi/naUg6KwHstqsNZDnj5nEv9ir1tmFHCp2FKi5aG1ex9YyURzduCu
         1W5ZXlGOTi3au2Iv1OZw927/HNJP7pxe55jlAMiW1N35V1Lh+yLS/nt3B0RP0m9pS/3X
         I8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669113; x=1774273913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGSmU9dcqf1LyB14ADER64gtrG8X3mhhv3QkYvPKxRE=;
        b=Ztrfp9YIPjk+Cb2wl4gVEJPP7FQ7ixWQfoCj/wQ5i8SYB8ALJVlLv6/bY/Y4Gb1n32
         oP8o+M4mpRPrt6Hy0hL34f9lAvOAMVOKMRfpjpTHdd53MvoVDN7z2itmvUgOKtiNE0MZ
         OJ2ADyjJLNlCtN++MCQZBxpFmZ5rlLFjTjsBV476bLDQp+7jlLKgoeNCjZ6LOaSzQgrL
         p+x0OLFbFFiSgc3co6ms0AquTUZLv+1TRPiP/M+D2gNR4DGOeakjdl33Q7BbqCPyOSZv
         sgwGwPCcGkeZQUsEOBxYId6txCE/L1OCZJL3F9di2IjG3Q9/R+mYYcpQUsJlaKCYOMrQ
         yL3g==
X-Forwarded-Encrypted: i=1; AJvYcCWHFQN8q7AKw/PgEYMXZ0ObDVQ28cZzyarocgkpUhQBvbZgn8XALLmOBU0ju705kbikh8z8xbsmqdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJe/CJ5Lzy51xUD9HBLOFSl++c1jNuaZHXaS8vpHDa3QimpyqO
	SQ6n7O2jZGephECZ2zVSxkt2UX+CBhjy62vP7qpsC9hbudmzDx+28jDo
X-Gm-Gg: ATEYQzzSA2eKtTffmUBcPkVdW1ueNuxyKCsWqhw/cjnocKU2JdBhXjkXuo9NTXfEjej
	PdLRYPKYJTDSRtLZMW27Qp2q1f5UeJGiNEQNvL8V1aJHafZW7LZFBGMHOgIk5rBSyXDLqFtkF+e
	hMT4vAkC7X5jw/xbHXIWtNwpNfz1KjRBJsCn1mCxBQ8Ja5MA5A68RRQWQLbXLL7laNAft03oAGs
	tWRAEQ8+OoJyBfUdEIxcLaCzMFHCIeHfXSBC1VCx9mPPMA8Iue44f/VHfKBVNb5CiUKaMz781OL
	Vi0O7rRMJBasxUY3pZH/WQL2F7yEqF/S9FKlDiI0nqtfC7BLN4XMkCc5/DoIQnLBqVkbB5fIDcn
	u/EUtEUuIOso8m93Yw1VlZ4DazjXgcJnnFe+Z7CW00pV/xdSNtRXDKeaWScH22FDMmuMywFudOh
	4cVm+SeX49KxpHRmEmtF9snFu60gqfWOhjEvY+QWTzrSNPMSV7SPtTyt01oh3xeJlA
X-Received: by 2002:a05:600c:c4ac:b0:485:40a4:364 with SMTP id 5b1f17b1804b1-4855670c2a5mr215981665e9.26.1773669112806;
        Mon, 16 Mar 2026 06:51:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fed7sm398747335e9.11.2026.03.16.06.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:51:52 -0700 (PDT)
Date: Mon, 16 Mar 2026 13:51:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4350: replace loop with
 fls_long()
Message-ID: <20260316135151.309207ae@pumpkin>
In-Reply-To: <20260314172006.69744-1-neelb2403@gmail.com>
References: <20260311020115.56321-1-neelb2403@gmail.com>
	<20260314172006.69744-1-neelb2403@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 13:20:06 -0400
Neel Bullywon <neelb2403@gmail.com> wrote:

> Address the TODO in adf4350_set_freq() by replacing the iterative
> power-of-2 shift loop with a constant-time bitwise calculation.
> 
> By comparing the highest set bits of the target constant and freq
> using fls_long(), we can calculate the required RF divider selection
> in a single step without relying on expensive 64-bit division.

Where is the 64bit division?
(apart from in v1)
Indeed where are the 64bit values at all.
If this code is used on 32bit it has to work with a 32bit long.
Which makes be think that the 'freq' variable should be u32 (or possibly u64
if frequencies above 4GHz are likely - which I doubt).

In any case this looks like initialisation code and the existing loop
has the advantage of being 'obviously correct' and small.

	David  


> 
> This ensures freq is properly shifted to meet or exceed the minimum
> VCO frequency.
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> ---
> Changes in v2:
>   - Use fls_long() instead of order_base_2(DIV_ROUND_UP_ULL()) to avoid
>     unnecessary 64-bit division (Andy Shevchenko)
>   - Add correction check for mantissa edge case
>   - Adjust whitespace per review feedback
> 
>  drivers/iio/frequency/adf4350.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index ed1741165f55..2183deec179d 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/gcd.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/bitops.h>
>  #include <asm/div64.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> @@ -151,17 +152,14 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
>  
>  	st->r4_rf_div_sel = 0;
>  
> -	/*
> -	 * !\TODO: The below computation is making sure we get a power of 2
> -	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
> -	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
> -	 * and friends.
> -	 */
> -	while (freq < ADF4350_MIN_VCO_FREQ) {
> -		freq <<= 1;
> -		st->r4_rf_div_sel++;
> +	if (freq < ADF4350_MIN_VCO_FREQ) {
> +		st->r4_rf_div_sel = fls_long(ADF4350_MIN_VCO_FREQ - 1) - fls_long(freq);
> +		if ((freq << st->r4_rf_div_sel) < ADF4350_MIN_VCO_FREQ)
> +			st->r4_rf_div_sel++;
>  	}
>  
> +	freq <<= st->r4_rf_div_sel;
> +
>  	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
>  		prescaler = ADF4350_REG1_PRESCALER;
>  		mdiv = 75;

