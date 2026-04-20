Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD49274FD0
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722443; cv=none; b=Ez0l0NTcgiZ/Vm8yxge7Gh+eQfCjq39quaUq8J7o4fe6Ahf7O8kOJ8e5aKXKjE8Z9DIvB+PecON+brdoiSFULAbRCGk2dR8h2GuSMvmDA4urHNLFPrihsf3Q+Qb31Cc2fas5P4qEHImlETwUVJGK0LPz041HDPJIawTi8fiUrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722443; c=relaxed/simple;
	bh=zcIuX44FQ4JZplZlzPi2l4ZSnMwkpRIbGnceAVAp6cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPS9QDzMiwoUoZlg3gd71hkKHiHpdF3a+o6VBikqtyFfVDA0kj6A1CjnEcIvkMOB5FRjDV3W7Q5WbrqLf7Jf/keFQK0bis9pTA/xxxiV7otpkCUSU4Ao7IU9ufzAKYtYwbCm5PmCo2eYQLHrslRzs6OSH6KzjK+BSyxSeqfhReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAReCENy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAReCENy"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d77f60944so2883286f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776722440; x=1777327240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7JO2f/xlDpOxtBT93GnNbMq3RmdZ9DsCL97xFYueTk=;
        b=kAReCENyQnUWaL/fzwM1HV0Iz4JNWHfQYDT+hEHCcnneS2miPKABJqXU6DBOguxZKS
         T+owt/hFSTq799Zq6ejr8MfRapAGqczgxrn/8/FSKbE4KmN2ecbAPCxl0IncFGwJTXxJ
         nLKB7sB3vG6SkQH2/xRRbRyCNxGQLGcXSEM/lZ3EydQTt+k/28Voi4lzCueMszLE9MQU
         MNmU/BmLUUxnUGI5vDtsusUgwIOBaCNde5y2QQ8c3lQ0RVjTWmuoH5l+htPqfA6o0t9v
         VEcoOG5uXV5v1ERu+jg2x5BELqnbOExZVcrhsQF9tEDo8NaLFrZbDn2mXtDgg+BpshvP
         X1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776722440; x=1777327240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7JO2f/xlDpOxtBT93GnNbMq3RmdZ9DsCL97xFYueTk=;
        b=Qxzi+yJtHcEb1e1rBLEZ/kPNaP2nH06jDOFsncpAJkIjtgpwJP5sj0t39RFb3Wsmfy
         msmVFybI709nxg8JIAB2YEQwrChtl4gXZoPK70m1HVZtJjP6XqZZkkGZSs8zYs5j7myw
         YUxGzLmNMW61iANUqe0Tzn+xGDha+5b/iB/2UiTDQu0Rxf47vbNba0p6SSq1DF+Kpx4w
         yK2h2IiNtTh5vP3iynrZWp0d64YzBoaT4v/wWfUObA6j/zl0CNBAz9DC1NeUBdFGcQGx
         OJk5loiHbXs7Ya94D5UX/tH9QUzy9i3xMeJe7G7il2FfKL8CDYqB8Y3QSK8rBuXdI0kT
         lgrA==
X-Forwarded-Encrypted: i=1; AFNElJ9FZbrRGPqEUc+KnxOw8DYawDtBDYWfh/kMRVg0PKPqs8TEfwcbIhTilAZ6QegNP513STkyoCh8c5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuZptlF6JYOA+l7b8w0ZQZdx4IRS+kmWa+flJ2cK//rFIYpRQ
	CqkCZK2c8Qq2bEoh7/9GN1Yv2rnmF6diBD2T3B7vrGXWaN2o8Tf6auE0
X-Gm-Gg: AeBDiesEgcplELj8kNYKg+1LHf2XBHbXoIWEw1mvs7Xqw3KBEu9skuFC8dC5a5Z1IbI
	XQgrJZzQ+mJdVlUvnH2vxti3r2BzCq/L0RLg0c6LySv5HJvhEqRuz5Be4xyqmNgRIJaQa2sP9Zr
	M4anZp48GH2ceBuHGXb1p44BKcEYcEochjMegplIJwPHDOLglDfuy4SN7K83uPYBzHrsXstkgo4
	EfAlpYAKCzu8zg/oMBg+oTzQ+/PPmUnQc8N2gK4D5CDEwmTH2/wTp+9mFECF01alc/FEVJSOFkq
	weruOQInm0iXjMOgYR/4hX2uVt9+bW6OQj7CEztK8gVJDNUY+8e6tyNGW65QziPXTij3X1ambnn
	jR1qQ8yRkUCOEURNG8dfrazPWf5+ZU0eRIpgbO+cK6Hh56DGRuZVziiyXn0GHU+nyPU8DdiBX+Q
	AuWSNFjzDD2Ypo71PNlhP+A83+GeMHcgxY0J//Pef42Lgu3uEuRN5CBysgGEdHPr52N5Vobw2y1
	4E=
X-Received: by 2002:a05:6000:2303:b0:43e:b020:f8a2 with SMTP id ffacd0b85a97d-43fe3dd5208mr22198611f8f.19.1776722440147;
        Mon, 20 Apr 2026 15:00:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc26a3sm36471952f8f.15.2026.04.20.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 15:00:39 -0700 (PDT)
Date: Mon, 20 Apr 2026 23:00:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede
 <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@stromeko.de>, Ben Collins <bcollins@watter.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/9] x86/extable: switch to using FIELD_GET_SIGNED()
Message-ID: <20260420230037.21fb4758@pumpkin>
In-Reply-To: <aeZf98xjbxdHvZOS@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-3-ynorov@nvidia.com>
	<20260420112428.GF3102624@noisy.programming.kicks-ass.net>
	<aeZf98xjbxdHvZOS@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 13:18:47 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> On Mon, Apr 20, 2026 at 01:24:28PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 17, 2026 at 01:36:13PM -0400, Yury Norov wrote:  
> > > The EX_DATA register is laid out such that EX_DATA_IMM occupied MSB.
> > > It's done to make sure that FIELD_GET() will sign-extend the IMM
> > > field during extraction.
> > > 
> > > To enforce that, all EX_DATA masks are made signed integers. This
> > > works, but relies on the particular implementation of FIELD_GET(),
> > > i.e. masking then shifting, not vice versa; and the particular
> > > placement of the fields in the register.  
> > 
> > I don't think the order of the mask and shift matters in this case. If
> > we were to first shift down and then mask, it would still work (after
> > all, the mask would also need to be shifted and would also get sign
> > extended, effectively ending up as -1).  
>  
> FIELD_GET() doesn't require mask to be signed when a reg is signed, so
> shifting mask may become zero-extended in an alternative implementation:
> 
>         (reg >> __bf_shf(mask)) & (mask >> __bf_shf(mask)
> 
> This all is hypothetical, anyways.
> 
> > But yes, this very much depends on the signed field being the topmost
> > field and including the MSB.  
> 
> This is the part I dislike mostly. This would look just like undefined
> behavior for the API user: depending on fields placement or type of the
> inputs, sometimes FIELD_GET() sign-extendeds the field, and sometimes
> not. 
> 
> We could likely force FIELD_GET() to treat both reg and mask as unsigned
> types, and state that explicitly in the documentation.
> 

There is already a BUILD_BUG_ON((_mask) == 0), changing it to >= 0
will detect negative masks.
I think the only one is the x86 exception table.
FIELD_GET() casts the result to typeof(_mask) so the sign of 'reg'
shouldn't matter.
I just tried building with a compile-time check for reg being negative.
But there are too many false positives from FIELD_GET(mask, readl(addr))
and FIELD_GET(mask, READ_ONCE(var)).
The pre-processor expansions of those don't bear thinking about.

It's late now, but I will check how __unsigned_scalar_typeof() handles
variables with const or volatile qualifiers.
I think they do though the 'default' the same at bitfields.

	David
