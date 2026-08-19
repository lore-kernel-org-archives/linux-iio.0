Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126A268690;
	Wed, 19 Aug 2026 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127999; cv=none; b=M+h3Ek56EEstb9UHOEq23cbRQOiF72fRRZlO4J6Dx8XBq82nRuafJLELzyFBeA4DD0pnpMz0B2vKs1PRSiiGO2Eyywsb2dB93iuKURiBMQogt1xadZawdGI4kijdsfLGdQXNZu3ZOip75hciD4aXka0hDGHvGbRAleL3KB9u5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127999; c=relaxed/simple;
	bh=bO0ewF/jIRKJTr9iDTrKWMW4tzf/dxjocgc8x+d5how=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p65mwQzzHxWYYrz8fpeilUBkS53dULTx5f86zZjQ3O4/V7vnc9DY5cXoSmMt3vM13a9L2lfVFiSdwxhDkqS/PkY5RviM7RANm/1d9xfGC3pefC2nSDnwMCygnngf42tqNunbMRb5A0C7jBTduP3tOUUDS71TXBPJH5eXbfqNtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZFZkRNgT; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZFZkRNgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787127995; x=1787387195;
	bh=DVwi+Qh+lytsk5HukjGP7UMSRtjZj7WP40TTQz79Nzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZFZkRNgThxyKLmxLhbcIMv+WsqqsTlYbArGAvBLpIFaY8jTpD7XIiwPJMPD+GOFB4
	 FlkvwCuWB2nSmdlHFPFoSCKHG822vOxDafYScQiSUAtFW0iF7PfUoPaudUiRpSVs5l
	 jJ8GPT8XVlmqcsChnYpfp2LupI1f8ROWpO5bClYWC3vuHvd5o/kU+cQUYh9ayNd6kU
	 n1JD588LpuXDGrMcKQ5m0P2B9cqoHtb6d7hPZAs2vzRnlQZzwxoYNH1t+ZNYhPadoe
	 ArrxrBZI0RFLe/QV/PgocFXH86GJ+xEnChXJMlK4q8aEPJ6WnLbKmrn832U8uAHgvM
	 lgrZKwLG6gn/A==
X-Pm-Submission-Id: 4hQ05y1sQYz2SchF
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
In-Reply-To: <20260819023233.03d79181@jic23-huawei> (Jonathan Cameron's
	message of "Wed, 19 Aug 2026 02:32:33 +0100")
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
	<20260812-mma8452-open-drain-v4-2-bfca15d02b59@geanix.com>
	<41zbnT5tdPvKMFjNwqTi18KkdWe7Lyw2tPRSixVZ-8cH1LJwnQRi78CowVB5NP6sD_iVSoTEMBevXuRCaDTpXA==@protonmail.internalid>
	<20260815051356.4dac350e@jic23-huawei> <87tsosk6zt.fsf@geanix.com>
	<qXFhLuDWkwGjQMtFJ4aqj9CMDDSMQQBvg29Nt5yY8DTpUfVr_ZMuw9ZbTUzgTPq6waMSQUozZh5Y4UhJiJnQGg==@protonmail.internalid>
	<20260819023233.03d79181@jic23-huawei>
Date: Wed, 19 Aug 2026 10:26:28 +0200
Message-ID: <878q621por.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Mon, 17 Aug 2026 19:10:46 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> "Jonathan Cameron" <jic23@kernel.org> writes:
>>
>> > On Wed, 12 Aug 2026 16:30:33 +0200
>> > Esben Haabendal <esben@geanix.com> wrote:
>> >
>> >> Reorder struct mma8452_data members to avoid holes.
>> > Trivial but sashiko pointed out mm[a]_8452 in the title.
>> > I'll tidy that up if nothing significant comes up.
>> >
>> > Interestingly Sashiko also thinks it found a deadlock.
>> > Given you are working with this driver if you have time could
>> > you take a look at that.
>> >
>> > https://sashiko.dev/#/patchset/20260812-mma8452-open-drain-v4-0-bfca15d02b59%40geanix.com
>> >
>> > I'm rather surprised to see the lock taken in the runtime
>> > pm suspend callback. It is probably there to close a race
>> > where the device is being suspended and the sampling
>> > frequency is being written.  I'm not immediately sure what
>> > the best way to fix it is. One thing that would work is to
>> > do pm_runtime_get* to raise the reference counter and stop
>> > there being any chance of an autosuspend.
>>
>> The mma8452_change_config() function is grabbing &data->lock, and is
>> forcing chip in stand mode while applying change. This needs to be
>> synchronized with mma8452_runtime_suspend() switching to standby mode,
>> to avoid a race condition where mma8452_change_config() would end up
>> undoing the change made by runtime PM, due to it keeping the old state
>> in is_active local variable. So far it makes sense.
>>
>> But I don't see the reason for mma8452_read_raw(IIO_CHAN_INFO_RAW)
>> grabbing the lock for the call to mma8452_read(). And when
>> mma8452_trigger_handler() calls mma8452_read() it does so without
>> data->lock held.
>>
>> So maybe we we can simply drop the &data->lock from mma8452_read_raw()?
>>
> That does look safe to do to me as well. Everything used is
> either reference counted (runtime pm in particular) or local variables
> so there doesn't seem to be any reason to take the lock for it.

I can add a patch with this change if another revision is needed, or
will send it separately otherwise.

/Esben
