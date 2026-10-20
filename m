Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516055;
	b=uaWer/Oqx+M9J70sULvdxQ2QmRnklGblFVBrYQDvGgsgIsciB9VPasu7/0SC+piktT3w
	 oGN4knJqSldoWqmax8jiqiCpGnh3EXYFMDeSI1qvf3htQs8ZSMj3Xxg4uBsBi+8K8iVlu
	 egk5vLjnvOCEouewl55+SxF4sY1PbUrIWYGyMzqi82btmjMBkDc9GFMmiN5EZjOjT/agM
	 ZoEnVqAEKmBWDZ6YcE7jbvQ3K5KCRAdWU4vEkKTjnm08Rj3+uN79S3QvhVhv30ujBvR5u
	 8RdR4uN0RWDdYfo8ysi3mxynXLTlKOtkvbhaNeEo6wGxAcGac2d2B0757Ii9bnTVJWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0NChw0q7iQyjFAII3unH4t5su0zEDRJMz0fmmAi/9lo=;
	b=lL04IFV+LsXY4aaD/snH5jIkIofYcNKa77UcGQ9qzg+SKppbLt31/Fg9yxy29C4MX64z
	 MC3QrKLHRcmZUwpeiICytOH3g0dqrH3I4CV/Tie9pFcEh//StVhM7Pzwpgyo4ZNMb2WQ9
	 aCnOqkwDVhhzJOENJk/rjfH+nI1Xg18/ot2ejA8gGb49idaAPNRY/Gkabz/IGX0JUUjab
	 Kyr0Z+6oIfGpjZX5yT2AK66t46t65UUxkvbM+L2KfcZD7tc/nFYjHLC8IoIxllIXFnQ0i
	 GKvyutXgzUiEM8+yxw65uFVG+oDleVyHMjDggt8XZRylLANdn638pdFcGNEBBknoiAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NiM8ezg3;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86025606A322
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 17:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86025606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NiM8ezg3
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35943f55c06so1352168eec.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792516055; x=1793120855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0NChw0q7iQyjFAII3unH4t5su0zEDRJMz0fmmAi/9lo=;
        b=NiM8ezg3/gAh640fVbXkioAOXlq5h+cvDQK76QDJ/mCqVVCoQ3ifezFIKjXT2ToXW0
         BCWQUnlbl873lYGS9OKrsrI3K3C9ZN1/0UuaLpl2TPBcGyP6fRtqAAJcApTniq0/ZtvX
         rE/etJIyrzT5qYjd+1uu2ezFZnfZQplXIubw29B8TNOXyViElhGgqWW+0snm9rtlLfAq
         g8mHMdcHGJ58ovEvNyk1bFbw3r0MC0luw5RUVCYOcNJ/3FqgqIajI1/i9JHWkU8IOylO
         E0dSASzURbz0chZnN5BMP5LtuL5CD3FEVuYtYczVB/t//gUhD/hjowt/CwqqrBKIUEAR
         j0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516055; x=1793120855;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0NChw0q7iQyjFAII3unH4t5su0zEDRJMz0fmmAi/9lo=;
        b=lg84z7s1hUN0vXD22I9pmkKwiaf++kxcVxyPw8+DWfiT5GPR0502cv5arKLw9sVaJc
         FxVZuHBdpsWBzKIu+jp30UX9EYuTYgHmjs4ypX7r2f0OhrSH4VFLUyN35XScNf/e4tCM
         iSjeRyDDPb159DFOo6kU0lyMorEm/9h1IwceQGUuSQo0wqOzwGBPiOV6CTNhaSHAVyEG
         Qbhm3ISF+OHCToiOsymVSoKa/kkQUHtATAqhmxE19jAwszPPAw5QnXXVjWw140cKWxo3
         H++BwN7varzJ+XrxpDqyX6bCOZVJkT+ohWZejspTsuBJ0bPkg48n+IS8jNdDk+2wfSL1
         F7QQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+HiEXQVl1vIPAcm2DoCNlJV+Cqa7grzxnS/ho7u8pubJOYqp6agWrQL6wjErp0RQwKDZQBdyC8YY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoiGZQBKHAr4wVgUsugHkyoLnJ/Bx3pTtOwh7xYywHiLMAo3kl
	OPJSy5DQMECOgfyxK4cNHSNYUpJsnUtvEbAu9YVpZaE5biUWOEylackqNE31XTZs
X-Gm-Gg: AYBFou2iXZjZMyk7OCeMZSX5w3WTORHmyJ/Ry+cijJX8/pHjqAOsgdL/rdIQeFGlcM8
	4CgNdVL3s+ZiUHjSWcZXb4d7n//Q25NOf1AhtG+YiBixIQAQdGZJv/TJWkvZ5ij5xzyoAzEMTyP
	Hlw9Ubtm3M3iJ4QyU7BkLcRwau4FSupgkhdmqmiRgvuZZl8j3OWU8liqRGbVgd4iQcALHLKBAIc
	Gkjj+CS94MRNt+wKRVrvHlBwS+NAOKrAjOGdUGTCWtnvVgQr9IK+i1VKeMeKMwYK5uiPz0NyHp9
	FODttRM8RXsCcr0gFF0j4Wl5gk5G0/O0dJ9nNADch3mnHkunhNOrYP2AdruNSCiWpEANOvItGz0
	pjZXtMchdqR3Km3C8rsfiGdtvjNtrVI9f+qN+c9PYLqFF8NeM7fr8OFeLFZGtVvK2MVkM2X8IM0
	MYomM8c5ZPVlihoXs2SZeeshbE1rT5fSss+5yfDXV9TcR3wG+XbfgIT6tT6K7Lackb38GEdS2QP
	T0lABm5N2Uxq4V/TgSjTfBgtKjnJbp7Wp+Z9LE4VyFGnHO/Yz7ZqNW904SIexXTg1SHPQ==
X-Received: by 2002:a05:7300:e7a4:b0:353:5d7a:cabe with SMTP id 5a478bee46e88-365fad8dd2dmr5231285eec.13.1792516054528;
        Tue, 20 Oct 2026 10:07:34 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm43436541eec.16.2026.10.20.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:07:33 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 20 Oct 2026 14:07:25 -0300
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v3 4/5] iio: core: use kstrtodec64() to parse
 fixed-point values
Message-ID: <5ixgnxi5hckja73lcujqo6c2bthknpeunwfaynpagyqnzsmqo4@fy3tvpswyza4>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
 <20261020-e-notation-v3-4-fd385c0fbf65@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-e-notation-v3-4-fd385c0fbf65@analog.com>

On 20/10/26 09:27, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Replace the open-coded __iio_str_to_fixpoint() parser with kstrtodec64(),
> so sysfs writes of fixed-point values also accept E notation.
> 
> The fractional part only keeps the sign when the integer part is zero,
> as before. The dB suffix for scale attributes is now handled by a separate
> __iio_str_to_fixpoint_units() helper. It strips an optional trailing
> newline and the "dB" or " dB" suffix before parsing.
> 
> When there is no fractional part (fract_mult == 0, or dec_scale == 0 for
> 64-bit values), try base-autodetecting kstrtoll() first so hexadecimal
> and octal input keeps its meaning ("010" is still 8). Fall back to
> kstrtodec64() on -EINVAL to accept E notation.
> 
> As a side effect, inputs that used to be rejected for integer-only
> attributes are now accepted. An invalid octal number such as "08" is
> parsed as decimal 8, and a fractional value such as "1.5" is rounded
> to 2.

...

>  int iio_str_to_fixpoint(const char *str, int fract_mult,
>  			int *integer, int *fract)
>  {
> -	return __iio_str_to_fixpoint(str, fract_mult, integer, fract, false);
> +	s64 dec64;
> +	int ret;
> +
> +	if (fract_mult) {
> +		/* scale = ffs(fract_mult) = ffs(10^n) = ffs(2^n * 5^n) = n + 1 */
> +		ret = kstrtodec64(str, ffs(fract_mult), &dec64);

As sashiko pointed out, this is breaking some test cases under
drivers/iio/test/iio-test-rescale.c because of the rounding case change.
That is in fact an issue within the test itself, witch limits the parsing
on 9 fractional digits only, requiring a relative ppm of a scaled value
to be zero. I will have that test fixed in a precursor patch.

> +		if (ret)
> +			return ret;
> +

...

-- 
Kind regards,

Rodrigo Alencar
