Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F04F3515D1;
	Thu, 23 Jul 2026 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824587; cv=none; b=X42rxR6tUZ7B130ol/3IeOBYacmEb5L+xQCuz2yn1EB7GGchUvV45mcFmVywWdGeckz6+HfPyg1q2yJs+ubGWP8zXNvkyI+pwimm/fMINIAKgy3bfIaxdvkHJHlrhCMHCHnPL7qhj0FqH7uB0QSfojL5nTjW1U7QxjjZC6wlgvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824587; c=relaxed/simple;
	bh=IK4V4tyrHqAPbaxwCsfj1Q64qT/ir0zkjHndOGoJwE4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=O+9dVyTcLmHjBXzNJM2O8v8HsymEr/pz9ZYIcHYK0jLnriDix06kSxNPzrMM+A53sKuTOWSnfsbl3ezAq/yeWNvlJiBUn4XBt3khkguHom1PvhUrqJxYj2Ws4TCEtbW+RD+76B+rHYhADt7EJskt1nc1670ge7TYgBgsmhOq9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=knYM/b8W; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="knYM/b8W"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8CEDF4E40EDB;
	Thu, 23 Jul 2026 16:36:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47DC36038D;
	Thu, 23 Jul 2026 16:36:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98DC111C11240;
	Thu, 23 Jul 2026 18:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784824583; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IK4V4tyrHqAPbaxwCsfj1Q64qT/ir0zkjHndOGoJwE4=;
	b=knYM/b8W1D8bEIQHmZIYg9RyKb5pKpyOO1NrBobLcd3o19rSlKjySNR8PVYrt6RBpF1EAe
	65GP6iEdzZHOOT5ovRt3/UO5mWRg0uJcalthkTKBc7kREveiuIteJiGmbhIJrUY9ZccJRn
	VDgNePiqrzd48xi4/b/uzXkEwulXGH6KV9gYP9qg7E7fdntHOfIAhfDYOAmEyRjE5gJ7Ec
	XDxVAzLp8BU52HhfdwQsZ80CDGO5jXNJ8r6ivEnsv0u+OC9n1fW8nr1Ts9fM7u0j4iUHI6
	8MrF47b5xdJ//RF6oenZjLB1giRic/dFR918RvLAC7KtcB4LjPgMzUBCKUp1Rw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 18:36:18 +0200
Message-Id: <DK63IBW41HRJ.30G4KQWDK6LFX@bootlin.com>
Subject: Re: [PATCH v7 3/9] gpio: regmap: Apply default resource callbacks
 for regmap IRQ chip
Cc: <dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <mwalle@kernel.org>, <brgl@kernel.org>,
 <tychang@realtek.com>, <wbg@kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <andy@kernel.org>,
 <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>, <bhelgaas@google.com>,
 <o-takashi@sakamocchi.jp>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
 <20260723034237.2501507-4-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-4-eleanor.lin@realtek.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 23, 2026 at 5:42 AM CEST, Yu-Chun Lin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> When GPIO regmap creates an IRQ chip on behalf of the user, it also
> takes an ownership of the respective callbacks and driver data.
> With that being done, apply default resource callbacks that keep
> tracking the IRQ requests and releases.
>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---

Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

I also tested this specifically on MAX7360, everything is still behaving
as expected.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

