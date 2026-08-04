Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152364399C8
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855370; cv=none; b=Ve/efR/wZsqMm5xnYBO4daifrDfY7GFT7s44W5O68gGD64hMFWD6f17ykMpcL6/2KT0uZihzKkfKw9k1CtnXPCrb5sK/61FdXykuDxI+Jc6L7J8gBNUTRkXxcD+/9FFoeR/DnYFalIceqG5Y5m4aEHo0CWEWL1qnHobbdvjcaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855370; c=relaxed/simple;
	bh=i+H7jY0mSc+KEc7VSzDtqOTfn56oYjDd3KqE1qtHxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9BL9H62yGDpt6N+TlmoluYQA3qsOpwdRtTretqqw/85dpfEwu852wnZHP5ztL2ESnHRAfheuTqxBeUBY52pMpszIKduLBbF28MXSbHifG3Pjv9FHQLaITDp7aFZGuqt4a/KLa2CnxSgaCuBJvZn9j+OHxMq91XsHBX2z9egr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNaxwrPT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNaxwrPT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49553515a8bso50464405e9.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785855367; x=1786460167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dw7iJbqbHaMY2LBdW8tLp5jrEOVyIbWuPmPQ4OlZuQ4=;
        b=jNaxwrPTdiDg27z2uFqzTSPKHFp5tfNnhj7YWC1WHwJam18D6mO7cPGU3keJkB/3Dr
         KOt29CLrRPrMIn02BAd5buyshdGdlspqhbzjq15FK+3YVhqPJDAEtw6wJqJKnlZ/OL19
         hIbvbI5k0shcqJtDXdpD8/+DSN6dVVUqoxT3fj9R5UyzU13Xzyckf2tWOEvEZ4RoRjEs
         sPPy6kM/PsUhNIr8/ziwNN1rOKi5dX1C8q2lj70Mmf9r3hSMwIm4IUNXHSEkk0akp24v
         V05Eswr2bUnyYmdGNFWDMIi9Pwe+KnV6OsFp5fY4P2hPFtLvHAOBl+PItPHu3Evm9e4V
         1hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855367; x=1786460167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dw7iJbqbHaMY2LBdW8tLp5jrEOVyIbWuPmPQ4OlZuQ4=;
        b=qsQS3vVDZ9smI9Yb+jL/mW50x97DyFqjDaPsZkaBQYVDwgitFAjWM9ds5pN5wLJbW3
         RMgUHwk7tJAW0Nbhm21L3bjkY+Izt3X3RLa6J66hSqgOJ5mMZ2DzSD6pH4/DtrcHss2o
         xBtBqJzx7RwBgjVHy3q6Int6vTZ+de7X/bojB63j4tfpYSFMgIPa/3qpB40EgQqVFgsF
         dqqrCeC30fKHwU3jCU2gwpEzDeMiQDEFm8mO/Nv9s7uo33KDEN7eHnMXPX0HVYBp0753
         5swGA8PgZGbMBCBJDyC6I8UpoQFrYSMI9HfgDOFoTKae7aex6wl2WVk7yKevYdZtCV60
         XtEQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOl0qE9Y0kOOMzkkxnhWdvSSyrovBAxLBoh5CYx9K0iDflY/lXmbEVPlTmflj4jIkYlFouElL89Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNZAUAX9Yq2QxWYo6kXg0bYRvyqXAME7HyDs2r2zcxjkl/ZJn
	xznQVQfxcx1+AtzF2ubazDT52JqArUqN6wZiK2gVvYKxqiTjzANCBI7J
X-Gm-Gg: AR+sD11PeYXG6GSWCiuxHUg4cH5WRa+E08wXAMH8gPmgeec5iH3i6NF56K/dI3+ac0x
	IyOR6Gm5nSco7RYMqHHpmP1PqKUmLTjDB/MOyBEB1xzSyBIXZgqjuxQAj2PordizOGcCRhgpPdd
	CmhokgGus0v2rFsJmqUzr8FTlU5QR7CVS9bjyGRZ639CeTsPWvRV8CULxvw0/o3Esn+RcZ2I1yB
	A3Vl5SLtFNSuYCQ3kDd+zPGayAFmBcig+754DD92Ow7NGR4r5g6Hqav4w7cpcqcGq08wbeIu68D
	10K5FRfuWaqlEcSONNsD6umWw6xiTHujYYJydlgpVvvA29p+8Qotm4KMO1umsArKFjOS3oZfYLE
	idztf27cgm2y7m8i5tb1HGEi+6dUtHuynTViwxVAEslBXR02abB6OucGWUu+P+/ZD9lbV+rW3PU
	vyP/UOPRt+O5VUVgrJZ8lz7hRfAr84GJ1rXyCZpIP76QRPKXhAxb7L
X-Received: by 2002:a05:600c:8b16:b0:492:6447:7a7f with SMTP id 5b1f17b1804b1-4980c66c84emr273645135e9.6.1785855366892;
        Tue, 04 Aug 2026 07:56:06 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e041b4bsm3730495e9.12.2026.08.04.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:56:06 -0700 (PDT)
Date: Tue, 4 Aug 2026 15:57:17 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org, igor.korotin@linux.dev, 
	branstj@gmail.com
Subject: Re: [RFC PATCH v4 3/3] iio: position: add Rust driver for ams AS5600
Message-ID: <anH7kbxvS6z5GlPI@nsa>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-4-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707151542.91997-4-muchamadcoirulanwar@gmail.com>

Hi Coirul,

Same as Jonathan on my rust capabilities (maybe now I'll have proper
motivation to learn it :)).

Just one question below...

On Tue, Jul 07, 2026 at 10:15:42PM +0700, Muchamad Coirul Anwar wrote:
> Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
> sensor. The driver exposes in_angl_raw and in_angl_scale via the IIO
> sysfs interface.
> 
> Features:
> - ARef<I2cClient> for safe refcounted I2C client access
> - Mutex-serialized status + angle read sequence
> - Static channel spec (module-level const)
> - No magnet validation at probe (deferred to read_raw per IIO convention)
> - Error propagation via ? operator (no recovery state machine)
> 
> The byte order for the AS5600's big-endian registers is handled via
> swap_bytes() in-driver. This is equivalent to C's
> i2c_smbus_read_word_swapped(). The long-term solution is regmap-rs
> where endianness is configured once at the transport level.
> 
> Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).
> 
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
> ---

...

> +impl IioDriver for As5600Priv {
> +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Result<IioVal> {
> +        const INFO_RAW: isize = iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize;
> +        const INFO_SCALE: isize = iio_chan_info_enum_IIO_CHAN_INFO_SCALE as isize;

Likely stupid question but do we always need the above? Some drivers might have
several INFO_* bits sets and we often need to nest the match if multiple channels have the
same bits. For those cases having to define all of them like this and
then doing the match seems not great to me. I guess we can directly have 
` iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize` in match but not sure
if it's also that neat...

So bottom line, it would be nice if we could have something nicely
readable that we could directly pass to match.

On another topic, I believe mask is present in several drivers for
historic reasons but note that this parameter is not really a mask. So
other name like 'info' is more appropriate.

- Nuno Sá

