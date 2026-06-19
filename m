Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E935DA49
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860695; cv=none; b=V5pGU6C9K7KDmHwlRI8Mefl4FVc3A4j0MFSeSz5u5zVcXgx4qM1KCCMW3lXF/84cT4HOIcIWX8Jn2yywdCYNBg1ODlVxUJ+XFCIlqN7OwnK9rZRUhNBG4rJF1BHT+NjC3CLfV4J0OTViGhrDHNBOnoctdOoAT8MD+3YvHEmFf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860695; c=relaxed/simple;
	bh=HrbxsYvatj3SpVyem3ASwi//HYE6/V8gZgmt9q74jQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rz4r+ZcTzhDlfrBBGMMNhgHUtx780MIx3tClN8OjpmFam3Sk9zkHHxZ++L7H99cKlGJ9HTrMrynDLVyZtLU3U1IdJmJPwZ6bnAvm0v9RjP6cNcMSebRRaoyWrSJ7nrUQlST/M85YYq3e+X4VadyOuUkZvvZdsO0UnxFjArHATug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j35HvQt+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j35HvQt+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4629051c946so1510419f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 02:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781860692; x=1782465492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qJ+1XH8dCritl14KLJVHxEllQqTFK4ERuhFL6hZTB7E=;
        b=j35HvQt+e7151kOosQ4nyu9brEc81AZMeEnvgXijMAmABxWhFGSwOQtdKla08koYp4
         sEOzToYALkC30qDT31iifoIzRY1Tzv98uwg09HvX+3VOR1A7wfh9TWXAEy1Y46wXazqV
         d8HNXTzat1SoeaKEw4+KWRXH5jZrQvlgcOKbQ9uiL9qHEB0/MwU6tbHtjig0Wxp6ib63
         1UgZs+UcJLZUijbRQCTngKX8KwHrCU3tW/Q9V6J2DFZUVx9taelRg++9X+29TrIhOhHo
         EpJrZitAOPMsdNH8Q4VuQY+vLYEoqNHI7k7EQ27p2gG4hvYRh9Sl1OmCYzAQ9Z7EpSMC
         bAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781860692; x=1782465492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ+1XH8dCritl14KLJVHxEllQqTFK4ERuhFL6hZTB7E=;
        b=NSeWKcIMrei1fshMtc9PCgjFAFyS7ek+ZaCGPssaSdv83eYTWcHxhe2SS/zsR1RuSV
         wINUHZmqdceHSKooWi4g83r+YrmAmydKSex9Ff6D6kAilGSvs7/+CeG4rcbsJtJEZjr7
         BuVodxwkFwlMAp1lfsvBzuSNXQYde8CApkCebHxWIrLFL7lSGG9Brh2CJJqvDAdLF+lT
         5Clha20+q1dRf4F1WuGIvwOjDFh+80zEmQLMxqpaUtIU+xPYcRWYrbgdDQryr0w4JwiU
         I9N+TvpQsdgeSYq8vAGSS4e7Iq7Ix00dzxKkxk5F9gdFJTHjtBBf5rkOf4yhJ2wlY2n6
         8rEA==
X-Forwarded-Encrypted: i=1; AFNElJ9zEyUxhHKI843uPV3S6YabkIvwFELML8pjdW8efGWys2BffQjF5fEhz32izfXEND6vWRF2htr49sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5A97GJu4qRlpPDiY0Eb//OFsOq6jKa1/N6X3ScyJMZDQhubb
	qNGJnc1XFfwVtEs2rtWPvdzos5pD6MPjRwO4OK8PjAly3D4NiV60ZdZV4vdRJQ==
X-Gm-Gg: AfdE7clBPcz2GyhTFmPw4Dw3ec81J+pgpsXzZ4swRcqkAKFX7SNV4E/BF65E4z1ImyH
	9wpN1Imf4MCZn6M8t6EnxyzfVcrCXnY+sBmv7uzH/04srZo3jX28Dph/gkEM0zRRB0lA/c35VwG
	lkyme7e5JebHZaouNe+C9LaZO13inL238tvTkx/jAF65NQwWkDkW+Y1gmrMqrdvGiXpF+RC7T7w
	xv4g6LWUthZMYmQEm/JxzPpGF4lDJAyu2/A2QZca/ZJ3WgzhND0Vo0Wd3sXSi+bSf0NAhAGO3GX
	y8mQ7mWhDm4q5qyXkvWU0mafY0ktvZ3pQAse00of3lU7GS7D6EofEnR8Ro6yvmCFKNLIWkPj8aF
	MD31iXTfmdj0Vq1J8agA6txAAFmPqMj0yHHOItGvQWbCTvWYqADN3iAlnDluNQdItYpmInn4aBq
	vQqAVV
X-Received: by 2002:a5d:5d81:0:b0:460:d1e:a59a with SMTP id ffacd0b85a97d-4651c1462c8mr3671623f8f.8.1781860691840;
        Fri, 19 Jun 2026 02:18:11 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc423bbsm5994831f8f.28.2026.06.19.02.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:18:11 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:19:13 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 06/16] iio: core: create local
 __iio_chan_prefix_emit() for reuse
Message-ID: <ajUI9nNvTS3sZsB-@nsa>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-6-79125ffbe430@analog.com>
 <ajQGTQ1_qcOwfzne@nsa>
 <x3aijvc4buo7aqbchikuoyyrgiq3afidtkla37h2rg4tvfdbc3@h42qp3estg2s>
 <ajQ1bZSNHQ96pyJx@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQ1bZSNHQ96pyJx@ashevche-desk.local>

On Thu, Jun 18, 2026 at 09:14:05PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 05:14:19PM +0100, Rodrigo Alencar wrote:
> > On 18/06/26 16:06, Nuno Sá wrote:
> > > On Thu, Jun 18, 2026 at 02:27:22PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, postfix);
> > > > +	if (!dev_attr->attr.name)
> > > >  		return -ENOMEM;
> > > 
> > > I don't oppose the change. Looks like a nice cleanup.
> 
> May I oppose it? I found use scnprintf() is harder to follow in comparison to
> nice kasprintf() that takes care for the dynamically allocated buffer.

Tend to agree a bit given I was used to the older code. So matching the
old logic with the new one is an exercise, yes.

> 
> Also there is a chance to get a name silently cut due to insufficient space.
> Besides that this function can't be used (again due to 'c') in kasprintf()-like
> wrapper. I do not consider this as a good approach. Have you looked at seq_buf
> instead?

Not so sure the above bothers me that much.

> 
> > > But bear in mind this very sensible as any subtle mistake means ABI breakage.
> 
> Which immediately raises a question of test coverage. Do we have one? If not,
> this code must be accompanied with one.

The above is the more concerning part to me.

- Nuno Sá

> 
> > Yes! I tried to be careful... this is dangerous stuff!
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
