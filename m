Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02F397697
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624509; cv=none; b=EmCCx0f1CaXEDfM2KGplOuevQw7vT+NwWgOLSrkHtrpoKrwB0R/u5GkSpKgfATW6ZGZ40kwtSH3ZdyiZMcFrPGsv2zjF8GJXPw2BOWHm8SUiNid54VWzTemPHEvlphDj3PngaLlZugSf0V/jzzBQY3HgteFedrx19YVYgHZ4zr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624509; c=relaxed/simple;
	bh=4H52RiUgfh21ZFPsHyoianCiAR34V0Nkw/EF+33bfDc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVygBwDlQZHEB3M8dSWrdpL1oO2DpgCnPjZ4XqVYfMmrSLWnCs+nWaLjtKUbTwmNsiwPhoEvhy2njPOzPq9koE+j+jSoqy0vfWYbGILceVFwKM8AUqYwwa7cuC6rIqkmna8VMvYRN5+ZD22OdDR7kfDl3C7eMedpm5VTvpXwSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqi5hMbx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqi5hMbx"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-827307b12dfso3598442b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 03:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772624507; x=1773229307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcdRETdlDQ9rJqwe5hebX3Cr0LcEt1jHyO8LM3OIebI=;
        b=jqi5hMbxNpHad1IIlLjUddUd3GhGB3jpQhsx+itjLrz05ii4OEvXaL63ROZemRhEZc
         DVsTK2M17aRy0srwahqnkX078oYykq3hHdo8DgSWXsRInt63UK0E9d+pWp4fQAX3iAzW
         T+QMlh1x8uJVPS1Zd2JxUf1fgAoeq6d603Xtq6GnSvJ7YhUAPITAE6xgHcOtB3YLkahl
         oHGxfalRcdh17h4JVni/dUAJmEbuFxnhjKRthjd4cugNNdFfB51e3w8c49vn6UBumneR
         v9Q07ZDOzBQJznY4mrpq9C5p3mMBPfl99axSzXAmACWZDuQfRX3uQaJ/PAgiwh6nYlXX
         7Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624507; x=1773229307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcdRETdlDQ9rJqwe5hebX3Cr0LcEt1jHyO8LM3OIebI=;
        b=VUuuXrrPNltqa0AHr6UWbYK8oVcbUctKYz9KdSBpUZJKGaB2psBkJGWfikKbttI8V/
         NYIQb4z2Ri+OF7s6kyFCLixBdYThYq8VbVQktHX0jtvao1GmWG2PfTuRPbHAKakq6kVF
         X8XjXzjMZ3b2yVKL+ZWutxeJQhPooEtMmJZewrsMQS9WFzORQ0gbM48/TH6SzmWCNhCg
         6itkf8XvjGP0NFtp83GehwrUp/wUiJBNuL8WixtfmhlRbU8J4fcSlZRh/6Z3W5LzVSMX
         wdiJJlEaoCuhmNFyk+MF8WObeRpQiIVQ1eL9b+36xAOCxqTS/0DMC704+kTbLtObshsJ
         EL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX34KrVJT/fyIjCKTLzW6dI032X+y+Dsdukd3xjlg+At7r6XNEsFhggaJSrMItj86Jy6j/kio05kQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwovAQINeuc131Vo/8jpZ2W9bwYrLYtCJZ08ubJ9m3Fdu6ZlAR
	CiOSfk9yHUpXj2BtDZG1rs2w6G/dTTdR4oAQWY9MwuQCQ/eQjvuXZ4zD
X-Gm-Gg: ATEYQzwvFa1tT4UR/v9Wjqi2za8CbUPTZ4+/T/1lliSjB30vrx/zjkSOMMsExXv93Iu
	k2lYin8DG7nOU7hGpX0WDML9X7zODmDU2ozmCdtd5O2UO66owteER0CvnSnBLTUOLyQu4EBSF+/
	JDDrcGBQe/tdoJBdhWmWZeS6r0GcfP9fnQdrQnTb4kBuhlRoE3cONU3yUVzleMKukMTcDIGd933
	31afDE1NDytCQ0ZxChFuo5as0LgfVdCn1645akdeY82GOfYyhpWzElo/v2xOazmqE+3RkgWxSBC
	v3kotyhxdsGnuajYXBlGYWnIeXh+aS7Gy0uXUF2w6MG7bhAEhkaADtLNfHsNcr1J6/A9TD88kJN
	FmsTl+UkcwhA9WTaZOWlaj37K/ELgj9R5Kpukz17QppQBZWBFzaLbZpIKADBhQR4VpozsHRqcfn
	VltBAHNl+ckQGSEYqjakygYcb/V7EfyEHvLY62r02SgJ37J5trL0auQM3CjkZI4tWw9cq3xUJzE
	WNlHqDYE7WX8vsVbKdUUjXmuQ8xA4xIq1/K8AzSSFPqZuy0bP5YAynnKiEHog==
X-Received: by 2002:a05:6a20:549c:b0:394:62e0:1b98 with SMTP id adf61e73a8af0-3982d2821b8mr1657671637.9.1772624507474;
        Wed, 04 Mar 2026 03:41:47 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73790f881esm1449862a12.10.2026.03.04.03.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:41:46 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 4 Mar 2026 11:41:29 +0000
To: David Laight <david.laight.linux@gmail.com>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <6et7t3o6fjiinpkvpsmoxjhp6edn23dgclbulaxg5paccdotgp@amtf33da5dhf>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <20260304101655.620df7ee@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304101655.620df7ee@pumpkin>

On 26/03/04 10:16AM, David Laight wrote:
> On Tue, 03 Mar 2026 13:27:07 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add kstrntoull() function, which converts a string to an ULL with a max
> > character limit. The function is an alternative integer parsing function
> > that does not require a null-terminated string. It becomes a better option
> > over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> > with custom delimiters without having to create temporary copies.
> > The function is consumed inside the implementation _kstrtoull(),
> > promoting reuse.
> 
> If you've got custom delimiters use a function that returns a pointer
> to the character that terminated the conversion.
> They save you having to find the delimiter as well as taking a copy.

understood, how about this prototype then:

const char __must_check *kstrntoull(const char *s, unsigned int base,
				    unsigned long long *res, size_t max_chars); 

to be used like:

	end = kstrntoull(s, base, &res, INT_MAX);
	if (IS_ERR(end)) {
		/* return or handle error */
		return PTR_ERR(end);
	}

the name itself is still under discussion.

-- 
Kind regards,

Rodrigo Alencar
