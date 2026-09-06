Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710F1DB356;
	Sun,  6 Sep 2026 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720652; cv=none; b=ACJbjR4pvy20ogy42RlDfUj4v8mjo2eVQeAtAXIuV1jf2FGTdEoR1GOJoSOlBeOvN0jnuHo0AtAo2aNiED+/RvzU1VrIR23gfGB3yLm3i6ShQSDdmhBot046IjxEINz4e7QppZIzZVPtL+v42lQoJ005GayN8NNrrDNeCisdPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720652; c=relaxed/simple;
	bh=fkuL9lk57Fu4jgGFnpUqsspdUnoVuz7bcyAX/OlGo4Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=WvBMy0tgkYM6aGDJ2ZkJNZ+u0vAG4nDe5ADnw5daZw1Sjctw5v6mgmj0DNjrqSOUSSpapWFeLJfj8QtjpZLZdOJQCa2CdcB8c/f5zChMlP72faSy3+tj7X/oP1oqWEEA079xX2zsDb/Xb2cEyC7ZNSuuNS4Mfi6qFZwvlahGc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKAh8Tqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKAh8Tqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246541F00A3A;
	Sun,  6 Sep 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720650;
	bh=7HHAXfwc9wO/Zue/pcde5vt97DrbGS+ON9z+VUxfPtc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=kKAh8TqkgTri8jBuGG+KdbvGncxJeyRRiS33InVOwFNoIslt2UGzFS+W2RjrZOjql
	 jxN6TsrE/qs67KBF2ASCLmzTYh7N1luN58eQq5CmkU/V0RoGLS4JN85p0ILX4G8QZ9
	 23lJHARcgxs9ND28iX0cmcgBjuhaYWYnPMeEth7qzcg5i0HEKwygSdrjYDc/TOk2xB
	 f23ryVyxKYoKmqeAE0W/QvIB1Fv7TLR6CKYFIVu5wXODyFult5riy21Q2QIzWSiBJk
	 bbJ3uepvc7BqkY7wrt8vYdj63hkzukap5DG3jvK514QXXAWtAcXSraIQqFP771pCjJ
	 HoDYrH4dQvB6w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 04/13] iio: adc: ad4134: Serialize single-read
 operations
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com, 
 jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
 andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, 
 skhan@linuxfoundation.org, marcelo.schmitt1@gmail.com
In-Reply-To: <apkTRwJp50WCaipq@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <4e136d116b2eda46fc36f3a3ded3990972c012c4.1788368334.git.marcelo.schmitt@analog.com>
 <apkTRwJp50WCaipq@ashevche-desk.local>
Date: Sun, 06 Sep 2026 19:50:47 +0100
Message-Id: <178872064714.3402141.14394353863875745387.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=817;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=fkuL9lk57Fu4jgGFnpUqsspdUnoVuz7bcyAX/OlGo4Y=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnbYHtNgi3u3s4ACskKtGF+oYrh6PMkz2vF/gs
 f922DTVSrSJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap22BxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiEYVD/0Ulh/zCzlioqsoQHp+RLoFbF6YNKDA2m9SybKgfFxQb4o
 UeiRhkDf6T8vz3lc29t0MLW7uT0JBrZloRtoVOqxnYQcPBpMAnAGHy9UWKobEjcFBMMzJWD7pjY
 0oZ1YKL5oRqThpTJW8P5QV373s9Ppq5/ughguoqhAi2bDlnh4/LyFQGMu3NVcpMDHvRx39zmKHw
 ufHMYU+X4lqyAZte622PWT5oSpNTk/soTf+f6EZDzC7WkB4tR++H4Ju1DsI5S/wgxfLO1xuT4JT
 gEOms4hfLRCoMUemupJgv2bFADXM70y9B64L6H/eoKrPOrBYeRxrqTqhc5Qn9W1ulHqFtuAmRkN
 8Z3v8hwQFXvZmlTA1tFiIuhdIlW/dWJTStKeqKSGPIEdm0qhNjSrqSCovQqW3bnsLqNMaHcRZYn
 5QXjKKV1ORGDnTkxC45XNKTdUuAp7NnvIq6Xa5G5ljzwXPDttt10+D/AQi1mUUTdHwNH+6ZTXM2
 eBuEEA5La1fCXPwMw1JlNiIvpFTbihvFixD8p8GNtbI9TdDQsbDEbttP9fuZ8sOvVPKHSEw70Js
 KiYhcAgAzJmXd8wG/blS6T7qh6Pt8wkUbmViJqxhiDjaOX71b3TRirLqbj+iP5VF0ADsPK3Zv3J
 S42DKvuz8sEfVVB7fUPzOPyS5UMs1zFauObZ5/Q==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

On 2026-09-03 09:27:19+03:00, Andy Shevchenko wrote:
> On Wed, Sep 02, 2026 at 02:22:41PM -0300, Marcelo Schmitt wrote:
> 
> > Protect single-sample read operations from going wrong if two or more of
> > them run concurrently. Serialize the data read operation so to avoid
> > single-sample read requests disrupting each other.
> 
> ...
> 
> >  	case IIO_CHAN_INFO_RAW:

Define the scope.
	case IIO_CHAN_INFO_RAW: {
Scope has a funny definition in switch statements and that can lead
to 'entertaining' results.   Some compilers will also moan about this.

> > +		guard(mutex)(&st->lock);
> 
> Always delimit guard()() with a blank line.
> 
> >  		gpiod_set_value_cansleep(st->odr_gpio, 1);
> 
> ...
> 
> With blank line added
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>


