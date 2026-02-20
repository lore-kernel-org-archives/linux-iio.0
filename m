Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1854337B8F
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582106; cv=none; b=JQ9vcqYXz27fMq5fHkJ3tQfGXm/g343eHRZKpiOsQ+1Iem/5lQmyz02yjCu5NT3tiOcNcMajBKkdJ66ceoYQWy/JxUD8Ozlm6Ww42gOQe8EbSkuWOWitTgPf63QcNpPEc+CvfpQ3i704niiUYWYRZzAyFG+Y+u6aiuN8GcsAHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582106; c=relaxed/simple;
	bh=vVqzlXAKvy6TnK1gPKeaDTYznYyhDiXtvnha857CiOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tAVWfbEpAsWUao5QFhP/Mzz6SqIpi/XAFYXQ6GIOeWg3OyYAdhpQTWs5+XVIdO9y6T6XfqKXVcDd6pAk07IGyaQD/QqnPEqJWAwgtxWDh/7MxcuKMxsc7G3gkvZQ3D9v3in4KVacYSqf2NpmexZgVT+XXFYTyK9lZUN0i+3KZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEqyncJ9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEqyncJ9"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359108fd24so1157241f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 02:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771582103; x=1772186903; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N7njb9Dlot5JVPaQKTXSPXh31mLIMwVNAtxSxfji2V0=;
        b=MEqyncJ93Ar15pWVhjZr5KdP0bGQXR9YqMeaXTVWHXkvzbwa131b6/6OY6kCVxE+5X
         XPyO4Sq8cWFdsTvyXcBz6mufPDJEBBRlDPMHvSS3WnT/EBzUkVWAOuOCOETY0T1LWmCf
         v19wgBiJXiwM/K0FruCvF6fKqA9cn1NCPiS2FjvlZyQHpYXN7ZrCwoQTgJi8hB/s5xej
         1xdjJNlUjzseGD4ysUCg5dUtDQb/B3mCA3NVio5gKaYJJmxgIRcqlPT7b1J2ex+7NK0z
         BfGXBXOPB2nQ+puYETxESTChn4Hah52Chfa3pKEDzR8e7fphWysMQtEYhMC5ENEOLE/t
         faSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771582103; x=1772186903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7njb9Dlot5JVPaQKTXSPXh31mLIMwVNAtxSxfji2V0=;
        b=FwMTlcIMCi5wiS83xchZH1tIGkxu+lO70q5uOPY+D+C08VEopY37rvNjWRM+PYOr5z
         EpCSG7Bs3aZr7VgTeF2VZ1RsCa+uJEzsPdCHYMPqnJl2ALZ5VCCl99xtvePP+81I/LL/
         fbasCoTecOqWFSpLR3NSJApswmfEDqS44pZkDiFV29h99t/vNORiU0XAg94AWd/+cVGU
         od4yJmDt0kdzUT5wtxfDw2X0zN7JTBLLFeT4xTVUOV/NXc+c2hD8czqcHV6u4c3ZhrlE
         VAnEwSKScAq3UCHAFUP6UpQNYdsF7B1ZzVUYBkx10Dz3mR3fWlf2gykBPS9TPlgRqkP2
         EldQ==
X-Gm-Message-State: AOJu0YyFnuuj0lVfnQpMi49yUD4CCnAXE7M9bHddvPAg2SnBcDG4xPO/
	digPNyGGbqiSZ64Bbc5YHTsEm/5e5Wz4YKjNnnjB4JF3jEHeIiT03hVq
X-Gm-Gg: AZuq6aLgHHuwfADNodE6OPtylfc78uUGk1yZLPdG4UcVuxSAlUzrjfjrt7HNFUydlSe
	5zwf+g9V+y+xYyYXdA7cej27yNH6v+7fjcUGPu8916e/cF40QTbu2fgC8be2biTwndMUf/EOb5m
	qdxrEyphAwWiDqP9C/nnT14e7MGWTsk3j4mO7ZlWLVMvFcaL7Bc3I/W7Oql0QkotpBX2y0rDvGm
	N4NcrDuVJQUV3SOxjnFSHdp5psRJmxXR5BPEfnu0QIaQYa2PnfKihcKqB4O9BKZdlf5w6rmSzTM
	OC1xwFdzxZZV8O9uGNEdlJfLw1vruGXOilUKBmPx5ySMxMgLPjMlDIHLuklf37GrVJeSiiWwTs1
	88QGQtj6pu8fobBTaTXD0ffF21dOee2K9EyYtxJRc+IBknvHWD3ApTqzXh9zFumeQ3JmCzevkN7
	wo2uYz0GLQUi9d+1suNVsRIi95WdbxwcM=
X-Received: by 2002:a05:6000:2511:b0:432:dc1f:6982 with SMTP id ffacd0b85a97d-4395fd35462mr9901455f8f.16.1771582102696;
        Fri, 20 Feb 2026 02:08:22 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8209sm55886120f8f.30.2026.02.20.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 02:08:22 -0800 (PST)
Message-ID: <e755b0e07f276327af68c7b0b223d4dff7b8ed32.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Date: Fri, 20 Feb 2026 10:09:05 +0000
In-Reply-To: <aZRt38PTZYzQv8Si@smile.fi.intel.com>
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
	 <525a30ed9127b689549bfaedc086638e2e3b5670.camel@gmail.com>
	 <aZQcpJV2GQ8vWnA_@smile.fi.intel.com>
	 <c27fd07403ed790902bc9ef5a863beeb7b7429be.camel@gmail.com>
	 <aZRt38PTZYzQv8Si@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 15:32 +0200, Andy Shevchenko wrote:
> On Tue, Feb 17, 2026 at 01:29:07PM +0000, Nuno S=C3=A1 wrote:
> > On Tue, 2026-02-17 at 09:45 +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 16, 2026 at 02:31:57PM +0000, Nuno S=C3=A1 wrote:
> > > > On Mon, 2026-02-16 at 09:14 +0100, Andy Shevchenko wrote:
>=20
> ...
>=20
> > > > > -	if (!buffer)
> > > > > -		return -ENOMEM;
> > > > > +	if (IS_ERR(buffer))
> > > > > +		return PTR_ERR(buffer);
> > > >=20
> > > > Subtle change that could have been mentioned in the commit message.
> > >=20
> > > Actually not really a change. Currently the error code is shadowed to=
 -ENOMEM,
> >=20
> > Well before that was explicit. Now it also depends on the internals of=
=C2=A0 __devm_add_action().
>=20
> True, but if that ever changed, we will have a new error code coming from
> ->probe() and that's fine. ->probe() is not stricted to the certain error=
 codes.

Note that I'm not complaining about the change. Just that it could have bee=
n mentioned
in the commit :)

- Nuno S=C3=A1
>=20
