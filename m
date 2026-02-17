Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73092E22B5
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318987; cv=none; b=falu+ZOwBzuLHIV8rHBnEFNb+CA/Jd+Ojc5rjXiSAWg+W7adxgKLUTZ6QAWJp3X10kjzwR+ukErPuGLyl3+e2Ia84puZIHTtdZj7lJkdVCSCuv0w0AvOm3TPWtMg6wAOHQh78/6bUSFUjK01NrUyG4u/0snHtefVn3jAJEZsSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318987; c=relaxed/simple;
	bh=MfcsSgPWRchgu0Fe44oDchYog/AV4PJhKU9vvH05Npw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QCWoaaYRB8oFQrQLu/0ijxtmFUzTpmCpa5D9PAm4MbDIp9NRslUgH8ZY4970S775i9v/ZHZZlEgumgiGImpCtHGrWN00XfiduQtj67p/xirIIUZdYslAQy+gbQSpcZM3qgd25XjyHsJAvxRqW8rlNFMPie18fZ17K0mixTnlNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npAik1nH; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npAik1nH"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649db2b6cdcso3629918d50.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 01:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771318986; x=1771923786; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjF0dk5KMmp/3IOMF9v7+zo8gHgtNcDNHXPYWCCd6nc=;
        b=npAik1nHmcm7p4YjCGnCVsYqbGqzRL+OwGL9KVgLsByJWvAlw56TdLXl/hVFV5FFzG
         tiU0gC5d4koOzupp6QSulLyGgNl/pu7VJSRXV5flYHTe0iIDi9yoYqveNF5qjOmPr4IH
         Ist66XOqFec4CXdBacZx5RrB4eckVYx6ec+sAVoOdjXToK/6bypaJoFKstvi6f/MIy9h
         qxPLGgYw1ZE94yhdtRkn2RR1Pmjy1ckMnz8MZ9Lw6ktHfmuhc5qklDmGaX5EavbwkAOs
         1t80jikO2hoingKPOm7g2IFLGIU/6CbxsJZ2yK6a7yXrQHTqgu2aeo6JUW8E2KTNfI1G
         GcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771318986; x=1771923786;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjF0dk5KMmp/3IOMF9v7+zo8gHgtNcDNHXPYWCCd6nc=;
        b=vL7iydfobIe4ZxRMjIHMLN09hQ1zETsks8w7OQ0ypJXWc6k02qJqx+MiA1CerYFRI1
         Vqm8+jvUgSUoF/gR6M7sRGBtUhHWinotMB7kNFvjL4matJXUQimC0BGro93b6bIMFQm6
         BtbkW3BMq5XzAebunnalOLA/GN+/nTAZVOAdBmhPKSCTMyDMXxalJ8Yubeyarau4Ld/J
         rYRotg4CKziqlRp0MUkXHRtitc7Jd9oHTqwvO4gtV+uH+lZBgVlO1cW7HINVizvfBnMP
         4QH7pJD0QdVXz0x2jrg+PbkFXc+hUjqrHzwSlNR26KFOKe0X1AkISmdiP+IVk3CAinYZ
         j8tw==
X-Forwarded-Encrypted: i=1; AJvYcCV9XlXOlMeMpy4uxGHD9H3m5RBRphiqiSBYUvHa7Or2ivm493SIDyENxUIv7zFMlU1Tug9D1CheNQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIK/EUt+6oKpveXc2gDsStJJGEmviqnlG8RHOYnwflVkH7E4x
	uqEdqphCUhWJ//mFYr5hzND98cR7WXlRdYmrPyaMOTBdrAvVJ6r/eIHL8ffA0EXICLM=
X-Gm-Gg: AZuq6aJdMAZxUgooCmeaa897Wr6PrAR0bt1iL8NwqB/PFi/9adPvqaTImvKoYxHslDa
	Mke3lpRUi/4knfOH7cL5fM0pVMkQ9JhIjOzvUSF25Tfi6DqPpCTKHA1R1ObnPhUfraMSnK7qVUZ
	pmk0Ij0jcRTGjylttmJx4eOTCb1nSAQGKzEL6uzWnoE/w3taaxqx7PtthtsC9qGTWzX8hfspvdm
	TDHsxa7daKi121A0OYq8hjGeSI+3kX7hpy1l7WOL/fdmx9ujNr6tO5LpcKUbue1xompZHmIJPJb
	UNwY1jfaauwgCwk7KQZIVMMPJX+ZE926r77tygvorFnXUV131HWOKpboU+PgyApyOYjsQ0MuS80
	RC3xIu/8z9pTOypbG9TRMpV0XevRMw7vv9sO2lmTWpnCD4LabPhPNwGfjXpa9hxSF8LXYXA1ypL
	bCj8+1zh2lCIT0QqszE8XfFdDhoKpm6D4KTEdzX9QBMx2KkpS9a/1tbNS2pg0dHXNyZQWM8f1j3
	DxIAQwnITYUTjKZOtqsNdlAsksK6ScrXuVIbiHq7qidFt+FBqM=
X-Received: by 2002:a05:690e:23db:b0:64a:f80a:cfeb with SMTP id 956f58d0204a3-64c21b7047bmr6703455d50.76.1771318985740;
        Tue, 17 Feb 2026 01:03:05 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22f89f75sm4564383d50.11.2026.02.17.01.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 01:03:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 03:02:48 -0600
Message-Id: <DGH464NASHBX.1VI3NRMRY5QX5@gmail.com>
Cc: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with
 guard()
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Ethan Tidmore"
 <ethantidmore06@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-2-ethantidmore06@gmail.com>
 <aZLCe_5C8e82EMGO@smile.fi.intel.com> <DGGOWGRQGI1C.XSJ585TPVWZA@gmail.com>
 <aZQovkDI3G9-B_Zr@smile.fi.intel.com>
In-Reply-To: <aZQovkDI3G9-B_Zr@smile.fi.intel.com>

On Tue Feb 17, 2026 at 2:37 AM CST, Andy Shevchenko wrote:
> On Mon, Feb 16, 2026 at 03:04:55PM -0600, Ethan Tidmore wrote:
>> On Mon Feb 16, 2026 at 1:08 AM CST, Andy Shevchenko wrote:
>> > On Sun, Feb 15, 2026 at 06:53:16PM -0600, Ethan Tidmore wrote:
>
> ...
>
>> >>  	int i, err =3D 0;
>> >
>> > Would you need the err assignment now?
>>=20
>> I'm not familiar with iio_for_each_active_channel() but, if there's a
>> chance it could run zero times, then it'd run into if (err) with err
>> not being initialized?
>
> Have you read my other comments? I also mentioned to replace
>
> 		err =3D -ENOMEM;
>
> with
>
> 		return -ENOMEM;

Sorry about that, when you asked about the assignment, I thought you meant
the initialization (err =3D 0) vs just declaring it (int err), rather than=
=20
realizing the variable itself is redundant. Will send v4 shortly.

Thanks,

ET
