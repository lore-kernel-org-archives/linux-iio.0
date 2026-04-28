Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB488272801
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401281; cv=none; b=JVK7KmV2o3i6NV09BWzslKd8loYI8s4adchcXECCTv6Vk0ce7dUaOlcTXOqpivxVN25HxL10yXluNwOAXlGkiAcyGjNUPN5AYpIRU53Zdv2MlKJAtfTLoynGhoNPsiL+c+LMjFcXv0a0vPXeHB7bXzraJJ2e5CETVuNW9LnYWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401281; c=relaxed/simple;
	bh=Mo2X4+kDtTDQPGneWz7t2qGSne23/W4uBhBFiRIlzGM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Df/oH4hG4+tW3PwKzoRazVM44lH3E0u8xa5gX2jvVW0vnKyJ8WjsjFcBfhdIdQR5MIk1q3FWVWpYBX0/6r1xu4OzxCQYsxgeUWJHg7YUCZQd1qYhjBQUE6epG0D6pLydZ33hGHgK4U84BtME5TQwasP3t6Fi3D8kUt7u1di2fEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FMDWwZsn; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FMDWwZsn"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777401277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mo2X4+kDtTDQPGneWz7t2qGSne23/W4uBhBFiRIlzGM=;
	b=FMDWwZsnFSgy6N+KH7/y0aqvCtXtY8/IxZ5mvmL2yTVNnIo2V2Vqe4+6JdxhzA3TFWBHyI
	UDafsvnsUHnnQNNHZnSr0ITk+q/stkwfJfZKB5Phkc1+qp6TC2m1GJeZhIrgazX2fWmBA1
	O5qrYHtmTALyviX3lhfaq/QFiS9GB5Y=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] iio: buffer: hw-consumer: fix use-after-free in error path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <20260428192636.58e4fc8b@jic23-huawei>
Date: Tue, 28 Apr 2026 11:34:22 -0700
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <DC73DE77-89A2-4268-B07B-2CED5C1D7592@linux.dev>
References: <20260428192636.58e4fc8b@jic23-huawei>
To: Jonathan Cameron <jic23@kernel.org>
X-Migadu-Flow: FLOW_OUT


> On Apr 28, 2026, at 11:26=E2=80=AFAM, Jonathan Cameron <jic23@kernel.org> w=
rote:
>=20
> =EF=BB=BFOn Tue, 28 Apr 2026 18:59:28 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>=20
>>> On Tue, Apr 28, 2026 at 10:53:25PM +0800, Felix Gu wrote:
>>> In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code=

>>> was using list_for_each_entry() to iterate through buffers while calling=

>>> iio_buffer_put() which can free the current buffer if refcount drops to 0=
.
>>> The list_for_each_entry() loop macro then evaluates buf->head.next to
>>> continue iteration, accessing the freed buffer.
>>>=20
>>> Fix this by using list_for_each_entry_safe().
>>>=20
>>> Closes:https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647=
%40gmail.com =20
>>=20
>> Format is wrong, missing space.
>>=20
>>>=20
>>=20
>> Tag block should have no blank lines.
>>=20
>>> Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
>>> Signed-off-by: Felix Gu <ustc.gu@gmail.com> =20
>>=20
>> I am also wondering should we put Reported-by with the reference to AI so=
mehow?
>> Jonathan, others, what are your opinions?
>=20
> Would be nice to do so for these - things noticed whilst reviewing a patch=

> type reports.
>=20
> Roman (+CC), any suggestions on how to do this?

I appreciate when people are recognizing Sashiko, but I don=E2=80=99t have a=
ny strong preference.
Many engineers are using it locally before sending patches upstream, so we=E2=
=80=99ll never know
it anyway. But Reported-by/Assisted-by tags are appreciated when appropriate=
.


