Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3D27FD49
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826170; cv=none; b=JVhQ+zEXXVgzwINqC4SAJ2JWLEkpTfhTx+k5Vya6rDFusYApJTDOJqHE0eqWSFFbZ0Y0QiLHxjjb+l6FKVk3ZQBDsx8P83PwpHuQcXPI+E8gxeoqStp/YQbF82RAqJkt82Gm3O5Ge12RSTdMe+Mw5mu6qTWWHHenGw5FDPcO1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826170; c=relaxed/simple;
	bh=DMpO3ajwC7Btu5PMHyb9DYRbQhvyvou7TYl47BKDq7w=;
	h=Date:Message-ID:In-Reply-To:From:References:Subject:To:Cc:
	 MIME-Version:Content-Type; b=Y8Br9S7hKWORLFuymEfNo86YSFhBuF1T594Cs+v8l9bU1xD/yHfBb5hABoutYbtuP70Z+l/+9pktBRP25Nq6F3/mRXAKnTaCH6ekIHGaTLA1TnNE/oV5MlZi72viwxCO0Ow46J6utrerk1K7FCzcRbd93pA1NEb+3tKC8E2npjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFPiv4LE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFPiv4LE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso30109725e9.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 23:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785826167; x=1786430967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :references:from:in-reply-to:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATMBDpTJ93xuadTJt1TrQQurBYrCmx1OgG4lu8gYdpI=;
        b=oFPiv4LEatyzD8ZSFeAPEO+6Nl2/hfKhfdgRIeYQ2lxm05lIvMt4zrs7BgJqA8M0/A
         JE9zoC+vTjF2Ruof3omONvuaJbUx0BwsXC+iFwPutuY8EdkybTd3X4gpaITtnYYse9AI
         dgwdXgpvkvtWgibLYcAl0oNPbkWRKLolWg2BYPjK/L4ls/d/L0mlVgOU3XQb3Ja4wsUh
         MOs3yMcXYJI1FxYPDcNkCu/g/y+IddktkBIQyBdBD4NTIq1st+jjCcJzIY3d36GsSyO1
         Q5OWOPGTfXVsjB42zcXWPlcajb8o4umSjSINvY2aFjKhbIcrF++bi1k1ehwvgeBWshm+
         IAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826167; x=1786430967;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :references:from:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATMBDpTJ93xuadTJt1TrQQurBYrCmx1OgG4lu8gYdpI=;
        b=GVrWKQLB/rXv7cwCopvJmor+POXus/NIDPQJ9vSb+FC+gtX2Eq/zZfWdjltk1mEDUn
         KVV1nQ3+InmF9+YZ5NkpWHLURp+r7/14CbvJfmcByJ3wyd24GgMnjzL51/8lBgS0jXIN
         gsxkiUp0gPeE+zk0QjRGqH+yj2XPW0tqtmjNKaKNJ6Nq51yAblMgALvOzZCTCE3xn+mi
         9D0RXZ+4NLLehsuw6J0e9yOWSGV0O2K5uWdLHxwHfi8BP9e5gktVpWB9CxvnKftIJ6fP
         EHdbcHfKpgEEk08TwbAFUpucoB3s8UUaGFbOJrkNulh53cGxIXIiJM5NxhxzreHnDVdu
         qlaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDzqiPIJvcXNGPP2yKbMtLvo8YA9AHvND+2WUB3VHNw/nNo+01D+FaRG5Djls9B+xErQw33cbj6zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0DLBdEvJKiaERJ8Z4MpQ97GfxoLVnY/JogpYDo9BoDpZEyn3
	x9z8J7f9Q3HwQ5HBSfPSIhntmXNtyyM/OvQuqUvtGR14uUI12D5A6rX/
X-Gm-Gg: AR+sD11ftKR66VvN0Y/Q+22e0gaH59RtKuaJqAewj6G6XSzbKy6OtSs72+cKZY55/We
	amEFo0vaXTjhCXORLXXC+6Hr8XHvQvZRbhfKYWX54S1me29sBEoca0E8usZH1tvgcpHEI6Wh/k+
	U8eeIwbkyemd9B1GpNr2uy0fb79V0BuGTTIi//w8oP7BhR80MH9Yr6La4VrunHLwiculxDpSQui
	zA0/DmN0HPtUOTOdvIy2RbrXtjDMAOPdcfye7Z9m4shPPUzhuhM+/Hm24lr4hZGTfMYU3r4OyjX
	sF2NwJLs8EdPBjRrq3r7j9J78gJQDpza1L9QZYg+ZF3gM/RSVtkmQ7CjzNrFeOwS7ykBd0r7uJE
	8UU9nKluF2UX43PdsW4DnmojxpZDSJHQ3IuJ63XwJ0Z2d1628QTMAthPx+erEI5NoL8aa5aScZn
	jOvyw0mkYKNixX1weThuz3uQvRnu6oWfYiRmApbsD39SWcK3aew5a3C27Ie988i6rbQnQEN5lGX
	ep5rfz/tK+6qdqQ6+AZA6+PqQA2IwgIDcDHwSGDtLHhFBzQtYQCeZHp2L1u2pk0V8W1WVns
X-Received: by 2002:a05:600c:33a5:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-4980c66d95bmr204358605e9.7.1785826166768;
        Mon, 03 Aug 2026 23:49:26 -0700 (PDT)
Received: from localhost (host-95-246-56-150.retail.telecomitalia.it. [95.246.56.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fdf392sm99790885e9.11.2026.08.03.23.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 23:49:26 -0700 (PDT)
Date: Tue, 04 Aug 2026 08:49:25 +0200
Message-ID: <5ea928fb5e9370824d62a0c5d5913458@gmail.com>
In-Reply-To: <20260802071246.62046-1-congnt264@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
References: <20260802071246.62046-1-congnt264@gmail.com>
Subject: Re: [PATCH] iio: adc: pac1921: fix wrong channel used in trigger handler read
To: Cong Nguyen <congnt264@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?iso-8859-1?b?U+E=?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matteo Martelli <matteomartelli3@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


On Sun,  2 Aug 2026 14:12:46 +0700, Cong Nguyen <congnt264@gmail.com> wrote:
> pac1921_trigger_handler() walks the enabled channels with
> iio_for_each_active_channel(), which yields the scan index (bit) of each
> active channel, while ch is a separate counter used to pack the samples
> contiguously into the scan buffer.
> 
> The register to read was looked up with the packing counter instead of
> the scan index:
> 
> 	ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> 
> pac1921_channels[] is ordered by scan index, so channels[bit] is the
> channel that is actually enabled, whereas channels[ch] is merely the
> ch-th array entry. These coincide only when the enabled channels form a
> contiguous prefix (e.g. all channels enabled). With a sparse scan mask -
> for example when only the power channel (scan index 3) is enabled - the
> handler reads the wrong register (VBUS instead of VPOWER) and pushes it
> to userspace as the enabled channel's data.
> 
> Index the channel array by the scan index (bit) to read the correct
> register, keeping ch only for contiguous packing into the scan buffer.
> 
> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> ---
>  drivers/iio/adc/pac1921.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index bce7185953ec..0037509503ed 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1037,7 +1037,7 @@ static irqreturn_t pac1921_trigger_handler(int irq, void *p)
>  	iio_for_each_active_channel(idev, bit) {
>  		u16 val;
>  
> -		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> +		ret = pac1921_read_res(priv, idev->channels[bit].address, &val);
>  		if (ret)
>  			goto done;
>  
> -- 
> 2.25.1
> 

This looks correct to me. I guess I didn't test it properly with a subset of
enabled channels when I wrote this.
Thanks for the fix!

Acked-by: Matteo Martelli <matteomartelli3@gmail.com>
