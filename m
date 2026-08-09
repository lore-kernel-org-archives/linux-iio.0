Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130E1FE471
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786294832; cv=pass; b=JxeVh/49OOsaRIbtznDcfT48dPWf5MnyqRwudzDI4Dx0KFIoclstWLmpe6DEg3TFEI/IZHNE2pwXf44/4EYEy2n+Vc23776Lj3E8YPSULJySDobOuCWka9L647YONEiT02psKqWA9b5NL2YDhavCE/DO+CzY+fGqBNy2Am5NwVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786294832; c=relaxed/simple;
	bh=SxjcI0gc0zqP3JozKANQcW4xRx8frwWsSToaQ17UQMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrF6geuTwLK6bfrKwWUqVEK5bqFy2CAPHSOP34E1uHiUpWVn3I2x8dKlHB+Ls68gZD64KRamDetSaOeHAKnd6dPT0uAlo0utxJZH3deuvUbhPPUxem6xRfWmd2AHnNuZ5YNp+18J3NAGgkvpwRkMzxFrbg2p0df0IFyHEEdH+bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ini+Vuno; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ini+Vuno"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1712a04ddaso163032166b.2
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 10:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786294829; cv=none;
        d=google.com; s=arc-20260327;
        b=WyAJXBlsiNZKk96tXkqIC9cLKpoWG7ADSpbIw9jsnfZa7M16FIbs0+KDizu6AbHuV4
         NLxohBtNFeGlXigrX9VC7hVaCPa4bisE0m67YaQGQB09wQyYql4pk55W4bah9eg8vTuB
         xWrpE/GmSGG4nhPPmmr2c1Ywx15ByyVbhR0Z1I+Kk5fFfqLAbIsdhaUX/qdoT/TH5Fhq
         RL3cEwWCQgN5BHoR6Q0kM2yqkzKUIxxfMrSTW26rFng30LXCkWfnGFFaQb4rJYPxQyFs
         oIZ5bkV/PXglKiUIzjswzkyLPqXglc0HGBX8FmweTwzYJpUXQgQgajwtU4FllJ46C88W
         LTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SxjcI0gc0zqP3JozKANQcW4xRx8frwWsSToaQ17UQMo=;
        fh=uF4B8AMhB0/67KKGoI9quwogoVQJJXJxzbQIPjFuLKU=;
        b=AAvGRHaNmLUp/eULhJ29zRCU/x7k0jiUVYe4lZYd8kQB2JQxgp6K0FjDdmUR3umgDx
         HyNieGo8PYwOTiAVw9MpMySY9CyJgsaR2egaOyFuQJDujdzETiyzjpYglJQ16Veau/aV
         AeRqwWBd0ABWIL4Vs2LriSc5nO6nvZab+jisT6mKA2w2RqUCI3C6evXLXXSXjbh9egTC
         PYBnphmCHLIEa8pb1LTfKr1cH6EelrV2ZXNLjiGXxwgjXBBU91jtVPQ6vZJilgbjuY6x
         UTdAA27B1mfdi74yHBAYiVIeEwfXHzmwNJPTNzryftS454hal4zIuwnGh9J2GGhZuu+o
         MAoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786294829; x=1786899629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SxjcI0gc0zqP3JozKANQcW4xRx8frwWsSToaQ17UQMo=;
        b=ini+VunoVQzniBSBdvCLOLfzlflM5BfIASaCGzCO0d6s6/0+j4eCVpU1mnxtQz127i
         OlrcoVc2WVK0R838SVGkZI6pvnANfLvV18Mv1I7IY9FB46AXo60/IbkWN+JbHEqHdkgu
         HMwPCRFCGQQ6hSHhWhaHcyPNjyleQxD3XWJ+olYEofYd1xJK+DpGZZ9tAcAr2f4Ig6tw
         0xXLsDvet2xupI/XyLnn5EZpGvshLgn1dhC3T678TreQEjGtg33+CQoRWYarr6bXxrRa
         mNqStOTo7c35j5AAeXdB8a3vbPMIUZyFf69sSl9r+rVDIxPqCIL2j52KNqpDZgGYJCF/
         G8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786294829; x=1786899629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxjcI0gc0zqP3JozKANQcW4xRx8frwWsSToaQ17UQMo=;
        b=q84g0vK27grHJyEbU4nFYor8GCMJQufanidlABWZw9xFkKPce1182llC7N1R7Hozgo
         WOs6YaijRGRudDwbTzyxoLIGO5dT/Sjvx+F4V7UM1rOkil5O+kkw684LBUa4yf7Dz2pB
         fhiEx0fVBQZE3mQO8CATzh6husKej974LuFcs/9orvlQOiFLC5VTJbmAji1IlqMJGSDl
         z9CYtdktaQKFRyBbvCbi5FP1QCcYukAvPgI9ocUGPOyOKhE4ncSr1y8PKHeBczHqRV4x
         YzR9a/yIyzeDarEUvL2JlEagST057iiw4jsC3Oj48yYhywbFPqlfr2/+zcH8RqzibjTC
         r2sA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3vrMt1XEVh5GJUq4CantCk+P2BqSqgPHrIBtm14ZhuWrz8P5z142uEF9wJCr96yZA+Vji2jznhzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3Ny1ejwh5U6J33bVl40KTaVyBjT8PvoeEWnPC8CyboaUy7LB
	gZq+5H6HuhCvSUQvaeMhA+F0lvERkmbA6Q2PxKO73d8vYo8wfQGX9OrQWrGYZeS5tgF2ouB0hot
	cgCNgCwWdEYtBGpykHQqWcvSmPoJuQ0w=
X-Gm-Gg: AR+sD12mvZ93DlxpGAjo61AntdYU5QsMW5bVoQ/xkInrVjWu2vhrtbjcygdQMEdyYSC
	dhTVSwwWzPYDUaXyM+kALAU9LoitxX4+KTma+e8gjnToESQAbKzkvQxnifxfIl7dfPhhNFoauYQ
	cjKgWK6He9i3ZTTcBETqVqQAVNf2xS2BDkCTeASPxT+Vlq3xrUQIsl68afJVgERT5RQSu0U+obD
	dS75bh52QlD1WahC33Pf+9YiYbprDdjPZ+s8jdIKlTK8CgWItsQ4KaKdMwzoBKM5B/rgOYQrZQr
	8LnQjVQUndrCkg8/4r3kx3kKM3cqr6ya6z10kxwnQ/8B8Yx2I/tgXtfp/P9pta0sboSmPpnP0Mg
	2CjijXVslbcKvHnoL2VHfddFSWUfHtCI2hf+5DcgAilKcLY3yYMQWmQNCZ9jjUwgpig6QyrrTsx
	DS9sR5m3VjPzlP5PwFGF+w73MCZ9HXOg==
X-Received: by 2002:a17:907:944a:b0:c1f:e9d3:a3f0 with SMTP id
 a640c23a62f3a-c2039ad2363mr1638337766b.7.1786294828642; Sun, 09 Aug 2026
 10:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809111303.496393-1-yashsuthar983@gmail.com>
In-Reply-To: <20260809111303.496393-1-yashsuthar983@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 9 Aug 2026 19:59:52 +0300
X-Gm-Features: AUfX_my1lWmCwdYZsxO20UNiPndbWeNdVGBOWE2j80vYRXYsGiTxr2VjxzqbEKw
Message-ID: <CAHp75Ve+ws_MvP4_dvaps0t_8RNVtrbCFj=GR7rW+haP-KYZ8A@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bmc150: use iio_push_to_buffers_with_ts()
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 2:13=E2=80=AFPM Yash Suthar <yashsuthar983@gmail.com=
> wrote:
>
> Replace deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts() to allow source size runtime checks.
>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---
> Follow-up suggested in:
> https://lore.kernel.org/linux-iio/261dcaa5-3e9f-4da8-adb9-dae4eb7310f2@ba=
ylibre.com/

There is a tag Suggested-by. Use it.

--
With Best Regards,
Andy Shevchenko
