Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1B463B74;
	Mon, 17 Aug 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986653; cv=none; b=JM8B6d3BwPSAdttoDLwLWVdQTMfAVpiNn53oy1n0m7J9rlYaepSkrrAc1vI83nlcRaocdqVm4oqvb+lhhtgQNFa2pa4f1gSvfYDzS3kkPUfxWxo24QRwJCPsOs+kSJDA4NT3GjUsIW2gEfH8l9lYRd7bGljgMEjPHSI1ZyweULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986653; c=relaxed/simple;
	bh=429GVpXSjxbFGUrebaLGA9YHUG9SEAs7LvNU4pq4uLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cvvn1H0Vv4vsgDYXaYyJg0E4+3HLvrCLsq4pi061toq8JWa6f6VVhD4oZUk8qGFssWmXtAVFm3YW9IiSxr7a2GGEUvMTbXSjv9znQkdncxNLXOZ9N+ru0FfcZqg5Aj7EBwSwBbAjU9GBCL+n2d5sc74FI8w+IzgWaxEcdemSp4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=DcvJ7GN6; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="DcvJ7GN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986648; x=1787245848;
	bh=+4gq9b+aC4RuMIcnTIexMo3YnPmYSG0OD9G4Ptomi7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DcvJ7GN6I9zPoKQNoRHb7LRxqZwqMEYHyPC8RklsHnxfc3F6wuSTIGz22A3/Ez6nd
	 t8mE1XHpa8NKXddqmU4xBd9eEdUFliMNVHhk/7DoEhnGdePA18t9N1dtT8vyV9TcXi
	 UqeMQF4cRD9RJDPJp9hWhtCvLqul3PhuQthYQapRZvhOGPrH2HeZB5e4ANLIQP/76I
	 XiitiFERZgX3ClVm5AsvBjBlW2zgMR69yJ2L7RxomnVo+zXLm+mIyCsfjp/WPLEN4J
	 nUzplw2DDz0+/RNzEsxJtK7jwjYJkjZxz3xvrdtoQWcW9KbWRAsr0sf46+7TvKYnxt
	 2xldg8xjGAOCA==
X-Pm-Submission-Id: 4hNzqp6jpCz1DDWl
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,  "Rob Herring"
 <robh@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Martin Kepplinger" <martink@posteo.de>,
  "Sean Nyekjaer" <sean@geanix.com>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "Joshua
 Crofts" <joshua.crofts1@gmail.com>,  "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 2/6] iio: accel: mma8452: Optimize struct mm8452_data
 member orders
In-Reply-To: <20260815051356.4dac350e@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 15 Aug 2026 05:13:56 +0100")
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
	<20260812-mma8452-open-drain-v4-2-bfca15d02b59@geanix.com>
	<41zbnT5tdPvKMFjNwqTi18KkdWe7Lyw2tPRSixVZ-8cH1LJwnQRi78CowVB5NP6sD_iVSoTEMBevXuRCaDTpXA==@protonmail.internalid>
	<20260815051356.4dac350e@jic23-huawei>
Date: Mon, 17 Aug 2026 19:10:46 +0200
Message-ID: <87tsosk6zt.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Wed, 12 Aug 2026 16:30:33 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> Reorder struct mma8452_data members to avoid holes.
> Trivial but sashiko pointed out mm[a]_8452 in the title.
> I'll tidy that up if nothing significant comes up.
>
> Interestingly Sashiko also thinks it found a deadlock.
> Given you are working with this driver if you have time could
> you take a look at that.
>
> https://sashiko.dev/#/patchset/20260812-mma8452-open-drain-v4-0-bfca15d02b59%40geanix.com
>
> I'm rather surprised to see the lock taken in the runtime
> pm suspend callback. It is probably there to close a race
> where the device is being suspended and the sampling
> frequency is being written.  I'm not immediately sure what
> the best way to fix it is. One thing that would work is to
> do pm_runtime_get* to raise the reference counter and stop
> there being any chance of an autosuspend.

The mma8452_change_config() function is grabbing &data->lock, and is
forcing chip in stand mode while applying change. This needs to be
synchronized with mma8452_runtime_suspend() switching to standby mode,
to avoid a race condition where mma8452_change_config() would end up
undoing the change made by runtime PM, due to it keeping the old state
in is_active local variable. So far it makes sense.

But I don't see the reason for mma8452_read_raw(IIO_CHAN_INFO_RAW)
grabbing the lock for the call to mma8452_read(). And when
mma8452_trigger_handler() calls mma8452_read() it does so without
data->lock held.

So maybe we we can simply drop the &data->lock from mma8452_read_raw()?

/Esben
