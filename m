Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F62DB795
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788325546; cv=pass; b=bo55GUn91JSSqIUeGqTShyuW93DzJFFVjKladXVsp8yEzPYRznuuv/0NZdPRvKiemCTcYd0TYv2EAX6h8tWDOZx5cSyafVwq/Dsn0CcAy/Q1wDZPgwQpWAX58OwWTsCAuaW8Vu9gkm8LSk5HMI/NwiXb4Xcl0CQI8jcrGYYemCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788325546; c=relaxed/simple;
	bh=NLHqvXto+f3RYXsUmTwIi3mwg7y/IwmK5K15JRyNzIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxkznuxY5whRykH9xgJLwWP/+oMrDJgv7eXX6a7spL6dnvwSQ/ou6t6giSWb89Wui2X4rhr9Ds38PSuXmXqkF5WElx+njtliWkANBd0t4nYaTupOF2GgDbypok+pMpTR9tG/bzQgDUSz9rkCq3Fzk32YUX98Er1Dyil4iTdSX8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+3L2msJ; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+3L2msJ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c7ed5410bso4093331fa.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 22:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788325543; cv=none;
        d=google.com; s=arc-20260327;
        b=J+JDdhsDd5cWie3Cq8cm1DadzeryPXb0JjHl6g4diEymPiHLrgPDwN3WGEks8erODT
         HTlS+QWb1Qa2C2yT23MfpiCcP7szhOac/YizmLNZDW8cJvlWgCRhUhBu9d+7w3GpqqLd
         DSAe8uYS8qYf6jK+pODh8Orfr8dEuWjOhiT/ohumai3mPuASfKnpdyndm2PkWYVFrfff
         E2jKTwiu28qG2xt249yuf4Dfmzx2y3fMKGVtQrXEHFjROEoxw8F9thq02lnWnpbof5xu
         053+zyarrVX8+8OOarKhWGBMg8L7q3354hI/YZlN2aGEjmnX3e6UQqcH3d+NKptAL51y
         pj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7nkXBkEBfR4l2iwoI8t7QwAJBhpGhm5orDlZN2BZ1Zc=;
        fh=IivpvTsmepQIyWeXYU///yzY+c8SVHird8oeQPV6EVk=;
        b=eyYQ1Wos+BbIb1RcqrILDfWCIUoCtt1ROMeXXAy4pIHqX6aWuUVbRhNQjUBQKCpvpx
         gKoLFyDY3bNZoVFeWgtEooaoum8EveA8pkW2CQX54XTfPbqmsfwVIlU/MGZJxzBKVdT7
         PCD3hcjE1ub2eBxfy8H6zjyNLm93Ky7TJTflERVZJi1pAV2r/yaN+AaZm/jX9M4dRSMQ
         khg7QNX9QuE8p6uXArgaXALwd8CEta+ghDIm6vHx7t32sMxGydOOyromM0YH2OiB3DZe
         iTWj+Cvn7DYXtsC4BZbp9NSlrTNF8y3Y+2dA/m0esovZNMHj3AaP+JmgNld9DNwYoG2W
         NZtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788325543; x=1788930343; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nkXBkEBfR4l2iwoI8t7QwAJBhpGhm5orDlZN2BZ1Zc=;
        b=l+3L2msJAclDMylMVngKESVYDuDdURyx2Mz0xwSZRwUENOISs+SVYaKdmAj6a0vj/Q
         U3LuYg6FXLS0q95etYUfeekJlW+VYIllaTiWRFZU0Cpiu1b5dJi/yvoKH6nGD1+tAMIZ
         uUN4w4fU0n9u/PBHoTpvdwqOdpEk7AWyrNdc2KnjejONHMRwaWgwNG3TpHE7KRFYNZuW
         Fw7BZoaB1Ft7Qrn2Nw185WB4mIKLu5oab5NzaskwOlreLKesmeOz+JNWD3fZ7dHv/cfN
         /+Ux+ats7H3/JrMgzHuwqbilYa9m7LjF9qdjWB25m3q12RwFHmWwLWxvuskoxe/BUuaA
         T0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788325543; x=1788930343;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7nkXBkEBfR4l2iwoI8t7QwAJBhpGhm5orDlZN2BZ1Zc=;
        b=oCxoQBJEVK5i2K/vnOrvelFZHsMgX2cT8ozAsJcnLmX9OKkvV6/wV8IWs3qIIRWL5h
         F/baFKxhD4w0hwu6HITNJp9rhthdS0ZUECR3I2wH0lMx37FKv2R6qwkIQPVMM3aVhKBh
         Cd5eciZXhBNDdM3NxWVrECw3vi9xvpjI5oX7JuvLnXtzNk2rIahNhW150zz2c3v2gvXT
         WTEmQPkX/tdafsCSapY2f5YO37sKP9KPgKrWaSOziR552APdwpnaSAPccaPkDG1RxZB7
         Y+w+cW6MqMeAr1YEBzjnlTLMp8dbwC7h7iOHrLewxOOTVJSxhrcfUXi5mvEucNs8rRrD
         cPHA==
X-Forwarded-Encrypted: i=1; AKwUvBz/Ij5+88ApEjUx6l3xiRDi1dyluVoaRSXkOoGpxyJeTsK0QpThUrDs7ufSe++eBNCOGu+RjT6IP/A=@vger.kernel.org
X-Gm-Message-State: AFuF++l/mQ9rCbI9Dnxrnvku27pScRTHWTETmm5Vfb/OeRhzt5Y9XHkd
	jCbzaI2nDCL/+U9Xn2i+fu6yRoneCPaxScFXUSH0Nq5v+i7wPPFqm5ra06KjwH82wa6ldWy1T2q
	UXZotBYO3aDLKlORziZEb/vVEuqQsqWA=
X-Gm-Gg: AYBFou003/NKEFSqYB9acfXaarJTUnGsA0jfNqnI2QTo3b14aVPCgl9JCq6q9Wf/sih
	z2uycYfzSYc9gLoxxDoOlvmW2aC0crKZuPyWd5o6It9vosjJ+H6Tdxf5K8CT499Hrd3mvtE5FHK
	GNB3TCQYHndpLFlLqqBZVEyLlduJfCcPnuOz+Ky3nfoacIQR4Lwnug3VRDawhWPLmz3zPS9QkyY
	lGWvp1yHPd3AsYuNhu1TDoXIxAx+9WO4yXErSPB3XI7fNq/9s7HymRXnTo2dgnf0rDv6H2Q4vPl
	rEo7OZPxwa0iFzV3FaDTDrL2+MC2zgi0nK80lrRuh338zc4=
X-Received: by 2002:a05:651c:a211:20b0:3a3:2a41:c0c4 with SMTP id
 38308e7fff4ca-3a34ffdf928mr3036391fa.14.1788325542808; Tue, 01 Sep 2026
 22:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
 <20260822062725.60519-3-muchamadcoirulanwar@gmail.com> <20260824010726.2849f3d8@jic23-huawei>
 <CAO26r3RLnX4HXrKDF6akmG722Q2CvDU-uJ40Yfuu_wwJdGgA9g@mail.gmail.com> <20260901021420.144a64d3@jic23-huawei>
In-Reply-To: <20260901021420.144a64d3@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 2 Sep 2026 12:05:31 +0700
X-Gm-Features: AcwNN1VwSx9iXjAYtJBmAc-tUFlWH0dfDFzrjPh6nAYPikoQ80HU5nlzzOFlAv0
Message-ID: <CAO26r3S4t0GCAep7J1suedPZZA85=vCzrWXA4wR=Lox7wceVDw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/3] rust: add minimal IIO subsystem abstractions
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	brucer42@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 08:14, Jonathan Cameron <jic23@kernel.org> wrote:

> > > > +        Ok(IioVal::Fractional(v, v2)) => {
> > > > +            // SAFETY: both `val` and `val2` are valid per the Safety contract.
> > > > +            unsafe {
> > > > +                *val = v;
> > > > +                *val2 = v2.get();
> > >
> > > Why get in some places and not others?  May well be a gap in my really limited
> > > rust knowledge.
> >
> > This came up in v3 and I answered it then but forgot to add the comment
> > as I said I would. IioVal::Fractional holds a NonZeroI32 denominator to
> > prevent division-by-zero in iio_format_value(). NonZeroI32 is a newtype
> > wrapper over i32, so .get() is needed to extract the inner i32. The
> > other variants hold plain i32 and don't need it. I'll add an inline
> > comment in v6.
>
> Ah.  This is my lack of rust knowledge (and forgetfulness).  I'd avoid
> putting too many comments in for the benefit of folk like me who are
> still failing to find the time to learn rust :(

Fair enough, I won't add the extra comment in v6 then, I'll leave it as is.

Thanks
Coirul
