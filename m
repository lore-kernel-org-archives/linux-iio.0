Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A04339B34
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406059; cv=none; b=XbVuXptoMEFi0OzP+58OPYiz8+rMffaJaKBmvQzL2XNSiq50zE/6Pj3Y4Urpt7bPDhw3w0tLjESe6r6fakUbIIVXK3t5ZEIvrKRXyWe+vaXbmafiaYpRmWyC1OrqApM24gpeKrbA2LlnET7Xg+v+yNDHDeS/XwyI059crJDxZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406059; c=relaxed/simple;
	bh=K1fkG5xJAYeAu2Jz3+lOBCdudWVHy6/ylSrbbO0iXBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=swWKhF/K+fzx8o4MxozCzp+h260UykPB7twr9JCnIXnBcDen7fHdfGfW1lIUiXv7WVRj+FGdkM8ZMyzuUp0gW9hopUdr0FUXmMLMISIjPq/+GOGhsfl68tbk/koBIYRGC1JXAdnMW/ndgu3VaIh4sPpHSsu/8AZQvXnB+r39YCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOMf9NuY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOMf9NuY"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3869837f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406055; x=1772010855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K1fkG5xJAYeAu2Jz3+lOBCdudWVHy6/ylSrbbO0iXBs=;
        b=kOMf9NuYg5Ir/TEv8MD93LQO4gNblmeWdXEUI7bQgf9+dHUekb/CowPyny8OrhHoEq
         YUT6DiFjA5hO/kP9cEyvcW7qkr6syjqjLWcn98o8BJRST3F1iKReWErTJYNrrV5yqy9O
         9p9p27Gf8n/AACGoKR37elouiLumTEnXXP+Bz69vj9Ux9J7W/J7kE+yyLbwTdYX8LKQR
         e43xvN2I9dWXjaSmhgbbcK1+XSOvpXXKtsWduPsiMySDKOeEpSD9671v+f4g9Zi93I6R
         p2LiAsHopHxSKZzKmkk4GZ6ECsnC5533t4ieI8XTFh2Kg4asYMipYltFQhmg2ubZbyZY
         p+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406055; x=1772010855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1fkG5xJAYeAu2Jz3+lOBCdudWVHy6/ylSrbbO0iXBs=;
        b=mnQRV0IC0RqDVzrgysVqMPXTi1szsiqeeDt65LcUDadDoVKGNUnZxGcJJv6+4hun/I
         QihuyZIv/pxibtkgBS1DU9BgQVMgjoUeX6Wji94y4wQ+ptD8oPg0NPd4j2KO02dJztd8
         9HO84KVCUfXrWE4T+S3QKLHOMNObrAJBncbN5SDokSIsT3jU9iNohrrGi5HG7Q51pSTb
         C/j2lajLPvLd4p3F21AxMlEvUZ8LCkVw9HTYEkpXa4OotxA9moEfmpbDZ37CJnvzBw6V
         +o4d0zdRflUwNYZwayggndzn5jHFM+NKQiszysSY9/ZCcT9C4/et1CrmppRIWgOhfZXT
         3C/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo9nlU0gHgoOtxdIGw3M1FUWAmlmkxhWCiy8mbz7W43kEmG8ADEmGr4JHTfUo6o88/H+c51QywnvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdAwbStoI6bt0rFcFkUvMDvsGAvalgu6m+Uq154Z85GIxafmu
	wntaPagWReHFeizY3pFWgtQ++uqq2g8zpmR+k4BEe38qFp+/qMDM8aRc
X-Gm-Gg: AZuq6aIJOTfrfREqbqvO12UPUxxr5O6V0I4nvRHAtx4qUbXo7jIheZa8n4ASdvs6UO9
	gEiSHgFNTnM7OXbQJviVktokF6JNcF+bjwkdoaa68icTcC6L7wWfMiR8vDt+QsAsiyN4MQhqfOt
	ZiPTGV68KrHkEfm6g08bvM4mbMsYGQ3Yv60UoxmlCneLj/4GywLGz5mCMv+XoCKLMt29kJ3qAY3
	iVDO54r+Z7y0PM9JYwWhSpziBwWH+SpZpDZLVJ3RReAarQXoPd6vxBZaDCV7+XsgLm461pAf/FN
	6UedtcG2FTwQCsFv1G7uoT7P7E47bw26jZ3HSnErnLRjqsA92H+qFzC5+vmo09xMaDFFVPHX+Cr
	RdFwuCeeGzGkHUCTFeC2CpzKrFAi1Ew/MjGGzJ81W/U2cW1CeFfkLqp3Zlruv7jHldhrBUs+wYT
	rI+yNlR/ELaQRxT+2aZWdZCajz8ElG0IQ=
X-Received: by 2002:a5d:64e7:0:b0:437:8f98:8c91 with SMTP id ffacd0b85a97d-4379db34172mr23918370f8f.3.1771406054907;
        Wed, 18 Feb 2026 01:14:14 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad009bsm39228886f8f.39.2026.02.18.01.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:14:14 -0800 (PST)
Message-ID: <f8292da100b987808c943821b48690002345724a.camel@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: use put_device() in
 viio_trigger_alloc() error path
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Feb 2026 09:14:57 +0000
In-Reply-To: <aZSEVpQBgHlRHbeW@smile.fi.intel.com>
References: <20260215222348.186806-1-salah.triki@gmail.com>
	 <aZLNX6Ifw68k-zu5@smile.fi.intel.com> <aZLZN6sD9H9dF8Np@pc>
	 <96b05a514d229b23ea0917447607dd7390ec0e2e.camel@gmail.com>
	 <aZSEVpQBgHlRHbeW@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 17:08 +0200, Andy Shevchenko wrote:
> On Tue, Feb 17, 2026 at 01:51:08PM +0000, Nuno S=C3=A1 wrote:
> > On Mon, 2026-02-16 at 09:45 +0100, Salah Triki wrote:
> > >=20
> > > You are absolutely right. My previous version (v3) was logically flaw=
ed as
> > > it could trigger the release callback before the necessary fields wer=
e
> > > initialized, leading to an unsafe irq_free_descs() call.
> > >=20
> > > Since I don't have the physical hardware to perform runtime injection
> > > tests,I relied on manual code path analysis and clearly failed to acc=
ount
> > > for the side effects of put_device().
> > >=20
> > > I'm sending a v4 which takes the safer approach: moving
> > > device_initialize() after all potential failure points. This way, we =
can
> > > safely use kfree() and irq_free_descs() in the error path without
> > > involving the device lifecycle prematurely.
> > >=20
> > > Thank you for the catch.
> >=20
> > Please just use the same approach Andy did for iio_device_alloc(). I po=
sted
> > links (in one of your versions) to that and for the discussion we alrea=
dy had
> > on this same function some time ago.
>=20
> I believe this is the approach mentioned above, id est move device_initia=
lize()
> further in the code. But I might misread something...

Me too. But if that was the case, I would not expect any put_device() call.=
 Ah, but I just read
Salah's reply. It will be done in v4.

- Nuno S=C3=A1
