Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF63590A9
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717617; cv=pass; b=SYgKeiOFXJRepV9io5CscWtDhFqm91/2gz0KvAPPLiAKFs3F0t1Alu6NqGBnmqIT019/nom0XbnTC7u7lxnYALdh+g6wI0SQmwoJ8P1lTvHeVi80EMSktdlQgLl22jrFcSRknBpqNtfbEbWkSkJKQMHf5OrU+RRdi7gzPE4ik1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717617; c=relaxed/simple;
	bh=ZXnQOUeDE7IoI1JbAe6tdNEpesImAjIF1+XCqbL0OzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsEuqhxccY6RRrGpqqVk/QO2bmfUcGxv5/p2GW20/ggWEAmPUOldy4JuoSUbckhhAD7BIwXD4oJCdJox+ROvKIfUZFzb0HgBt7BgqqXXXO6Io+nLTt818fBVLNdlbe/m+U31vxecHokcii9hecL5HbA51w1ScpLyi4WayayC5oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Dg2VJvlF; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Dg2VJvlF"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba388bc0a9dso619781666b.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 13:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776717614; cv=none;
        d=google.com; s=arc-20240605;
        b=Wt4KEszZbPDaX8SoNePxvHyu4M0v+iCJmyWgQs78UJxOS8V9tw8WpR7s+E5FvJsBMt
         b717DEtZiQ/a4SCRftnt58f/8af1MtWD6qmdk1BvUnimP6ZLTELPCTh8lGxS97JxMdtR
         2F7Li6EsQG790pj4GdXkNvakZrSBqg4YeOQDHknPcT5X6BfTyVeEmXRZh/QTnhNBnPr+
         MV5R0wRsHrZxDfbFe2SPVNvCY7XPbk03igHtPczedqlyD6LN2zsoKe18goVfleEhVJJn
         ZBpITbITUjpkBGSR+VjPhhYkxS3AqEPf9+++fr0rHZo+LKKsx9aGZ6zJaGzngToQqruD
         Cntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXnQOUeDE7IoI1JbAe6tdNEpesImAjIF1+XCqbL0OzA=;
        fh=m1ck7sF1ZNs/ZKM/aMwXng6B1iTvjxVvRyYJ5p/Z78g=;
        b=Z6zCwckoXvkCJHIkUEDX0a7anzmo01u5bRBFgT4u/aoGMJWRi/Jtf8HVx4Q/lBkp4J
         VzVWgZZZRwyg5g70GhwDk6ELoPN0Gxm6CsJlGFeq9laX2JlH77qGwHNTH9y0H1A6wAL4
         Ya5W2BLSziqZufV0Yakv/Sk0vNCvihRMo1JJvjSYE2MNe3i7llfAJjZMSTYICwKuV4lr
         ry4k7DkVK/jgn3y3zwnLa/GIAFIXAnKQasjB3ctwKDE271uPI9g/fqKYTbfmO4KbNjc6
         cqdNxON3kUOzIQ4tVNcJKnudlo4k3eV/7odfUYp+UzBUd+9BscDygEMMKl3jzMnyMxYU
         7KIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776717614; x=1777322414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXnQOUeDE7IoI1JbAe6tdNEpesImAjIF1+XCqbL0OzA=;
        b=Dg2VJvlFSi/XayZ+cwW/wceHO7uxqVTwWN3wmLvtLl8nO5fwh0XIxLak7XIekCzXMg
         mocf4Qy/Ahc+PINUyqFFVkoiPsvOtXNkRg4hj5l2B6Ya8nwY+WaAHFpCzfjDrGFBBTls
         bLntkRdWQ0LUHoaKNyimraeXQK5re+4eAIQ96Pyfdkn3pPDFFPEZ8N+qndFXQqiiN04K
         GsXU3V/ZtYdAgK/5lVc3dOZNYLt5b695aIHSn753o3N2Gw0lV/PnBFpcRRH04eKPdiHB
         FRf7CaePsVO9QGaC3DDxzVl7cs/T9VSGFXUnxB5wM7ECsZPzpi4sD3IxgHLOXR0Q1fBC
         GQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717614; x=1777322414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXnQOUeDE7IoI1JbAe6tdNEpesImAjIF1+XCqbL0OzA=;
        b=IwiOSBzKHG/iVwxVD+pky3QO318goxrtwMJAUm+JUqgP8E4jZHyzAuwjyQnZzanrXZ
         9J+kHtBeJVPhH9T6Zo4h+xavIdpirUcHECNpzphb9lk7VdAC52dFjZhmG7stgfQDKYck
         Prs4O9Q0NibHOSI81SE5E7J5fbDPmKkerHw4RztYtYVd7bE/DDbB1uny9FymwlW6PLJq
         dri4AZGNd4J/3yLEa8mXLDaq2XNN8Q9X3KxOiHXkLFpKyzQaw1z5idODs07fvwcA9Eq0
         S/qUdNHieArLVQE/SAPhqwBKxRuTt+zVvCsYafVpgLXn+I5m4e3aB4Y+jRBMF7jLD1Me
         V1/A==
X-Forwarded-Encrypted: i=1; AFNElJ/IAMJOsldJZ8y2OuUELOF1T2abzIQ5AXHFqfwum5oBaCHtHnkf/w64+Av0NsHrQsq/5RLErGrrTrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaeWTSW0Qbpxf55bmxM46xNcf5/oPx9nt6xCAZHuymhPxbBEuZ
	EExIk8v5xAOyshb9ydDU+HABLCKh7pZ+5s3PtauEjlo1I3Refa+x4c4sawnTqi0D7/kkeimnW7a
	OtdbfuhVWwRO0hKS/GUDvtkup0RwrOrYovLvpuvg8SA==
X-Gm-Gg: AeBDievMxHS+3+ErGrSQVMoZjM5RI/sOXd+QY6uRCA4Yn7UTSAUmCiS5zG34bHVyKFe
	CYIVc//YLfR1LYBDycNGa+ngNoJDMpOObBZLWLdOcH4TgwSYY5f2fFKGGuOKMKu8VHEmWijO1E8
	z/xP68yVCd78xVDXa8V1A2qrjIOH/PZ+OdcP1beKYNNoVHIqAN256922XU7idtvMzerduW9BeA9
	V6tj61FgW0B3kuVIQT2vF/PCKR4110otyVZb3a8Vj9Ckbk/c33rpjws0P+87r0vR0FedhHizx8m
	I1ey++Q0tpZeIr5LKG3Xw8uUPSi9PxxfQTf10TjhGIQqUpfovYQ=
X-Received: by 2002:a17:906:9f90:b0:b9c:451b:234e with SMTP id
 a640c23a62f3a-ba41916f46cmr779072466b.11.1776717613789; Mon, 20 Apr 2026
 13:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420200047.102159-1-raffaelraiel@usp.br> <aeaKP2vARF-Bv1-2@ashevche-desk.local>
 <aeaL9ZvMEFF2OK0n@ashevche-desk.local>
In-Reply-To: <aeaL9ZvMEFF2OK0n@ashevche-desk.local>
From: Raffael Raiel Trindade <raffaelraiel@usp.br>
Date: Mon, 20 Apr 2026 17:40:01 -0300
X-Gm-Features: AQROBzCZyS2lvIFhJodeMM8WKNwiS6fiK1ZAQgc6D0jqqsAUeP4UXbUL0gkI36M
Message-ID: <CALSmcyMRpiqHjryq5+GU9vXsZt0qJZbvjGhyW-Ho6Rm_Ly8kbA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: vcnl4000: use lock guard()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, Kim Carvalho <kim.ca@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 5:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Apr 20, 2026 at 11:19:11PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 20, 2026 at 04:59:33PM -0300, Raffael Raiel Trindade wrote:
> >
> > > Use guard() for handling mutex lock instead of manually locking and
> > > unlocking. Remove gotos in error handling logic. This prevents forgot=
ten
> > > locks on early exits.

...

> > Side note: This can be simplified with FIELD_MODIFY().
>
> To be clear, the patch LGTM, the above is a material for another if you
> wish/have time to do so.

Hello, Andy

Thank you for the clarification and the LGTM.
I will consider applying your suggestion with a new patch
in the near future.

--
Best Regards,
Raffael Raiel Trindade
