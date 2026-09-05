Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B126A0A7;
	Sat,  5 Sep 2026 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788651625; cv=none; b=MbNqGgWMpeDX7Q2XCbGDarwidrXUg9lB1KqTf8q+WCmVfuExEl0OQDCrn1/YAs48xI61sc6aivETiE+hoI+AJFCtOXHjHdJTA4CWafGrroXXgn5uRQUm0OZ3LCtl2LrtRqcLrvNI1onf6kKwkoYzAt87rAJ2z0OIwXGUcgfJxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788651625; c=relaxed/simple;
	bh=EzM+g04VKtJs/sbBtht/tz1iD+imnoy3tcg3M1I7mVA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=RQC7dOGJdfhhb0HSYDYCt79z2AC8YFGxHzCM0cY2CaGq0lUaiLRQlO4Mi3nQlErYQ7um+75pKnwnYGrGqfiPCogbNCSS46EkZVx1naFrmp3LosTNYGLQrUu7x3RkTkO1Yce0cu6whddqkvuhPlLRsBHugUIvXKt3IPMvc/fPOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBTjlUlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBTjlUlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9B01F00A3A;
	Sat,  5 Sep 2026 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788651623;
	bh=LTPfWvt4FFNJg9koUy8BlGjHJrozzgeznIzsksiu7Ks=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=TBTjlUlk7Tlng+aVC6Q0tsFpWDqeRwDLOTz5gBiArl5QVUuPznGGwhScWGQOSjMUZ
	 mEHojyNSG9MgGmsugd/VIIZfkwPaBBPZUDB+KyJkaDeaKkU9ukHbAoKTdKyS9okOjC
	 gzTjTI7uifNCAL9ql6253ZMJTH71tpGof+eJnbEJ4gvxjtEwnDuJ/lpdudrQYLdRoh
	 uEC/zgOkMy7cZf+/dedjk0dvIQbhwBgtAlwYlKL7eIz4mM8S+1mpIbpT8w09thZwEj
	 faa8x0EQ22SyzGY/cjBZJ5fIBBxrSeuoL6c2T/IgN5DcTfUMWjoSrgfDkz7qNCiwz4
	 Zg5n6gtZVIeCQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] Add support for AS7343 multi-spectral sensor
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <apvKFENwRCFrZhDO@ashevche-desk.local>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
 <apvKFENwRCFrZhDO@ashevche-desk.local>
Date: Sun, 06 Sep 2026 00:40:20 +0100
Message-Id: <178865162068.3402141.1669078775218314364.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=621;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=EzM+g04VKtJs/sbBtht/tz1iD+imnoy3tcg3M1I7mVA=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnKhmk4BDzQ+o1HPg+acphkELf71jBIRwzTwEY
 IeE4wyG/DCJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapyoZhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiKlJD/94QbhBDi5ywvKpRBJwKxvAZIsolkHS2CkLsehBH6kJRJF
 BQLzpiW3jPjtsNGpRDP5B97JDL0n5yU4gX89BxmrMkb53IJ1WRFTSFCdsYh6sR1XXn/Aa2P+xyq
 KtdEjgGjtaqA64yBA1oa5YK+pNNNdh9V7JIkGiyxTECnq/Vmu7UG9+JrhrvB0ioT6LbNemrVuUa
 6Z2vSoNNlmzgADaW3CFqLu+bdgoSP4q6dsbytk6jRMu1KgKJXBEw3YdZ8OzRzUaFDOdAWheIT2w
 6QddqLUQtUFTx8uUdVELk1MAbymTOscCLuFQmze3eRI40gy4paWcMaScZorIRFkeHbV7/v/gehZ
 zWyHKM3NWRwLgzMc2QQHpomKAPBpsqfp7LKzd9OYvZI8+xCDGPRPF1bB1WyhC0naj4x99k/mF+o
 zXI9XEU6FKjZ0mTV0fz+ehEivL8LGX+6Qgmss+7a3nS5+7WchXlVyeV1kfm8weTG5RL0b1lsfD7
 GDwdxxU7vUiqi7gp6ullJHxhucaGJSQxDjvWXSoMlQ8D1iFHX6Vtc7jZe5LtwLCkVuD+Ea7lCL3
 lUKnhqljoNSaUhRLqLnGakqg+FwiYaAmNA45fjA+i1hUMzon5lw50GJ+PY7VC6GL2U4YWFqQP3L
 V8jh7GgZRODi+2+OVryMJnGWayjgenKEMNQtBEw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

On 2026-09-05 10:51:48+03:00, Andy Shevchenko wrote:
> On Fri, Sep 04, 2026 at 10:53:24PM -0700, Chang Yu wrote:
> 
> ...
> 
> > Datasheet: [1]
> > 
> > Link: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf [1]
> 
> This is a Datasheet link, no need to have three lines for it, just
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf

In addition to this I'd like to see the tag in the driver commit tag
block. That is more useful than having it in the cover letter. 

Thanks,

Jonathan

