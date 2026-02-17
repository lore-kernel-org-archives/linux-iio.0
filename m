Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D302DF6E9
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334907; cv=none; b=URFidMlYuu/2OxqXgMPh1Wygn6w6blBY4J0ODxwIjS7y6JQfhX2t/g4Br0HWD2tbUYeMI6JWCOqjDGom6udAdgGk/AiEB/+lUzySh+UG/eAw3tON4+qRmPC96dAX2Pvmmi/+Pu7vqidmNYVHMRPk/oVSC0rr8LkR6bDm8Um5D10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334907; c=relaxed/simple;
	bh=cFF52qz0PD8aczZoib1i23aZ9w/Zx2t4N+NgXu2ufjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrAMrha9me3mkmD12vwnvrPRQhfcx0OKia69olQXdr3FlVciYSQ72ZKjxrq5ch4HqnB65Lmrmul7vTzW2hozKvsCHY9wUaVnxa11JYjfS4Tj3vWlXpBuVMQm1SoS25kSSZHWr/3FIJyfmgYDZLKwjTm6JLZCyPYMv3mlkfNWGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqqNDseO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqqNDseO"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43626796202so3890443f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771334905; x=1771939705; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aOWNrVRUU5sVLN+DLhuo4oI/n0WRUiVr3FUn821tZYo=;
        b=EqqNDseOQRY/8PIsZ2uk9PE3Jp0ec5+fckOJ/kwiuJSwstzO8+adW3HBv36ZFCwUaL
         Wxw0QrFUGvhU2yojXFlVpmXoDr6WLoaLdOcd391AfVBhYGufepZHD6DNhxW07daA0f+p
         G8qYV+u91AvQMBGaRjcejeGqY90ITUFv7mRO5tLReGy/PsUcDGTkH6/KiMALtZe6Ch8J
         d9b7MsTGea09eawJX8WdDDth9cD9d/ZuLrZtHZLvCOSTtFZhfW9az6Sg6BtAr/nVY1iR
         d3UU4TJ0qk3YseKVk15ySt7bmuqsP0xEhZ4AWzQ0Ej+JAJyybFtn0AqnTbFqgGzYGOuS
         qqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334905; x=1771939705;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOWNrVRUU5sVLN+DLhuo4oI/n0WRUiVr3FUn821tZYo=;
        b=dtVVEyb+7A0FjIOBCekGIJmb4KS4V7lvEUCu1jgk3zffc3m2kifqPN2ByIj7E+7sFk
         DKWzickhynP0K9Z5LN60l0WiCojGrrOeyqobCTUDQFDMZlEhyM/PlEPZxAz3NkYBBxZQ
         kacrnWW0fK4ZpLusA6EEyN0UgvckAJPRAv3cxPqPVskY+uYRT8qHUKVEznwMaU9M493a
         /zCujCkNOmOXR0BaYqClwi009Ei0zor8owV9gxJIVW+jQyD/5mpPwcff2t1TufgBs77N
         88r0ZBd3BszmeNT39vj/ptRtg0+H8jRX4sZjYQZ10ZYFm6t7hgC2JITdtAs6uDzXnqrI
         QnBQ==
X-Gm-Message-State: AOJu0YyJxDnz+yclaEtelH86mcSzFsokYpx5Nm4idsFzVMRlNiwSc7//
	cG3oc9AGAJefCHmczBbbGV3/iF70ak2Wto8Xe+KrE61JVjo6n0sh1b2a
X-Gm-Gg: AZuq6aK3csho5LTGN81ax5w9I7/1RyP3xDFPOnx204EWCRaTpXSUoEOX/aD0gw5YEbG
	PfysY12Qj9b56eheRsWZHG+9IrI4NX5rxfBR5CXCGR7bliDcZGp/MZpyBQD7+3o+25NskW0Saun
	eS5UuiBvukxWJyGe0HJsGO4cNs9Gv5Eq55CTSLWQYE1PAYvKAcVFaj6Z4OpsR7vZuvckBnQOkd9
	955gJHhJ928B6A01yikc7wN1anJ7SmXLNOZjIrbM3EqEV5wpx3t+sTftGwVWXEjdOOVeruG8NGM
	kI2b2pL9zCHPyjnYaSXaQKxzO70WTZJJ4EClxk6CQKmvFfjrTYha71Wjy92UXuapz6hQE4IF7J3
	DGU7fvct1Fvx/KASGlwdcHhX7jvy6BQ7dfBINuhLtAfWyc9WbGSKcsIhDJEwqmZeUkuCWsSPh17
	OEbj53AWldXlZz0rVR5Vqr6RYtj/OlWvoWM6DCVV0w5g==
X-Received: by 2002:a05:6000:2283:b0:435:e451:39d4 with SMTP id ffacd0b85a97d-4379792bf73mr26224243f8f.44.1771334904551;
        Tue, 17 Feb 2026 05:28:24 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad009bsm33511634f8f.39.2026.02.17.05.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:28:24 -0800 (PST)
Message-ID: <c27fd07403ed790902bc9ef5a863beeb7b7429be.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Date: Tue, 17 Feb 2026 13:29:07 +0000
In-Reply-To: <aZQcpJV2GQ8vWnA_@smile.fi.intel.com>
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
	 <525a30ed9127b689549bfaedc086638e2e3b5670.camel@gmail.com>
	 <aZQcpJV2GQ8vWnA_@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 09:45 +0200, Andy Shevchenko wrote:
> On Mon, Feb 16, 2026 at 02:31:57PM +0000, Nuno S=C3=A1 wrote:
> > On Mon, 2026-02-16 at 09:14 +0100, Andy Shevchenko wrote:
> > > Use devm_add_action_or_reset() instead of devres_alloc() and
> > > devres_add(), which works the same. This will simplify the
> > > code. There is no functional changes.
>=20
> > LGTM. Just one minor "complain". Anyways:
>=20
> My answer below.
>=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Thanks!
>=20
> ...
>=20
> > > -	if (!buffer)
> > > -		return -ENOMEM;
> > > +	if (IS_ERR(buffer))
> > > +		return PTR_ERR(buffer);
> >=20
> > Subtle change that could have been mentioned in the commit message.
>=20
> Actually not really a change. Currently the error code is shadowed to -EN=
OMEM,

Well before that was explicit. Now it also depends on the internals of  __d=
evm_add_action().
That is why I said it was subtle. But yes, no functional change.

- Nuno S=C3=A1
>=20
