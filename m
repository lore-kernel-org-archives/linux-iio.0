Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B44DBD8B
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861769; cv=none; b=tjNO2uq1Xrq4ghoRekcJGugM+u9OAThfNyH4pnfCrlSD38xvhrQHPmQoW0G1VPKvocy7pwKpa5ymUIgGfYS3cbujrJ1+wgz+eDl2oZUho05fyyyfUJl8kLx44G4nBSM3q0XyPsIMAlYokzhIgFYMXLxVPfL1twRMkbx1A5j1Lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861769; c=relaxed/simple;
	bh=mfZ5aUfZ9W7xA/f9RA7WBvF1P6krtGyAok4kokbQcYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edbkgQilylyoYw27WdxqNjv9QrfL+Msc4RJKQLAT9lwcNY//6D9qAAUQnVu++DEzj565GxVbf7dOgjX/z7RM1H3uW0Xvw1eCgymcn3xHikEVX6yRblNhDKkDJ8mgRWVpwsUMSrMtvHASdu0SrQAfmtQ2uRm/JwSZ7xd/ByiDIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ozlXgBMz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ozlXgBMz"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-484392e3d33so3146756f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788861765; x=1789466565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mfZ5aUfZ9W7xA/f9RA7WBvF1P6krtGyAok4kokbQcYw=;
        b=ozlXgBMzhZDIRvnYUMTOGzJY7y8NuWU+w9Rw6Pf+nuWmSm4iLJVDjPgz76HvaOTSCY
         wBt7Vf5Y11OQRgj+6JXU1zDJyL+uPHu/chtd0y2YIWvDiLI6Q0MQtZU7FWliP8oB+M1k
         bRm4FXLN0FwqEbl/HHWtmUwtRHIxs2hQyhKiuN0G67nTRuLp0gb8pIYlredUGsBfTYjX
         TzM5ELzx9lQ+8lfq6uPJVZzJTqR7wlRxdCel0/9WHnNQUOTdoyBMm7XximM+cTP9vvEf
         r5g7I8JxZ2Fhyg07zpIpvqqljB2p9i6rsT0AOc4540ZCsLxv7xPhI7VMDZdeAn7vbOFW
         2hPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788861765; x=1789466565;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfZ5aUfZ9W7xA/f9RA7WBvF1P6krtGyAok4kokbQcYw=;
        b=Mcv04lDx5ZOdyxvJMKo5ce7zYkLkukray3PwCukFl1Zid/7v+og0uEQK9ZMEO3eues
         17Yj1x2woYplxFbHA8fjln4zIodhW9WD4IgLjY+twGBLoiSLON7HEE2RxWeQED6Sv71c
         vnr5N8n0hvv8hRSEqPEljGecujgqTIEVIqwdfWcYlD0V+Se52AyGeeGN+ggh/5hYKYdH
         KIDeYUfdkCwVIdvalFfSeDveYox8PNXO+GWAsNmkrn5jl+wugwR7/1d0/Jf9Mm8pBFrc
         I51UINN+8FhQVh2u8g5Mmi/FBVsb6u26wbV2n+4fQo6sLVJDh5bQzk9hEniBftE3lwSE
         fK8A==
X-Forwarded-Encrypted: i=1; AKwUvByTM93QcBhhj0YMoyKJbGkqYsvEe/WuNgWav02rvEVR4dFre8pAg4L0f2HC+6ySJze0NjnqnjB3q18=@vger.kernel.org
X-Gm-Message-State: AFuF++kimexrmOO3rXVluS7c8F7HKfc8Kj58N05xmsPPjYsS7JYf6PUs
	hNZMo18YBvjFI/xG998mnEKrpl57R69WEy2IRBoVrgYiT6bDKd6bBkMZauVdDFfAXeM=
X-Gm-Gg: AYBFou12LhReOzDALEDWqsUYkBMHu0ds36GDVmeg/4Bor3/yAKjCb1uhJkdpij8RseX
	WzfS9P84W2ocOQi8SADO1//cMkqwgpfGqvCpM9uZoFpw8BzPgJAFOnTEVzcdu4zHuxZ1yqnKBuG
	RYukmnVujYODfc81N3cpPXZ0bLQt0knxV2jmLSm5gBYttstHkbRtWNACB+pYUaTHNURfWFXKMIr
	7HTWI7hMTN45M6kjLCRyvX8lpgutZhMTgkvJS0Rl7L8ekuvLorn4C9BG+gRbDVmwvfZdb0dj1B1
	WZ/wQmqQYluwxiPs2oUYbrPaHb5I3QA2JdPzz8F/N+knKIm6S+QZHkwp4DRb8JzJDR4oW+3mULj
	N4RHLz4WPeS2goouwQLHThEAsXUHrd3SqowpzvOoyBVlLKVSPNBFKl184keDzKJd40X0Rml1PSv
	bbkABPKA8gMDjz5F/WFTRXg6gqgPhXq/MZDbHFARH77YPBBi179we1F8UfqKOnHxbgzUhcS0wbD
	AMootXSAAmoYZh/+D1ROy8Z7yZSGFwIlVxnT0joVDV4NbmT9xg=
X-Received: by 2002:a05:6000:1843:b0:485:8c17:975f with SMTP id ffacd0b85a97d-4858c1798damr27182312f8f.33.1788861764527;
        Tue, 08 Sep 2026 03:02:44 -0700 (PDT)
Received: from localhost (p200300f65f19a904516ed84e8e7b3ca0.dip0.t-ipconnect.de. [2003:f6:5f19:a904:516e:d84e:8e7b:3ca0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-485883a9234sm34875344f8f.14.2026.09.08.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:02:43 -0700 (PDT)
Date: Tue, 8 Sep 2026 12:02:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Laight <david.laight.linux@gmail.com>, linux-iio@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleinxer <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <ap_cLN807bC56OBU@monoceros>
References: <20260803094702.3852-1-david.laight.linux@gmail.com>
 <11o7545n-7569-3p9r-1q77-8nor8513r6n1@syhkavp.arg>
 <20260803163955.627bdd3f@pumpkin>
 <20260823233536.30b984ed@jic23-huawei>
 <20260901175101.1e059ac8@jic23-huawei>
 <20260907231444.7fa2d116@jic23-huawei>
 <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="egsce43zaasbu3cd"
Content-Disposition: inline
In-Reply-To: <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>


--egsce43zaasbu3cd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
MIME-Version: 1.0

On Mon, Sep 07, 2026 at 08:32:16PM -0700, Borislav Petkov wrote:
> On Mon, Sep 07, 2026 at 11:14:44PM +0100, Jonathan Cameron wrote:
> > I went ahead and picked these up on
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git ib-iio-x8=
6-asm-fix-7.3
> > and merged that into the main IIO branch. I want to give plenty of time=
 in next
> > for the driver that was relying on them.
> >=20
> > Currently this is all in my testing branch but I'll push that out as a =
non rebasing
> > (ideally) branch a bit later in the week.
>=20
> No, this is not how this works. x86 changes go through tip and if you nee=
d an
> immutable branch, we can give you a tag.

While x86 usually goes through tip and none of the x86 maintainers
commented before Jonathan applied, it got positive feedback from hpa and
peterz a month ago and iio depends on it.

So I suggest to do the practical thing and pull Jonathan's branch into
tip. Technically that doesn't make a difference (apart from maybe branch
vs tag preferences).

Best regards
Uwe

--egsce43zaasbu3cd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqf3UAACgkQj4D7WH0S
/k6MzggApFuYnn+6K6MhbYPlYLbjpXHFLcOb0VRFR3FjSzeReqAmbonX1pAQ4+kY
QGkn6sZsZfmnZTATEc/2X1nK1PMlDg0cpqsqdhwJTbBVgC031QNORUSli98gnCqE
XU+P/bSIn2vUrJ51MJeUklZ3ipkxT3QV2gzO0dz7XklhN2RKvzQ8Y2Rbstgh7d6S
MND1/4xiz6mtKtvz2Uj51zZSawsayuE3ltPw+R9OP0+wCmo9DmZPth9yhkBgkhIQ
dOxJ0qSOOa2Bhq7lH+E61EFbGoCcGaFFNl8HGqb9U4E0nmFfA+s+feiyHAZUxkGI
Qj4Iu9/WCRXCl2RYNi2cNHavqBHpyw==
=lNlM
-----END PGP SIGNATURE-----

--egsce43zaasbu3cd--
