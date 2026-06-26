Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4603E3C48
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479900; cv=none; b=eycVoP1iZNdYBu2u6sbuJAygSFNkbeE+cAzhH808vVqu+fq/4vWLB3uYQjG7g00BigtmvK44Hb9J5XCqZgnyA+uRLnZrT+KCjl65i+mdhVMOG+V3f0YkWwEAMU1pfQwlfGdTRrW2V76YvifqoPkjVzJZJCjUuQbW6xJ0ngim9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479900; c=relaxed/simple;
	bh=g74h5nMG2Muxpb1zKR1SzpZn4GOvZVqUJyiTDhZ+Qdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5rs0vDFEPKGtKRFOiaYuwMGrLgHH+E0Sqxha2ERZPU/r7qLxJ0+QpY2N5quVN79k2OM+9I4yGmyOSH1Nj9rcI7FwCkj5KWD1rZCxRUDiw2Eufl8W/uSpgqx/Y5ztQ0fuLE8BxHhVRhm4fLd8wf6D1QE2YkPKoiktLT7gA4bztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=edSlccIF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="edSlccIF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b613a17bso9159605e9.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782479896; x=1783084696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VJE2Q0wRemfAFmMp6oN0iCUsBxXjEe9Lpsiy0TlcHk=;
        b=edSlccIFBKMDGAwRBY9KGqTAOjFcy++nvVp0BKhjQMGw4Go5TSdpm/mLbLIgjORdRp
         uyYzTnv3817qWOR89ZQmI597renvJpwtPO8Q4tcu3zbkY51pcPkkw6sm0QV6A4R1z7yc
         CzFkwSVTE5VsZDd/TRZ4BvjtLl5GSNO8sCEfVgPYa+wZce/IKdV2W4x4rRLuLUtVqLZd
         MzSGfP+pqHBCdVESyVCjrEclrnCwP8t3eZlwl7W0f8cFmuBmHJf6rr5M9/nqqiowbbi5
         AyFpT0cXkq4TVVcrPKBQnWRX8aMTQ43u5TuUfeVZPP24oYMPuDEBMmF38/mrDsFTqD8+
         +FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479896; x=1783084696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VJE2Q0wRemfAFmMp6oN0iCUsBxXjEe9Lpsiy0TlcHk=;
        b=Crbl2u17EigpNA7t9bgw0kXYlUsi8oV6TSu95hkYgtEtA3PTV1lakaezOG+2Q4xlVC
         ZPSwLDUUjDIZtfe7MifHgX86E0eiz6SkoFBvsgDDGVZ7DoHTOCvD6+VWNAscboMskgLp
         Xl4Toeq4X3AL1RDgAiwcAhMsnKEEnUz8e67vp5R4W6yRTrqhdxxdhjokTJ8CqrHj/d0e
         RziF1YC2LmUJMZA/iz5pIK2N/FmfB6ADVQgkiRf96yyfYA3mqsIgocnYOoo66q97jHPI
         Df54c0RSr2VAX0wfFaP8MgdLpbaeqK4aDNHTaRcv+mlOAn2fxiES1L1i80ydRG+2nuTM
         PCSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8J0qN7tUVCotfJqCyYqf6HSRX/PIvNiw9ywslr9vK4KVq/UIZ1eH+zyvcSNUf211mA+Vp2omDi4e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZCiLNKrbxjEyBTu+sFPA4h8sdFYe+O199bAXEaNYyZS783T2
	64r35zi5wAOWvXYnMNgTxxmgDhhPNkIdGvQYt9L/jb/CKMn99cqLgdSOTLBVWejCWa4BHRF4+Oq
	QnabG
X-Gm-Gg: AfdE7ckiKUjVwN1DDJeHBe+Y+aD0USOmbWHtHjQ+mHixciPLxDU1tJLafegcKzPsTe7
	fq9+FM3JEh7Wd7cvuiiwDC13ZtDdsgI8BftRbF7Ifs8BgZKtbdmBU6/TrlurM+ULFyD1QESIaTi
	kLvZca0+a0XSQ6Ta1TwhqA+1h6XMz7IDmq70bhnVsTbVcB/xacrmYBrvtmP7ZtGhKNvjIFNRLHi
	fh+2rKqoM0GtDr7iv8YNPqKA3eVXzxVhgkVkW+dj3t/oZ6bTKKqiUip22Q6wJcbth7wGlHpTd6z
	NwxGoPN0TAqO/MO6lBCQH3OYjaIZJINzSTUlJDRJJ3I+ep039zIofzvf4I8oMd9C5/ARTS9PltG
	FidRw66jCVwTMeqUFFhYA7YH7KpdLSLeTXjEbpKmxrN1uEuGWnwhhkNPrvtMtNrJm274iLXpNrD
	MK+ZcoXkn35Bwlm9hb+NFaEqk6/Ij5Ul3YDdXL4I0c0bjpMEjFZ/g2jM6OQmZ0FJwgaw/L7AJIp
	5Q6
X-Received: by 2002:a05:600c:8b82:b0:492:6fa2:fffe with SMTP id 5b1f17b1804b1-4926fc2ee01mr11951535e9.8.1782479896318;
        Fri, 26 Jun 2026 06:18:16 -0700 (PDT)
Received: from localhost (p200300f65f47db04b3606a871f5f1c38.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b360:6a87:1f5f:1c38])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46dcbac0c9dsm15087448f8f.19.2026.06.26.06.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:18:14 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:18:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/13] staging: iio: Initialize spi_device_id arrays
 using member names
Message-ID: <aj570BhA6oCEOgJ0@monoceros>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
 <cac7a68e6a6adb1b58207640ab045e59eec86f53.1781883685.git.u.kleine-koenig@baylibre.com>
 <20260624185419.27db9ef9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7thw2omwi5v34cxb"
Content-Disposition: inline
In-Reply-To: <20260624185419.27db9ef9@jic23-huawei>


--7thw2omwi5v34cxb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 13/13] staging: iio: Initialize spi_device_id arrays
 using member names
MIME-Version: 1.0

Hello Jonathan,

On Wed, Jun 24, 2026 at 06:54:19PM +0100, Jonathan Cameron wrote:
> On Fri, 19 Jun 2026 17:54:41 +0200
> Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrote:
>=20
> > While being less compact, using named initializers allows to more easily
> > see which members of the structs are assigned which value without having
> > to lookup the declaration of the struct. And it's also more robust
> > against changes to the struct definition.
> >=20
> > The mentioned robustness is relevant for a planned change to struct
> > spi_device_id that replaces .driver_data by an anonymous union.
> >=20
> > This patch doesn't modify the compiled arrays, only their representation
> > in source form benefits. The former was confirmed with x86 and arm64
> > builds.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> Applied.  So that leaves the pair related to Andy's comment and that ADI =
IMU for
> a v2.
>=20
> Thanks for your hard work on this.  I merged it fairly quick because
> I know we are going to have some merge conflicts (mostly other folk
> tidying up individual drivers as part of more complex changes)

Thanks for your cooperation and merging it. The combination makes this
worthwhile.

Best regards
Uwe

--7thw2omwi5v34cxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo+fBIACgkQj4D7WH0S
/k6eWwf/Tvn+bgvNG3NK+tD84r9aiGJo4jpMK1kWEL1eDrhI0sCrR2Kr8jaYb0Kk
Dj7pzmKa8uyYV+saXCth2I7y8rWNSmsphOwE87zPEfRDCGgYq3L0Ei77FE30GtOT
OYEz+uBkcsDyz0cIEKrueEUBViG3KhnmKcXr4jwF271JP2VbAqPiGh6ctUrUN4Nf
AJkQcx+VQjQsRZovjvaPeQGkymlKNlHSqngjNuGpYFN4zCEPL2/BcPrm7qqXiG/T
Y5RwvpwNMC/uBZ+0Mv0DlIrlVe72dTCk/F+eX0Nid0BGVLyefvVaPJdoy2Ntfsck
/xsSrJhj3o1OTf9ZgY1aooUnGcxLKw==
=ADFr
-----END PGP SIGNATURE-----

--7thw2omwi5v34cxb--
