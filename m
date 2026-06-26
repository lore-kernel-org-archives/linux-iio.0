Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30733EFFAE
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483235; cv=pass; b=cU8QgE67nXiZpFWaT00yOgC8HhIJj4/ZynCqh578vejh6M9GvxaDVJmwPXsRMUs8YUO5wIbvRtyDEu6/yZP4LOAE6ig04mpo/uRig+grXFLyQxtVlb1vV0ieS7WgJ6mK5oQWr0Ivy3RLA18aI1hNNuOLVan6zhti3xWdXTiNcMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483235; c=relaxed/simple;
	bh=f4swRmSPcax2LTXfUl3bZ+7ZWOARiWsbDI/D43/QRo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsDjZy2KKsJP+uYjelCAPWr69zSB5l/DN/1UBb68kLQOjZFa51yo8g6rYUwLC3lspgYqy4NgjdJfwCFS7x1ovUL4p/lG7mclQhhmJNwrC7yh5C5a0wqderhO7xnp4CxuwG6btluHyuYHn7q3Gi2CbYai0YlgUO659lO/9io4vKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCAnJcvX; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCAnJcvX"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c122adf1cfbso77832466b.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 07:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782483232; cv=none;
        d=google.com; s=arc-20260327;
        b=qB157L/81bSnB7Ubuk/PjhdfaWM0bzx41OJvvAPzHuIwOLMzLcYz/Ni1gNOAs8f0QL
         ooxkedWOTo/Sx0JCBat9NbgHphNCBc5Mj2suydGCy9pG4ERv4it8URXust7lKK2oZSYc
         61X3WO91e/B/3yk5Ked/Wa6clu8kTBJ7znNdvC3NXxibzSkYW/sHEirj+fSBw5gaDXe5
         beZY6G9USrO1YuSNMDPp4dJ83lgYI0eOCMRgSaB7+qRtrBdiPGWQeUnHhV2y9aJq7OWJ
         m95zZStRrvWu6+T0qk+YjX3BSow3r9c6coY7CYUKGmf5Ngo1pCYnui/45Ho9O1izTBzG
         /Ang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4swRmSPcax2LTXfUl3bZ+7ZWOARiWsbDI/D43/QRo0=;
        fh=KAW1sXl8lK/PjBqJaV3ijvmccSt/usC4TG93S822LD8=;
        b=GsdHwWUKy5i9mMlhPY9T/zRHOSSFlBtRrzo8Tr5MGAEqK3mMKCO9xFE2nv6HflS/8y
         HaH4fgh9KuBeoeTCS44LFLtjSNzpM78tx6GRBcBWRB0b4mxAXVBh5o07pdSleVsOaUh5
         r3bxjZMmfvQuCjZUme9LjnXDvdjnXA0CJO+85gVKwg3zo6RIj33yO35GibdIs2ZCS79p
         +InnL9AdkPcspNmWucRTwwdFzlv5uxgnQ0hBT83+qDbNpTf3kO+9PnQLvd0D+B9joCcz
         24NZljIszhx57g2HS4sYyH81bgMI1h4YCOK8IOg7Jv2u6bCdi2aiP/LvI6mNhn/oo1H9
         vpQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782483232; x=1783088032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4swRmSPcax2LTXfUl3bZ+7ZWOARiWsbDI/D43/QRo0=;
        b=PCAnJcvX065q1wDe8Yp300e27kVLtniHuihRcxy1diI0Hrn6o938OjJbj7XafJUMhF
         K1C4kdYkFVKosHWuziaOy25dfZgUqXoR5Marp7pudvkVgjZyRljXCrEbaDIPsUzG+nFK
         ogMwsPxbyr71uVXyfpmpRrg2mqjfo2k5nlaF9AdFRONzmHWRuZKHUXgT+PmEh2ZWp3o8
         UF3xQIrPzRoSBjVJfcD0rwFmu/xxGww/hCsXwHGCzhQXFdXcQvCCyX+0r6liazENQREk
         /xYnWKq+Or/+72VuubvnCtHvDaxyx7MKDBT25HqRxWdCRlgwQ7kYHdfB6xO40dgKCvbr
         Orvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782483232; x=1783088032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4swRmSPcax2LTXfUl3bZ+7ZWOARiWsbDI/D43/QRo0=;
        b=NgaDOyQG97Mwmzap1PRjDsXIcckizSo5mO5vZk9EgYj90mwYnE8oQFFwdXensulVwG
         UX7DYOW0yfo+d3bw7YgF6Q2JCLLraBWphkZGmnxwq1m/yMosACbLd5lqPknjNzCMMnGF
         YkmRk5T0RlIdRAFPPJSkwnhIAp0bWlapjqz6WCA8Ptv93TRMU0N5bZk1BCpvs296nHKY
         21mwpG4uCu+VsKLA95G/K6Y38smx1Go4pYtFwIb3ADQ+O5KhEWuAM5Wzbqoy+MqHx96z
         72E+SXC+OyLdFYcvq9Q/ITJWS2bghFNfHJdEgfmR2J3IOUJlm/jrzRiE3bwBTZZTwVFo
         Cm/Q==
X-Forwarded-Encrypted: i=1; AHgh+RpB4Y8hHRIEZwzmJwWbBg3iwOjDSBxw2FPeOrTl7UQnvzBCSGCoaC4gqCOMxtrui2+4Iz+xkSxvUuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCMuyeb3E47fF7btGXiPJAcDaXkj8Go8ppT2ZRovjBVGCqt3V
	3/oaAuRtj6Ig2rPbr25UpY4GFeMq+dhFFK7N+txYalaNH8YP8x/8/Hr6tshYJi/Ni22f+ls+wee
	1HplsOswS6wldH7kNudIpa/gvZ/E3vBY=
X-Gm-Gg: AfdE7ck5Jrb2FsMGiXCpJOqfX4uW8nUsTvgqOhaRzGbYjkQNidagY05EVOgRsNlvJ1M
	lCferZ7Sej/dhCX7oCHL0e9qrpiojJ9yrmfYUd/yw3QNWX/FjcR6tehkaMB6WPP5f+F1wJFcJcT
	ZEFb31CE+6ukmqA2lfhBtxIOjlc6+sdS+bDIKKxEtz51jYcM+2J8vTl2GQUtxdrjYmDfPD5584H
	LPKqKuSULEHSDJXoTwaXe8pb4GUBzL6Xx/Ar6NGtldQY1wMHV+cytw8mcCOjj4WWheLp1DxAuKz
	xIaH6W4IuJz+AeqZzj8D9T84w/lbWjKtA0lOcrN+f/8SByPeViNW9C7JzXQjc9Ia1cYeDkHzmEp
	BSOj9hJbpgf6IQdcQAtEZfG8vTUKrlF77va9HbjYv0puYywkA1AtSkbWJ1g==
X-Received: by 2002:a17:906:c141:b0:c12:3219:ba2b with SMTP id
 a640c23a62f3a-c1233484815mr58141266b.12.1782483231883; Fri, 26 Jun 2026
 07:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
 <aj5v3rDRlY7H39Tq@ashevche-desk.local> <aj6EhyuOxBqDDf0X@nsa>
In-Reply-To: <aj6EhyuOxBqDDf0X@nsa>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 26 Jun 2026 17:13:15 +0300
X-Gm-Features: AVVi8Cfh5bd1NwE-0xp141JpHITmck0suCBduOlqNG4ySqfu-vvSjJ81KX6ccz8
Message-ID: <CAHp75Vc-DXE-fvGSyyEzbhs_f_bTw0UT0T9JmBsXsGYD7xOK2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Joshua Crofts <joshua.crofts1@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, David Heidelberg <david@ixit.cz>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 4:56=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
> On Fri, Jun 26, 2026 at 03:26:06PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 25, 2026 at 09:38:07PM +0200, Joshua Crofts wrote:

...

> > Now all is better. The only thing is missing is Cc: stable@ line.
>
> I'm not sure we have a defined policy for that in IIO. Now that you
> mention it, maybe time to ask...
>
> My understanding always was that Jonathan takes care of Ccing stable
> but maybe he just does it and being nice about it, does not complain :).

This is the stable Linux kernel policy, it's superior to subsystem ones.

> So, Jonathan,
>
> Should the sender take care about Cc or not? Or it does not really matter
> :)?


--=20
With Best Regards,
Andy Shevchenko
