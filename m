Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2D3B8BD5
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293508; cv=pass; b=sx4qKXphCpAYfZRqhpC7oGFNZe6tyLHMs+9aarou/DfmuIsY1IjQRDipyzWQknMxa/qM+jzn63cAI866G02VpttxHjTct/VxKVSApin1oOk8sC69o3PipeAe+pRPrNfhu93Mw/CvutTFmUeeNPzD5ED0114HM1k0SGU3HIiY08A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293508; c=relaxed/simple;
	bh=zamNpFeA1MZ17r8CMsJit4TwZ+RjEPZDXwmFPClldsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6xk2meM0w+jNMd0SkHabn7JArq8zkD5u08nKIMlyYi27nZeBbobhRvphPtVP0R9lXDkZURwERF3Wri3d6NqqLEIkGWVXynh0EytVXPszAXno/ZeKJI5FAMJbDVtkv0z3feIdO2i225O07ho7dPSb73YfTeoFO4iBJo2klls3Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIjhupXL; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIjhupXL"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65427236e94so6769353d50.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 05:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777293506; cv=none;
        d=google.com; s=arc-20240605;
        b=I1DF2kSStv+FJHXaowAHn9U0gnNvzSRLxpLiMrUK3hXMAD4Z6Htt3uLurKRYTKCTP1
         X6bFOEhBRzMJlymQg8qNUIVX1rUGAD8WhNu3N2XH5RA0PINBSU3Q7kckZxeodAWmsYme
         ThQ6D93v4DL0FdEanLi0e7i2SFJKfArb8SnmL3wGUFQzfikvHfBVtRTR03/ZfaQJRL7/
         PbmPyas6Ij3xMyC+Ja5gtbqsLz28fUzEyANctf8TjwsXV2vdHGi+ZPr/E2PbAi49w98J
         gpR1ii3w/0VpTUB5B+aoi+uYMLss5v3ExCJnUn78XgAPqNek7VwdCXYfVmkxdx2Zf8Bx
         cvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zamNpFeA1MZ17r8CMsJit4TwZ+RjEPZDXwmFPClldsg=;
        fh=DjTijmnkrVoaCOBcdLA71q+YsfGpdeFVWUTHKepOmcg=;
        b=Xbk3T565KsTNgxneS8dxtk0V2woerxlqbd11gvnDU9UFHLe5zgHZjifMXjRbHsWJz/
         5gvJ7cynGiKwDqKGJchxpnLtl6u0vttvC7qnVadMIPEYz+PgkNPGVjMmfXMj8WO/cKdV
         zo7UfVmSnxJBSwyL9evkIeuuC83Wh/S1Du9nJpPNdXv36ViXWXxdQ5avMy3FSAO64lGj
         aPGEicrORFdq6e2WCtY7CpqF5CSxmXrOXx67ldl/FP36OP7gGlUMToVsizb6e5qS9Gxl
         C72OixKmGJIViVhbxXnQDFhJl4NxRvQ5LHoeVX07rIMGtjjpopdn1isbePXbmzrreJPC
         5GFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293506; x=1777898306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zamNpFeA1MZ17r8CMsJit4TwZ+RjEPZDXwmFPClldsg=;
        b=oIjhupXLPWiq1c/SWFcavkQXl9U+O5Ha1HkftalpEU5XE4qfvHLQvnODJ2IxbkC2lz
         ylSbETxALOEa6mC/nyv2a5oQxFYn7lHWjxOLvIt+Zc+WY9/IlCweZPg+wTwV4SHriBye
         yZ6HBno2h+XMJtvprFO/6/07PX8vzLInBQ4Uf/UbX6J6eOmmZ7bXu/QQu15DkLqoT0NB
         /7qKGuqH8a71SZQ3YuMQW9d5EFaV3TqGdcVjeyI/ytv9s/O+jWrs8gUb04r8stubppoX
         GH/pl06vQcoaYbyeafaxyZmWZU2byJ/XYyZObozXmxRzQQGKwz4pcR3R1ti8itD1ENns
         MxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293506; x=1777898306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zamNpFeA1MZ17r8CMsJit4TwZ+RjEPZDXwmFPClldsg=;
        b=BgtVthf09CJ7Ewct7wAdHu2yYuUW6i1bGXtj9TNdOwR4+deYXkShC2eVZQyEyGVAH+
         pvxZrxRUK4Z3hFD54cLPxlsyrB1RKi0As/HZPIS4JUXkIF8lbZd2RB/GPKh9i74luDyA
         Ow/vPSgSZX7/vPHuDqVDRaBWnzYnF2auETgZ9ioTUIgSFLKz7RLKTIg5hlemQGZBi4Sy
         JFZJpwEGV7mdfFmspDeFz69ehUKlO2H9anhaUH7PLhNA2g35SDcITnTtPjLKer0M9N/1
         izCirBc6A0cHTQuGOzcNBYlxqo4T+BLiCTPQFduBROtJ1dmfzHh6VOLA1ZqCHeCAcyj2
         fC7A==
X-Forwarded-Encrypted: i=1; AFNElJ8T3TxO6HGTzmqU49Mg1/RfVdkw8n7CTgrbzUksYX+L7e3SWC4LA+JhLNUP0CURJ+pd1nyKtzzYtgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1VTE0G1YTNOM98xzUC7Lc7OhLmzpvP3fCUR5ZG7Y0W4ld+TD
	7Rh/f9M9BRjbLCZgHkyH9g4WprGDQl8kAapnWD//vrkG1RLdcDyE34iqe1KflP8ECBWPOdV7EP9
	7sNdMi/nZ5lNJ65XuzeUpQLap+W1AOj8=
X-Gm-Gg: AeBDieucYP1tWr5LaW14gI61a6/iD2IrlFmdCb6i6Q4h/EtFRk6scxTrSyEgyyIzkrg
	1ZXTVW9Ap0VRh5BLNMyqrffw841NFJwdMupdBA40+NK57xtNI52c8Cdoc08w0GGaMCqCehNl4BN
	MLpTLkSw1NZDWbUqc/xpI1ORIT0uV8dNsF/+SjRc9jRxbgpUi4Wtno+tN+2L9lxN+2J5kIWQSwZ
	+hcYVKiYjnTAvsBrI3WL1HpaKmO/LIaPOpWGi+yaAZwNHzXpCSFk5wZicZ5P2b8i5hez2hlIxvV
	EarbVp5aSzdwzYo=
X-Received: by 2002:a05:690e:124a:b0:651:b13e:f9ef with SMTP id
 956f58d0204a3-65310803d3fmr38518177d50.14.1777293505766; Mon, 27 Apr 2026
 05:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426205039.125818-1-m32285159@gmail.com> <ae8b6wdyNR-G-i1m@stanley.mountain>
 <20260427110215.1d3eb495@jic23-huawei>
In-Reply-To: <20260427110215.1d3eb495@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 27 Apr 2026 07:38:14 -0500
X-Gm-Features: AVHnY4JH8ViBvHUm4gauKJie9Jw5lHzogx117wNnCK5_l03aEMkAwKbZrOFS4eU
Message-ID: <CAKqfh0Hk3fAysVR_g43F6it9xaeTBwk7VoG9BDVH_h5HNAJ85Q@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: Add error handling to adt7316_spi_probe()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dan Carpenter <error27@gmail.com>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

On Mon, Apr 27, 2026 at 5:02=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> We do normally check spi and i2c writes.

Knew that, I was looking for unchecked probing and writing in this
area and came across this.

> Anyhow as far as I'm concerned adding checks to normal calls is
> fine, but not to things around reset, mode switches or power
> management unless you can test them.

Sorry, I didn't realize this area was *very* special. Obviously I do
now, but anyways, I'm going to drop this patch and focus on some other
things.

best regards,
maxwell
