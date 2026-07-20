Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDDB2C0F93
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527296; cv=none; b=VEhhPuesdN7nNn69575FblNRnIkswNLoqSbk0HcKP1/CED0k83+HQsBjV9JK1jNwjPZBAmBa/8zuzYJS/7it2pcP34uux8K5kxy40jaOJBWqk76C0h/EqF2a7DIBciuF9bqPIFuf/lky5/h6m7wZM0IzvgnfQOVuPFaVMk/LXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527296; c=relaxed/simple;
	bh=wwnlxyM97g5gXcU7wg6PIobYqg7uUyC4T+tkEFb9WDE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=q/81r2F7U6Y7yUZwj/u3mOWVMR1iTRwmCq4SnG+HK/ZeZyOd/sUohs+Wl6rcWwSXpF4a6/DJ38ToqI6ZxRrVRShnoeJ1MO8PNQTZySDhnb+cnrU1FEi5bYHwPfSdNSRw88JQ6+vZk4NA6YngNvOL3DfhVTIGeS1AfBhIRiAE+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l2NVX2Vu; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l2NVX2Vu"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784527274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKDPGORur0xVtYmq0hXZ7pENIE/FDt/uYqyAGbmL6Xs=;
	b=l2NVX2VuhhxptgreNBaTCt8CkV1ZQErCjdqTtpcV6nCxABk805WyeUS6xP7BazdoFT8SbM
	kuton7auhyFPBjWWN97R2kjhwe5jor2vR7TVMdsNk2YFEmT/1Blolik5+qF55bfouKv4kb
	EyKcRwL1K/FI7JQWcOHbgQjhv41Ari8=
Date: Mon, 20 Jul 2026 06:01:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <e1fe5f3f8445bb104112ffddc592eea9a370c5e6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
To: "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>
Cc: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "David Lechner"
 <dlechner@baylibre.com>, "=?utf-8?B?TnVubyBTw6E=?=" <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260720020640.4bdde14e@jic23-huawei>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
 <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
 <d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
 <20260716141837.83326-1-jorijnvdgraaf@catcrafts.net>
 <ea6f4eaeb0535d607d77920515e9cb1739266624@linux.dev>
 <20260720020640.4bdde14e@jic23-huawei>
X-Migadu-Flow: FLOW_OUT

July 20, 2026 at 7:06 AM, "Jonathan Cameron" <jonathan.cameron@oss.qualco=
mm.com> wrote:


>=20
>=20On Thu, 16 Jul 2026 19:06:51 +0000
> "Siratul Islam" <siratul.islam@linux.dev> wrote:
>=20
>=20>=20
>=20> July 16, 2026 at 8:18 PM, "Jorijn van der Graaf" wrote:
> >=20=20
>=20>  ...
> >  > +#define QMC6308_AUTOSUSPEND_DELAY_MS 500
> >  > You can call it QMC6308_SLEEP_DELAY_MS to align with other values.
> >  >=20
>=20>  I'd prefer to keep AUTOSUSPEND here: it names the mechanism the va=
lue
> >  feeds (pm_runtime_set_autosuspend_delay()) and matches yamaha-yas530
> >  and ak8974 in this directory.
> >=20=20
>=20>  I can find atleast 10 drivers in IIO that uses *_SLEEP_DELAY_MS po=
stfix
> >  for autosuspend delay value. So it's not a strong reason not to use =
it.
> >=20
>=20This sort of thing tends to be author preference as both show up.
> AUTOSUSPEND is clearer in purpose so if anything would be my slight
> preference
>=20
AUTOSUSPEND=20is a bit more specific, but it's too long and doesn't align
with other #defines. I was suggesting SLEEP because it would align perfec=
tly
with all the other defines and there are existing drivers that use SLEEP.
> >=20
...
>=20

--
Best regards,
Sirat
