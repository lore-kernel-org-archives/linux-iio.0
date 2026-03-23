Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C44395D80
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264052; cv=none; b=Nb41PU0K5gZMgwNETtTu4KXiPanDTGK1aclIJB9il331sAGJOH6kb2gSqe2Ry5A3Z+pqxzfbhmpQCbGIPoFnpKlMIs3poadgD2LYYl3qR9uWILvUH+D++GZxgq3u+PEDCv8iqgIQv18aScNgueDmtt52iwpJEh9j30yuYgAqVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264052; c=relaxed/simple;
	bh=WDighDaD4KT0IuNZ8FdNHXLv2+dX8hCdCwnZFgPWteA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Amh7KW+KPzomel83PAOMmunog6FIzqexEvQgw+ro48gS5TxFrwIdL83iVbQSEzErx3rG25Sv0T6oRxeWHKFF5oJTVIR+LIV85EXTK67ZiuG0tI827DCb/A1vWDjGPKqjf8g/UTukrdq0R2EKPDCk8cZG9GSsLV5MmRmSK3znrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls1c0+4o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls1c0+4o"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486507134e4so50262055e9.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 04:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774264050; x=1774868850; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WDighDaD4KT0IuNZ8FdNHXLv2+dX8hCdCwnZFgPWteA=;
        b=Ls1c0+4oZCFouqTGrS9o8f2n/lWNVUqFhG3eWrawaEqq93OgqqBAsNpTXgwLzk3jv7
         85BKO5yxqmR7VXvunOUId8G+T/oROHH+t1ml4IWjS7yQ5p28ozcAdd2jzmB9tMQ7/tSi
         jkWQmi4wnAUHlNv3yfq7L2z5lUn+/y/eYE1UCBI5m43egM+zxKkYYUlRxY8X0RsWdYC7
         Vm/PognTFPtvyoikBrvuBiTOWUSc7As8jT2jARMBhYEqxZmklp7UUYzpqqY3W2fUYKXP
         Nuqw7q6MvuC8EE+JxbEBtZ8+Bx/50hnfM/OpxUHF9n/ZVUURSwt3+/lHWCSGIHsuShrK
         qhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774264050; x=1774868850;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDighDaD4KT0IuNZ8FdNHXLv2+dX8hCdCwnZFgPWteA=;
        b=GEqJKZhd/N8m4sJdr7ZHvrPubxtqXmVqDpGctr+pCXCMJLUfol1M6JXUX4AyhVU/7R
         OdxmMvgzXZQ3Q80g/Rd0FFLZn7nZHu6Ej5dBXrE/dtBXA9ej+3J/ukWCJZABiaISOIOa
         Y8uJHSkYVcyRadDxnChN354dBW8Ajnx47vkWSzpOZO8tCMVmrAvVyYw6RRQoMV2nQmj4
         hz8UCSuCQn0EhMKBFntVxvze77lvxpzENiP5M2umIgSSB6ZQ0ENZe+P39sCTecdR6fyj
         OwrRAx9AOLzwuWbIlgXWwqFmyVvixQSUTFq2RvD6Rt5zSD5CC3rNxU0v6Yh6ApgToLRi
         cECQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUeXTTSeD3dGngTlaGy8uKpMpHjLGFqYDL+8xOMQZtWVPdTH/uJfX2iaFdZqqduLTMHo9/tNCbu60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/pjkGM4ngw+2PhrI1q9dO34lcH6lrg0A5/dwcoUQEAtljV0le
	ETIJ1dU6QXJvuWJVmcJ++Er8nxMQrmzj2Dni8mO8/vzVGoKpt6LAeJ++
X-Gm-Gg: ATEYQzyp4CqCvtZmr/NbI2MxHqhKkuwV3PtdHHF8x1v29ODWN7I6W/GHmZ76EpOA/Om
	q08PBONlvk7sexWUoQUPh76t6IG5mdPcFuawKFAOMz95awffSSs3dhP8pbFbJnfe2YbY9NBl1pk
	HogAHQbsXWxtB5a7+fTI7sNuIamK5UBgT/owgCIi0RCWmmN9kqtF2G+/ZFz/LpHKROb7C2kqFK0
	8I+5y+3lWcuDdmd46ePNBswP8p7teQdediimpdh6zldrSs3+qBd2s+ti33A+z+rJFH7+UTXfMCK
	UhljMO1Mbp4QNP4AgeEh5yWDiZeJNiG6tFEIZcucajMP2IaKEuqFTKZTgDjeQI6yu3Ktdai3aet
	i3IN1dd2UIlPc/v06oJPG6/Ug8B6+EHTUDpNQqk6ThZ+r1jzAOTGTd5NU9Uy9YUJ093koMU9Mrm
	ZG6yB47s4IiP2EhlAZIjFkCpNICtEnOPo=
X-Received: by 2002:a05:600c:4707:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-486fee231cdmr156767535e9.21.1774264049736;
        Mon, 23 Mar 2026 04:07:29 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647120a1sm29662569f8f.30.2026.03.23.04.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:07:29 -0700 (PDT)
Message-ID: <920aba2275ff1da033214293a603ef1e215d3dcb.camel@gmail.com>
Subject: Re: [PATCH v2] iio: frequency: adf4350: replace loop with fls_long()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, David Laight
	 <david.laight.linux@gmail.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 23 Mar 2026 11:08:15 +0000
In-Reply-To: <abgOuRDBt73Wv2N6@ashevche-desk.local>
References: <20260311020115.56321-1-neelb2403@gmail.com>
	 <20260314172006.69744-1-neelb2403@gmail.com>
	 <20260316135151.309207ae@pumpkin> <abgOuRDBt73Wv2N6@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-16 at 16:07 +0200, Andy Shevchenko wrote:
> On Mon, Mar 16, 2026 at 01:51:51PM +0000, David Laight wrote:
> > On Sat, 14 Mar 2026 13:20:06 -0400
> > Neel Bullywon <neelb2403@gmail.com> wrote:
> >=20
> > > Address the TODO in adf4350_set_freq() by replacing the iterative
> > > power-of-2 shift loop with a constant-time bitwise calculation.
> > >=20
> > > By comparing the highest set bits of the target constant and freq
> > > using fls_long(), we can calculate the required RF divider selection
> > > in a single step without relying on expensive 64-bit division.
> >=20
> > Where is the 64bit division?
> > (apart from in v1)
> > Indeed where are the 64bit values at all.
> > If this code is used on 32bit it has to work with a 32bit long.
> > Which makes be think that the 'freq' variable should be u32 (or possibl=
y u64
> > if frequencies above 4GHz are likely - which I doubt).
>=20
> I don't know about _this_ device, but before looking into datasheet I wou=
ldn't
> put a low probability on the frequencies higher than 4.3GHz. We have (or =
going
> to have) devices that work with up to 26GHz frequencies in this folder.

Yes, it goes up to 4.4GHz.

- Nuno S=C3=A1

>=20
> > In any case this looks like initialisation code and the existing loop
> > has the advantage of being 'obviously correct' and small.
