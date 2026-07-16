Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B5E42BE98;
	Thu, 16 Jul 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212104; cv=none; b=SQ6kFuO0z0r+f9b5OEYPmOT6QG1iBng1N0AFQQuxvWWxi8TSoQWg0m1TEQwT+HlcObqqiqXX9zIKDABdmPnzCv485AoI65Mkk73dBeouelBatwq9zsAT0FkkFLcMFz02l7NP9ho/3qaPeEwl4hNT8o/Pw9RNdIs7vdAEbY9tYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212104; c=relaxed/simple;
	bh=AC34adnZx+5SmfNkaJJaduNEJlCDO1QPKf8CUFQmsWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5JmLfl9eEm6ArCcOmXgMhe7SVhn+BcRFnnhK+RfNp3aanG8IO+yESL4V8Fry6UMoSUWucvKt+EVMWXxh3I/y26IqGxg3bt1XGjFlMnByMUVkpNh3M2oWdHR7Lk7tNhVn2NJM90oEyCfm9SAepPQEdiIcCxd1cednovKxuLtO08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=162.0.218.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from MTA-08-4.privateemail.com (mta-08.privateemail.com [198.54.118.215])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4h1FWj6gG5z2xBp;
	Thu, 16 Jul 2026 10:18:25 -0400 (EDT)
Received: from mail.privateemail.com (K8S-PROD-WORKER-07 [87.215.145.39])
	by mta-08.privateemail.com (Postfix) with ESMTPA id 4h1FWH2RPtz3hhTP;
	Thu, 16 Jul 2026 10:18:03 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Siratul Islam <siratul.islam@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add QST QMC6308
Date: Thu, 16 Jul 2026 16:18:00 +0200
Message-ID: <20260716141800.82761-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <989a9b6a2024415ce29c1aef162c6a4d341dfa45@linux.dev>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net> <20260714202842.340293-2-jorijnvdgraaf@catcrafts.net> <03e59d2907ffccc2cecd94ab44d19359f2474733.camel@linux.dev> <20260715204616.46517-1-jorijnvdgraaf@catcrafts.net> <989a9b6a2024415ce29c1aef162c6a4d341dfa45@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sirat,

On Wed, 2026-07-15 at 22:16 +0000, Siratul Islam wrote:
> > I'd lean towards keeping the separate file.
> Wait for more feedback before deciding, since you have a few days
> before you send v2. DT maintainers usually prefer reusing the same
> file where possible.

Right, my previous email wasn't meant to lock in a decision,
just my preference. If the DT maintainers want it merged in v2
I'll happily do that.

> Register compatibility is driver specific. Bindings are only for
> describing hardware. So if there are reasons to use separate
> bindings, this isn't one of them. A fallback-compatible
> relationship isn't needed, as we are already using an enum to list
> which different sensors the binding supports.

Fair point on both counts; I'll drop that sentence. The lack of
property overlap is the part that matters here.

Thanks,
Jorijn
