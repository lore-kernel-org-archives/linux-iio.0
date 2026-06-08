Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0A3E638B
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950611; cv=none; b=J1qfRM6MeP9tt0op7+d2sGiDybxNBrnI2M/z32E8E0rPY/xwx4K5pSt9oMVHcm2EmWn8PwkwTj+RGHYhs/WBi+gIApiE/+KtmUdPbesG8xWjKj365XeRGhN3ibRRob+EC71973gLrGafxICWMT0c7CSydbLcmzei+Y5Tqcm868Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950611; c=relaxed/simple;
	bh=tBO6EHZ7m3EmVy0SfD+RfgsKaS54zMv6O+QHMuDtz4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fdgizu/pVZAuqkW9Gh95vtI8rNU1rVqDOIe6qc14QZE//s8h3TX+Fcd2VBPfF20RGRkIaEi5Acy/sarJcQCqqu4UoW0204yurtWxb1t7TvBc9xeQOOhjlqqW1C+38gsfNEx9rR2Q5h5dXusbWlyCYR2t0cmJYl0hw+a7kaUYNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcahCdKl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcahCdKl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso39419645e9.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780950608; x=1781555408; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tBO6EHZ7m3EmVy0SfD+RfgsKaS54zMv6O+QHMuDtz4g=;
        b=KcahCdKlB26orKlkAyhz/qS7aphZDrI8ejkrHrYcTCbhqiZOrUXn5SGc+2t6QtAP6K
         98mFQwAyEPki1e0Li3liy42sKS2cAKObJ0J9bh78igv0/c6gKHgYSzePbam+tlQUoDzy
         HPuzDIE/+/MtQBR9R2mv/H20TMeFLraji7VL6YyDdFilqRwXVk3jAN7Glv58JwGQIWWu
         TUoyKTYmfZKFjXKdkgPz8+AcGhTiRsSeAGksxTzWJS3Qrl9NrgPnb1zI4qJIKBo4VO6a
         KUaFfVEh90es6rdedwThAbjN6AEtUc4/xo8kqYiaSFU5wi3hbpT9Q4HPXgqpqT1TeH7+
         ZwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950608; x=1781555408;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBO6EHZ7m3EmVy0SfD+RfgsKaS54zMv6O+QHMuDtz4g=;
        b=fxaup+e859B0cSzHThPIaQLrEFWY7iZdrurxY4P83PdxsvbfGAQxggDLb8hW5HUPOk
         FNFbH6DBijqh58+PbNCtroJTlCQrCcBqig2+ZL65z+5hkPAFdJrRFRBw7pe4R3LLIQH0
         GXcp5zGnMmXXOK9wzCaw43IVe+qsQfxmEzlt1BeRGNjBzjPrp2B8bUOKtjUXsxSa/kU+
         gVHmrISKHQ1EEQs34QRLBuY+T4unU0v7msgkUaKoANWlo5gKa0v/x+T7hWeyCo+xqM+z
         ceyo3cn2UbtfFp+Rff6X2WDLypg9gLM9sMJcCLaPLahiY4Hx22ez54PxSFZ3lVya61VR
         vUlw==
X-Forwarded-Encrypted: i=1; AFNElJ/cYfaU4Q9A+PKxxdgO/9kgZrrHFGIr5lzezxdzehKL8rdYf6T7l5ioFMheXVBSmhTGLn6u0dXKGA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2cRmi710goshUKpWM965q6JJu+92psVBMFdnDJbOUQ/zr0Kh
	+hYJt/YdOFDTRF8PFGrBSfz9Nip3Q6XTc7hnuIMpbqeYf+uEgArXTyDR
X-Gm-Gg: Acq92OFO7l9WoSCKR73iZETL2JOpaUStDZRVyvjmPCg9GdEU3QCeFVoSWNFwGQCo4y9
	+xCFOLk82n6pKwLUeQlmDdvQ/FmsLIFpDP4tXImfI5u3H3JkcEIty9/KZDSw2prXF5ChpdKklVI
	3YpLx2gc2nHfn2V8U7S6uuZVwZJBRgT4X1geJaozqdY4OiGfw6tQOZOz+W8759AVLSN709Xo/ST
	zrua4VtEDPy6laU2QTKfcJvOiY0kRpznmJJj8BbvOWsrnsdDb6xpF+lm4L3DU/leLmzLC4nwHsl
	dKYL3B6VhBVR3UoxdbDScKJH2zPPmy/vNXHpYntukqKI3Qk51R7BIrZlKekO4dS9BgVU2FnLgz4
	O8eoi9NRjnPZyTVm8yQeyJrqOWU7Ax6VinMsNIUvA0c32KQvtejs75d2jOLQuAuSoDwXbZJxMTX
	jrpS0QmVi+c5MMDjj41kD/u+48BDSerYiIRpWaOcdIWEzc/O/vCeSfAgMFbgEzFHiURV1gz/H6v
	5cBkWprEiQu
X-Received: by 2002:a05:600c:3b1f:b0:490:b9c3:6c48 with SMTP id 5b1f17b1804b1-490c2621dabmr295540605e9.29.1780950608202;
        Mon, 08 Jun 2026 13:30:08 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm430313545e9.6.2026.06.08.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:30:07 -0700 (PDT)
Message-ID: <da949cdf51727f74d1f0f5b3e8248d5dc34e2219.camel@gmail.com>
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Dan Carpenter
	 <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Maxwell Doose
 <m32285159@gmail.com>,  Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, David Lechner	 <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	kernel-janitors@vger.kernel.org
Date: Mon, 08 Jun 2026 21:31:14 +0100
In-Reply-To: <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
References: 
	<CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
	 <20260526191946.409160c8@jic23-huawei>
	 <aiEpmqKwFuIMRfdl@ashevche-desk.local> <aiEtIGOFhF8AfUCT@stanley.mountain>
	 <aiExQzpIOwPgwd3-@ashevche-desk.local>
	 <aiE3N6zErq2WcCvS@ashevche-desk.local> <aiFVuvVtaWbjfVzA@stanley.mountain>
	 <aiFWg6vC2cVbONTK@stanley.mountain> <aiGRzFrSU6QUL4R2@ashevche-desk.local>
	 <aiJo1kjN3_XDUdBc@stanley.mountain> <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 11:28 +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:
> > On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> > > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> > > > > =C2=A0=C2=A0 168=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^
> > > > > Uninitialized variable.
> > > >=20
> > > > s/variable/data/.
> > >=20
> > > With what I asked in the previous reply and what you explained there
> > > (thanks, btw!) I still think your patches are not fully correct. They
> > > will require to atomically write all or nothing. If we want support
> > > partial writes we need to go with that differently (reset ppos when
> > > we got enough or more than enough data).
> >=20
> > Requiring writes to syfs and debugfs be atomic is pretty normal and
> > works well in practice.=C2=A0 These are very small writes.
>=20
> Perhaps. In any case your patch will break existing partial writes, right=
?
> I'm still considering that resetting ppos is the right thing to do. Just
> need to find where the best place is to do that.

I think anyone doing partial writes on a debugfs interface like this one is=
 very
unlikely but it is a fair point, yes. But can't we be more relaxed on debug=
fs? No
userspace app should be relying on debugfs in order to work (though I know =
that
actually happens).

Anyways, this is one of those interesting edge cases and easy enough to get=
 wrong. I
guess we should either:

1. Improve simple_write_to_buffer() docs;
2. Or come up with a new simple_write_once_to_buffer() helper?

- Nuno S=C3=A1
