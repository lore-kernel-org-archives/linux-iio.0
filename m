Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F063DC878
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900523; cv=pass; b=BbyfGAqW8Mkk+iQkDBJZdEpWomVGW2glU/ySkKBcWXqq4O8InQiFacM+8F8xPvtbT57yt5aM2Bs3YN+9fD/YRjioN6Md2+Xhl0LNKGOP70Q6Mo70w0GzoJBwxwGSN5ILLhJOnZPax2qdQz6U65ELMCxgnUXD7Pw+6AE9ajKk3o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900523; c=relaxed/simple;
	bh=WUMZC5zmbWFHHM9fj/b0WVfBxUhBF81uS3y69nJEc54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDjWt16l1NDdYXa+2ykCY4prWykep1N8z0RGVxIIdlhvlwEYvwpy62g77GL4DWSoRqfNXMQHi5Y93zVwOs3WMvC0BVbHpnWMXPIRkjZSJ1Fw+maOSoFuu3Z1KbsfqKvt7IEY8BSEbm9VhwM8Wyh7+ZCXIxyQggZ/l3lQrEe89Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn9xNuvR; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn9xNuvR"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a20d12211bso7193281fa.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 00:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787900519; cv=none;
        d=google.com; s=arc-20260327;
        b=FjbQApeOxlOmqKjmBWcoB9LeHVL8jw5hR7TcRv8oHDKILdwbcgL8xjDYWfv+IbS0bo
         C5fP/7mrEkrhCw+p2GHW+u7N+tYiuJWfILOgr2Q3XgRYqZWZMdez/YiJzNRl1cEGUyjQ
         fSgkCPoKBH5U/O1NT7ycnhp2DQq9ziBicpkJXmduiadv7KgDIWGjcn9sL1PrtpcNc2IH
         mlfhYEcm/2rwJvcoiZ85czjd4UogixQe2RwnrzpXpA1hzLaE+BDqyKBITcizAJvBfb7N
         8pyID7les8fK3bdWFSj2rQxCC0GO3JZKeBqPWcmOYTpu2VGQWcj7aAv1e+YkraY21ynQ
         7WBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H4YdnU69bw2loweZcyhECkKVgGdkyMQpoAxdxOphCTE=;
        fh=PFnMk2XRuFSprhZj+E8KpJjUrZAyVtjY6DR4fvgR3OI=;
        b=R19WmAvwCSFpUt4fMr2itd4oWEOr94ebhr/fR2kDVTKK2GyGTVs1AGDC1KUjGVJkjO
         fUJ7A4o4aCAxVt/fdtwxjwPtA8ZzNPQ4K5PMcXu/7fgphpLpu8MRUee4nV6gXWA/fw7r
         qa68BlkFUlvKJrRYukJ0K6GHS7lhiX3NFoIn0y2sO215pTWk5Zl0CCZpyS/ZBSWbVzJI
         WlbgHZnV7YRtnGjS8Ce6XBMlX8vqfp3fmgIkbcXzL0XHgQZMbVQYGbn2C5uAeVrkI49q
         2bo0AIccwVBzMp7cEy0cojy98RLpXeWg8O3DsDeUfg5HMUB1oIcgLxMLiYEYnXaAIRbM
         nlSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787900519; x=1788505319; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4YdnU69bw2loweZcyhECkKVgGdkyMQpoAxdxOphCTE=;
        b=Gn9xNuvRxtRTpKHKpxXJTDHjvMhBlWvtemhqnqf+pNCkWzHReockOnLz89X/aMZMNB
         b0T9mcl8KTBDtX3wRQo9V7jauZUj9eJnei+uTby40CK61tqSqlMLLXpA8sTwgHmsUkL4
         wd64VqvNKeKvexLyvHDVj32uNkcH+Z3zW1WDrbk2qNGuUcYEKs1EZKvq8eyQmRRo01Dm
         eHOtYQQnfZomgt73Rrs0yl9Imhz95QRU/6jXqMmJG39yf8XOdoKO5OcVznsKjaYB08mP
         iJDNSQHwTEImS+wUQAmh+6NeL5Gs0h6/buMLxjkmr4XPfcLZjvlg9c7MqSUh4SFNR2PU
         WzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787900519; x=1788505319;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H4YdnU69bw2loweZcyhECkKVgGdkyMQpoAxdxOphCTE=;
        b=RGdBzfIvTJufDzvEltSfm81J0EQmB3jbBorP2z/lmijNVHH/xe/0BqEg0bBhEpswdo
         AwiNyURPxcrYaU+CSPGuD4TyBj94zLo9x5eZ1nJGDVUYtZxHhmgo2SIuPoSJMKadr+/x
         fbJ2eJFyVkMLpA3dReTkch/4Pv5X4sXxNUAdoKMogOBcyoC7PiJGcWb3A8wukC0T6Pnq
         Es9I/tM0WLkNoqCzFu3aHgZxhShKVF8wpN1daptQRHWSSTYyudnd6Nb7PwZ4deCSxEai
         f8IyoRiszn/i40ZbjCrNObF/tav3+aSz1J3bNmWLsKGHHtn62WzgVos3rG9HW1mRJzzP
         zuBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpIg93eJBUS2osCnyc8gAfIJAK6gatoQ2GD8rQLZ11RRaMzCwHNs1Mm3HNenUr/Vul5/400iQN/bw=@vger.kernel.org
X-Gm-Message-State: AFuF++lLtL6Ti9MDPYQ/sgdx34YSuO4v2gwbCdTwuoXXYP5ei/jKD6qN
	3U8whnJQLfGaAL2T/pr9cQ5f4qd4dgg4JaabUGBcUUEKWuDF8z/sAWeBIP42Hjm+fhtYvayzRoV
	8peDK1KGqk7RY3xlLMm+L5dHL4FcedQA=
X-Gm-Gg: AR+sD10zYZq1DND2/YGALsEF+r6ABzQl88DQodrFSwtMhRBpDAfKJ95lIiFhftIQlvw
	a+hXm8nDX1j8HWQo1mBR5yz5N56bqLdWVjpNw5VhOCul69wFWDLBoiQ+YN2jn0ImDvsW3ZUmcWR
	4K8yPQXFMLoPacuFTu4OUnElPRL16WLadHfk+huP90vIB4dBgYDmF3CfejSOdvwQ1JO3csqO386
	swrWj5wDHce88dluJ+1ikhyzdTIFyRxu8BVwjx1KwAWOzZwmtBATIIyvDEpLBoNaqp5rFCMPn87
	2K4K/SaZRr2PxM+vJn1bod4rO2CtmHXy+j3cz7MeLl47hX0sRLwhTB8E6w==
X-Received: by 2002:a2e:a909:0:b0:3a3:364:f783 with SMTP id
 38308e7fff4ca-3a303650017mr4458281fa.11.1787900519048; Fri, 28 Aug 2026
 00:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
 <20260822062725.60519-4-muchamadcoirulanwar@gmail.com> <20260824011749.62322d99@jic23-huawei>
In-Reply-To: <20260824011749.62322d99@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Fri, 28 Aug 2026 14:01:47 +0700
X-Gm-Features: AcwNN1WZvS_vxAPD9ztThL80CtQKEFkx81WWXxaTUCllRl2U0Sxi7MBLeV2GPXs
Message-ID: <CAO26r3QMzTuGnHN3if8N82DEHdWo4TS5upEWgUz88gy54rXj8g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/3] iio: position: add Rust driver for ams AS5600
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	brucer42@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thanks.

On Mon, 24 Aug 2026 at 07:17, Jonathan Cameron <jic23@kernel.org> wrote:

> > The AS5600 stores the 12-bit raw angle big-endian across registers
> > 0x0C-0x0D. smbus_read_word_swapped() handles the byte swap: SMBus
> > always transmits the low byte first (little-endian wire), so an
> > unconditional byte swap recovers the correct value regardless of CPU
> > endianness. The long-term solution is regmap-rs where endianness is
> > configured once at the transport level.
> >
> > This driver uses INDIO_DIRECT_MODE without buffer or trigger support.
>
> I'd only talk about what you do support.  There are always many things
> that aren't in an initial driver so listing that bit doesn't provide much
> value.

Yes, I'll remove that sentence.

> >
> > Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).
>
> Generally put things like testing info in the cover letter or below
> the ---

I'll move it below the --- separator.

> The code itself looks fine to me - but as with earlier I'm looking
> for rust expert review.


I'll add an explicit review request to Danilo, Igor, and Brandon in
the v6 cover letter.

Thanks again for making time to review.

Coirul
