Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0484E2F13
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650987; cv=none; b=rOUfQ0QisRtUJLZhzrZqallOfu57gPnMTAb/Fq5he9osCGiTh8E1eFND77Du5wYbSk+zb0z11dpBLKt6O4EGSJH7GnZgHlTXw8iq8KQClguijf6+oT4KDF9KbIAJLNVY1Mygog6vwRof+ikB0UZWeGvLLPAWVHppJQysQf+OlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650987; c=relaxed/simple;
	bh=uH8NWP6hqMrvDVS9z/5CKaKwPsFLHJzxuq9YJ/dyciA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQuAgCCPB4wg8T/p2ao1EUkxeZszs05+JizHilcODHB/hVowUqZiIYKYgHfEyZ7LVuuhHBlHgRoU63+amp4ScVtoQBCvHJkB5EuGPlbGM8QSy95Ar1+sL1+HjHw/2vBMHhDjKzuwjlIn72Iz81Mfb9tu0HZE0elg55/Q14lApiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDEOMm0u; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDEOMm0u"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so3146445e9.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789650980; x=1790255780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jyHTXhU2i3wo4vr8m+HRY7gVmHqcPKmGSY9WcNTgeTg=;
        b=cDEOMm0uKQIoAo4QkAnCSDCycAgEo1RaoKX8MY3gyrq0OVoGGg7XZTw4+6Zn5a62pe
         igXwyfZRvdbdTtCyF1+yUeehbr/KjyZrP3tb6RNKVBvCFAAIOaJQGEdixs+HAfTbMlF8
         RRsaVYzYFWI/x/XWXUPGFRqX8J3q+h9jqZpRktoX4wW4SOmfI2HnhOuufE7htnKo8HOo
         9B/6+PwK1gvMI0l2wwwOm5Vs59sqnF1BZSWNZYFL7U/ZDSGbBYjo/8Mp4cuYpvxWKBV/
         I2aAlkBT4MEnnkPQTinXIEtkBP6/D7Aq/FHnmlUgwM2A26fSjvCI04HHLDFcyM4E8xRQ
         1kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789650980; x=1790255780;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jyHTXhU2i3wo4vr8m+HRY7gVmHqcPKmGSY9WcNTgeTg=;
        b=F1Eb0iirLAh1yPmh9PTlj88AhS5QAlINolxuIEBD17KYFxXYziW9aGfpGL5Z5gUKIn
         Vq6EPrZPRbZNpCPlBKxgmtQfVCUx0aYLAzYwDSo6OE/CYPOTHWkrY3i1fm55kZWbLeTb
         3kvu8OxfSnSrdn1C/uEPIxzd/BjFqRdFchTEBXb8k4spCxGvOfRwkJawCBZHnkJTq1+f
         F3A6ZG7rJjIKcVxinVPnsTKyo4O9wkLM5I2j7crGS9afROlIZgGs4u2X74FHPtii7tJo
         5eU+p7S/VHrMJ+Z6iMxnjpxOC31GNl5cTw7Y09LF/SjEYk0bCBDHEklTt4HK9O+rGNui
         LdMQ==
X-Forwarded-Encrypted: i=1; AKwUvByoFgGaw/ATwJcid8WFlH8OBGgcvgBAjNrhrwRL/zY7K1C/GfDWSdlMJEslgaRsoE78pOoiuKQv7Pg=@vger.kernel.org
X-Gm-Message-State: AFuF++ltvbkLXwdwNCPIZGwSdscLrD75uSbPm9hUatOWupYMa9mIRz3g
	Dsv65CzufFTnKCw1EtsbHzwpod3IYC3wXHpwKbit0GLbC6vnqzmbw8fW8Pv/yQ==
X-Gm-Gg: AYBFou3ylhzMG8JRL9kXxaeoXW4FIuABaCGWH3pKbSh1cGJXkY2SYa2sx+qJ1+UlxeP
	IV50w7AhC7fM2fVH++bv8UJM2m7OO2ZPioWinUaAKgzSfu5ppGY0RBVOK7qxhXBVJ/8IdEgalAU
	+uG9xrIC5ac39z9ykgtyhh6xVvJOv0rcfEB+daq60uAGDFetTHZvykEXdZaLhDbajPRUOv9O7Zm
	Wfq9tTdQvM5kdW/kMevMHOwIaekr3gLUyV/x1NyfuwdhwdXw/N3kPOnjHd5fUaw0zS/F/kRCQta
	9t09o9EUQG7u9ZYRQ4389T5/CF3bmm4nmh6tn4jPlA4LNdZzzdiELEJw/lpusLHm2P7yoH3v+7d
	eaqfJ1Wn6FWTx19jPE/dCsr02wmvtoj4FX9RKkoz6oQ3f75OrIUqw6x9RhHOGimHXhRetrER+6E
	JTjHOcibAA+XlkfKU2dmzCUNZ/Gz+czubcJgFGDMzCs3YDLPRscKxqsLDlZgw=
X-Received: by 2002:a05:600c:1992:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fbd1af43dmr45281015e9.3.1789650979552;
        Thu, 17 Sep 2026 06:16:19 -0700 (PDT)
Received: from pc ([196.235.229.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd232b25sm73364885e9.4.2026.09.17.06.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:16:18 -0700 (PDT)
Date: Thu, 17 Sep 2026 14:16:15 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mlx90614: Fix dual channel probe
 condition check
Message-ID: <aqvoH9ohxkJ6iPei@pc>
References: <20260917110121.631587-1-salah.triki@gmail.com>
 <CAKv63utdoBrCFiw8vkGsMhY9PrWX0DWdxqP5szvTGpdmfSQh5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv63utdoBrCFiw8vkGsMhY9PrWX0DWdxqP5szvTGpdmfSQh5A@mail.gmail.com>

Hi Crt,

Thanks for your feedback.

Actually, the patch primarily fixes the behavior for the MLX90614.

In the current codebase, MLX90614 has `chip_info->dual_channel = true`.
Because `mlx90614_probe_num_ir_sensors()` checks
`if (chip_info->dual_channel)`, it returns 0 immediately for MLX90614
without reading the EEPROM CONFIG1 register. As a result, dual-channel
MLX90614 sensors are incorrectly registered as single-channel devices.

For MLX90615 (`dual_channel = false`), the condition was bypassed, causing
an unnecessary SMBus read to EEPROM CONFIG1, even though MLX90615 only
supports a single object channel.

By changing the check to `if (!chip_info->dual_channel)`, we fix both
issues:
1. MLX90614 correctly reads EEPROM CONFIG1 to detect whether it operates
in single or dual channel mode.
2. MLX90615 skips the EEPROM read entirely.

I don't have physical hardware to test this on; this bug was spotted via
code inspection.

Best regards,
Salah

On Thu, Sep 17, 2026 at 01:27:48PM +0200, Crt Mori wrote:
> So this fix is for the MLX90615, which is registered as single channel
> operation? Did you test on 90614 as well?
> 
> Best regards,
> Crt
> 
> Crt Mori
> 
> Melexis Technologies NV
> Transportstraat 1
> 3980 Tessenderlo
> 
> Mobile: +32 492 46 22 15
> E-mail: cmo@melexis.com
> Website: www.melexis.com
> 
> ----------------------------------------------------------
> The contents of this e-mail are CONFIDENTIAL AND PROPRIETARY. Please
> read our disclaimer at http://www.melexis.com/mailpolicy
> 
> 
> On Thu, 17 Sept 2026 at 13:01, Salah Triki <salah.triki@gmail.com> wrote:
> >
> > In mlx90614_probe_num_ir_sensors(), the check on chip_info->dual_channel
> > is inverted.
> >
> > Currently, if dual_channel is true (MLX90614), the function returns 0
> > immediately without checking op_eeprom_config1. This forces all MLX90614
> > devices to be registered as single sensor (num_channels = 2), making the
> > second object temperature channel inaccessible.
> >
> > Conversely, if dual_channel is false (MLX90615), the function skips the
> > early return and performs an unnecessary SMBus read on EEPROM CONFIG1 even
> > though MLX90615 does not support dual channel operation.
> >
> > Fix this by negating the condition so that single-channel chips return
> > early with 0, while dual-channel capable chips (MLX90614) proceed to read
> > the EEPROM configuration register to detect whether 1 or 2 object channels
> > are present.
> >
> > Fixes: 3d5ead238bc8 ("iio: mlx90614: Factor our register IO and constants into model specific descriptor")
> > Assisted-by: LLM
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---
> >  drivers/iio/temperature/mlx90614.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> > index 27d6ab5f5d7a..4f79da1f905e 100644
> > --- a/drivers/iio/temperature/mlx90614.c
> > +++ b/drivers/iio/temperature/mlx90614.c
> > @@ -565,7 +565,7 @@ static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
> >         const struct mlx_chip_info *chip_info = data->chip_info;
> >         s32 ret;
> >
> > -       if (chip_info->dual_channel)
> > +       if (!chip_info->dual_channel)
> >                 return 0;
> >
> >         ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
> > --
> > 2.43.0
> >
