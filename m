Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C995386C1C
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363826; cv=none; b=ixazqa99+LVCo/tmmDI58GOIeDhUYSFwK2n5YFgroOI+j+GSxJUK+QcscM/CzQqAsxm2r4y+qfwETjTu3VreCxpcAmGOPZFpIjzywaEPxj+YBbO+rdGrpmzgucSfObYDT+V2lgTHUNSMKnkW3O75HT6zpN53+eStAW1hgvlSquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363826; c=relaxed/simple;
	bh=F7N+y3gCNAmJZfNUR6yLudPtRwbf81nGC8KlaAu9p9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JulSpwuOySNG0rZoZyno+a1hnfSLLwJeohEpiIkxy6wtQfO7bpWstmfeoJp1fXBCawEu+L9Kx2Iwtc7IVVYjskheL+FwX7SUM4Q1ipDdss8G98lSu0+2sxCLQTptETiMPACqn+br2Q1lcwbuZFECa4+WAkAxuHx27WuSdm+S/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pu1wGEEK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pu1wGEEK"
Message-ID: <cb8eb38462312fa6c09ccea6fdc9c20d7cf11831.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784363811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7N+y3gCNAmJZfNUR6yLudPtRwbf81nGC8KlaAu9p9E=;
	b=pu1wGEEKSSQ1eLvgAZcYWANfkrIgWwV2PMb9AqNHHI6AKps/0uMlLG61iAOaq6wmbxTjTl
	OyxePNx03h3URQRJn9aMRA2TW7y/Vf+shnjwDVeYRnmws76TXNRDhzEXx1p+h4GDcYBjBd
	sH4qehZIhtJVLXi6wiZWTW4+MrlumP4=
Subject: Re: [PATCH v10 0/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: jic23@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andriy.shevchenko@intel.com, 
	u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com, nuno.sa@analog.com,
 	Michael.Hennerich@analog.com, dlechner@baylibre.com, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 18 Jul 2026 14:36:02 +0600
In-Reply-To: <20260717201138.1078019-1-shofiqtest@gmail.com>
References: <20260717201138.1078019-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2026-07-17 at 23:11 +0300, Md Shofiqul Islam wrote:
> Sorry for the long gap since v9. Between then and now the driver's
> buffer implementation was rewritten from the kfifo-based design onto
> the standard IIO hardware-trigger and triggered-buffer framework, and
> I read through every open comment from every reviewer before sending
> this rather than sending again too quickly.
>=20
...
>=20
> Changes since v9:
> - Rewrote the buffer implementation around devm_iio_trigger_alloc() +
> =C2=A0 devm_iio_triggered_buffer_setup() instead of the kfifo buffer and
> =C2=A0 manual postenable/predisable pair. The hard-irq handler now only
> =C2=A0 reads and clears INT_STATUS1 before calling iio_trigger_poll();
> =C2=A0 the threaded trigger handler does the FIFO drain. This relies on
> =C2=A0 the trigger core's own attach/detach synchronization instead of an
> =C2=A0 explicit iio_buffer_enabled() guard or synchronize_irq(), which th=
e
> =C2=A0 old design needed to avoid a NULL active_scan_mask race on teardow=
n
> =C2=A0 (Sashiko, both HIGH severity findings)
>=20
...
>=20
> --
> 2.51.1

Not sure if it was said already, but please include change log from older v=
ersions too.=C2=A0
You could keep the description short, and include Links to each version as =
well. It is=C2=A0
difficult to hunt them down one by one from lore.

Also, don't send "To" a list. send your patches to Maintainers and=C2=A0
Cc Reviewers and lists.

--
Best regards,
Sirat
