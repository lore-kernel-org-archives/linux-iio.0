Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674800;
	b=J4MmTuf4l0hKEGmkWRpUjbDYyUnzIt2B/u/pkJSIL3IqNB+fwLoJaQiCcpFgS4Sg4gkG
	 4j7O95P80xO6GL3ra7daM8Ssv4XmSSoMqkHFCCLYlvSZpiVXZz8hfnwFYtG5T+FxF/Ckc
	 1fXLI6tM4aVTPNupQg96K0Kx2rLwavaL2BQV1d1wEh79ICzEECNaRneEfHitmwxEWWPof
	 rDr5QSubMykTcq3+cFiFhU7qHekKfq6iUWIWnTccHcoAGTfHSBACj6nBGHXQkX/UM4MSx
	 6bKDY7Cbf/KVZqnm2MqDq+gCh9hNOoGscpjdjNvbz03lFTPRqthahLv93yH3voHdwSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ETqG1il4N8mKp1ES7UIxjJSG7R/8D8mHYo98MJ4c86E=;
	b=mz5fTxB3OCQLn34r/w42AfUoICKBlq67oSK6TIBo5WsJY92ISWX6DgXc+Dye11du4N4N
	 fFeKH6dzr3Wb+0XW3H1ls+4fn+NBmS5+EsxLtFE4KLZsrbm0rlsnlku9ygYdrWTnclj8d
	 s+2kwpUN8vg1LLJp9R7wkK8FvKY8V+SkebjduNOjx9FXMjfm+Vq4xMYbMrGW/usJ4YaeD
	 w29kyda3D1Q/X6RxHvQghUjmOWOFyhFPM5/rR4FDqTEc5sjwFDbhI1fGxclJXelShtNqU
	 swwYAvOyubmCvKG4zl8YTAZyArL5tXEXmPbdrN8qQ84n8HgKYa7I90MNX9DpTjNWGEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaMBHAtc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11FA606A330
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 02:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A11FA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaMBHAtc
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so2825901fa.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 18:59:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793674798; cv=none;
        d=google.com; s=arc-20260327;
        b=Lq40BkDJRFUy1Ui08G7Xwtau1l6qHbR7uVKDUSPB13QEku9gUWZyZuIYy14Rk9eepV
         vmLPggmteF7A9q5o4x+8LqsBizESlNazsF9N28ILAZ/oJnq4pSULXnD0VmkM9w2CUKB0
         GsOx9MaAvLAjogu+mZh/gHl8U6IMR/7TH8g6zIf0Inbrr3Tb2304+NaSBdSnoHYFclph
         qJMFsufo3piDJIlXDOTgW6Zvqb96a42TfcpeDSOpy4p7BWflqvuOBCahqwOnYWjU+OKJ
         ojBqZb4zq1D0pa1VwZGtwM8wQQHL41NhM7beVNi6Mj6obq1akgQM63ygomrxWW6p/iDD
         lCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ETqG1il4N8mKp1ES7UIxjJSG7R/8D8mHYo98MJ4c86E=;
        fh=BhUHbmiC+/gZPWzj3fZxuRktlXZ9+ZnBPCf752oc7SU=;
        b=NPnTgcrntEeMcD+gFb+dw4GyC2nYhgP6aITqmuLG867jurAuh0xRo2Pvff6Us2u44o
         vOfTPEPNRZgbZJJ7SzGjGOvzZw8jw0gnMpwZ5LcEEAjX4TQ6BZpl/8GwfY6ZTWnJas6k
         nKMUc0WoWKlTkkwtnkMtO4Fe7K8jKjNlfMxaSzyIRuqzAj37be/q3z58RKySZmzXeDeI
         dfu87dbx3h8Ryl3/2Fken0eQEonBLXRnqCAaV+kbcsjhff5LKZAjd+9O6iuKuwYf5K9S
         g3rsnYKcaYI+Jo4IQjkVcd0QYXzWi5ZAr19y/H5xKMM0Oz6cfxbYRc7huCl5YDyBGh5c
         I8gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674798; x=1794279598; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ETqG1il4N8mKp1ES7UIxjJSG7R/8D8mHYo98MJ4c86E=;
        b=xaMBHAtcgObBuntoHugcBxOLoUrHT2YIGTntbFYY02LjeRx696VZdOCXQJc7RUlHGQ
         WicxPxCoIQt8eO2DyQwNKvexJveUUxNzN6gasKaLm0EtSkMWigSBdxDhZUKv6XcpUM5K
         Y93t+DNvYnLqzloo9M7jUJebky4EjyYaJXhv4OqDnNG4iEfmOQ0kRn0vjbFyiyMltRf+
         6qOEG63pEBR/Z1FVPqHbDteIytOeTLXaVm2Dy2gKHGjA04yf624+iCE8iz2WPzamhE48
         SqDztXrglog9gIw7p1baheGW9fXAcHTAnldQ73PMfzY7n+MUh/AOI6KnmoZrsqXryyWX
         PYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674798; x=1794279598;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ETqG1il4N8mKp1ES7UIxjJSG7R/8D8mHYo98MJ4c86E=;
        b=kyfuNM3EGYzp/MSWVoAVJKG4BXcY3tBQjkhgglbhE3IkfEtOx6LiNw2muaA0TWnLpr
         5eNsaqC7tT89dgSdtELpe0LqvzyyDIuduXxLzm7Ad0ocwntH983c7nGTFXJatc4dkOnc
         uk0ac+UepjNOTQfv24hOCMnD9h0B4ZuxD33X1w9JMZIZMQucy7Ai37mydsamuHQlN3Bl
         zMSb7VsTqc5zOxQGaJxHza2tFMDFcuSbbzuZHh6aCmLUU1bkN8c+z+BkTMHeXE+V1R51
         engtCkoeLf6g+FAujBgFzV2NfotLvoPQEKBOdiacKoAFUMNs7X4ZoH6X5OnCQrgw3uCk
         e9Dw==
X-Forwarded-Encrypted: i=1; AKwUvBzBQm37nbh9kMSA4kD2j4Om52xTYEqtjcisBgKMd1XE18IY52UE53RnB7d90OLGhT0GtqrlgoRtBfg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8tntaIIaqWYgZQqTSbcAMWq3RQ28eD3s2YEJ5wAUSWPLcUeT0
	gFpXh7eBvrO06ysEziZb+qR1mVzHLFTt5mh4RR2B2wz5wJHGnf1LAsP61v5Ccm7i3tp77Qo85TF
	GSi4vJKggKn4oo3Z7y8id6cteH6tqVOg=
X-Gm-Gg: AYBFou2kQGZD2gmn0ueeboQPF6/1pUqUfcq8ojf1t/GI+Hzw/ekimEBICS3AsHlIsl9
	6DPqFqjLerRmRf/bFEE6Q3FxrlHqFSGzQ9pee01z0J3regXO2htIVLeMYGjO6NFO6ta13G92U4G
	sw1Ei20o2w0uslt+p3ltIAUpezlU0R9F8hJCmvpUnAe+HhdF6dg96u+SS/iKigpH0eZvgFlkzL5
	bin3Z7MZ1aSIE9Ale+fpEyMiOfcITPFrwhPzEmOkvkMYxV80yS7LerijFsUZ7K5KemNzjkC1Sq2
	7m4fOI6XSVrEzlFX8v/apckXGqfaQczJkya/UJWJdIgC37NhkZm3wjt6pdga8IqcM98Ab56k0ek
	kMup4TtADT55vEmwWhishJKzIl0u766GPMBwxXgU=
X-Received: by 2002:a05:651c:890:b0:3ac:4f4c:8da2 with SMTP id
 38308e7fff4ca-3aca5812ademr34312701fa.17.1793674797546; Mon, 02 Nov 2026
 18:59:57 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
 <179260197668.3127.18219777718091081046@linux.dev> <CAO26r3QK+Q5=JR5TeMzEX-WiLpgYWd8Zn0O1qx11LxTgN96BPg@mail.gmail.com>
 <179286358623.55649.5397316745104390556@linux.dev> <CAO26r3Qk3bEUwL1=MyHP6hu_YQNSN-uD_2-ceA0KtK=ejxLf2g@mail.gmail.com>
In-Reply-To: <CAO26r3Qk3bEUwL1=MyHP6hu_YQNSN-uD_2-ceA0KtK=ejxLf2g@mail.gmail.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 3 Nov 2026 09:59:46 +0700
X-Gm-Features: AclHuK89EtRkVz-OsObyYnxQUnt0Uu1dpICeA0ah4MC2QsH7LZxgTCAmcbRUiEw
Message-ID: <CAO26r3RofEz-YCnaUfTTb+7phdEzUqG5iwVObuho_EgW5Ep44Q@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
To: Igor Korotin <igor.korotin@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Mark Brown <broonie@kernel.org>, Brandon StJohn <branstj@gmail.com>, linux-iio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Igor,

I've tested your changes on an AS5600 connected to a BeagleBone Black
over I2C2. Everything works. I'll put the details in the v7 cover
letter.

One thing I forgot to ask before, the registration rework in the IIO
abstraction and the driver is your code. Are you fine with me adding

  Co-developed-by: Igor Korotin <igor.korotin@linux.dev>
  Signed-off-by: Igor Korotin <igor.korotin@linux.dev>

to patches 3 and 4 in v7? I don't want to add your Signed-off-by without
asking.

I will send v7 shortly.

Thanks,
Coirul
