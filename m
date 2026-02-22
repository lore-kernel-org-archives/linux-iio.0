Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19033EBF29
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795888; cv=none; b=ula4+wxj0BzvVz4Dei2Gt3PBvmNQCRc1Xs0s54JCy3+OogyXmFN8BUCzsw9adLRXmGnyNUyaDmf7kwykcycebCOeJ/7i4jKGO3jRDHgSQlXT+IDV7mMqaHDiOy4zcrjU/3r7pVvIac/Xcn+rY0pz5QtFbQjtzglbLdomP805N3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795888; c=relaxed/simple;
	bh=QzjME7zcYdVaQ3w3zHJF+94MbWLnBCtVKpePFUUeZ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkOZMJUgTa7ruknBST4wosBOmDrrW/z06PIdlH/HRw9nvLM4/ezh/qtRulxaSgCF/f1AqlZbmmZxKVwHMh50PbwBVsNp6N1fOrMUVegxrSwGwbPr4sjbuwsp9GuZRXj4Rm+hBctZOtiJSdsFaUFM6t+llk3+vljBtyF45fQXVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQdyR6Xp; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQdyR6Xp"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba94dbf739so3932429eec.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771795886; x=1772400686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w7RhOYqSZYG7/4DzPKHxyo/THmHlSU/4FOb0tUj651s=;
        b=HQdyR6XpXovX9ta792x5e3wfZNwsBEQQojpEE2YbIUwXnYuZq1ofadYI+9K6oQC32P
         Ri3Bwg35TS+yS+RrqWV7Yg0oVAb8MnjfrpJe94WNhlAaIVAQ9+os2iTk0ChoJWWO60pc
         BqDfVCIolnxk+59FnvA4+wuyxplF+zyweHI7DMRv7Z3HKt2lSOmePlKS2CKYi/LdHAhQ
         gQ1rbPZEYAKea2aacZbrHGIoLLk0+vM6ZVoa0uBOYboFBYiqVuKPp7teHNMrfCevI4lt
         2SKaYY9RWMpCs/Az54jJ/L5UylVFPIZumepM9j+HFXzyWiqlq+GibefmgOjmSDLaVTZN
         Og5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771795886; x=1772400686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7RhOYqSZYG7/4DzPKHxyo/THmHlSU/4FOb0tUj651s=;
        b=rXhBqWHMDBEOcf0pls1hoTMKK85xR/xGlSEFjAB31s7oJJJKkPWL2nmSsF+6bUbVVD
         31efowdSzBVC8vHndo3zHzZicpuSQRfwtew3TMF5EKrs3bjPOlOIMl2kpf6LM6a1dMeO
         1k+t+8XGcN/N9Y7Vig29hVnsXAjDdUcpaPpuACKkQygSAlEk/mP0AEnvegspMiRqI9mz
         b/CNn1aMKN5Z2rM+EO4cIcdSDHQLs/P532d4usKk3nykxqZFIW0wn3zHZ7yiz8qc5i8c
         dJ8jzApglrHdWERGr2bPrCccCe/GGH28EFc6AlS8rJjNyEzU7t3oHxuMwnTUePFm0NbB
         iaVA==
X-Forwarded-Encrypted: i=1; AJvYcCWP1WdOx1xr3U4GAkcMRAwsNpyBGYekWMa8FRqwjLBUnNANGyAD9UhNu6XccZlQRjqrbLgaNBls6pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMHF6NNhZG0G0MdaNvzP59eg7psYUrN8W+feV7MnvrHDwnE1o
	2AB2HDyTsws/HWuwqoJd9/w8PHoHTlA/OfF18vd/6a6iaEMVQ3hetKmI
X-Gm-Gg: AZuq6aLTIwYLt1W95+0oD8EGLRcIc4D96k0FIiJWeM142RykhrgZMPuPeQM0y9dROuo
	T4/QN4lGNv14PuihCIyr3V7DlPHkr4P39PWCayga/dzfHBnjzvLzuXxzx4dkGx8qmcp5w0CWDmZ
	f0KTDK+uu4FOUW/BaOe937lXO2Af+3k2DrBvqzz9JhRh8yatJCNQYvn1031/mGw9Q2DFtG105Tz
	9QmP0BW3iVc67lyDeTf/VxFRZxdx0JzEUDI/EeH51XBDhxZy/Pkg3meS6jJMMK9fIu/q80jgx8/
	O9fq7EPp273INbzLEvf6zWrlF3O5Agxv+5ISNdGdxjr/XXWuO2OKvnWlyDNf4bo9r0CGKH7C30x
	x5cJHXUMMsUDaig9dN3M0U2aFFPeFo9VUqyWl+LPqE3l+k4MGEifXOIUU7/G4beLHlLyjvRXiSh
	8JqgUvanC4cYSUtfpK8ozOoqt5jLWU/gjxxnqy3IMvshwQ0LQ46dzHZrnJ94J4TbQ=
X-Received: by 2002:a05:693c:2293:b0:2b0:4902:c55c with SMTP id 5a478bee46e88-2bd7bd03e39mr3161672eec.18.1771795885912;
        Sun, 22 Feb 2026 13:31:25 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe82d3sm4014173eec.21.2026.02.22.13.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 13:31:25 -0800 (PST)
Date: Sun, 22 Feb 2026 13:31:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: switch to using guard()
 notation
Message-ID: <aZt0IGNW2hddXvRZ@google.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
 <aZbBGomQi0l84An_@smile.fi.intel.com>
 <b36307f9-c4b6-4242-9cf1-838799a926ea@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36307f9-c4b6-4242-9cf1-838799a926ea@baylibre.com>

On Sat, Feb 21, 2026 at 11:20:42AM -0600, David Lechner wrote:
> On 2/19/26 1:51 AM, Andy Shevchenko wrote:
> > On Wed, Feb 18, 2026 at 06:29:27PM -0800, Dmitry Torokhov wrote:
> >> guard() notation allows early returns when encountering errors, making
> > 
> > guard()()
> > 
> > // strictly speaking
> > 
> >> control flow more obvious. Use it.
> > 
> > I like the change, but...
> > 
> >> Also variables that now only hold error codes (or 0) are renamed to
> >> "error" to make their purpose clearer.
> 
> Normally I would not give my opinion on this, but since I wrote the driver
> originally, I will say please don't rename. I prefer to always use "ret".

I hope I can convince you otherwise.

IMO "ret" or "retval" should be used when the returned value is intended
to be used during normal operation. For cases where we only expect to
have an error or 0 for success "error" or "err" is more appropriate.
This allows you to write

	error = do_action(...);
	if (error) {
		// handle error somehow, typically simply report.
	}

This also helps when reading the code as you know that there is usually
no reason to care about the specific value in this variable (maybe
except -EPROBE_DEFER).

I will push the conversion ret -> error to the very last patch so it can
easily be dropped if I am unsuccessful in swaying your opinion.

Thanks.

-- 
Dmitry
