Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503828;
	b=EjIFsbbILVYJiaeP7zH0FZYkr3LWNoHof+E5kox1SSX8ZVPylMe07q4ZT5erTVVDlMvP
	 8M7o7czGYgdEAf0bukqE2P5VY5yIqgkom5lBI4jvwESbQ3rU0merfOTWjrjNzVwuxE4rw
	 p4yMOmcMOkvzJH07I7PX1ToaI/FWNWDPkqAoKwAX9Cl8B6l9YRuEa4mh+zQ16I57//Ndg
	 Rkp98XpdojTYdQrCzw0d5l4fzjAPHVsfYaRW+DOikI9VCdPh6GsFuOOhJpi0h6vz9fuTt
	 CR83qPwWwtVHcu22FeskBBO56qx49kVQS3rH6B6GyUdbLO3+U3C3nfeUCLE+HdJWR6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503828;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AR/cFk2X1quGruBxo9ZZs//35Ek6zU5kc3K2jTMdIpw=;
	b=nL+O+eVXLT22pofi3BKoJkKnCYd7b+ra1dufBdlrsY+bG9QnATDmkd82IydLa0RiEPvY
	 8zzMiVemO0p5MxKde5dC8fKMJDnlzNVZFOoRV34j3oHb+psmqGPaw+AKf9hTvZOIRopd9
	 EQysPke6sPzzvkNuRWfAmAte9BfMjVPCO3Co+DJA66qc9wbjwq8Fqoz9BPMDz+hmxxIMo
	 HaNUge2Rkxx3Ib5m7oyEgC39OzdyXy1HYWCJtJ8bFFY5efmvcNsMGrWd8MoZEnBBldxMH
	 qZsGe3sE9VtuTF3vUHT141DpfWyR4JX5jH7de59uGTPylGC4Eh9IQZOXCPnsPW/7Rww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYdKK29f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42D606A325;
	Sun,  1 Nov 2026 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYdKK29f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61361F000C1;
	Sun,  1 Nov 2026 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793503827;
	bh=AR/cFk2X1quGruBxo9ZZs//35Ek6zU5kc3K2jTMdIpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BYdKK29fZBd5auKssRy65Wgdz7C4lJYjNJOnxLaJdYgymgiWz9fnEvZ6kUYxQWF8I
	 rNTDRUknq5HzkVcoONNefwuQVmrSdYk2Onu/6HTPJvzgNWiKnVuNXrRWbazAT9Sn95
	 TmUwad7fch1k7M3M39JizGxl87VfJP7f5/HiwaiCWQfQ1fveRDBoBA/c22hfahTTzS
	 k1oPXpH1u+zD2W5udxuV6V+U2yFrPGxZ7Pip4RnAri5Vh5aqZZ0IbSwfOVMYcK+lON
	 fbHk+IvXu63oNGOYgk0k2v1yVqX34Pj85zrg4ddzJNBCcxF2NLAKOS2/q6MdwvTDqn
	 lpzjGBmao8oMg==
Date: Sun, 1 Nov 2026 03:30:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, Benson Leung <bleung@chromium.org>, David Lechner
 <dlechner@baylibre.com>, Guenter Roeck <groeck@chromium.org>, Jagath Jog J
 <jagathjog1996@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Jinseob Kim <kimjinseob88@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Remi Buisson
 <remi.buisson@tdk.com>, chrome-platform@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, Bart Van
 Assche <bvanassche@acm.org>
Subject: Re: [PATCH v4 0/9] iio: enable context analysis for all drivers
Message-ID: <20261101033018.05897c08@jic23-hlaptop>
In-Reply-To: <20261027124954.110697-1-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 14:49:45 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> Jonathan asked for the qcom-spmi-adc5-gen3 fix to become the first
> patch of a series that enables context analysis across IIO [1]. This
> is that series.

Nice work.  I'm very happy to see this.  I had a play the other day
with the patches reordered so I could see the reports getting
fixed as I went patch by patch.

Applied with the last patch modified to what Marco Elver suggested.
I added a note to say that I'd modified that from the posted patch.
(pasted below)

Please take a look and check I didn't mess it up.
I kept your sign off as fundamental change was yours even if the
actual diff ends up completely different!

Now on the testing branch of iio.git which I'll rebase on rc1 in
the next few days and push out for linux-next to pick up towards
the end of the week.

Thanks,

Jonathan


=46rom 137ca6e5de3bd4e1056877d0b82214e82143efa7 Mon Sep 17 00:00:00 2001
From: Rupesh Majhi <zoone.rupert@gmail.com>
Date: Sun, 1 Nov 2026 03:24:24 +0000
Subject: [PATCH] All of drivers/iio now builds without context analysis
 warnings, so enable it for drivers/iio.

Modified from posted patch following suggestion from Marco Elver
to limit the necessary change to the top level Makefile.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 4e1d930108de..a238c015a70f 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the industrial I/O core.
 #
+subdir-ccflags-y +=3D $(CFLAGS_CONTEXT_ANALYSIS)
=20
 obj-$(CONFIG_IIO) +=3D industrialio.o
 industrialio-y :=3D industrialio-core.o industrialio-event.o inkern.o
--=20
2.56.0

